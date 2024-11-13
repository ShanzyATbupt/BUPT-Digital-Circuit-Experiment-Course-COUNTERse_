// 计数器模块
module counter(
    input wire clk,
    input wire rst_n,
    input wire pause_state,  // 暂停状态输入
    output reg [3:0] ones,
    output reg [3:0] tens
);

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        ones <= 4'd0;
        tens <= 4'd0;
    end
    else if (!pause_state) begin  // 非暂停状态时计数
        if (ones == 4'd9) begin
            ones <= 4'd0;
            if (tens == 4'd1) begin
                tens <= 4'd0;
            end
            else begin
                tens <= tens + 1'b1;
            end
        end
        else begin
            ones <= ones + 1'b1;
        end
    end
	 else begin
		ones <= ones;
		tens <= tens;
	end
end

endmodule
