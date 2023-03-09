int: test_doc = r21;

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
                      
                      |reg in test_doc, d in 1..days];
%%FULL TIMER TEEACHING TIME                 
output[  if (d mod 7 = wednesday /\ fix(roster[reg,d]) in {shiftoff}   /\ fix(REGISTRARS[reg,FullPartTime]="FT"))
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
          
          | reg in test_doc,d in 1..days];
%%PART TIMER TEACHING TIME
output[  if (d mod 7 = wednesday /\ fix(roster[reg,d]) in {shiftoff}   /\ fix(REGISTRARS[reg,FullPartTime]="PT"))
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
          
          | reg in test_doc,d in 1..days];
