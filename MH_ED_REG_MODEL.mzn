%% each reg has their own role.....

include "MH_ED_REG_DATA.mzn";


include "MH_ED_reg_shifts.mzn";     %%rosteron shift  definitions




string: new_line = "\n";


int: monday     = 1;
int: tuesday    = 2;
int: wednesday  = 3;
int: thursday   = 4;
int: friday     = 5;
int: saturday   = 6;
int: sunday     = 0;


enum  regs = {r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13,r14,r15,r16,r17,r18,r19,r20,r21,r22,r23};

%DISPATCH integer--> shift

function shifts: get_shift(int:sh) =    
                     if sh = 0 then off       
                 elseif sh = 1 then a81730
                 elseif sh = 2 then rt81730
                 elseif sh = 3 then pft81730
                 elseif sh = 4 then p142330
                 elseif sh = 5 then rt142330
                 elseif sh = 6 then ft142330
                 elseif sh = 7 then n230830
                 elseif sh = 8 then leave   %%annual
                 elseif sh = 81 then study   %%exam
                 elseif sh = 9 then trn1217                    %% if s= 9 /\ FULLTIME then trn1217 elseif shift = 9 /\ PARTTIME then trn 121430
                 elseif sh = 91 then or817
                 elseif sh = 10 then a112130
                 elseif sh = 11 then us81730
                 elseif sh = 14 then us142330
                 else off
                 endif;


%% wednesday shifts for registrar are half shifts around teaching === so 0800-1200 or 1700-2330
%% teaching shifts are later
function shifts: get_wed_shift(int:sh) =
                 if     sh = 0 then off       
                 elseif sh = 1 then a812
                 elseif sh = 2 then rt812
                 elseif sh = 3 then pft812
                 elseif sh = 4 then p172330
                 elseif sh = 5 then rt172330
                 elseif sh = 6 then ft172330
                 elseif sh = 7 then n230830
                 elseif sh = 8 then leave     %%annual
                 elseif sh = 81 then study   %%exam
                 elseif sh = 9 then trn1217    %% --- this is done down below
                 elseif sh = 91 then or817
                 elseif sh = 10 then a112130
                 elseif sh = 11 then us81730
                 elseif sh = 14 then us142330
                 else off
                 endif;

int: days = 13 * 7;   %%13 weeks in a term  --- very very rarely there is  12 or 14 weeks!!!!


array[regs,1..days] of var 0..100: roster;    % var 0..10 are the shift codes

constraint forall ( reg in regs, day in wk1  )  (roster[reg,day] = week1  [reg,day] );
constraint forall ( reg in regs, day in wk2  )  (roster[reg,day] = week2  [reg,day] );
constraint forall ( reg in regs, day in wk3  )  (roster[reg,day] = week3  [reg,day] );
constraint forall ( reg in regs, day in wk4  )  (roster[reg,day] = week4  [reg,day] );
constraint forall ( reg in regs, day in wk5  )  (roster[reg,day] = week5  [reg,day] );
constraint forall ( reg in regs, day in wk6  )  (roster[reg,day] = week6  [reg,day] );
constraint forall ( reg in regs, day in wk7  )  (roster[reg,day] = week7  [reg,day] );
constraint forall ( reg in regs, day in wk8  )  (roster[reg,day] = week8  [reg,day] );
constraint forall ( reg in regs, day in wk9  )  (roster[reg,day] = week9  [reg,day] );
constraint forall ( reg in regs, day in wk10 )  (roster[reg,day] = week10 [reg,day] );
constraint forall ( reg in regs, day in wk11 )  (roster[reg,day] = week11 [reg,day] );
constraint forall ( reg in regs, day in wk12 )  (roster[reg,day] = week12 [reg,day] );
constraint forall ( reg in regs, day in wk13 )  (roster[reg,day] = week13 [reg,day] );




output[show(REGISTRARS[reg,emp_num]) ++ " " ++  show(REGISTRARS[reg,reg_role]) ++  "   "  ++ show(REGISTRARS[reg,FullPartTime]) ++ "\n" | reg in regs];output["\n\n"];

output[show(shift) ++ " \t" ++ show(REG_SHIFTS[shift,shift_description]) ++ new_line | shift in shifts];

output["\n\n"];

output[show(day_num) ++ " " ++ show(DATES[day_num]) ++ "\n" | day_num in 1..days]; 


output[show(roster[reg,day]) ++ " " ++ if day mod 7 = 0 then "||" else "" endif ++ if day = days then "\n" else "" endif  |reg in regs, day in 1..days];

%%%%THE WHOLE ROSTER>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

%%everyday except wednesday
output[        if fix(roster[reg,d]) != 0 
               then                           
                      show(REGISTRARS[reg,emp_num])                      ++ sep ++ 
                      show(DATES[d])                                     ++ sep ++ 
                      show(area)                                         ++ sep ++
                      show(REG_SHIFTS[get_shift(fix(roster[reg,d])),1])  ++ sep ++   %SHIft
                      show(REGISTRARS[reg,reg_role])                     ++ sep ++
                      show(REG_SHIFTS[get_shift(fix(roster[reg,d])),2])  ++ sep ++
                      show(REG_SHIFTS[get_shift(fix(roster[reg,d])),3])  ++ sep ++
                      show(REG_SHIFTS[get_shift(fix(roster[reg,d])),4])  ++ sep ++
                      show(REG_SHIFTS[get_shift(fix(roster[reg,d])),5])  ++ sep ++
                      show(REG_SHIFTS[get_shift(fix(roster[reg,d])),6])  ++ sep ++                      
                      dag_end ++ "\n"
               else ""
               endif
                      
   |reg in regs, d in 1..days where d mod 7 in {monday,tuesday,thursday,friday,saturday,sunday}];
                      
%%fullroster wednesday_shifts
output[        if     fix(roster[reg,d]) != 0                           
               
               then   show(REGISTRARS[reg,emp_num])                            ++ sep ++ 
                      show(DATES[d])                                           ++ sep ++ 
                      show(area)                                               ++ sep ++
                      show(REG_SHIFTS[get_wed_shift(fix(roster[reg,d])),1])    ++ sep ++   %SHIft
                      show(REGISTRARS[reg,reg_role])                           ++ sep ++
                      show(REG_SHIFTS[get_wed_shift(fix(roster[reg,d])),2])    ++ sep ++
                      show(REG_SHIFTS[get_wed_shift(fix(roster[reg,d])),3])    ++ sep ++
                      show(REG_SHIFTS[get_wed_shift(fix(roster[reg,d])),4])    ++ sep ++
                      show(REG_SHIFTS[get_wed_shift(fix(roster[reg,d])),5])    ++ sep ++
                      show(REG_SHIFTS[get_wed_shift(fix(roster[reg,d])),6])    ++ sep ++                      
                      dag_end ++ "\n"
                      
               else ""
               endif       
                      |reg in regs, d in 1..days where d mod 7 in  {wednesday}];

                      
                                                                                                                                                                        
%%FULL TIMER TEEACHING TIME                 
output[  if (d mod 7 = wednesday /\ fix(roster[reg,d]) in {0,1,2,3,4,5,6,9}   /\ fix(REGISTRARS[reg,FullPartTime]="FT"))
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
          
          | reg in regs,d in 1..days where d mod 7 = wednesday];
%%PART TIMER TEACHING TIME
output[  if (d mod 7 = wednesday /\ fix(roster[reg,d]) in {0,1,2,3,4,5,6,9}   /\ fix(REGISTRARS[reg,FullPartTime]="PT"))
                       then 
                       show(REGISTRARS[reg,emp_num])           ++ sep ++ 
                       show(DATES[d])                          ++ sep ++ 
                       show(area)                              ++ sep ++
                       show(REG_SHIFTS[trn121430,1])             ++ sep ++
                       show(REGISTRARS[reg,2])                 ++ sep ++
                       show(REG_SHIFTS[trn121430,2])             ++ sep ++
                       show(REG_SHIFTS[trn121430,3])             ++ sep ++
                       show(REG_SHIFTS[trn121430,4])             ++ sep ++
                       show(REG_SHIFTS[trn121430,5])             ++ sep ++
                       show(REG_SHIFTS[trn121430,6])             ++ sep ++
                       dag_end ++ "\n" 
                       else "" endif 
          
          | reg in regs,d in 1..days];

          
%% 34T TEACHING TIME
output[  if (d mod 7 = wednesday /\ fix(roster[reg,d]) in {0,1,2,3,4,5,6,9}   /\ fix(REGISTRARS[reg,FullPartTime]="34T"))
                       then 
                       show(REGISTRARS[reg,emp_num])           ++ sep ++ 
                       show(DATES[d])                          ++ sep ++ 
                       show(area)                              ++ sep ++
                       show(REG_SHIFTS[trn12001545,1])             ++ sep ++
                       show(REGISTRARS[reg,2])                 ++ sep ++
                       show(REG_SHIFTS[trn12001545,2])             ++ sep ++
                       show(REG_SHIFTS[trn12001545,3])             ++ sep ++
                       show(REG_SHIFTS[trn12001545,4])             ++ sep ++
                       show(REG_SHIFTS[trn12001545,5])             ++ sep ++
                       show(REG_SHIFTS[trn12001545,6])             ++ sep ++
                       dag_end ++ "\n" 
                       else "" endif 
          
          | reg in regs,d in 1..days];
                    
                              
                                        
                                                  
                                                                      
output["\n\n"];          

output[show(REGISTRARS[r19,emp_num]) ++ "\n"];
output[show(roster[r19,day]) ++ " " ++ if day mod 7 = sunday then "\n" else "" endif | day in 1..days];

