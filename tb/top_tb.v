module top_tb;

integer i = 0;

reg clk = 0, sys_rst = 0;
reg [15:0] din;
wire [15:0] dout;

top dut(clk, sys_rst, din, dout);

always #5 clk = ~clk;

initial begin 
    sys_rst = 1'b1;
    repeat(5) @(posedge clk);
    sys_rst = 1'b0;
    din = 10;
    #1800;
    $stop;
end

endmodule

























//`timescale 1ns / 1ps

////----MODULE BEGINS----//
//module top_tb;

//integer i = 0;
//top dut();                                   // ADDING INSTANCE OF OUR RTL


////----UPDATING VALUES OF ALL GPR TO 2----//
//initial begin
//    for (i = 0; i < 32; i = i + 1)
//        begin
//            dut.GPR[i] = 2;
//        end
//end


//initial begin
//    //----IMMEDIATE ADDITION OPERATION----//
//    $display("----IMMEDIATE ADDITION OPERATION----");
//    dut.IR = 0;
//    dut.`imm_mode = 1;
//    dut.`oper_type = 2;
//    dut.`rsrc1 = 2;
//    dut.`rdst = 0;
//    dut.`isrc = 4;
//    #10;
//    $display("VALUE IN SOURCE REGISTER 1:%0d \nIMMEDIATE VALUE TO BE USED:%0d \nDESTINATION REGISTER VALUE:%0d \n",dut.GPR[2], dut.`isrc, dut.GPR[0]);
    
    
//    //----REGISTER ADDITION OPERATION----//
//    $display("----REGISTER ADDITION OPERATION----");
//    dut.IR = 0;
//    dut.`imm_mode = 0;
//    dut.`oper_type = 2;
//    dut.`rsrc1 = 4;
//    dut.`rsrc2 = 5;
//    dut.`rdst = 0;
//    #10;
//    $display("VALUE IN SOURCE REGISTER 1:%0d \nVALUE IN SOURCE REGISTER 2:%0d \nDESTINATION REGISTER VALUE:%0d \n",dut.GPR[4], dut.GPR[5], dut.GPR[0]);
    
    
//    //----IMMEDIATE MOVE OPERATION----//
//    $display("----IMMEDIATE MOVE OPERATION----");
//    dut.IR = 0;
//    dut.`imm_mode = 1;
//    dut.`oper_type = 1;
//    dut.`rdst = 4;
//    dut.`isrc = 55;
//    #10;
//    $display("IMMEDIATE VALUE TO BE USED:%0d \nDESTINATION REGISTER VALUE:%0d \n", dut.`isrc, dut.GPR[4]);
    
    
//    //----REGISTER MOVE OPERATION----//
//    $display("----REGISTER MOVE OPERATION----");
//    dut.IR = 0;
//    dut.`imm_mode = 0;
//    dut.`oper_type = 1;
//    dut.`rdst = 4;
//    dut.`rsrc1 = 6;
//    #10;
//    $display("VALUE IN SOURCE REGISTER 1:%0d \nDESTINATION REGISTER VALUE:%0d \n", dut.GPR[7], dut.GPR[4]);
    
    
//    //----IMMEDIATE MULTIPLICATION OPERATION----//
//    $display("----IMMEDIATE MULTIPLICATION OPERATION----");
//    dut.IR = 0;
//    dut.`imm_mode = 1;
//    dut.`oper_type = 4;
//    dut.`rdst = 0;
//    dut.`rsrc1 = 4;
//    dut.`isrc = 350;
//    #10;
//    $display("VALUE IN SOURCE REGISTER 1:%0d \nIMMEDIATE VALUE TO BE USED:%0d \nVALUE IN SPECIAL REGISTER(MSB BITS):%0d \nVALUE IN DESTINATION REGISTER(LSB BITS):%0d \n", dut.GPR[4], dut.`isrc, dut.SGPR, dut.GPR[0]);
    
    
//    //----REGISTER MULTIPLICATION OPERATION----//
//    $display("----REGISTER MULTIPLICATION OPERATION----");
//    dut.IR = 0;
//    dut.`imm_mode = 0;
//    dut.`oper_type = 4;
//    dut.`rdst = 2;
//    dut.`rsrc1 = 0;
//    dut.`rsrc2 = 1;
//    dut.GPR[3] = dut.SGPR;
//    #10;
//    $display("VALUE IN SOURCE REGISTER 1:%0d \nVALUE IN SOURCE REGISTER 2:%0d \nVALUE IN DESTINATION REGISTER 1(MSB BITS):%0d \nVALUE IN DESTINATION REGISTER 2(LSB BITS):%0d \n", dut.GPR[0], dut.GPR[1], dut.GPR[3], dut.GPR[2]);
    
    
//    //----IMMEDIATE OR OPERATION----//
//    $display("----IMMEDIATE OR OPERATION----");
//    dut.IR = 0;
//    dut.`imm_mode = 1;
//    dut.`oper_type = 5;
//    dut.`rdst = 0;
//    dut.`rsrc1 = 4;
//    dut.`isrc = 16;
//    #10;
//    $display("VALUE IN SOURCE REGISTER 1:%8b \nIMMEDIATE VALUE TO BE USED:%8b \nDESTINATION REGISTER VALUE:%8b \n",dut.GPR[4], dut.`isrc, dut.GPR[0]);
    
    
//    //----REGISTER OR OPERATION----//
//    $display("----REGISTER OR OPERATION----");
//    dut.IR = 0;
//    dut.`imm_mode = 0;
//    dut.`oper_type = 5;
//    dut.`rdst = 0;
//    dut.`rsrc1 = 4;
//    dut.`rsrc2 = 16;
//    #10;
//    $display("VALUE IN SOURCE REGISTER 1:%8b \nVALUE IN SOURCE REGISTER 2:%8b \nDESTINATION REGISTER VALUE:%8b \n",dut.GPR[4], dut.GPR[16], dut.GPR[0]);
    
    
//    //----IMMEDIATE AND OPERATION----//
//    $display("----IMMEDIATE AND OPERATION----");
//    dut.IR = 0;
//    dut.`imm_mode = 1;
//    dut.`oper_type = 6;
//    dut.`rdst = 4;
//    dut.`rsrc1 = 7;
//    dut.`isrc = 56;
//    #10;
//    $display("VALUE IN SOURCE REGISTER 1:%8b \nIMMEDIATE VALUE TO BE USED:%8b \nDESTINATION REGISTER VALUE:%8b \n",dut.GPR[7], dut.`isrc, dut.GPR[4]);
    
    
//    //----REGISTER AND OPERATION----//
//    $display("----REGISTER AND OPERATION----");
//    dut.IR = 0;
//    dut.`imm_mode = 0;
//    dut.`oper_type = 6;
//    dut.`rdst = 4;
//    dut.`rsrc1 = 7;
//    dut.`rsrc2 = 8;
//    #10;
//    $display("VALUE IN SOURCE REGISTER 1:%8b \nVALUE IN SOURCE REGISTER 2:%8b \nDESTINATION REGISTER VALUE:%8b \n",dut.GPR[7], dut.GPR[8], dut.GPR[4]);
    
    
//    //----IMMEDIATE NOR OPERATION----//
//    $display("----IMMEDIATE NOR OPERATION----");
//    dut.IR = 0;
//    dut.`imm_mode = 1;
//    dut.`oper_type = 10;
//    dut.`rdst = 0;
//    dut.`rsrc1 = 4;
//    dut.`isrc = 16;
//    #10;
//    $display("VALUE IN SOURCE REGISTER 1:%16b \nIMMEDIATE VALUE TO BE USED:%16b \nDESTINATION REGISTER VALUE:%16b \n",dut.GPR[4], dut.`isrc, dut.GPR[0]);
    
    
//    //----REGISTER NOR OPERATION----//
//    $display("----REGISTER NOR OPERATION----");
//    dut.IR = 0;
//    dut.`imm_mode = 0;
//    dut.`oper_type = 10;
//    dut.`rdst = 0;
//    dut.`rsrc1 = 4;
//    dut.`rsrc2 = 16;
//    #10;
//    $display("VALUE IN SOURCE REGISTER 1:%16b \nVALUE IN SOURCE REGISTER 2:%16b \nDESTINATION REGISTER VALUE:%16b \n",dut.GPR[4], dut.GPR[16], dut.GPR[0]);
    
    
//    //----IMMEDIATE NOT OPERATION----//
//    $display("----IMMEDIATE NOT OPERATION----");
//    dut.IR = 0;
//    dut.`imm_mode = 1;
//    dut.`oper_type = 11;
//    dut.`rdst = 0;
//    dut.`isrc = 16;
//    #10;
//    $display("IMMEDIATE VALUE TO BE USED:%8b \nDESTINATION REGISTER VALUE:%8b \n", dut.`isrc, dut.GPR[0]);
    
    
//    //----REGISTER NOT OPERATION----//
//    $display("----REGISTER NOT OPERATION----");
//    dut.IR = 0;
//    dut.`imm_mode = 0;
//    dut.`oper_type = 11;
//    dut.`rdst = 0;
//    dut.`rsrc1 = 6;
//    #10;
//    $display("VALUE IN SOURCE REGISTER 1:%8b \nDESTINATION REGISTER VALUE:%8b \n", dut.GPR[6], dut.GPR[0]);
    
    
//    //----TESTING ZERO FLAG----//
//    $display("----TESTING ZERO FLAG----");
//    dut.GPR[0] = 0;
//    dut.IR = 0;
//    dut.`imm_mode = 1;
//    dut.`oper_type = 6;
//    dut.`rdst = 1;
//    dut.`rsrc1 = 0;
//    dut.`isrc = 0;
//    #10;
//    $display("VALUE IN SOURCE REGISTER 1:%16b \nIMMEDIATE VALUE TO BE USED:%16b \nDESTINATION REGISTER VALUE:%16b \nZERO FLAG:%0d \n",dut.GPR[0], dut.`isrc, dut.GPR[1], dut.zero);
    
    
//    //----TESTING SIGN FLAG----//
//    $display("----TESTING SIGN FLAG----");
//    dut.GPR[0] = 16'h8000;
//    dut.GPR[1] = 0;
//    dut.IR = 0;
//    dut.`imm_mode = 0;
//    dut.`oper_type = 2;
//    dut.`rsrc1 = 0;
//    dut.`rsrc2 = 1;
//    dut.`rdst = 2;
//    #10;
//    $display("VALUE IN SOURCE REGISTER 1:%16b \nVALUE IN SOURCE REGISTER 2:%16b \nDESTINATION REGISTER VALUE:%16b \nSIGN FLAG:%0d \n",dut.GPR[0], dut.GPR[1], dut.GPR[2], dut.sign);
    
    
//    //----TESTING CARRY AND OVERFLOW FLAG----//
//    $display("----TESTING CARRY AND OVERFLOW FLAG----");
//    dut.GPR[0] = 16'h8000;
//    dut.GPR[1] = 16'h8002;
//    dut.IR = 0;
//    dut.`imm_mode = 0;
//    dut.`oper_type = 2;
//    dut.`rsrc1 = 0;
//    dut.`rsrc2 = 1;
//    dut.`rdst = 2;
//    #10;
//    $display("VALUE IN SOURCE REGISTER 1:%16b \nVALUE IN SOURCE REGISTER 2:%16b \nDESTINATION REGISTER VALUE:%16b \nCARRY FLAG:%0d \nOVERFLOW FLAG:%0d \n",dut.GPR[0], dut.GPR[1], dut.GPR[2], dut.carry, dut.overflow);
    
//end

//endmodule
