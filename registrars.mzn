include "reg_dates.dzn";
include "reg_weeks.mzn";
include "reg_shifts.mzn";
include "registrars_term4.mzn";
include "global_calendar.mzn";
%int: days=7;
int: DAYS=91; %%13 weeks....


string: sep = "*";

string: dag_end = join(sep,["R","N"," "," "," ","N","N","N","N","N","N","N","N","N","N","N"]);

enum  regs = {r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13,r14,r15,r16,r17,r18,r19,r21};

int: emp_num= 1;
int: reg_role = 2;

enum shifts = {a812,pft812,red812,rt812,a81330,a81430,a81630,pft81630,rt81630,or817,
               a81730,pft81730,red81730,rt81730,us81730,a81830,pft81830,red81830,a819,red819,rt819,a81930,pft81930,red81930,rt81930,a82030,
               or103012,a112130,trn121430,a1217,trn1217,p132330,ft132330,red132330,rt132330,us132330,p13302330,p142330, 
               ft142330,red142330,rt142330,p1424,trn143017,p14302330,p152330,p172330,ft172330,red172330,rt172330,n230830,leave,off};

set of shifts: RSHIFTS ={off,a81730,p142330,n230830,leave,trn1217};

function shifts: get_shift(int:sh) = 
                 if     sh = 0 then  off
                 elseif sh = 1 then a81730
                 elseif sh = 2 then p142330
                 elseif sh = 3 then n230830
                 elseif sh = 4 then leave
                 elseif sh = 5 then trn1217
                 else off
                 endif
                 ;

output[show(REGISTRARS[reg,emp_num]) ++ " " ++  show(REGISTRARS[reg,reg_role]) ++ "\n" | reg in regs];output["\n\n"];

output[show(sh) ++ " \t" ++ show(REG_SHIFTS[sh,1]) ++ "\n" | sh in shifts];

output["\n\n"];

output[show(d) ++ " " ++ show(DATES[d]) ++ "\n" | d in 1..DAYS]; 


%%/////////////////////////////////////////////////////////
%%/////////////////////////////////////////////////////////
output[                                      
                      show(REGISTRARS[reg,emp_num])                    ++ sep ++ 
                      show(DATES[d])                                   ++ sep ++ 
                      show(area)                                       ++ sep ++
                      show(REG_SHIFTS[get_shift(fix(week1[reg,d])),1]) ++ sep ++   %SHIft
                      show(REGISTRARS[reg,2])                          ++ sep ++
                      show(REG_SHIFTS[get_shift(fix(week1[reg,d])),2]) ++ sep ++
                      show(REG_SHIFTS[get_shift(fix(week1[reg,d])),3]) ++ sep ++
                      show(REG_SHIFTS[get_shift(fix(week1[reg,d])),4]) ++ sep ++
                      show(REG_SHIFTS[get_shift(fix(week1[reg,d])),5]) ++ sep ++
                      show(REG_SHIFTS[get_shift(fix(week1[reg,d])),6]) ++ sep ++                      
                      dag_end ++ "\n"
                      
                      |reg in regs, d in 1..7];
output[  if (d mod 7 = wednesday /\ fix(week1[reg,d]) in {shiftoff})
          then 
                       show(REGISTRARS[reg,emp_num])           ++ sep ++ 
                       show(DATES[d])                          ++ sep ++ 
                       show(area)                              ++ sep ++
                       show(REG_SHIFTS[trn1217,1])             ++ sep ++
                       show(REGISTRARS[reg,2])                 ++ sep ++
                       show(REG_SHIFTS[trn1217,2])             ++ sep ++
                       show(REG_SHIFTS[trn1217,3])             ++ sep ++
                       show(REG_SHIFTS[trn1217,4])             ++ sep ++
                       show(REG_SHIFTS[trn1217,5])             ++ sep ++
                       show(REG_SHIFTS[trn1217,6])             ++ sep ++
                       dag_end ++ "\n" 
                       
          else "" endif 
          
          | reg in regs,d in 1..7];
%%/////////////////////////////////
%%/////////////////////////////////