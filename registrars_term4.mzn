int: emp_num     = 1;
int: reg_role    = 2;
int: FullPartTime =3;


function var string: get_reg(regs:reg,int:num) =
        REGISTRARS[reg,num];
    
        array[ regs, 1..3] of var string: REGISTRARS = array2d( regs, 1..3, [
%empnum      regrole              FullPartTime        
"59575","12240-B0041-03-Reg1",   "FT",  
"41114","12240-B0041-03-Reg2",   "FT",     
"59579","12240-B0041-03-Reg3",   "FT",
"51172","12240-B0041-03-Reg4",   "FT",
"59148","12240-B0041-03-Reg5",   "FT",
"58706","12240-B0041-03-Reg6",   "FT",
"62685","12240-B0041-03-Reg7",   "FT",
"62306","12240-B0041-03-Reg8",   "FT",
"58343","12240-B0041-03-Reg9",   "FT",
"59117","12240-B0041-03-Reg10",  "FT",
"57287","12240-B0041-03-Reg11",  "FT",
"53641","12240-B0041-03-Reg12",  "FT",
"61188","12240-B0041-03-Reg13",  "FT",
"62750","12240-B0041-03-Reg14",  "FT",
"62644","12240-B0041-03-Reg15",  "FT",
"62330","12240-B0041-03-Reg16",  "FT",
"58094","12240-B0041-03-Reg17",  "FT",
"51525","12240-B0041-03-Reg18",  "PT",     %%alicia is a parttimer with special shifts....
"53687","12240-B0041-03-Reg19",  "PT",
"53620","12240-B0041-03-Reg20",  "PT"
]);
