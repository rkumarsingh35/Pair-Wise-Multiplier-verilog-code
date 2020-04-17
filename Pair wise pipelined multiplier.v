`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date:   10:48:39 04/12/2020 
// Design Name:	Pairwise pipeling Multiplication
// Module Name:   Multiplier 
// Project Name: 	4bit * 4bit Pairwise Pipelining Multiplier  
// Revision: 
// Revision 0.01 - File Created
// Author:			Rakesh Kumar Singh
// keyword: Pairwise, Pipelining, Reduce Carry Propogation.
//////////////////////////////////////////////////////////////////////////////////
module multiplier(A,B,C,clk1,clk2);
input clk1,clk2;
input [3:0] A,B; // Two 4-bit input of Multiplier A and B
output reg [7:0] C; // Multiplier output of 8-bit
reg [7:0] Q,W,E,R,T,Y;	
wire [3:0] AE,AO,BE,BO;
wire [7:0] U,I,O,P;
//Dividing input in odd and even part 
//A=(Ae+Ao)
//B=(Be+Bo)
assign AE = {1'b0,A[2],1'b0,A[0]};  //even part of A
assign AO = {A[3],1'b0,A[1],1'b0};	//Odd Part of A
assign BE = {1'b0,B[2],1'b0,B[0]};  //even part of B
assign BO = {B[3],1'b0,B[1],1'b0};  //Odd part of B
//C = A*B
//C=(Ae+Ao)*(Be+Bo) = (Ae*Be)+(Ao*Be)+(Bo+Ae)+(Bo*Ao)
assign U = AE*BE;			//Multiplication of Even part of Both A and B			
assign I = AE*BO;			//Multiplication of Even part of A and Odd part of B
assign O = AO*BE;			//Multiplication of odd part of A and Even part of B
assign P = AO*BO;			//Multiplication of odd part of Both A and B
always @ (posedge clk1) // Implementing piepelinig
 begin
   Q <= #2 U;
	W <= #2 I;
	E <= #2 O;
	R <= #2 P;
 end
always @ (negedge clk2) 
 begin
     T <= #2 Q+W;		//Addition of (Ae*Be)+(AeBo)
	  Y <= #2 E+R;		//Addition of (Ao*Be)+(AoBo)
 end
always @ (posedge clk1)
 begin
     C <= #2 T+Y;   //Final prodcut genration
 end
endmodule
