%% each reg has their own role.....
include "reg_shifts.mzn";     %%rosteron shift  definitions
include "reg_dates.dzn";
include "reg_weeks_term4.mzn";
include "registrars_term4.mzn";

include "global_calendar.mzn";

int: DAYS=91; %%13 weeks....



enum  regs = {r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13,r14,r15,r16,r17,r18,r19,r20};


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

int: days = 14;
array[regs,1..days] of var 0..10: roster;

constraint forall(reg in regs, day in wk1)  (roster[reg,day]=week1[reg,day]);
constraint forall(reg in regs, day in wk2)  (roster[reg,day]=week2[reg,day]);





output[show(REGISTRARS[reg,emp_num]) ++ " " ++  show(REGISTRARS[reg,reg_role]) ++ "\n" | reg in regs];output["\n\n"];

output[show(sh) ++ " \t" ++ show(REG_SHIFTS[sh,1]) ++ "\n" | sh in shifts];

output["\n\n"];

output[show(d) ++ " " ++ show(DATES[d]) ++ "\n" | d in 1..DAYS]; 

/*
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

*/



output[show(roster[reg,day]) ++ " " ++ if day = 14 then "\n" else "" endif |reg in regs, day in 1..14];

%%%%THE WHOLE ROSTER>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

output[                                      
                      show(REGISTRARS[reg,emp_num])                    ++ sep ++ 
                      show(DATES[d])                                   ++ sep ++ 
                      show(area)                                       ++ sep ++
                      show(REG_SHIFTS[get_shift(fix(roster[reg,d])),1]) ++ sep ++   %SHIft
                      show(REGISTRARS[reg,2])                          ++ sep ++
                      show(REG_SHIFTS[get_shift(fix(roster[reg,d])),2]) ++ sep ++
                      show(REG_SHIFTS[get_shift(fix(roster[reg,d])),3]) ++ sep ++
                      show(REG_SHIFTS[get_shift(fix(roster[reg,d])),4]) ++ sep ++
                      show(REG_SHIFTS[get_shift(fix(roster[reg,d])),5]) ++ sep ++
                      show(REG_SHIFTS[get_shift(fix(roster[reg,d])),6]) ++ sep ++                      
                      dag_end ++ "\n"
                      
                      |reg in regs, d in 1..days];
                      
output[  if (d mod 7 = wednesday /\ fix(roster[reg,d]) in {shiftoff})
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
          
          | reg in regs,d in 1..days];





