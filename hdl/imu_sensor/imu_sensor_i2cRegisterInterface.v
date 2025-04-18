//////////////////////////////////////////////////////////////////////
////                                                              ////
//// registerInterface.v                                          ////
////                                                              ////
//// This file is part of the i2cSlave opencores effort.
//// <http://www.opencores.org/cores//>                           ////
////                                                              ////
//// Module Description:                                          ////
//// You will need to modify this file to implement your
//// interface.
//// Add your control and status bytes/bits to module inputs and outputs,
//// and also to the I2C read and write process blocks
////                                                              ////
//// To Do:                                                       ////
////
////                                                              ////
//// Author(s):                                                   ////
//// - Steve Fielding, sfielding@base2designs.com                 ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2008 Steve Fielding and OPENCORES.ORG          ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE. See the GNU Lesser General Public License for more  ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from <http://www.opencores.org/lgpl.shtml>                   ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
`include "imu_sensor_i2cSlave_define.v"

module imu_sensor_i2cRegisterInterface (
    clk,
    addr,
    dataIn,
    writeEn,
    dataOut,
    myReg0,
    myReg1,
    myReg2,
    myReg3,
    myReg4,
    myReg5,
    myReg6,
    myReg7,
    myReg8,
    myReg9,
    myReg10,
    myReg11,
    myReg12,
    myReg13,
    myReg14,
    myReg15,
    myReg16,
    myReg17,
    myReg18,
    myReg19,
    myReg20,
    myReg21,
    myReg22,
    myReg23,
    myReg24
  );

  input clk;
  input [7:0] addr;
  input [7:0] dataIn;
  input writeEn;
  output [7:0] dataOut;
  input [7:0] myReg0;
  input [7:0] myReg1;
  input [7:0] myReg2;
  input [7:0] myReg3;
  input [7:0] myReg4;
  input [7:0] myReg5;
  input [7:0] myReg6;
  input [7:0] myReg7;
  input [7:0] myReg8;
  input [7:0] myReg9;
  input [7:0] myReg10;
  input [7:0] myReg11;
  input [7:0] myReg12;
  input [7:0] myReg13;
  input [7:0] myReg14;
  input [7:0] myReg15;
  input [7:0] myReg16;
  input [7:0] myReg17;
  input [7:0] myReg18;
  input [7:0] myReg19;
  input [7:0] myReg20;
  output [7:0] myReg21;
  output [7:0] myReg22;
  output [7:0] myReg23;
  output [7:0] myReg24;

  reg [7:0] myReg21;
  reg [7:0] myReg22;
  reg [7:0] myReg23;
  reg [7:0] myReg24;

  reg [7:0] dataOut;

  // --- I2C Read
  always @(posedge clk)
  begin
    case (addr)
      8'h00:
        dataOut <= myReg0;
      8'h01:
        dataOut <= myReg1;
      8'h02:
        dataOut <= myReg2;
      8'h03:
        dataOut <= myReg3;
      8'h04:
        dataOut <= myReg4;
      8'h05:
        dataOut <= myReg5;
      8'h06:
        dataOut <= myReg6;
      8'h07:
        dataOut <= myReg7;
      8'h08:
        dataOut <= myReg8;
      8'h09:
        dataOut <= myReg9;
      8'h0A:
        dataOut <= myReg10;
      8'h0B:
        dataOut <= myReg11;
      8'h0C:
        dataOut <= myReg12;
      8'h0D:
        dataOut <= myReg13;
      8'h0E:
        dataOut <= myReg14;
      8'h0F:
        dataOut <= myReg15;
      8'h10:
        dataOut <= myReg16;
      8'h11:
        dataOut <= myReg17;
      8'h12:
        dataOut <= myReg18;
      8'h13:
        dataOut <= myReg19;
      8'h14:
        dataOut <= myReg20;
      8'h15:
        dataOut <= myReg21;
      8'h16:
        dataOut <= myReg22;
      8'h17:
        dataOut <= myReg23;
      8'h18:
        dataOut <= myReg24;
      default:
        dataOut <= 8'h00;
    endcase
  end

  // --- I2C Write
  always @(posedge clk)
  begin
    if (writeEn == 1'b1)
    begin
      case (addr)
        8'h15:
          myReg21 <= dataIn;
        8'h16:
          myReg22 <= dataIn;
        8'h17:
          myReg23 <= dataIn;
        8'h18:
          myReg24 <= dataIn;
        default:
          myReg24 <= dataIn;
      endcase
    end
  end

endmodule
