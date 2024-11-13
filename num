// 顶层模块
module num(
    input wire clk,          // 系统时钟100Hz
    input wire rst_n,        // 复位键，低电平有效
    input wire pause_btn,    // 暂停键，低电平有效
    output wire [6:0] seg,   // 7段数码管段选信号(共阳极)
    output wire [1:0] cat,    // 数码管位选信号(低电平有效)
	 output reg [5:0] cat_h   //2-7数码管不亮
);

// 内部信号

initial cat_h <= 6'b111111;

wire clk_1hz;        
wire pause_state;    // 暂停状态标志
wire [3:0] ones;     
wire [3:0] tens;     
reg [3:0] digit_display;
reg scan_cnt;

// 分频器
freq_div freq_div_inst(
    .clk_in(clk),
    .rst_n(!rst_n),
    .clk_out(clk_1hz)
);


// 暂停控制模块
debounce debounce_inst(
    .clk(clk),
    .rst_n(!rst_n),
    .key_in(!pause_btn),
    .pause_state(pause_state)
);


// 计数器模块
counter counter_inst(
    .clk(clk_1hz),
    .rst_n(!rst_n),
    .pause_state(pause_state),
    .ones(ones),
    .tens(tens)
);


// 扫描计数器
always @(posedge clk or negedge (!rst_n)) begin
    if (!(!rst_n)) begin
        scan_cnt <= 1'b0;
    end
    else begin
        scan_cnt <= scan_cnt + 1'b1;
    end
end

// 位选信号生成
assign cat = (scan_cnt == 1'b0) ? 2'b01 :
             (scan_cnt == 1'b1) ? 2'b10 :
             2'b11;

// 数据选择多路器
always @(*) begin
    case(scan_cnt)
        1'b1: digit_display = ones;
        1'b0: digit_display = tens;
        default: digit_display = 4'd0;
    endcase
end

// 数码管显示模块
seg_display seg_display_inst(
    .bcd_in(digit_display),
    .seg_out(seg)
);

endmodule
