//-----------------------------------------------------
// Design Name : periferic_ADC  
// File Name   : periferic_ADC.v
// designed by: SuperJairo
//-----------------------------------------------------
module periferic_ADC ( 	
	input              clk,
	input              reset,
	input		   enable,
	input  [31:0]	   data_input,
 
	input  [7:0]	data_converted,
	input 		adc_oec,
	output reg 	adc_clk,
	output 		start,
	output reg [2:0]  select_data,
	
	output reg [7:0]  data_channel0,
	output reg [7:0]  data_channel1,
	output reg [7:0]  data_channel2,
	output reg [7:0]  data_channel3,
	output reg [7:0]  data_channel4,
	output reg [7:0]  data_channel5,
	output reg [7:0]  data_channel6,
	output reg [7:0]  data_channel7
);

//////////////////////////////////////////
//
//    frequency divider for clock in adc
//
//////////////////////////////////////////

reg 	[27:0] counter;
wire enable_ADC;

parameter n_alto = 79;  // frequency of 640 kHz
//parameter n_alto=50000000; // frequency of 4 Hz

initial begin
	counter=0;
	adc_clk=0;
end	 
always @ (posedge clk) 
	begin		
		counter = counter+1;
		if(counter<=n_alto)
			adc_clk=1;
		else
			begin
				adc_clk=0;
				if(counter==n_alto+n_alto)
					counter=0;
			end	
	end	
/////////////////////////////////////////////////////////////////
//
//  Control enable ADC
//
/////////////////////////////////////////////////////////////////

assign 	enable_ADC = data_input[0];


/////////////////////////////////////////////////////////
//
//    frequency divider for signal start
//
////////////////////////////////////////////////////////

reg 	[27:0] counter2;
reg 	counter_clk;

//parameter n_alto2=625000; // frequency of 80 Hz
parameter n_alto2=12500; // frequency of 4 kHz  ///Funciona


initial begin
	counter2=0;
	counter_clk=0;
end	 
always @ (posedge clk) 
	begin		
		counter2 = counter2+1;
		if(counter2<=n_alto2)
			counter_clk=1;
		else
			begin
				counter_clk=0;
				if(counter2==n_alto2+n_alto2)
					counter2=0;
			end	
	end	

/////////////////////////////////////////////////////////////////
//
//  generation of a signal start
//
/////////////////////////////////////////////////////////////////

or signal_start (start,counter_clk,adc_oec);


/////////////////////////////////////////////////////////
//
//    frequency divider for counter on selector way  
//
////////////////////////////////////////////////////////

reg 	[27:0] counter3;
reg 	counter_clk2;

//parameter n_alto3=6250000; // frequency of 80 Hz
parameter n_alto3=250000; // frequency of 200 Hz  


initial begin
	counter3=0;
	counter_clk2=0;
end	 
always @ (posedge clk) 
	begin		
		counter3 = counter3+1;
		if(counter3<=n_alto3)
			counter_clk2=1;
		else
			begin
				counter_clk2=0;
				if(counter3==n_alto3+n_alto3)
					counter3=0;
			end	
	end	

	
/////////////////////////////////////////////////////////////////
//
//  generation of a signal select
//
/////////////////////////////////////////////////////////////////

parameter n_input = 8; // number of analog inputs on ADC

always @ (posedge counter_clk2)
begin
	if (reset) 
		begin
		select_data = 3'b0;
		end 
	else 
		if (enable_ADC)
			if (select_data == (n_input-1))
				select_data = 3'b0;
			else
				select_data = select_data + 1;
end

/////////////////////////////////////////////////////////////////
//
//  output data for each analog input signal
//
/////////////////////////////////////////////////////////////////


always @ (negedge adc_oec) 
begin
	if(reset)
		begin
		data_channel0=8'b0;
 		data_channel1=8'b0;
 		data_channel2=8'b0;
		data_channel3=8'b0;
		data_channel4=8'b0;
		data_channel5=8'b0;
		data_channel6=8'b0;
		data_channel7=8'b0;
		end
	else
		case(select_data)
			3'd0: 	data_channel0=data_converted;
			3'd1: 	data_channel1=data_converted;
			3'd2: 	data_channel2=data_converted;
			3'd3: 	data_channel3=data_converted;
			3'd4: 	data_channel4=data_converted;
			3'd5: 	data_channel5=data_converted;
			3'd6: 	data_channel6=data_converted;
			3'd7: 	data_channel7=data_converted;
			default: data_channel0=data_channel0;
		endcase
end




endmodule

