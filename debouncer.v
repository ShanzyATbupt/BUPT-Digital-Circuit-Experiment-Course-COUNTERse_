module debounce(
    input wire clk,
    input wire rst_n,
    input wire key_in,    // 低电平有效的按键输入
    output reg pause_state // 暂停状态标志
);

reg [2:0] count;  // 增加位宽，增加防抖时间
reg key_reg1, key_reg2;
wire key_edge;

initial begin
    pause_state <= 1'b0;
    count <= 3'b111;  // 初始化计数器
end

// 两级寄存器消抖
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        key_reg1 <= 1'b1;
        key_reg2 <= 1'b1;
    end
    else begin
        key_reg1 <= key_in;
        key_reg2 <= key_reg1;
    end
end

// 检测按键下降沿
assign key_edge = key_reg2 & ~key_reg1;

// 消抖计数器和状态切换
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        count <= 3'b111;
        pause_state <= 1'b0;  // 复位时不暂停
    end
    else begin
        if (key_edge) begin  // 检测到按键按下
            count <= 3'd0;
        end
        else if (count < 3'd2) begin  // 延长防抖时间，等到稳定后才翻转
            count <= count + 1'b1;
        end
        else if (count == 3'd2) begin
            count <= count + 1'b1;  // 保持 count 在稳定状态
            pause_state <= ~pause_state;  // 切换暂停状态
        end
    end
end

endmodule