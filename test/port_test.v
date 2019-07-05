module port_test
#(
    parameter BUFFER_LENGTH = 8,
    parameter LOG_BUFFER_LENGTH = 3,
    parameter WORD_WIDTH = 8
)
();
	reg clk = 0, rst = 0;
	reg[WORD_WIDTH - 1: 0] data_in;
	wire[WORD_WIDTH - 1: 0] data_middle, data_out;
	
	reg in_read_enable;
	reg out_write_enable;

	wire out_read_enable, out_empty, out_is_writing;
	wire in_write_enable, in_empty, in_is_writing;

	assign out_read_enable = in_empty;
	assign in_write_enable = out_is_writing;
	
	Port 
	#(
			.BUFFER_LENGTH(BUFFER_LENGTH),
			.LOG_BUFFER_LENGTH(LOG_BUFFER_LENGTH),
			.WORD_WIDTH(WORD_WIDTH)
	)
	output_port(
			.clk(clk),
			.rst(rst),
			.data_in(data_in),
			.read_enable(out_read_enable),
			.write_enable(out_write_enable),

			.data_out(data_middle),

			.empty(out_empty),
			.is_writing(out_is_writing)
	);

	Port
	#(
			.BUFFER_LENGTH(BUFFER_LENGTH),
			.LOG_BUFFER_LENGTH(LOG_BUFFER_LENGTH),
			.WORD_WIDTH(WORD_WIDTH)
	)
	input_port(
			.clk(clk),
			.rst(rst),
			.data_in(data_middle),
			.read_enable(in_read_enable),
			.write_enable(in_write_enable),

			.data_out(data_out),

			.empty(in_empty),
			.is_writing(in_is_writing)
	);

	initial begin
		in_read_enable = 0;
		
		#10 rst = 1;
		#10 rst = 0;

		#10 clk = 1;
		#10 clk = 0;
		#5 data_in = 8'b00000001;
		#0 out_write_enable = 1;
		#5 clk = 1;
		#10 clk = 0;
		
		#5 data_in = 8'b00000010;
		#5 clk = 1;
		#10 clk = 0;

		#5 data_in = 8'b00000011;
		#5 clk = 1;
		#10 clk = 0;

		#5 data_in = 8'b00000100;
		#5 clk = 1;
		#10 clk = 0;

		#5 out_write_enable = 0;
		#5 clk = 1;
		#10 clk = 0;

		#10 clk = 1;
		#10 clk = 0;
		#5 in_read_enable = 1;
		#5 clk = 1;
		#10 clk = 0;
		#10 clk = 1;
		#10 clk = 0;
		#10 clk = 1;
		#10 clk = 0;
		#10 clk = 1;
		#10 clk = 0;
		#10 clk = 1;
		#10 clk = 0;
		
	end

endmodule