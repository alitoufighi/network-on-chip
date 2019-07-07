module switch 
#(
    parameter X = 1,
    parameter Y = 1
)
(
    input clk,
    input rst,

    ////////////////////////////////
    input [127:0] data_in [0:4],
    input [4:0] is_writing_in, // is 1 when input port is writing (has access granted)
    input [4:0] have_data, // input port says I have data

    output [4:0] read_enable, // to tell input port give me data

    ////////////////////////////////

    output [127:0] data_out [0:4],
    output [4:0] is_wirting_out,
);

    reg [2:0] routing_table [0:4];
    reg [4:0] routing_table_valid;
    reg [4:0] output_port_occupied;

    wire [31:0] src_ip;
    wire [31:0] dst_ip;
    assign src_ip = 

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            integer i;
            for (i = 0; i < 5; i = i + 1) begin
                // routing_table[i] <= 0;
                routing_table_valid[i] <= 0;
                output_port_occupied[i] <= 0;
            end
        end
        integer i;
        for (i = 0; i < 5; i = i + 1) begin
            if (have_data[i]) begin
                if (routing_table_valid[i]) begin

                end
                else begin // figure out which output port to be forwarded
                    // using data_in[i]
                    if (~output_port_occupied[0]) begin // 0 should be assigned using routing algorithm
                        routing_table[i] <= 0; // or which output port?
                        routing_table_valid[i] <= 1;
                        read_enable[i] <= 1;
                        output_port_occupied[0] <= 1;
                        // data_in[i] is 64 bits long as in is this format:
                        // +----------------+----------------+
                        // 63               31               0
                        //      DEST_IP            SRC_IP
                        //
                        // Each IP address is in this format:
                        // +----------------+----------------+
                        // 31               15               0
                        //        X                 Y
                        //
                        // So, data_in[63:46] is X of destination
                        // and data_in[45:32] is Y of destination
                        if (data_in[63:46] > X) begin

                        end
                        else begin
                          
                        end
                    end
                    
                end
            end
            
        end
    end
endmodule