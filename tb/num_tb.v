module num_tb;

// 测试信号定义
reg clk;
reg rst_n;
reg pause_btn;
wire [6:0] seg;
wire [1:0] cat;
wire [5:0] cat_h;
// 用于显示数字的辅助变量
reg [3:0] curr_num;

// 实例化被测试模块
num dut(
    .clk(clk),
    .rst_n(rst_n),
    .pause_btn(pause_btn),
    .seg(seg),
    .cat(cat),
	 .cat_h(cat_h)
);

// 生成100Hz时钟信号（周期10ms）
initial begin
    clk = 0;
    forever #5000 clk = ~clk;  // 5000ns = 5us，产生100Hz时钟
end

// 解码段选信号，转换为数字便于观察
always @(*) begin
    case(seg)
        7'b011_1111: curr_num = 4'd0;
        7'b000_0110: curr_num = 4'd1;
        7'b101_1011: curr_num = 4'd2;
        7'b100_1111: curr_num = 4'd3;
        7'b110_0110: curr_num = 4'd4;
        7'b110_1101: curr_num = 4'd5;
        7'b111_1101: curr_num = 4'd6;
        7'b000_0111: curr_num = 4'd7;
        7'b111_1111: curr_num = 4'd8;
        7'b110_1111: curr_num = 4'd9;
        default: curr_num = 4'hF;  // 无效显示
    endcase
end

// 测试激励
initial begin
    // 初始化信号
    rst_n = 0;
    pause_btn = 0;
    
    // 等待一段时间让系统稳定
    #1000;
    
    // 测试复位功能
    rst_n = 1;
    #40000;
    rst_n = 0;
    
    // 等待几个数字变化
    #2000000;
    
    // 测试暂停功能
    pause_btn = 1;  // 按下暂停键
    #40000;
    pause_btn = 0;  // 释放暂停键
    
    // 暂停状态等待
    #1000000;
    
    // 继续计数
    pause_btn = 1;  // 再次按下暂停键
    #40000;
    pause_btn = 0;  // 释放暂停键
    
    // 继续运行一段时间
    #18000000;
    
    // 结束仿真
    $finish;
end

endmodule
