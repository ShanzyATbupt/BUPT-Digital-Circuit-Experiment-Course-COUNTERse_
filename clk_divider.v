// 分频器模块
module freq_div(
    input wire clk_in,
    input wire rst_n,
    output reg clk_out
);

reg [5:0] count;  // 计数器，100分频需要7位

always @(posedge clk_in or negedge rst_n) begin
    if (!rst_n) begin
        count <= 6'd0;
        clk_out <= 1'b0;
    end
    else if (count == 6'd49) begin  // 100Hz到1Hz需要除以100
        count <= 6'd0;
        clk_out <= ~clk_out;
    end
    else begin
        count <= count + 1'b1;
    end
end
endmodule