module Port
#(
    parameter BUFFER_LENGTH = 8,
    parameter LOG_BUFFER_LENGTH = 3,
    parameter WORD_WIDTH = 128
)
(
    input clk,
    input rst,
    input [WORD_WIDTH - 1: 0] data_in,
    input read_enable,
    input write_enable,

    output reg [WORD_WIDTH - 1: 0] data_out,

    output empty,
    output reg is_writing
);

reg [LOG_BUFFER_LENGTH - 1: 0] write_ptr = 0;
reg [LOG_BUFFER_LENGTH - 1: 0] read_ptr = 0;
reg [LOG_BUFFER_LENGTH - 1: 0] buffered_data_length = 0;

reg [WORD_WIDTH - 1: 0] memory [0: BUFFER_LENGTH - 1];

wire have_data;

reg access_granted = 0;

assign empty = (buffered_data_length == 0);
assign have_data = (buffered_data_length > 0);

always @(posedge clk, posedge rst) begin
    if (rst) begin : reset_if
        integer i;
        for (i = 0; i < BUFFER_LENGTH; i = i + 1) begin
            memory[i] <= 0;
        end
        read_ptr <= 0;
        write_ptr <= 0;
        buffered_data_length <= 0;
        is_writing = 0;
    end
    else begin : normal
        if (access_granted) begin
            if (have_data) begin
                data_out = memory[read_ptr];
                read_ptr = read_ptr + 1;
                buffered_data_length = buffered_data_length - 1;
                is_writing = 1;  
            end
            else begin
                access_granted = 0;
                is_writing = 0;
            end
        end

        else begin
            is_writing = 0;
            if (read_enable & have_data) begin
                access_granted = 1;
                
            end
        end

        if (write_enable && buffered_data_length < BUFFER_LENGTH) begin
            memory[write_ptr] = data_in;
            write_ptr = write_ptr + 1;
            buffered_data_length = buffered_data_length + 1;
        end
    end
end

endmodule