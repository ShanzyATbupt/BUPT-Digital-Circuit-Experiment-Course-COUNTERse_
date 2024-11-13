// 数码管显示模块
module seg_display(
    input wire [3:0] bcd_in,
    output reg [6:0] seg_out
);

always @(*) begin
    case(bcd_in)
        4'd0: seg_out = 7'b011_1111;  // "0"
        4'd1: seg_out = 7'b000_0110;  // "1"
        4'd2: seg_out = 7'b101_1011;  // "2"
        4'd3: seg_out = 7'b100_1111;  // "3"
        4'd4: seg_out = 7'b110_0110;  // "4"
        4'd5: seg_out = 7'b110_1101;  // "5"
        4'd6: seg_out = 7'b111_1101;  // "6"
        4'd7: seg_out = 7'b000_0111;  // "7"
        4'd8: seg_out = 7'b111_1111;  // "8"
        4'd9: seg_out = 7'b110_1111;  // "9"
        default: seg_out = 7'b000_0000;  // 灭灯
    endcase
end

endmodule