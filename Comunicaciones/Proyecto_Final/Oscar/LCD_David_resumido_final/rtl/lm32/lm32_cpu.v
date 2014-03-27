// =============================================================================
//                           COPYRIGHT NOTICE
// Copyright 2006 (c) Lattice Semiconductor Corporation
// ALL RIGHTS RESERVED
// This confidential and proprietary software may be used only as authorised by
// a licensing agreement from Lattice Semiconductor Corporation.
// The entire notice above must be reproduced on all authorized copies and
// copies may only be made to the extent permitted by a licensing agreement from
// Lattice Semiconductor Corporation.
//
// Lattice Semiconductor Corporation        TEL : 1-800-Lattice (USA and Canada)
// 5555 NE Moore Court                            408-826-6000 (other locations)
// Hillsboro, OR 97124                     web  : http://www.latticesemi.com/
// U.S.A                                   email: techsupport@latticesemi.com
// =============================================================================/
//                         FILE DETAILS
// Project          : LatticeMico32
// File             : lm32_cpu.v
// Title            : Top-level of CPU.
// Dependencies     : lm32_include.v
// Version          : 6.1.17
// =============================================================================

`include "lm32_include.v"

/////////////////////////////////////////////////////
// Module interface
/////////////////////////////////////////////////////

module lm32_cpu (
    // ----- Inputs -------
    clk_i,
    rst_i,
    // From external devices
    interrupt_n,
    // From user logic
`ifdef CFG_IWB_ENABLED
    // Instruction Wishbone master
    I_DAT_I,
    I_ACK_I,
    I_ERR_I,
    I_RTY_I,
`endif
    // Data Wishbone master
    D_DAT_I,
    D_ACK_I,
    D_ERR_I,
    D_RTY_I,
    // ----- Outputs -------
`ifdef CFG_IWB_ENABLED
    // Instruction Wishbone master
    I_DAT_O,
    I_ADR_O,
    I_CYC_O,
    I_SEL_O,
    I_STB_O,
    I_WE_O,
    I_CTI_O,
    I_LOCK_O,
    I_BTE_O,
`endif
    // Data Wishbone master
    D_DAT_O,
    D_ADR_O,
    D_CYC_O,
    D_SEL_O,
    D_STB_O,
    D_WE_O,
    D_CTI_O,
    D_LOCK_O,
    D_BTE_O
    );

/////////////////////////////////////////////////////
// Parameters
/////////////////////////////////////////////////////

parameter eba_reset = `CFG_EBA_RESET;                           // Reset value for EBA CSR

parameter icache_associativity = 1;    
parameter icache_sets = 512;                      
parameter icache_bytes_per_line = 16;  
parameter icache_base_address = 0;      
parameter icache_limit = 0;                    

parameter dcache_associativity = 1;    
parameter dcache_sets = 512;                      
parameter dcache_bytes_per_line = 16;  
parameter dcache_base_address = 0;      
parameter dcache_limit = 0;                    

parameter watchpoints = 4'h0;
parameter breakpoints = 4'h0;
parameter interrupts = `CFG_INTERRUPTS;                         // Number of interrupts

/////////////////////////////////////////////////////
// Inputs
/////////////////////////////////////////////////////

input clk_i;                                    // Clock
input rst_i;                                    // Reset
input [`LM32_INTERRUPT_RNG] interrupt_n;        // Interrupt pins, active-low

`ifdef CFG_IWB_ENABLED
input [`LM32_WORD_RNG] I_DAT_I;                 // Instruction Wishbone interface read data
input I_ACK_I;                                  // Instruction Wishbone interface acknowledgement
input I_ERR_I;                                  // Instruction Wishbone interface error
input I_RTY_I;                                  // Instruction Wishbone interface retry
`endif

input [`LM32_WORD_RNG] D_DAT_I;                 // Data Wishbone interface read data
input D_ACK_I;                                  // Data Wishbone interface acknowledgement
input D_ERR_I;                                  // Data Wishbone interface error
input D_RTY_I;                                  // Data Wishbone interface retry

/////////////////////////////////////////////////////
// Outputs
/////////////////////////////////////////////////////


`ifdef CFG_IWB_ENABLED
output [`LM32_WORD_RNG] I_DAT_O;                // Instruction Wishbone interface write data
wire   [`LM32_WORD_RNG] I_DAT_O;
output [`LM32_WORD_RNG] I_ADR_O;                // Instruction Wishbone interface address
wire   [`LM32_WORD_RNG] I_ADR_O;
output I_CYC_O;                                 // Instruction Wishbone interface cycle
wire   I_CYC_O;
output [`LM32_BYTE_SELECT_RNG] I_SEL_O;         // Instruction Wishbone interface byte select
wire   [`LM32_BYTE_SELECT_RNG] I_SEL_O;
output I_STB_O;                                 // Instruction Wishbone interface strobe
wire   I_STB_O;
output I_WE_O;                                  // Instruction Wishbone interface write enable
wire   I_WE_O;
output [`LM32_CTYPE_RNG] I_CTI_O;               // Instruction Wishbone interface cycle type 
wire   [`LM32_CTYPE_RNG] I_CTI_O;
output I_LOCK_O;                                // Instruction Wishbone interface lock bus
wire   I_LOCK_O;
output [`LM32_BTYPE_RNG] I_BTE_O;               // Instruction Wishbone interface burst type 
wire   [`LM32_BTYPE_RNG] I_BTE_O;
`endif

output [`LM32_WORD_RNG] D_DAT_O;                // Data Wishbone interface write data
wire   [`LM32_WORD_RNG] D_DAT_O;
output [`LM32_WORD_RNG] D_ADR_O;                // Data Wishbone interface address
wire   [`LM32_WORD_RNG] D_ADR_O;
output D_CYC_O;                                 // Data Wishbone interface cycle
wire   D_CYC_O;
output [`LM32_BYTE_SELECT_RNG] D_SEL_O;         // Data Wishbone interface byte select
wire   [`LM32_BYTE_SELECT_RNG] D_SEL_O;
output D_STB_O;                                 // Data Wishbone interface strobe
wire   D_STB_O;
output D_WE_O;                                  // Data Wishbone interface write enable
wire   D_WE_O;
output [`LM32_CTYPE_RNG] D_CTI_O;               // Data Wishbone interface cycle type 
wire   [`LM32_CTYPE_RNG] D_CTI_O;
output D_LOCK_O;                                // Date Wishbone interface lock bus
wire   D_LOCK_O;
output [`LM32_BTYPE_RNG] D_BTE_O;               // Data Wishbone interface burst type 
wire   [`LM32_BTYPE_RNG] D_BTE_O;

/////////////////////////////////////////////////////
// Internal nets and registers 
/////////////////////////////////////////////////////

// Pipeline registers

reg valid_f;                                    // Instruction in F stage is valid
reg valid_d;                                    // Instruction in D stage is valid
reg valid_x;                                    // Instruction in X stage is valid
reg valid_m;                                    // Instruction in M stage is valid
reg valid_w;                                    // Instruction in W stage is valid

wire [`LM32_WORD_RNG] immediate_d;              // Immediate operand
wire load_d;                                    // Indicates a load instruction
reg load_x;                                     
reg load_m;
wire store_d;                                   // Indicates a store instruction
reg store_x;
reg store_m;
wire [`LM32_SIZE_RNG] size_d;                   // Size of load/store (byte, hword, word)
reg [`LM32_SIZE_RNG] size_x;
wire branch_d;                                  // Indicates a branch instruction
reg branch_x;                                   
reg branch_m;
wire branch_reg_d;                              // Branch to register or immediate
wire [`LM32_PC_RNG] branch_offset_d;            // Branch offset for immediate branches
reg [`LM32_PC_RNG] branch_target_x;             // Address to branch to
reg [`LM32_PC_RNG] branch_target_m;
wire [`LM32_D_RESULT_SEL_0_RNG] d_result_sel_0_d; // Which result should be selected in D stage for operand 0
wire [`LM32_D_RESULT_SEL_1_RNG] d_result_sel_1_d; // Which result should be selected in D stage for operand 1

wire x_result_sel_csr_d;                        // Select X stage result from CSRs
reg x_result_sel_csr_x;
`ifdef LM32_MC_ARITHMETIC_ENABLED
wire x_result_sel_mc_arith_d;                   // Select X stage result from multi-cycle arithmetic unit
reg x_result_sel_mc_arith_x;
`endif
`ifdef LM32_NO_BARREL_SHIFT    
wire x_result_sel_shift_d;                      // Select X stage result from shifter
reg x_result_sel_shift_x;
`endif
`ifdef CFG_SIGN_EXTEND_ENABLED
wire x_result_sel_sext_d;                       // Select X stage result from sign-extend logic
reg x_result_sel_sext_x;
`endif
wire x_result_sel_logic_d;                      // Select X stage result from logic op unit
reg x_result_sel_logic_x;
wire x_result_sel_add_d;                        // Select X stage result from adder
reg x_result_sel_add_x;
wire m_result_sel_compare_d;                    // Select M stage result from comparison logic
reg m_result_sel_compare_x;
reg m_result_sel_compare_m;
`ifdef CFG_PL_BARREL_SHIFT_ENABLED
wire m_result_sel_shift_d;                      // Select M stage result from shifter
reg m_result_sel_shift_x;
reg m_result_sel_shift_m;
`endif
wire w_result_sel_load_d;                       // Select W stage result from load/store unit
reg w_result_sel_load_x;
reg w_result_sel_load_m;
reg w_result_sel_load_w;
`ifdef CFG_PL_MULTIPLY_ENABLED
wire w_result_sel_mul_d;                        // Select W stage result from multiplier
reg w_result_sel_mul_x;
reg w_result_sel_mul_m;
reg w_result_sel_mul_w;
`endif
wire x_bypass_enable_d;                         // Whether result is bypassable in X stage
reg x_bypass_enable_x;                          
wire m_bypass_enable_d;                         // Whether result is bypassable in M stage
reg m_bypass_enable_x;                          
reg m_bypass_enable_m;
wire sign_extend_d;                             // Whether to sign-extend or zero-extend
reg sign_extend_x;
wire write_enable_d;                            // Register file write enable
reg write_enable_x;
wire write_enable_q_x;
reg write_enable_m;
wire write_enable_q_m;
reg write_enable_w;
wire write_enable_q_w;
wire read_enable_0_d;                           // Register file read enable 0
wire [`LM32_REG_IDX_RNG] read_idx_0_d;          // Register file read index 0
wire read_enable_1_d;                           // Register file read enable 1
wire [`LM32_REG_IDX_RNG] read_idx_1_d;          // Register file read index 1
wire [`LM32_REG_IDX_RNG] write_idx_d;           // Register file write index
reg [`LM32_REG_IDX_RNG] write_idx_x;            
reg [`LM32_REG_IDX_RNG] write_idx_m;
reg [`LM32_REG_IDX_RNG] write_idx_w;
wire [`LM32_CSR_RNG] csr_d;                     // CSR read/write index
reg  [`LM32_CSR_RNG] csr_x;                  
wire [`LM32_CONDITION_RNG] condition_d;         // Branch condition
reg [`LM32_CONDITION_RNG] condition_x;          
wire scall_d;                                   // Indicates a scall instruction
reg scall_x;    
wire eret_d;                                    // Indicates an eret instruction
reg eret_x;
wire eret_q_x;
reg eret_m;
wire csr_write_enable_d;                        // CSR write enable
reg csr_write_enable_x;
wire csr_write_enable_q_x;

wire bus_error_d;                               // Indicates an bus error occured while fetching the instruction in this pipeline stage
reg bus_error_x;

reg [`LM32_WORD_RNG] d_result_0;                // Result of instruction in D stage (operand 0)
reg [`LM32_WORD_RNG] d_result_1;                // Result of instruction in D stage (operand 1)
reg [`LM32_WORD_RNG] x_result;                  // Result of instruction in X stage
reg [`LM32_WORD_RNG] m_result;                  // Result of instruction in M stage
reg [`LM32_WORD_RNG] w_result;                  // Result of instruction in W stage

reg [`LM32_WORD_RNG] operand_0_x;               // Operand 0 for X stage instruction
reg [`LM32_WORD_RNG] operand_1_x;               // Operand 1 for X stage instruction
reg [`LM32_WORD_RNG] store_operand_x;           // Data read from register to store
reg [`LM32_WORD_RNG] operand_m;                 // Operand for M stage instruction
reg [`LM32_WORD_RNG] operand_w;                 // Operand for W stage instruction

reg [`LM32_WORD_RNG] registers[0:(1<<`LM32_REG_IDX_WIDTH)-1];   // Register file
wire [`LM32_WORD_RNG] reg_data_0;               // Register file read port 0 data         
wire [`LM32_WORD_RNG] reg_data_1;               // Register file read port 1 data
reg [`LM32_WORD_RNG] bypass_data_0;             // Register value 0 after bypassing
reg [`LM32_WORD_RNG] bypass_data_1;             // Register value 1 after bypassing
wire reg_write_enable_q_w;

reg interlock;                                  // Indicates pipeline should be stalled because of a read-after-write hazzard

wire stall_a;                                   // Stall instruction in A pipeline stage
wire stall_f;                                   // Stall instruction in F pipeline stage
wire stall_d;                                   // Stall instruction in D pipeline stage
wire stall_x;                                   // Stall instruction in X pipeline stage
wire stall_m;                                   // Stall instruction in M pipeline stage

// To/from adder
wire adder_op_d;                                // Whether to add or subtract
reg adder_op_x;                                 
reg adder_op_x_n;                               // Inverted version of adder_op_x
wire [`LM32_WORD_RNG] adder_result_x;           // Result from adder
wire adder_overflow_x;                          // Whether a signed overflow occured
wire adder_carry_n_x;                           // Whether a carry was generated

// To/from logical operations unit
wire [`LM32_LOGIC_OP_RNG] logic_op_d;           // Which operation to perform
reg [`LM32_LOGIC_OP_RNG] logic_op_x;            
wire [`LM32_WORD_RNG] logic_result_x;           // Result of logical operation

`ifdef CFG_SIGN_EXTEND_ENABLED
// From sign-extension unit
wire [`LM32_WORD_RNG] sextb_result_x;           // Result of byte sign-extension
wire [`LM32_WORD_RNG] sexth_result_x;           // Result of half-word sign-extenstion
wire [`LM32_WORD_RNG] sext_result_x;            // Result of sign-extension specified by instruction
`endif

// To/from shifter
`ifdef CFG_PL_BARREL_SHIFT_ENABLED
wire direction_d;                               // Which direction to shift in
reg direction_x;                                        
reg direction_m;
wire [`LM32_WORD_RNG] shifter_result_m;         // Result of shifter
`endif
`ifdef CFG_MC_BARREL_SHIFT_ENABLED
wire shift_left_d;                              // Indicates whether to perform a left shift or not
wire shift_left_q_d;
wire shift_right_d;                             // Indicates whether to perform a right shift or not
wire shift_right_q_d;
`endif
`ifdef LM32_NO_BARREL_SHIFT
wire [`LM32_WORD_RNG] shifter_result_x;         // Result of single-bit right shifter
`endif

// To/from multiplier
`ifdef LM32_MULTIPLY_ENABLED
wire [`LM32_WORD_RNG] multiplier_result_w;      // Result from multiplier
`endif
`ifdef CFG_MC_MULTIPLY_ENABLED
wire multiply_d;                                // Indicates whether to perform a multiply or not
wire multiply_q_d;
`endif

// To/from divider
`ifdef CFG_MC_DIVIDE_ENABLED
wire divide_d;                                  // Indicates whether to perform a divider or not
wire divide_q_d;
wire modulus_d;
wire modulus_q_d;
wire divide_by_zero_x;                          // Indicates an attempt was made to divide by zero
`endif

// To from multi-cycle arithmetic unit
`ifdef LM32_MC_ARITHMETIC_ENABLED
wire mc_stall_request_x;                        // Multi-cycle arithmetic unit stall request
wire [`LM32_WORD_RNG] mc_result_x;
`endif

// From CSRs
wire [`LM32_WORD_RNG] interrupt_csr_read_data_x;// Data read from interrupt CSRs
wire [`LM32_WORD_RNG] cfg;                      // Configuration CSR
reg [`LM32_WORD_RNG] csr_read_data_x;           // Data read from CSRs

// To/from instruction unit
wire [`LM32_PC_RNG] pc_f;                       // PC of instruction in F stage
wire [`LM32_PC_RNG] pc_d;                       // PC of instruction in D stage
wire [`LM32_PC_RNG] pc_x;                       // PC of instruction in X stage
wire [`LM32_PC_RNG] pc_m;                       // PC of instruction in M stage
wire [`LM32_PC_RNG] pc_w;                       // PC of instruction in W stage
wire [`LM32_INSTRUCTION_RNG] instruction_d;     // Instruction in D stage

// To/from load/store unit
wire [`LM32_WORD_RNG] load_data_w;              // Result of a load instruction
wire stall_wb_load;                             // Stall pipeline because of a load via the data Wishbone interface

// To/from JTAG interface

// Hazzard detection
wire raw_x_0;                                   // RAW hazzard between instruction in X stage and read port 0
wire raw_x_1;                                   // RAW hazzard between instruction in X stage and read port 1
wire raw_m_0;                                   // RAW hazzard between instruction in M stage and read port 0
wire raw_m_1;                                   // RAW hazzard between instruction in M stage and read port 1
wire raw_w_0;                                   // RAW hazzard between instruction in W stage and read port 0
wire raw_w_1;                                   // RAW hazzard between instruction in W stage and read port 1

// Control flow
wire cmp_zero;                                  // Result of comparison is zero
wire cmp_negative;                              // Result of comparison is negative
wire cmp_overflow;                              // Comparison produced an overflow
wire cmp_carry_n;                               // Comparison produced a carry, inverted
reg condition_met_x;                            // Condition of branch instruction is met
reg condition_met_m;
wire branch_taken_m;                            // Branch is taken in M stage

wire kill_f;                                    // Kill instruction in F stage
wire kill_d;                                    // Kill instruction in D stage
wire kill_x;                                    // Kill instruction in X stage
wire kill_m;                                    // Kill instruction in M stage
wire kill_w;                                    // Kill instruction in W stage

reg [`LM32_PC_WIDTH+2-1:8] eba;                 // Exception Base Address (EBA) CSR
reg [`LM32_EID_RNG] eid_x;                      // Exception ID in X stage

wire exception_x;                               // Indicates if a debug exception has occured
reg exception_m;
reg exception_w;
wire exception_q_w;

wire interrupt_exception;                       // Indicates if an interrupt exception has occured
`ifdef CFG_BUS_ERRORS_ENABLED
wire instruction_bus_error_exception;           // Indicates if an instruction bus error exception has occured
wire data_bus_error_exception;                  // Indicates if a data bus error exception has occured
`endif
`ifdef CFG_MC_DIVIDE_ENABLED
wire divide_by_zero_exception;                  // Indicates if a divide by zero exception has occured
`endif
wire system_call_exception;                     // Indicates if a system call exception has occured

`ifdef CFG_BUS_ERRORS_ENABLED
reg data_bus_error_seen;                        // Indicates if a data bus error was seen
`endif

/////////////////////////////////////////////////////
// Functions
/////////////////////////////////////////////////////

`include "lm32_functions.v"

/////////////////////////////////////////////////////
// Instantiations
///////////////////////////////////////////////////// 

// Instruction unit
lm32_instruction_unit #(
    .associativity          (icache_associativity),
    .sets                   (icache_sets),
    .bytes_per_line         (icache_bytes_per_line),
    .base_address           (icache_base_address),
    .limit                  (icache_limit)
  ) instruction_unit (
    // ----- Inputs -------
    .clk_i                  (clk_i),
    .rst_i                  (rst_i),
    // From pipeline
    .stall_a                (stall_a),
    .stall_f                (stall_f),
    .stall_d                (stall_d),
    .stall_x                (stall_x),
    .stall_m                (stall_m),
    .valid_f                (valid_f),
    .kill_f                 (kill_f),
    .branch_taken_m         (branch_taken_m),
    .branch_target_m        (branch_target_m),
`ifdef CFG_IWB_ENABLED
    // From Wishbone
    .i_dat_i                (I_DAT_I),
    .i_ack_i                (I_ACK_I),
    .i_err_i                (I_ERR_I),
    .i_rty_i                (I_RTY_I),
`endif
    // ----- Outputs -------
    // To pipeline
    .pc_f                   (pc_f),
    .pc_d                   (pc_d),
    .pc_x                   (pc_x),
    .pc_m                   (pc_m),
    .pc_w                   (pc_w),
`ifdef CFG_IWB_ENABLED
    // To Wishbone
    .i_dat_o                (I_DAT_O),
    .i_adr_o                (I_ADR_O),
    .i_cyc_o                (I_CYC_O),
    .i_sel_o                (I_SEL_O),
    .i_stb_o                (I_STB_O),
    .i_we_o                 (I_WE_O),
    .i_cti_o                (I_CTI_O),
    .i_lock_o               (I_LOCK_O),
    .i_bte_o                (I_BTE_O),
`endif
`ifdef CFG_BUS_ERRORS_ENABLED
    .bus_error_d            (bus_error_d),
`endif
    .instruction_d          (instruction_d)
    );

// Trace instructions in simulation
lm32_simtrace simtrace (
    .clk_i                  (clk_i),
    .rst_i                  (rst_i),
    .stall_x                (stall_x),
    .stall_m                (stall_m),
    .valid_w                (valid_w),
    .kill_w                 (kill_w),
    .instruction_d          (instruction_d),
    .pc_w                   (pc_w)
    );

// Instruction decoder
lm32_decoder decoder (
    // ----- Inputs -------
    .instruction            (instruction_d),
    // ----- Outputs -------
    .d_result_sel_0         (d_result_sel_0_d),
    .d_result_sel_1         (d_result_sel_1_d),
    .x_result_sel_csr       (x_result_sel_csr_d),
`ifdef LM32_MC_ARITHMETIC_ENABLED
    .x_result_sel_mc_arith  (x_result_sel_mc_arith_d),
`endif
`ifdef LM32_NO_BARREL_SHIFT    
    .x_result_sel_shift     (x_result_sel_shift_d),
`endif
`ifdef CFG_SIGN_EXTEND_ENABLED
    .x_result_sel_sext      (x_result_sel_sext_d),
`endif    
    .x_result_sel_logic     (x_result_sel_logic_d),
    .x_result_sel_add       (x_result_sel_add_d),
    .m_result_sel_compare   (m_result_sel_compare_d),
`ifdef CFG_PL_BARREL_SHIFT_ENABLED
    .m_result_sel_shift     (m_result_sel_shift_d),  
`endif    
    .w_result_sel_load      (w_result_sel_load_d),
`ifdef CFG_PL_MULTIPLY_ENABLED
    .w_result_sel_mul       (w_result_sel_mul_d),
`endif
    .x_bypass_enable        (x_bypass_enable_d),
    .m_bypass_enable        (m_bypass_enable_d),
    .read_enable_0          (read_enable_0_d),
    .read_idx_0             (read_idx_0_d),
    .read_enable_1          (read_enable_1_d),
    .read_idx_1             (read_idx_1_d),
    .write_enable           (write_enable_d),
    .write_idx              (write_idx_d),
    .immediate              (immediate_d),
    .branch_offset          (branch_offset_d),
    .load                   (load_d),
    .store                  (store_d),
    .size                   (size_d),
    .sign_extend            (sign_extend_d),
    .adder_op               (adder_op_d),
    .logic_op               (logic_op_d),
`ifdef CFG_PL_BARREL_SHIFT_ENABLED
    .direction              (direction_d),
`endif
`ifdef CFG_MC_BARREL_SHIFT_ENABLED
    .shift_left             (shift_left_d),
    .shift_right            (shift_right_d),
`endif
`ifdef CFG_MC_MULTIPLY_ENABLED
    .multiply               (multiply_d),
`endif
`ifdef CFG_MC_DIVIDE_ENABLED
    .divide                 (divide_d),
    .modulus                (modulus_d),
`endif
    .branch                 (branch_d),
    .branch_reg             (branch_reg_d),
    .condition              (condition_d),
    .scall                  (scall_d),
    .eret                   (eret_d),
    .csr_write_enable       (csr_write_enable_d)
    ); 

// Load/store unit       
lm32_load_store_unit #(
    .associativity          (dcache_associativity),
    .sets                   (dcache_sets),
    .bytes_per_line         (dcache_bytes_per_line),
    .base_address           (dcache_base_address),
    .limit                  (dcache_limit)
  ) load_store_unit (
    // ----- Inputs -------
    .clk_i                  (clk_i),
    .rst_i                  (rst_i),
    // From pipeline
    .stall_a                (stall_a),
    .stall_x                (stall_x),
    .stall_m                (stall_m),
    .kill_x                 (kill_x),
    .kill_m                 (kill_m),
    .exception_m            (exception_m),
    .store_operand_x        (store_operand_x),
    .load_store_address_x   (adder_result_x),
    .load_store_address_m   (operand_m),
    .load_store_address_w   (operand_w[1:0]),
    .load_q_x               (load_q_x),
    .load_q_m               (load_q_m),
    .store_q_m              (store_q_m),
    .sign_extend_x          (sign_extend_x),
    .size_x                 (size_x),
    // From Wishbone
    .d_dat_i                (D_DAT_I),
    .d_ack_i                (D_ACK_I),
    .d_err_i                (D_ERR_I),
    .d_rty_i                (D_RTY_I),
    // ----- Outputs -------
    // To pipeline
    .load_data_w            (load_data_w),
    .stall_wb_load          (stall_wb_load),
    // To Wishbone
    .d_dat_o                (D_DAT_O),
    .d_adr_o                (D_ADR_O),
    .d_cyc_o                (D_CYC_O),
    .d_sel_o                (D_SEL_O),
    .d_stb_o                (D_STB_O),
    .d_we_o                 (D_WE_O),
    .d_cti_o                (D_CTI_O),
    .d_lock_o               (D_LOCK_O),
    .d_bte_o                (D_BTE_O)
    );      
       
// Adder       
lm32_adder adder (
    // ----- Inputs -------
    .adder_op_x             (adder_op_x),
    .adder_op_x_n           (adder_op_x_n),
    .operand_0_x            (operand_0_x),
    .operand_1_x            (operand_1_x),
    // ----- Outputs -------
    .adder_result_x         (adder_result_x),
    .adder_carry_n_x        (adder_carry_n_x),
    .adder_overflow_x       (adder_overflow_x)
    );

// Logic operations
lm32_logic_op logic_op (
    // ----- Inputs -------
    .logic_op_x             (logic_op_x),
    .operand_0_x            (operand_0_x),

    .operand_1_x            (operand_1_x),
    // ----- Outputs -------
    .logic_result_x         (logic_result_x)
    );
              
`ifdef CFG_PL_BARREL_SHIFT_ENABLED
// Pipelined barrel-shifter
lm32_shifter shifter (
    // ----- Inputs -------
    .clk_i                  (clk_i),
    .rst_i                  (rst_i),
    .stall_x                (stall_x),
    .direction_x            (direction_x),
    .sign_extend_x          (sign_extend_x),
    .operand_0_x            (operand_0_x),
    .operand_1_x            (operand_1_x),
    // ----- Outputs -------
    .shifter_result_m       (shifter_result_m)
    );
`endif

`ifdef CFG_PL_MULTIPLY_ENABLED
// Pipeline fixed-point multiplier
lm32_multiplier multiplier (
    // ----- Inputs -------
    .clk_i                  (clk_i),
    .rst_i                  (rst_i),
    .stall_x                (stall_x),
    .stall_m                (stall_m),
    .operand_0              (d_result_0),
    .operand_1              (d_result_1),
    // ----- Outputs -------
    .result                 (multiplier_result_w)    
    );
`endif

`ifdef LM32_MC_ARITHMETIC_ENABLED
// Multi-cycle arithmetic
lm32_mc_arithmetic mc_arithmetic (
    // ----- Inputs -------
    .clk_i                  (clk_i),
    .rst_i                  (rst_i),
    .stall_d                (stall_d),
    .kill_x                 (kill_x),
`ifdef CFG_MC_DIVIDE_ENABLED                  
    .divide_d               (divide_q_d),
    .modulus_d              (modulus_q_d),
`endif
`ifdef CFG_MC_MULTIPLY_ENABLED        
    .multiply_d             (multiply_q_d),
`endif
`ifdef CFG_MC_BARREL_SHIFT_ENABLED
    .shift_left_d           (shift_left_q_d),
    .shift_right_d          (shift_right_q_d),
    .sign_extend_d          (sign_extend_d),
`endif    
    .operand_0_d            (d_result_0),
    .operand_1_d            (d_result_1),
    // ----- Outputs -------
    .result_x               (mc_result_x),
`ifdef CFG_MC_DIVIDE_ENABLED                  
    .divide_by_zero_x       (divide_by_zero_x),
`endif
    .stall_request_x        (mc_stall_request_x)
    );
`endif
              
`ifdef CFG_INTERRUPTS_ENABLED
// Interrupt unit
lm32_interrupt interrupt (
    // ----- Inputs -------
    .clk_i                  (clk_i), 
    .rst_i                  (rst_i),
    // From external devices
    .interrupt_n            (interrupt_n),
    // From pipeline
    .stall_x                (stall_x),
    .exception              (exception_q_w), 
    .eret_q_x               (eret_q_x),
    .csr                    (csr_x),
    .csr_write_data         (operand_1_x),
    .csr_write_enable       (csr_write_enable_q_x),
    // ----- Outputs -------
    .interrupt_exception    (interrupt_exception),
    // To pipeline
    .csr_read_data          (interrupt_csr_read_data_x)
    );
`endif



// Register file


/////////////////////////////////////////////////////
// Combinational Logic
/////////////////////////////////////////////////////

// Register file read ports
assign reg_data_0 = registers[read_idx_0_d];
assign reg_data_1 = registers[read_idx_1_d];

// Detect read-after-write hazzards
assign raw_x_0 = (write_idx_x == read_idx_0_d) && (write_enable_q_x == `TRUE);
assign raw_m_0 = (write_idx_m == read_idx_0_d) && (write_enable_q_m == `TRUE);
assign raw_w_0 = (write_idx_w == read_idx_0_d) && (write_enable_q_w == `TRUE);
assign raw_x_1 = (write_idx_x == read_idx_1_d) && (write_enable_q_x == `TRUE);
assign raw_m_1 = (write_idx_m == read_idx_1_d) && (write_enable_q_m == `TRUE);
assign raw_w_1 = (write_idx_w == read_idx_1_d) && (write_enable_q_w == `TRUE);

// Interlock detection - Raise an interlock for RAW hazzards 
always @*
begin
    if (   (   (x_bypass_enable_x == `FALSE)
            && (   ((read_enable_0_d == `TRUE) && (raw_x_0 == `TRUE))
                || ((read_enable_1_d == `TRUE) && (raw_x_1 == `TRUE))
               )
           )
        || (   (m_bypass_enable_m == `FALSE)
            && (   ((read_enable_0_d == `TRUE) && (raw_m_0 == `TRUE))
                || ((read_enable_1_d == `TRUE) && (raw_m_1 == `TRUE))
               )
           )
       )
        interlock = `TRUE;
    else
        interlock = `FALSE;
end

// Bypass for reg port 0
always @*
begin
    if (raw_x_0 == `TRUE)        
        bypass_data_0 = x_result;
    else if (raw_m_0 == `TRUE)
        bypass_data_0 = m_result;
    else if (raw_w_0 == `TRUE)
        bypass_data_0 = w_result;
    else
        bypass_data_0 = reg_data_0;
end

// Bypass for reg port 1
always @*
begin
    if (raw_x_1 == `TRUE)
        bypass_data_1 = x_result;
    else if (raw_m_1 == `TRUE)
        bypass_data_1 = m_result;
    else if (raw_w_1 == `TRUE)
        bypass_data_1 = w_result;
    else
        bypass_data_1 = reg_data_1;
end

// D stage result selection
always @*
begin
    d_result_0 = d_result_sel_0_d[0] ? {pc_f, 2'b00} : bypass_data_0; 
    case (d_result_sel_1_d)
    `LM32_D_RESULT_SEL_1_ZERO:      d_result_1 = {`LM32_WORD_WIDTH{1'b0}};
    `LM32_D_RESULT_SEL_1_REG_1:     d_result_1 = bypass_data_1;
    `LM32_D_RESULT_SEL_1_IMMEDIATE: d_result_1 = immediate_d;
    default:                        d_result_1 = {`LM32_WORD_WIDTH{1'bx}};
    endcase
end

`ifdef CFG_SIGN_EXTEND_ENABLED
// Sign-extension
assign sextb_result_x = {{24{operand_0_x[7]}}, operand_0_x[7:0]};
assign sexth_result_x = {{16{operand_0_x[15]}}, operand_0_x[15:0]};
assign sext_result_x = size_x == `LM32_SIZE_BYTE ? sextb_result_x : sexth_result_x;
`endif

`ifdef LM32_NO_BARREL_SHIFT
// Only single bit shift operations are supported when barrel-shifter isn't implemented
assign shifter_result_x = {operand_0_x[`LM32_WORD_WIDTH-1] & sign_extend_x, operand_0_x[`LM32_WORD_WIDTH-1:1]};
`endif

// Condition evaluation
assign cmp_zero = operand_0_x == operand_1_x;
assign cmp_negative = adder_result_x[`LM32_WORD_WIDTH-1];
assign cmp_overflow = adder_overflow_x;
assign cmp_carry_n = adder_carry_n_x;
always @*
begin
    case (condition_x)
    `LM32_CONDITION_U1:   condition_met_x = `TRUE;
    `LM32_CONDITION_U2:   condition_met_x = `TRUE;
    `LM32_CONDITION_E:    condition_met_x = cmp_zero;
    `LM32_CONDITION_NE:   condition_met_x = !cmp_zero;
    `LM32_CONDITION_G:    condition_met_x = !cmp_zero && (cmp_negative == cmp_overflow);
    `LM32_CONDITION_GU:   condition_met_x = cmp_carry_n && !cmp_zero;
    `LM32_CONDITION_GE:   condition_met_x = cmp_negative == cmp_overflow;
    `LM32_CONDITION_GEU:  condition_met_x = cmp_carry_n;
    default:              condition_met_x = 1'bx;
    endcase 
end

// X stage result selection
always @*
begin
    x_result =   x_result_sel_add_x ? adder_result_x 
               : x_result_sel_csr_x ? csr_read_data_x
`ifdef CFG_SIGN_EXTEND_ENABLED
               : x_result_sel_sext_x ? sext_result_x
`endif
`ifdef LM32_NO_BARREL_SHIFT
               : x_result_sel_shift_x ? shifter_result_x
`endif
`ifdef LM32_MC_ARITHMETIC_ENABLED
               : x_result_sel_mc_arith_x ? mc_result_x
`endif
               : logic_result_x;
end

// M stage result selection
always @*
begin
    m_result =   m_result_sel_compare_m ? {{`LM32_WORD_WIDTH-1{1'b0}}, condition_met_m}
`ifdef CFG_PL_BARREL_SHIFT_ENABLED
               : m_result_sel_shift_m ? shifter_result_m
`endif
               : operand_m; 
end

// W stage result selection
always @*
begin
    w_result =    w_result_sel_load_w ? load_data_w
`ifdef CFG_PL_MULTIPLY_ENABLED
                : w_result_sel_mul_w ? multiplier_result_w
`endif
                : operand_w;
end


// Indicate when a branch should be taken in M stage (exceptions are a type of branch)
assign branch_taken_m =      (stall_m == `FALSE) 
                          && (   (   (branch_m == `TRUE) 
                                  && (condition_met_m == `TRUE) 
                                  && (valid_m == `TRUE)
                                 ) 
                              || (exception_m == `TRUE)
                             );

// Generate signal that will kill instructions in each pipeline stage when necessary
assign kill_f =    (branch_taken_m == `TRUE) 
                ;
assign kill_d =    (branch_taken_m == `TRUE) 
                ;
assign kill_x =    (branch_taken_m == `TRUE) 
                ;
assign kill_m =    `FALSE
                ;                
assign kill_w =    `FALSE
                ;

// Exceptions

`ifdef CFG_BUS_ERRORS_ENABLED
assign instruction_bus_error_exception = bus_error_x == `TRUE;
assign data_bus_error_exception = data_bus_error_seen == `TRUE;
`endif
`ifdef CFG_MC_DIVIDE_ENABLED
assign divide_by_zero_exception = divide_by_zero_x == `TRUE;
`endif
assign system_call_exception = scall_x == `TRUE;

assign exception_x =           (system_call_exception == `TRUE)
`ifdef CFG_BUS_ERRORS_ENABLED
                            || (instruction_bus_error_exception == `TRUE)
                            || (data_bus_error_exception == `TRUE)
`endif
`ifdef CFG_MC_DIVIDE_ENABLED
                            || (divide_by_zero_exception == `TRUE)
`endif
`ifdef CFG_INTERRUPTS_ENABLED
                            || (   (interrupt_exception == `TRUE)
                               )
`endif
                            ;

// Exception ID
always @*
begin
`ifdef CFG_BUS_ERRORS_ENABLED
         if (instruction_bus_error_exception == `TRUE)
        eid_x = `LM32_EID_INST_BUS_ERROR;
    else
`endif
`ifdef CFG_BUS_ERRORS_ENABLED
         if (data_bus_error_exception == `TRUE)
        eid_x = `LM32_EID_DATA_BUS_ERROR;
    else
`endif
`ifdef CFG_MC_DIVIDE_ENABLED
         if (divide_by_zero_exception == `TRUE)
        eid_x = `LM32_EID_DIVIDE_BY_ZERO;
    else
`endif
`ifdef CFG_INTERRUPTS_ENABLED
         if (   (interrupt_exception == `TRUE)
            )
        eid_x = `LM32_EID_INTERRUPT;
    else
`endif
        eid_x = `LM32_EID_SCALL;
end

// Stall generation

assign stall_a = (stall_f == `TRUE);
                
assign stall_f = (stall_d == `TRUE);
                
assign stall_d =   (stall_x == `TRUE) 
                || (   (interlock == `TRUE)
                    && (kill_d == `FALSE)
                   ) 
                || (   (eret_d == `TRUE)
                    && (load_q_x == `TRUE)
                   )
                || (   (csr_write_enable_d == `TRUE)
                    && (load_q_x == `TRUE)
                   )                      
                ;
                
assign stall_x =    (stall_m == `TRUE)
`ifdef LM32_MC_ARITHMETIC_ENABLED
                 || (   (mc_stall_request_x == `TRUE)
                     && (kill_x == `FALSE)
                    ) 
`endif
                 ;

assign stall_m =    (stall_wb_load == `TRUE)
                 || (   (D_CYC_O == `TRUE)
                     && (   (store_m == `TRUE)
                         || (load_m == `TRUE)
                         || (load_x == `TRUE)
                        ) 
                    ) 
`ifdef CFG_IWB_ENABLED
                 || (I_CYC_O == `TRUE)            
`endif                               
                 ;      

// Qualify state changing control signals
`ifdef LM32_MC_ARITHMETIC_ENABLED
wire   q_d = (valid_d == `TRUE) && (kill_d == `FALSE);
`endif
`ifdef CFG_MC_BARREL_SHIFT_ENABLED
assign shift_left_q_d = (shift_left_d == `TRUE) && (q_d == `TRUE);
assign shift_right_q_d = (shift_right_d == `TRUE) && (q_d == `TRUE);
`endif
`ifdef CFG_MC_MULTIPLY_ENABLED
assign multiply_q_d = (multiply_d == `TRUE) && (q_d == `TRUE);
`endif
`ifdef CFG_MC_DIVIDE_ENABLED
assign divide_q_d = (divide_d == `TRUE) && (q_d == `TRUE);
assign modulus_q_d = (modulus_d == `TRUE) && (q_d == `TRUE);
`endif
wire   q_x = (valid_x == `TRUE) && (kill_x == `FALSE);
assign csr_write_enable_q_x = (csr_write_enable_x == `TRUE) && (q_x == `TRUE);
assign eret_q_x = (eret_x == `TRUE) && (q_x == `TRUE);
assign load_q_x = (load_x == `TRUE) 
               && (q_x == `TRUE)
                  ;
wire   q_m = (valid_m == `TRUE) && (kill_m == `FALSE) && (exception_m == `FALSE);
assign load_q_m = (load_m == `TRUE) && (q_m == `TRUE);
assign store_q_m = (store_m == `TRUE) && (q_m == `TRUE);
assign exception_q_w = ((exception_w == `TRUE) && (valid_w == `TRUE));        
// Don't qualify register write enables with kill, as the signal is needed early, and it doesn't matter if the instruction is killed (except for the actual write - but that is handled separately)
assign write_enable_q_x = (write_enable_x == `TRUE) && (valid_x == `TRUE);
assign write_enable_q_m = (write_enable_m == `TRUE) && (valid_m == `TRUE);
assign write_enable_q_w = (write_enable_w == `TRUE) && (valid_w == `TRUE);
// The enable that actually does write the registers needs to be qualified with kill
assign reg_write_enable_q_w = (write_enable_w == `TRUE) && (kill_w == `FALSE) && (valid_w == `TRUE);

// Configuration (CFG) CSR
assign cfg = {
              `LM32_REVISION,
              watchpoints[3:0],
              breakpoints[3:0],
              interrupts[5:0],
              `FALSE,
              `FALSE,
              `FALSE,
              `FALSE,
              `FALSE,
              `FALSE,
              `FALSE,
              `FALSE,
`ifdef CFG_SIGN_EXTEND_ENABLED
              `TRUE,
`else
              `FALSE,
`endif
`ifdef LM32_BARREL_SHIFT_ENABLED
              `TRUE,
`else
              `FALSE,
`endif
`ifdef CFG_MC_DIVIDE_ENABLED
              `TRUE,
`else
              `FALSE,
`endif
`ifdef LM32_MULTIPLY_ENABLED 
              `TRUE
`else
              `FALSE
`endif
              };

// Extract CSR index
assign csr_d = read_idx_0_d[`LM32_CSR_RNG];

// CSR reads
always @*
begin
    case (csr_x)
    `LM32_CSR_IE,
    `LM32_CSR_IM,
    `LM32_CSR_IP:   csr_read_data_x = interrupt_csr_read_data_x;  
    `LM32_CSR_CFG:  csr_read_data_x = cfg;
    `LM32_CSR_EBA:  csr_read_data_x = {eba, 8'h00};
    default:        csr_read_data_x = {`LM32_WORD_WIDTH{1'bx}};
    endcase
end

/////////////////////////////////////////////////////
// Sequential Logic
/////////////////////////////////////////////////////

// Exception Base Address (EBA) CSR
always @(posedge clk_i `CFG_RESET_SENSITIVITY)
begin
    if (rst_i == `TRUE)
        eba <= eba_reset[`LM32_PC_WIDTH+2-1:8];
    else
    begin
        if ((csr_write_enable_q_x == `TRUE) && (csr_x == `LM32_CSR_EBA) && (stall_x == `FALSE))
            eba <= operand_1_x[`LM32_PC_WIDTH+2-1:8];
    end
end

	
`ifdef CFG_BUS_ERRORS_ENABLED
// Watch for data bus errors
always @(posedge clk_i `CFG_RESET_SENSITIVITY)
begin
    if (rst_i == `TRUE)
        data_bus_error_seen <= `FALSE;
    else
    begin
        // Set flag when bus error is detected
        if ((D_ERR_I == `TRUE) && (D_CYC_O == `TRUE))
            data_bus_error_seen <= `TRUE;
        // Clear flag when exception is taken
        if ((exception_m == `TRUE) && (kill_m == `FALSE))
            data_bus_error_seen <= `FALSE;
    end
end
`endif
 
// Valid bits to indicate whether an instruction in a partcular pipeline stage is valid or not  


always @(posedge clk_i `CFG_RESET_SENSITIVITY)
begin
    if (rst_i == `TRUE)
    begin
        valid_f <= `FALSE;
        valid_d <= `FALSE;
        valid_x <= `FALSE;
        valid_m <= `FALSE;
        valid_w <= `FALSE;
    end
    else
    begin    
        if ((kill_f == `TRUE) || (stall_a == `FALSE))
            valid_f <= `TRUE;
        else if (stall_f == `FALSE)
            valid_f <= `FALSE;            
        if (kill_d == `TRUE)
            valid_d <= `FALSE;
        else if (stall_f == `FALSE)
            valid_d <= valid_f & !kill_f;
        else if (stall_d == `FALSE)
            valid_d <= `FALSE;
        if (kill_x == `TRUE)
            valid_x <= `FALSE;
        else if (stall_d == `FALSE)
            valid_x <= valid_d & !kill_d;
        else if (stall_x == `FALSE)
            valid_x <= `FALSE;
        if (kill_m == `TRUE)
            valid_m <= `FALSE;
        else if (stall_x == `FALSE)
            valid_m <= valid_x & !kill_x;
        else if (stall_m == `FALSE)
            valid_m <= `FALSE;
        if (stall_m == `FALSE)
            valid_w <= valid_m & !kill_m;
        else 
            valid_w <= `FALSE;        
    end
end

// Microcode pipeline registers
always @(posedge clk_i `CFG_RESET_SENSITIVITY)
begin
    if (rst_i == `TRUE)
    begin
        operand_0_x <= {`LM32_WORD_WIDTH{1'b0}};
        operand_1_x <= {`LM32_WORD_WIDTH{1'b0}};
        store_operand_x <= {`LM32_WORD_WIDTH{1'b0}};
        branch_target_x <= {`LM32_WORD_WIDTH{1'b0}};        
        x_result_sel_csr_x <= `FALSE;
`ifdef LM32_MC_ARITHMETIC_ENABLED
        x_result_sel_mc_arith_x <= `FALSE;
`endif
`ifdef LM32_NO_BARREL_SHIFT    
        x_result_sel_shift_x <= `FALSE;
`endif
`ifdef CFG_SIGN_EXTEND_ENABLED
        x_result_sel_sext_x <= `FALSE;
`endif    
        x_result_sel_logic_x <= `FALSE;
        x_result_sel_add_x <= `FALSE;
        m_result_sel_compare_x <= `FALSE;
`ifdef CFG_PL_BARREL_SHIFT_ENABLED
        m_result_sel_shift_x <= `FALSE;
`endif    
        w_result_sel_load_x <= `FALSE;
`ifdef CFG_PL_MULTIPLY_ENABLED
        w_result_sel_mul_x <= `FALSE;
`endif
        x_bypass_enable_x <= `FALSE;
        m_bypass_enable_x <= `FALSE;
        write_enable_x <= `FALSE;
        write_idx_x <= {`LM32_REG_IDX_WIDTH{1'b0}};
        csr_x <= {`LM32_CSR_WIDTH{1'b0}};
        load_x <= `FALSE;
        store_x <= `FALSE;
        size_x <= {`LM32_SIZE_WIDTH{1'b0}};
        sign_extend_x <= `FALSE;
        adder_op_x <= `FALSE;
        adder_op_x_n <= `FALSE;
        logic_op_x <= 4'h0;
`ifdef CFG_PL_BARREL_SHIFT_ENABLED
        direction_x <= `FALSE;
`endif
        branch_x <= `FALSE;
        condition_x <= `LM32_CONDITION_U1;
        scall_x <= `FALSE;
        eret_x <= `FALSE;
`ifdef CFG_BUS_ERRORS_ENABLED
        bus_error_x <= `FALSE;
`endif
        csr_write_enable_x <= `FALSE;
        operand_m <= {`LM32_WORD_WIDTH{1'b0}};
        branch_target_m <= {`LM32_WORD_WIDTH{1'b0}};
        m_result_sel_compare_m <= `FALSE;
`ifdef CFG_PL_BARREL_SHIFT_ENABLED
        m_result_sel_shift_m <= `FALSE;
`endif    
        w_result_sel_load_m <= `FALSE;
`ifdef CFG_PL_MULTIPLY_ENABLED
        w_result_sel_mul_m <= `FALSE;
`endif
        m_bypass_enable_m <= `FALSE;
        branch_m <= `FALSE;
        exception_m <= `FALSE;
        load_m <= `FALSE;
        store_m <= `FALSE;
`ifdef CFG_PL_BARREL_SHIFT_ENABLED
        direction_m <= `FALSE;
`endif
        write_enable_m <= `FALSE;            
        write_idx_m <= {`LM32_REG_IDX_WIDTH{1'b0}};
        condition_met_m <= `FALSE;
        operand_w <= {`LM32_WORD_WIDTH{1'b0}};        
        w_result_sel_load_w <= `FALSE;
`ifdef CFG_PL_MULTIPLY_ENABLED
        w_result_sel_mul_w <= `FALSE;
`endif
        write_idx_w <= {`LM32_REG_IDX_WIDTH{1'b0}};        
        write_enable_w <= `FALSE;
        exception_w <= `FALSE;
    end
    else
    begin
        // D/X stage registers
       
        if (stall_x == `FALSE)
        begin
            operand_0_x <= d_result_0;
            operand_1_x <= d_result_1;
            store_operand_x <= bypass_data_1;
            branch_target_x <= branch_reg_d == `TRUE ? bypass_data_0[`LM32_PC_RNG] : pc_d + branch_offset_d;            
            x_result_sel_csr_x <= x_result_sel_csr_d;
`ifdef LM32_MC_ARITHMETIC_ENABLED
            x_result_sel_mc_arith_x <= x_result_sel_mc_arith_d;
`endif
`ifdef LM32_NO_BARREL_SHIFT    
            x_result_sel_shift_x <= x_result_sel_shift_d;
`endif
`ifdef CFG_SIGN_EXTEND_ENABLED
            x_result_sel_sext_x <= x_result_sel_sext_d;
`endif    
            x_result_sel_logic_x <= x_result_sel_logic_d;
            x_result_sel_add_x <= x_result_sel_add_d;
            m_result_sel_compare_x <= m_result_sel_compare_d;
`ifdef CFG_PL_BARREL_SHIFT_ENABLED
            m_result_sel_shift_x <= m_result_sel_shift_d;
`endif    
            w_result_sel_load_x <= w_result_sel_load_d;
`ifdef CFG_PL_MULTIPLY_ENABLED
            w_result_sel_mul_x <= w_result_sel_mul_d;
`endif
            x_bypass_enable_x <= x_bypass_enable_d;
            m_bypass_enable_x <= m_bypass_enable_d;
            load_x <= load_d;
            store_x <= store_d;
            branch_x <= branch_d;
            write_idx_x <= write_idx_d;
            csr_x <= csr_d;
            size_x <= size_d;
            sign_extend_x <= sign_extend_d;
            adder_op_x <= adder_op_d;
            adder_op_x_n <= ~adder_op_d;
            logic_op_x <= logic_op_d;
`ifdef CFG_PL_BARREL_SHIFT_ENABLED
            direction_x <= direction_d;
`endif
            condition_x <= condition_d;
            csr_write_enable_x <= csr_write_enable_d;
            scall_x <= scall_d;
`ifdef CFG_BUS_ERRORS_ENABLED
            bus_error_x <= bus_error_d;
`endif
            eret_x <= eret_d;
            write_enable_x <= write_enable_d;
        end
        
        // X/M stage registers

        if (stall_m == `FALSE)
        begin
            operand_m <= x_result;
            m_result_sel_compare_m <= m_result_sel_compare_x;
`ifdef CFG_PL_BARREL_SHIFT_ENABLED
            m_result_sel_shift_m <= m_result_sel_shift_x;
`endif    
            if (exception_x == `TRUE)
            begin
                w_result_sel_load_m <= `FALSE;
`ifdef CFG_PL_MULTIPLY_ENABLED
                w_result_sel_mul_m <= `FALSE;
`endif
            end
            else
            begin
                w_result_sel_load_m <= w_result_sel_load_x;
`ifdef CFG_PL_MULTIPLY_ENABLED
                w_result_sel_mul_m <= w_result_sel_mul_x;
`endif
            end
            m_bypass_enable_m <= m_bypass_enable_x;
`ifdef CFG_PL_BARREL_SHIFT_ENABLED
            direction_m <= direction_x;
`endif
            load_m <= load_x;
            store_m <= store_x;
            branch_m <= branch_x;
            if (exception_x == `TRUE)
                write_idx_m <= `LM32_EA_REG;
            else 
                write_idx_m <= write_idx_x;
            condition_met_m <= condition_met_x;
            branch_target_m <= exception_x == `TRUE ? {eba, eid_x, {3{1'b0}}} : branch_target_x;
            eret_m <= eret_q_x;
            write_enable_m <= exception_x == `TRUE ? `TRUE : write_enable_x;            
        end
        
        // State changing regs
        if (stall_m == `FALSE)
        begin
            if ((exception_x == `TRUE) && (q_x == `TRUE) && (stall_x == `FALSE))
                exception_m <= `TRUE;
            else 
                exception_m <= `FALSE;
        end
                
        // M/W stage registers

        operand_w <= exception_m == `TRUE ? {pc_m, 2'b00} : m_result;        
        w_result_sel_load_w <= w_result_sel_load_m;
`ifdef CFG_PL_MULTIPLY_ENABLED
        w_result_sel_mul_w <= w_result_sel_mul_m;
`endif
        write_idx_w <= write_idx_m;
        write_enable_w <= write_enable_m;
        exception_w <= exception_m;
    end
end


// Register file write port
// Adding a reset causes a huge slowdown and requires lots of extra LUTs
always @(posedge clk_i)
begin
    if (reg_write_enable_q_w == `TRUE)
        registers[write_idx_w] <= w_result;
end


/////////////////////////////////////////////////////
// Behavioural Logic
/////////////////////////////////////////////////////

// synthesis translate_off            

// Reset register 0. Only needed for simulation. 
initial
begin
    registers[0] = {`LM32_WORD_WIDTH{1'b0}};
end

// synthesis translate_on
        
endmodule 
