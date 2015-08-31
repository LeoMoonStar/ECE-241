onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /accserial_tb/iClk
add wave -noupdate /accserial_tb/iResetn
add wave -noupdate /accserial_tb/iStart
add wave -noupdate /accserial_tb/iStartAddress
add wave -noupdate /accserial_tb/iNumVal
add wave -noupdate /accserial_tb/oSO
add wave -noupdate /accserial_tb/AdderSum
add wave -noupdate /accserial_tb/DoneShift
add wave -noupdate /accserial_tb/DoneAdd
add wave -noupdate -divider ADD
add wave -noupdate /accserial_tb/dut/ADD/iNVal
add wave -noupdate /accserial_tb/dut/ADD/iStartAddr
add wave -noupdate /accserial_tb/dut/ADD/iClk
add wave -noupdate /accserial_tb/dut/ADD/iResetn
add wave -noupdate /accserial_tb/dut/ADD/iDoneShift
add wave -noupdate /accserial_tb/dut/ADD/iStart
add wave -noupdate -radix binary /accserial_tb/dut/ADD/oSum
add wave -noupdate /accserial_tb/dut/ADD/oDoneAdd
add wave -noupdate /accserial_tb/dut/ADD/NState
add wave -noupdate -radix unsigned /accserial_tb/dut/ADD/CState
add wave -noupdate /accserial_tb/dut/ADD/NumVal
add wave -noupdate /accserial_tb/dut/ADD/MAR
add wave -noupdate /accserial_tb/dut/ADD/R
add wave -noupdate /accserial_tb/dut/ADD/S
add wave -noupdate /accserial_tb/dut/ADD/DoneAdd
add wave -noupdate -radix hexadecimal /accserial_tb/dut/ADD/MemOut
add wave -noupdate -divider M1
add wave -noupdate /accserial_tb/dut/ADD/M1/iData
add wave -noupdate /accserial_tb/dut/ADD/M1/iAddress
add wave -noupdate /accserial_tb/dut/ADD/M1/iR_Wn
add wave -noupdate /accserial_tb/dut/ADD/M1/clk
add wave -noupdate -radix unsigned /accserial_tb/dut/ADD/M1/oData
add wave -noupdate -radix unsigned -childformat {{{/accserial_tb/dut/ADD/M1/mem[255]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[254]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[253]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[252]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[251]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[250]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[249]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[248]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[247]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[246]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[245]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[244]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[243]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[242]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[241]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[240]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[239]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[238]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[237]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[236]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[235]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[234]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[233]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[232]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[231]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[230]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[229]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[228]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[227]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[226]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[225]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[224]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[223]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[222]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[221]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[220]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[219]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[218]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[217]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[216]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[215]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[214]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[213]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[212]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[211]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[210]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[209]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[208]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[207]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[206]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[205]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[204]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[203]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[202]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[201]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[200]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[199]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[198]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[197]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[196]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[195]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[194]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[193]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[192]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[191]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[190]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[189]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[188]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[187]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[186]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[185]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[184]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[183]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[182]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[181]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[180]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[179]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[178]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[177]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[176]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[175]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[174]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[173]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[172]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[171]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[170]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[169]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[168]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[167]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[166]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[165]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[164]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[163]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[162]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[161]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[160]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[159]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[158]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[157]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[156]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[155]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[154]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[153]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[152]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[151]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[150]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[149]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[148]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[147]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[146]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[145]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[144]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[143]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[142]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[141]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[140]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[139]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[138]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[137]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[136]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[135]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[134]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[133]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[132]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[131]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[130]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[129]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[128]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[127]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[126]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[125]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[124]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[123]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[122]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[121]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[120]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[119]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[118]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[117]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[116]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[115]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[114]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[113]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[112]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[111]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[110]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[109]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[108]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[107]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[106]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[105]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[104]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[103]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[102]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[101]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[100]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[99]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[98]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[97]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[96]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[95]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[94]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[93]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[92]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[91]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[90]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[89]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[88]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[87]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[86]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[85]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[84]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[83]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[82]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[81]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[80]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[79]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[78]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[77]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[76]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[75]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[74]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[73]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[72]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[71]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[70]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[69]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[68]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[67]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[66]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[65]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[64]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[63]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[62]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[61]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[60]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[59]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[58]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[57]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[56]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[55]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[54]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[53]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[52]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[51]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[50]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[49]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[48]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[47]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[46]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[45]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[44]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[43]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[42]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[41]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[40]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[39]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[38]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[37]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[36]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[35]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[34]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[33]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[32]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[31]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[30]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[29]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[28]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[27]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[26]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[25]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[24]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[23]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[22]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[21]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[20]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[19]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[18]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[17]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[16]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[15]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[14]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[13]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[12]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[11]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[10]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[9]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[8]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[7]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[6]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[5]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[4]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[3]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[2]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[1]} -radix unsigned} {{/accserial_tb/dut/ADD/M1/mem[0]} -radix unsigned}} -subitemconfig {{/accserial_tb/dut/ADD/M1/mem[255]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[254]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[253]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[252]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[251]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[250]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[249]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[248]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[247]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[246]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[245]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[244]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[243]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[242]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[241]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[240]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[239]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[238]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[237]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[236]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[235]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[234]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[233]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[232]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[231]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[230]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[229]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[228]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[227]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[226]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[225]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[224]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[223]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[222]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[221]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[220]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[219]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[218]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[217]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[216]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[215]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[214]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[213]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[212]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[211]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[210]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[209]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[208]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[207]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[206]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[205]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[204]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[203]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[202]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[201]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[200]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[199]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[198]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[197]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[196]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[195]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[194]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[193]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[192]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[191]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[190]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[189]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[188]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[187]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[186]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[185]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[184]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[183]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[182]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[181]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[180]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[179]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[178]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[177]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[176]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[175]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[174]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[173]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[172]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[171]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[170]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[169]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[168]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[167]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[166]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[165]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[164]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[163]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[162]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[161]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[160]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[159]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[158]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[157]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[156]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[155]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[154]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[153]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[152]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[151]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[150]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[149]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[148]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[147]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[146]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[145]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[144]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[143]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[142]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[141]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[140]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[139]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[138]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[137]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[136]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[135]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[134]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[133]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[132]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[131]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[130]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[129]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[128]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[127]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[126]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[125]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[124]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[123]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[122]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[121]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[120]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[119]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[118]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[117]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[116]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[115]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[114]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[113]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[112]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[111]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[110]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[109]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[108]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[107]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[106]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[105]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[104]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[103]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[102]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[101]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[100]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[99]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[98]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[97]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[96]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[95]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[94]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[93]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[92]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[91]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[90]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[89]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[88]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[87]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[86]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[85]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[84]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[83]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[82]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[81]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[80]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[79]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[78]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[77]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[76]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[75]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[74]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[73]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[72]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[71]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[70]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[69]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[68]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[67]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[66]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[65]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[64]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[63]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[62]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[61]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[60]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[59]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[58]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[57]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[56]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[55]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[54]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[53]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[52]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[51]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[50]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[49]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[48]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[47]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[46]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[45]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[44]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[43]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[42]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[41]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[40]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[39]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[38]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[37]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[36]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[35]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[34]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[33]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[32]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[31]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[30]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[29]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[28]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[27]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[26]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[25]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[24]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[23]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[22]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[21]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[20]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[19]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[18]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[17]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[16]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[15]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[14]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[13]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[12]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[11]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[10]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[9]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[8]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[7]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[6]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[5]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[4]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[3]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[2]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[1]} {-height 17 -radix unsigned} {/accserial_tb/dut/ADD/M1/mem[0]} {-height 17 -radix unsigned}} /accserial_tb/dut/ADD/M1/mem
add wave -noupdate /accserial_tb/dut/ADD/M1/addr_reg
add wave -noupdate -divider SHIFT
add wave -noupdate /accserial_tb/dut/SHIFT/iData
add wave -noupdate /accserial_tb/dut/SHIFT/iDoneAdd
add wave -noupdate /accserial_tb/dut/SHIFT/iClk
add wave -noupdate /accserial_tb/dut/SHIFT/iResetn
add wave -noupdate /accserial_tb/dut/SHIFT/oDoneShift
add wave -noupdate /accserial_tb/dut/SHIFT/oSO
add wave -noupdate /accserial_tb/dut/SHIFT/NState
add wave -noupdate /accserial_tb/dut/SHIFT/CState
add wave -noupdate /accserial_tb/dut/SHIFT/NumBits
add wave -noupdate /accserial_tb/dut/SHIFT/S
add wave -noupdate -radix hexadecimal /accserial_tb/dut/SHIFT/DelayCounter
add wave -noupdate /accserial_tb/dut/SHIFT/Done1s
add wave -noupdate /accserial_tb/dut/SHIFT/DoneShift
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1830000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 255
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {1767890 ps} {2064850 ps}
