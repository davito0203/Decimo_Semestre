//---------------------------------------------------------------------------
// Wishbone General Pupose IO Component
//
//     0x00	
//     0x10     gpio_in    (read-only)
//     0x14     gpio_out   (read/write)
//     0x18     gpio_oe    (read/write)
//
//---------------------------------------------------------------------------

module wb_gpio (
	input              clk,
	input              reset,
	// Wishbone interface
	input              wb_stb_i,
	input              wb_cyc_i,
	output             wb_ack_o,
	input              wb_we_i,
	input       [31:0] wb_adr_i,
	input        [3:0] wb_sel_i,
	input       [31:0] wb_dat_i,
	output reg  [31:0] wb_dat_o,
	//
	output             intr,
	// IO Wires
	input       [31:0] gpio_in,
	output reg  [31:0] gpio_out,
	output reg  [31:0] gpio_oe,
	output [7:0] reloj_data,
	output [3:0] reloj_anodos
);

//---------------------------------------------------------------------------
//
//     Digital Time 
// 
//---------------------------------------------------------------------------

//--------------------------------
//    frequency divider
//--------------------------------
reg 	clk_seconds;
reg 	[27:0] counter;

//parameter n_alto=8333; //frequency of 6 kHz
//parameter n_alto = 79;  // frequency of 640 kHz
//parameter n_alto = 138889 //frequency if 3.6 kHz
parameter n_alto=50000000; // frequency of 1 Hz


initial begin
	counter=0;
	clk_seconds=0;
end	 
always @ (posedge clk) 
	begin		
		counter = counter+1;
		if(counter<=n_alto)
			clk_seconds=1;
		else
			begin
				clk_seconds=0;
				if(counter==n_alto+n_alto)
					counter=0;
			end	
	end	

//--------------------------------
//    counter minutes and hours
//--------------------------------
wire edit,advance_hours,advance_minutes;
assign edit = gpio_in[1];
assign advance_hours = gpio_in[2];
assign advance_minutes = gpio_in[0];

reg [5:0] seconds, minutes, hours;

initial begin
	seconds=6'd0;
	minutes=6'd0;
	hours=6'd0;
end

always @ (posedge clk_seconds)
	begin
		if(edit)
			begin
				seconds=6'd0;
				if(advance_hours)
					if(hours==6'd12)  //== 6'd23   when is used with AM or PM
						hours=6'd1;  // =6'd0
					else
						hours = hours+1;	
				if(advance_minutes)
					if(minutes==6'd59)
						minutes=6'd0;
					else
						minutes = minutes+1;	
			end
		else
			if(seconds == 6'd59)
			begin
				seconds=6'd0;
				if (minutes ==6'd59)
				begin
					minutes=6'd0;
					if(hours == 6'd12)	//== 6'd23   when is used with AM or PM
						hours =6'd1;     // =6'd0
					else
						hours = hours+1;
				end					
				else
					minutes = minutes+1;
			end
			else
				seconds=seconds+1;			
	
	end


//---------------------------------------------------------------------------
// register and operation clock
//---------------------------------------------------------------------------

reg mode;
reg [31:0] display1, display0;

wire [7:0]  datahours, dataminutes ; 
assign datahours = mode ? {2'b0,hours} : display1;
assign dataminutes = mode ? {2'b0,minutes} : display0;


//---------------------------------------------------------------------------
// Hardware implementation
//---------------------------------------------------------------------------

segmentos reloj0(
	.clk(		clk	),
	.enable(	1'b1	),
	.reset(		reset	),
	.datahours(  datahours	),
	.dataminutes(dataminutes),
	.datapoints(~{1'b0,clk_seconds,2'b0}),
	.bcd(	reloj_data	),
	.anodos( reloj_anodos	)
    );

//---------------------------------------------------------------------------
// Signal of control from wishbone
//---------------------------------------------------------------------------

wire [31:0] gpiocr = 32'b0;

reg  ack;
assign wb_ack_o = wb_stb_i & wb_cyc_i & ack;

wire wb_rd = wb_stb_i & wb_cyc_i & ~wb_we_i;
wire wb_wr = wb_stb_i & wb_cyc_i &  wb_we_i;

always @(posedge clk)
begin
	if (reset) begin
		ack      <= 0;
		gpio_out <= 'b0;
	end else begin
		// Handle WISHBONE access
		ack    <= 0;

		if (wb_rd & ~ack) begin           // read cycle
			ack <= 1;

			case (wb_adr_i[7:0])
			'h00: wb_dat_o <= gpiocr;
			'h04: wb_dat_o <= {31'b0,mode};
			'h08: wb_dat_o <= {26'b0,hours};
			'h0c: wb_dat_o <= {26'b0,minutes};
			'h10: wb_dat_o <= gpio_in;
			'h14: wb_dat_o <= gpio_out;
			'h18: wb_dat_o <= gpio_oe;
			default: wb_dat_o <= 32'b0;
			endcase
		end else if (wb_wr & ~ack ) begin // write cycle
			ack <= 1;

			case (wb_adr_i[7:0])
			'h00: begin
			end
			'h04: mode <= wb_dat_i[0];
			'h08: display1 <= wb_dat_i;
			'h0c: display0 <= wb_dat_i;
			'h14: gpio_out <= wb_dat_i;
			'h18: gpio_oe  <= wb_dat_i;
			endcase
		end
	end
end


endmodule
