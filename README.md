####计数器实验
完成一个0-19循环计数器的电路设计、仿真验证、并下载到实验板上实现。计数器具体功能要求如下：
1.数码管DISP1和DISP0显示计数值，计数值每秒加1，加到19后回00；
2.BTN0为暂停键，按一下计数暂停，再按一下计数继续（必须设置防抖电路对该按键进行防抖）；
3.BTN7为复位键，任何时刻按下复位键计数值回到00；
4。时钟系统选择100Hz。
####模块说明
tb文件夹为仿真文件num_tb.v，num.v为主模块
