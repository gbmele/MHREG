int: emp_num     = 1;
int: reg_role    = 2;
int: FullPartTime =3;


%function var string: get_reg(regs:reg,int:num) =
%        REGISTRARS[reg,num];
    
array[ regs, 1..3] of var string: REGISTRARS = array2d( regs, 1..3, [
%empnum      regrole              FullPartTime        
"53620","12240-B0041-03-Reg1","FT", % rebekah bennetts US SSP,1
"58706","12240-B0041-03-Reg2","FT",% sabahat zaidi,2
"59148","12240-B0041-03-Reg3","FT",% camilo vesga,3
"58930","12240-B0041-03-Reg4","FT",% Peter Tao,4
"62330","12240-B0041-03-Reg5","FT",% luke wynne,5
"62644","12240-B0041-03-Reg6","FT",% jai gohil,6
"63593","12240-B0041-03-Reg7","FT",% isaac clifford,7
"62326","12240-B0041-03-Reg8","FT",% niamh hughe,8
"59117","12240-B0041-03-Reg9","FT",% josh lazarus,9
"62306","12240-B0041-03-Reg10","FT",% cameron morrice,10
"58921","12240-B0041-03-Reg11","FT",% mani padukka,11
"58932","12240-B0041-03-Reg12","FT",% justin shin,12
"99999","12240-B0041-03-Reg13","FT",%blank,13
"64226","12240-B0041-03-Reg14","FT",% beau wilson St Vs,14
"52782","12240-B0041-03-Reg15","PT",% pushparaani paramarajah,15
"64196","12240-B0041-03-Reg16","PT",% jaisneet minhas,16
"61188","12240-B0041-03-Reg17","PT",% sandra ruiz,17
"58094","12240-B0041-03-Reg18","PT",% jannet chan,18
"29821","12240-B0041-03-Reg19","PT",% deepak,19
"51525","12240-B0041-03-Reg20","PT",% alicia Liang CMO no teaching time,20
"53694","12240-B0041-03-Reg21","PT",% james lim,21
"58919","12240-B0041-03-Reg22","PT",% victoria Ho,22



]);
