int: emp_num     = 1;
int: reg_role    = 2;
int: FullPartTime =3;


%function var string: get_reg(regs:reg,int:num) =
%        REGISTRARS[reg,num];
    
        array[ regs, 1..3] of var string: REGISTRARS = array2d( regs, 1..3, [
%empnum      regrole              FullPartTime        
"59575","12240-B0041-03-Reg1",   "FT", % duy le
"41114","12240-B0041-03-Reg2",   "FT", % peak looi 
"59579","12240-B0041-03-Reg3",   "FT", % kago 
"51172","12240-B0041-03-Reg4",   "FT", % brendon
"59148","12240-B0041-03-Reg5",   "FT", % camilo
"62685","12240-B0041-03-Reg6",   "FT", % ben lee
"58706","12240-B0041-03-Reg7",   "FT", % sabahat
"62306","12240-B0041-03-Reg8",   "FT", % cameron morris 
"59117","12240-B0041-03-Reg9",   "FT", % josh lazarus
"57287","12240-B0041-03-Reg10",  "FT", % ken de jong
"58343","12240-B0041-03-Reg11",  "FT", % claire littlewood
"61188","12240-B0041-03-Reg12",  "FT", %  sandra ruiz
"62750","12240-B0041-03-Reg13",  "FT", % caroline waddacor
"62644","12240-B0041-03-Reg14",  "FT", % jai gohil
"62330","12240-B0041-03-Reg15",  "FT", % luke wynn
"53641","12240-B0041-03-Reg16",  "FT", % dennis chung
"58094","12240-B0041-03-Reg17",  "PT", % jannet chan
"51525","12240-B0041-03-Reg18",  "PT",     %%alicia is a parttimer with special shifts....
"53687","12240-B0041-03-Reg19",  "PT", % libby ward
"53620","12240-B0041-03-Reg20",  "FT", % rebekah bennetts
]);
