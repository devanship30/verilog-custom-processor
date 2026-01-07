`timescale 1ns / 1ps

//----FIELDS OF INSTRUCTION REGISTER----//
`define oper_type IR[31:27]
`define rdst IR[26:22]
`define rsrc1 IR[21:17]
`define imm_mode IR[16]
`define rsrc2 IR[15:11]
`define isrc IR[15:0]


//----ARITHMETIC OPERATIONS----//
`define movsgpr 5'b00000                               // 0
`define mov 5'b00001                                   // 1
`define add 5'b00010                                   // 2
`define sub 5'b00011                                   // 3
`define mul 5'b00100                                   // 4


//----LOGICAL OPERATIONS----//
`define ror 5'b00101                                   // 5
`define rand 5'b00110                                  // 6
`define rxor 5'b00111                                  // 7
`define rxnor 5'b01000                                 // 8
`define rnand 5'b01001                                 // 9
`define rnor 5'b01010                                  // 10
`define rnot 5'b01011                                  // 11


//---LOAD AND STORE INSTRUCTIONS FOR DATA MEMORY----//
`define storereg 5'b01100                              // STORE THE VALUE FROM REGISTER INTO DATA MEMORY
`define storedin 5'b01101                              // STORE THE VALUE FROM DIN INTO DATA MEMORY
`define senddout 5'b01110                              // SEND THE DATA FROM DATA MEMOERY TO DOUT
`define sendreg 5'b01111                               // SEND THE DATA FROM DATA MEMOERY TO REGISTER


//----JUMP AND BRANCH INSTRUCTIONS----//
`define jump 5'b10000                                  // NO CONDITION JUMP
`define jcarry 5'b10001                                // JUMP IF CARRY = 1
`define jnocarry 5'b10010                              // JUMP IF CARRY = 0
`define jsign 5'b10011                                 // JUMP IF SIGN = 1
`define jnosign 5'b10100                               // JUMP IF SIGN = 0
`define jzero 5'b10101                                 // JUMP IF ZERO = 1
`define jnozero 5'b10110                               // JUMP IF ZERO = 0
`define joverflow 5'b10111                             // JUMP IF OVERFLOW = 1
`define jnooverflow 5'b11000                           // JUMP IF OVERFLOW = 0


//----HALT----//
`define halt 5'b11001                                  // THIS STATEMENT MAKES THE PROGRAM GO INTO HALT STATE UNTIL SYSTEM IS RESET


//----MODULE BEGINS----//
//----DEFINING INPUT AND OUTPUT----//
module top(
            input clk, sys_rst,
            input [15:0] din,
            output reg [15:0] dout
           );


//----DEFINING PROGRAM AND DATA MEMORY----//
reg [31:0] inst_mem [15:0];                            // INSTRUCTION MEMORY    WE INCREASED THE INSTURCTION MEMORY FROM 16 TO 32 INSTRUCTIONS BECAUSE I WAS NOT ABLE TO ADD MORE INSTRUCTIONS WITHOUT DELETING THE PREVIOUS ONES
reg [15:0] data_mem [15:0];                            // DATA MEMORY


//----DEFINING THE REGISTERS----//
reg [31:0] IR;                                         // INSTRUCTION REGISTER
reg [15:0] GPR [31:0];                                 // GENERAL PURPOSE REGISTER
reg [15:0] SGPR;                                       // SEPECIAL GPR USED FOR MULTIPLICATION
reg [31:0] mul_res;                                    // TEMP REGISTER USED TO STORE THE O/P OF MUL OP


//----ADDING REGISTER FLAGS----//
reg sign = 0, zero = 0, overflow = 0, carry = 0;
reg [16:0] temp_sum;


//----DEFINING JUMP FLAG AND STOP----//
reg jmp_flag = 0;
reg stop = 0;


//----PROCESSOR OPERATIONS----//
task decode_inst();
    begin
//always@(*)                                             // THE * SIGN MEANS THAT THE OPERATIONS WOULD BE CHECKED EVERYTIME A VALUE CHANGES
    
        
        //----INITIALIZING THE VALUE OF JUMP FLAG ANG STOP TO BE ZERO----//
        jmp_flag = 1'b0;
        stop = 1'b0;
        
        case(`oper_type)
        
            //----SPECIAL MOV OPERATION FOR MULTIPLICATION----//
            `movsgpr: begin
                GPR[`rdst] = SGPR;
            end
            
            
            //----MOV OPERATION----//
            `mov: begin
                if (`imm_mode)
                    GPR[`rdst] = `isrc;
                else
                    GPR[`rdst] = GPR[`rsrc1];
            end
            
            
            //----ADDITION OPERATION----//
            `add: begin
                if (`imm_mode)
                    GPR[`rdst] = GPR[`rsrc1] + `isrc;
                else
                    GPR[`rdst] = GPR[`rsrc1] + GPR[`rsrc2];    
            end
            
            
            //----SUBTRACTION OPERATION----//
            `sub: begin
                if (`imm_mode)
                    GPR[`rdst] = GPR[`rsrc1] - `isrc;
                else
                    GPR[`rdst] = GPR[`rsrc1] - GPR[`rsrc2];
            end
            
            
            //----MULTIPLICATION OPERATION----//
            `mul: begin
                if (`imm_mode)
                    mul_res = GPR[`rsrc1] * `isrc;
                else
                    mul_res = GPR[`rsrc1] * GPR[`rsrc2];
                GPR[`rdst] = mul_res[15:0];
                SGPR = mul_res[31:16];
            end
            
            
            //----BITWISE OR OPERATION----//
            `ror: begin
                if (`imm_mode)
                    GPR[`rdst] = GPR[`rsrc1] | `isrc;
                else
                    GPR[`rdst] = GPR[`rsrc1] | GPR[`rsrc2];
            end
            
            
            //----BITWISE AND OPERATION----//
            `rand: begin
                if (`imm_mode)
                    GPR[`rdst] = GPR[`rsrc1] & `isrc;
                else
                    GPR[`rdst] = GPR[`rsrc1] & GPR[`rsrc2];
            end
            
            
            //----BITWISE XOR OPERATION----//
            `rxor: begin
                if (`imm_mode)
                    GPR[`rdst] = GPR[`rsrc1] ^ `isrc;
                else
                    GPR[`rdst] = GPR[`rsrc1] ^ GPR[`rsrc2];
            end
            
            
            //----BITWISE XNOR OPERATION----//
            `rxnor: begin
                if (`imm_mode)
                    GPR[`rdst] = GPR[`rsrc1] ~^ `isrc;
                else
                    GPR[`rdst] = GPR[`rsrc1] ~^ GPR[`rsrc2];
            end
            
            
            //----BITWISE NAND OPERATION----//
            `rnand: begin
                if (`imm_mode)
                    GPR[`rdst] = ~(GPR[`rsrc1] & `isrc);
                else
                    GPR[`rdst] = ~(GPR[`rsrc1] & GPR[`rsrc2]);
            end
            
            
            //----BITWISE NOR OPERATION----//
            `rnor: begin
                if (`imm_mode)
                    GPR[`rdst] = ~(GPR[`rsrc1] | `isrc);
                else
                    GPR[`rdst] = ~(GPR[`rsrc1] | GPR[`rsrc2]);
            end
            
            
            //----BITWISE NOT OPERATION----//
            `rnot: begin
                if (`imm_mode)
                    GPR[`rdst] = ~(`isrc);
                else
                    GPR[`rdst] = ~(GPR[`rsrc1]);
            end
            
            
            //----STORE THE VALUE FROM REGISTER INTO DATA MEMORY----//
            `storereg: begin
                data_mem[`isrc] = GPR[`rsrc1];
            end
            
            
            //----STORE THE VALUE FROM DIN INTO DATA MEMORY----//
            `storedin: begin
                data_mem[`isrc] = din;
            end
            
            
            //----SEND THE DATA FROM DATA MEMOERY TO DOUT----//
            `senddout: begin
                dout = data_mem[`isrc];
            end
            
            
            //----SEND THE DATA FROM DATA MEMOERY TO REGISTER----//
            `sendreg: begin
                GPR[`rdst] = data_mem[`isrc];
            end
            
            
            //----NO CONDITION JUMP----//
            `jump: begin
                jmp_flag = 1'b1;
            end
            
            
            //----JUMP IF CARRY = 1----//
            `jcarry: begin
                if (carry == 1'b1)
                    jmp_flag = 1'b1;
                else
                    jmp_flag = 1'b0;
            end
            
            
            //----JUMP IF CARRY = 0----//
            `jnocarry: begin
                if (carry == 1'b0)
                    jmp_flag = 1'b1;
                else
                    jmp_flag = 1'b0;
            end
            
            
            //----JUMP IF SIGN = 1----//
            `jsign: begin
                if (sign == 1'b1)
                    jmp_flag = 1'b1;
                else
                    jmp_flag = 1'b0;
            end
            
            
            //----JUMP IF SIGN = 0----//
            `jnosign: begin
                if (sign == 1'b0)
                    jmp_flag = 1'b1;
                else
                    jmp_flag = 1'b0;
            end
            
            
            //----JUMP IF ZERO = 1----//
            `jzero: begin
                if (zero == 1'b1)
                    jmp_flag = 1'b1;
                else
                    jmp_flag = 1'b0;
            end
            
            
            //----JUMP IF ZERO = 0----//
            `jnozero: begin
                if (zero == 1'b0)
                    jmp_flag = 1'b1;
                else
                    jmp_flag = 1'b0;
            end
            
            
            //----JUMP IF OVERFLOW = 1----//
            `joverflow: begin
                if (overflow == 1'b1)
                    jmp_flag = 1'b1;
                else
                    jmp_flag = 1'b0;
            end
            
            
            //----JUMP IF OVERFLOW = 0----//
            `jnooverflow: begin
                if (overflow == 1'b0)
                    jmp_flag = 1'b1;
                else
                    jmp_flag = 1'b0;
            end
            
            //----HALT----//
            `halt: begin
                stop = 1'b1;
            end
        
        endcase
    end
    
endtask


task decode_condflag();
    begin
//always@(*)

        begin
        
            //----SIGN FLAG----//
            if (`oper_type == `mul) 
                sign = SGPR[15];
            else
                sign = GPR[`rdst][15];
            
            
            //----CARRY FLAG----//
            if (`oper_type == `add)
                begin
                    if (`imm_mode)
                        begin
                            temp_sum = GPR[`rsrc1] + `isrc;
                            carry = temp_sum[16];
                        end
                    else
                        begin
                            temp_sum = GPR[`rsrc1] + GPR[`rsrc2];
                            carry = temp_sum[16];
                        end
                end
            else
                carry = 1'b0;
            
            
            //----ZERO FLAG----//
            if (`oper_type == `mul)
                zero = ~ ((|GPR[`rdst]) | (|SGPR[15:0]));
            else
                zero = ~(|GPR[`rdst]);
            
            
            //----OVERFLOW FLAG----//
            if (`oper_type == `add)
                begin
                    if (`imm_mode)
                        overflow = ((GPR[`rsrc1][15]) & (IR[15]) & (~(GPR[`rdst][15]))) | ((~(GPR[`rsrc1][15])) & (~(IR[15])) & (GPR[`rdst][15]));
                    else
                        overflow = ((~(GPR[`rsrc1][15])) & (~(GPR[`rsrc2][15])) & (GPR[`rdst][15])) | ((GPR[`rsrc1][15]) & (GPR[`rsrc2][15]) & (~(GPR[`rdst][15])));
                end
            else if (`oper_type == `sub)
                begin
                    if (`imm_mode)
                        overflow = ((GPR[`rsrc1][15]) & (~(IR[15])) & (~(GPR[`rdst][15]))) | ((~(GPR[`rsrc1][15])) & (IR[15]) & (GPR[`rdst][15]));
                    else
                        overflow = ((~(GPR[`rsrc1][15])) & (GPR[`rsrc2][15]) & (GPR[`rdst][15])) | ((GPR[`rsrc1][15]) & (~(GPR[`rsrc2][15])) & (~(GPR[`rdst][15])));
                end
            else
                overflow = 1'b0;
        end

    end

endtask


//----READING INSTRUCTION FILE----//
initial begin
            //    $readmemb("program_1.mem", inst_mem);
            $readmemb("program_2.mem", inst_mem);
end


//----INITIALIZING COUNT AND PROGRAM COUNTER----//
reg [2:0] count = 0;
integer PC = 0;


////----READING INSTRUCTION ONE AFTER THE OTHER----//
//always@(posedge clk)
//    begin
//        if (sys_rst)
//            begin
//                count <= 0;
//                PC <= 0;
//            end
//        else
//            begin
//                if (count < 4)
//                    count <= count + 1;
//                else
//                    begin
//                        count <= 0;
//                        PC <= PC + 1;
//                    end
//            end
//    end


////----UPDATING IR AND CALLING DECODE_INST AND DECODE_CONDFLAG IF NEEDED----//
//always@(*)
//    begin
//        if (sys_rst)
//            IR = 0;
//        else
//            begin
//                IR = inst_mem[PC];
//                decode_inst();
//                decode_condflag();
//            end
//    end


//----ADDING STATE OF FSM----//
parameter idle = 0, fetch_inst = 1, dec_exec_inst = 2, next_inst = 3, sense_halt = 4, delay_next_inst = 5;

reg [2:0] state = idle, next_state = idle;


//----SENSE AND RESET BLOCK----//
always@(posedge clk)
    begin
        if (sys_rst)
            state <= idle;
        else
            state <= next_state;
    end


//----NEXT STATE AND OUTPUT DECODER----//
always@(*)
    begin
        case(state)
        
            //----IDLE STATE----//
            idle: begin
                IR = 32'h0;
                PC = 0;
                next_state = fetch_inst;
            end
            
            
            //----FETCH INSTRUCTION STATE----//
            fetch_inst: begin
                IR = inst_mem[PC];
                next_state = dec_exec_inst;
            end
            
            
            //----DECODE AND EXECUTE THE INSTRUCTIONS----//
            dec_exec_inst: begin
                decode_inst();
                decode_condflag();
                next_state = delay_next_inst;
            end
            
            
            //----DELAY STATE----//
            delay_next_inst: begin
                if (count < 4)
                    next_state = delay_next_inst;
                else
                    next_state = next_inst;
            end
            
            
            //----NEXT INSTRUCTION STATE----//
            next_inst: begin
                next_state = sense_halt;
                if (jmp_flag == 1'b1)
                    PC = `isrc;
                else
                    PC = PC + 1;
            end
            
            
            //----SENSE HALT STATE----//
            sense_halt: begin
                if (stop == 1'b0)
                    next_state = fetch_inst;
                else if (sys_rst == 1'b1)
                    next_state = idle;
                else
                    next_state = sense_halt;
            end
            
            
            //----DEFAULT----//
            default: next_state = idle;
            
        endcase
    end


//----COUNT UPDATE FOR DELAY----//
always@(posedge clk)
    begin
        case(state)
        
            idle: begin
                count <= 0;
            end
            
            fetch_inst: begin
                count <= 0;
            end
            
            dec_exec_inst: begin
                count <= 0;
            end
            
            
            //----COUNT IS UPDATED ONLY DURING THE DELAY STAGE----//
            delay_next_inst: begin
                count <= count + 1;
            end
            
            next_inst: begin
                count <= 0;
            end
            
            sense_halt: begin
                count <= 0;
            end
            
            default: count <= 0;
            
        endcase
    end

endmodule
