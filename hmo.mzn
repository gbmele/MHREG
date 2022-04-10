

include "globals.mzn";
include "table.mzn";

                       %% day mod 7 = 1 is monday
int: monday     = 1;   %%  Nurse rostering benchmark website has first day of roster numbered 1.
int: tuesday    = 2;
int: wednesday  = 3;
int: thursday   = 4;
int: friday     = 5; 
int: saturday   = 6;  
int: sunday     = 0;  

int: wk1_mon  =  1;   set of int: wk1  =  1..7;   set of int: fn1 = 1..14;
int: wk2_mon  =  8;   set of int: wk2  =  8..14;
int: wk3_mon  = 15;   set of int: wk3  = 15..21;  set of int: fn2 = 15..28;
int: wk4_mon  = 22;   set of int: wk4  = 22..28;
int: wk5_mon  = 29;   set of int: wk5  = 29..35;  set of int: fn3 = 29..42;
int: wk6_mon  = 36;   set of int: wk6  = 36..42;
int: wk7_mon  = 43;   set of int: wk7  = 43..49;  set of int: fn4 = 43..56;
int: wk8_mon  = 50;   set of int: wk8  = 50..56;
int: wk9_mon  = 57;   set of int: wk9  = 57..63;  set of int: fn5 = 57..70;
int: wk10_mon = 64;   set of int: wk10 = 64..70;
int: wk11_mon = 71;   set of int: wk11 = 71..77;
int: wk12_mon = 78;   set of int: wk12 = 78..84;
int: wk13_mon = 85;   set of int: wk13 = 85..91;


int: WEEKS = 13;
int: DAYS = WEEKS * 7;
set of int: days = 1..DAYS;  
enum shifts = {a,p,n,o,l};   %%am pm night off leave

enum docs ={A,B,C,D,E,F,G,H,J,K,L,M,N,O,P,Q,R,S,T,U,V,W};   %,L1,L2,L3,L4;  

array[docs,days] of var shifts: roster;
array[docs,days] of var shifts: alloc;
array[docs,days] of var 0..1: leave;
array[docs,days] of var 0..1: days_off;


predicate on_night(docs: doc, days: day) =
          roster[doc,day]=n;
          
predicate no_night(docs: doc, days: day) =
          roster[doc,day] !=n;
          
          

predicate on_shift(docs: doc, int:day)=
          (roster[doc,day] = a \/ roster[doc,day] = p \/ roster[doc,day]=n \/ roster[doc,day]=l) ;        

predicate off_shift(docs: doc, int:day)=
          (roster[doc,day] = o);        


predicate shifts_per_week(docs: doc, int: num) =
          (count(roster[doc,  1..7],o, 7 - num) /\
           count(roster[doc, 8..14],o, 7 - num) /\
           count(roster[doc,15..21],o, 7 - num) /\
           count(roster[doc,22..28],o, 7 - num) /\
           count(roster[doc,29..35],o, 7 - num) /\
           count(roster[doc,36..42],o, 7 - num) /\
           count(roster[doc,43..49],o, 7 - num) /\
           count(roster[doc,50..56],o, 7 - num) /\
           count(roster[doc,57..63],o, 7 - num) /\
           count(roster[doc,64..70],o, 7 - num) /\
           count(roster[doc,71..77],o, 7 - num) /\
           count(roster[doc,78..84],o, 7 - num) /\
           count(roster[doc,85..91],o, 7 - num)) ;
           
predicate shifts_per_fortnight (docs: doc,int: num ) =     %%THIS IS PAY FORTNIGHT
        (count(roster[doc, 1..14], o, 14-num) /\
        count( roster[doc,15..28], o, 14-num) /\
%       count( roster[doc,29..42], o, 14-num) /\
        global_cardinality(roster[doc,29..42], [o], [14-num]) /\
        global_cardinality(roster[doc,43..56], [o], [14-num])  /\
        count( roster[doc,57..70],o, 14-num));

predicate shifts_per_block (docs: doc,shifts: sh, int: num ) =     
        ((count(roster[doc, 1..28], sh,num)) /\
        (count(roster[doc, 29..56],sh,num)) /\
        (count(roster[doc, 1..28], sh,num)));

                                                             
                                                       
predicate no_consec_saturdays(docs: doc) =
  forall(d in 1..DAYS-7 where d mod 7 = saturday) 
      (on_shift(doc,d) -> off_shift(doc,d+7));

predicate no_consec_sundays(docs: doc) =
  forall(d in 1..DAYS-7 where d mod 7 = sunday)  
      (on_shift(doc,d) -> off_shift(doc,d+7));
                                     
predicate no_consec_sat_and_or_sun(docs: doc) =
  
     forall(d in 1..DAYS-8 where d mod 7 = saturday)  
        ( (on_shift(doc,d) -> off_shift(doc,d+8)) /\  % no next sunday   after this saturday 
          on_shift(doc,d+1)-> off_shift(doc,d+7));     % no next saturday after this sunday

predicate no_consec_weekends(docs: doc) =
             no_consec_saturdays(doc) /\ no_consec_sundays(doc) /\ no_consec_sat_and_or_sun(doc);

predicate no_mon_after_sun (docs: doc) =
  forall(d in 1..DAYS-1 where d mod 7 = sunday)  
        (on_shift(doc,d) -> off_shift(doc,d+1));
        
        

%%%%%%%%%%


predicate two_days_off_after_nights(docs:doc)=
  forall( d in 1..DAYS-6)
    (   (if  (off_shift(doc,d) /\on_night(doc,d+1) /\ on_night(doc,d+2) /\ on_night(doc,d+3)) then  (off_shift(doc,d+4) /\ off_shift(doc,d+5)) else true endif)) ;% \/
%        (if  (on_night(doc,d) /\ on_night(doc,d+1) /\ on_night(doc,d+2) /\ on_night(doc,d+3)) then  (off_shift(doc,d+4) /\ off_shift(doc,d+5)) else true endif));


predicate two_days_off_after_four_shifts(docs:doc, shifts:s) =
     forall(d in 1..DAYS-6)
         ((roster[doc,d]=s /\ roster[doc,d+1]=s /\ roster[doc,d+2]=s /\ roster[doc,d+4]=s) -> roster[doc,d+5]=o /\ roster[doc,d+6]=o);

predicate one_day_off_after_four_shifts(docs:doc, shifts:s) =
     forall(d in 1..DAYS-5)
         ((roster[doc,d]=s /\ roster[doc,d+1]=s /\ roster[doc,d+2]=s /\ roster[doc,d+4]=s) -> roster[doc,d+5]=o);





string: s1 = "(p o o o n n n | o o o a a a a | n n n n o o o | p p p p o o o | o p p p p o o |o o o p p p p | o o p p o p p | o a a a a o o | o o a a o a a | o a a o o p p | o a o o o p p p | o a a a a o o | a a a a o o o  | o o p p o a a  | a o p p p o o | a o o o n n n | o a o o p p p   )*";

string: s2 = "( o p o o n n n |n n n n o o o | o o a a o a a |o o o a a a a | a a a a o o o | o a a a a o o  |a a o a a o o | o a a p p o o | o o a a o p p |o o p p o a a | o p p p p o o | p p o p p o o | o o o p p p p p | p p p p o o o | o o p p o p p| p p | a a | o o o o o)*";


%constraint forall (doc in {A,B,C,D,E,F,G,H,J,K} ,day in days) 
%  ((alloc[doc,day]=roster[doc,day]) /\
%  (regular(roster[doc,..],s2)) /\
%  shifts_per_week(doc,4)); % /\ no_consec_weekends(doc));  % /\ no_mon_after_sun(doc)  /\ no_consec_weekends(doc)) ;  % /\ no_nights(doc)); 
  

   /*   
constraint forall(doc in {B,C}) 
           % (global_cardinality_low_up([roster[doc,d] | d in  1..DAYS],[n,a],[9,16],[15,25])      /\
            ((global_cardinality_low_up([roster[doc,d] | d in  1..28]  ,[n,a],   [3,4], [4,8]        ))    /\
             (global_cardinality_low_up([roster[doc,d] | d in 29..56]  ,[n,a],   [3,4], [4,8]        ))    /\
             (global_cardinality_low_up([roster[doc,d] | d in 57..91]  ,[n,a],   [3,6], [4,8])));
       
*/   


%predicate TWO_IN_FOUR(docs:doc) -
%          forall (d in {1,29})
%           ((global_cardinality_low_up([roster[doc,d] | d in  1..DAYS where d mod 7 = saturday],[n,a,p], [1,1,1],[3,3,3]))  /\
          
          

predicate N_A_AP_P(docs:doc)=
    forall (d in {1,29,57}) 
         ((global_cardinality_low_up(roster[doc,d..d+6],[n],[3],[4])) /\
         (count(roster[doc,d+7..d+13],a,4)) /\
         (count(roster[doc,d+14..d+20],p,2)) /\ 
         (count(roster[doc,d+21..d+27],p,4)) /\
                                
         (if d = 57 then 
                 global_cardinality_low_up(roster[doc,d+28..d+34],[n],[3],[4])
                 else
                 true
          endif));

predicate A_AP_P_N(docs:doc)=
    forall (d in {1,29,57}) 
         ((count(roster[doc,d..d+6],a,4)) /\
         (count(roster[doc,d+7..d+13],p,2)) /\ 
         (count(roster[doc,d+14..d+20],p,4)) /\
         (global_cardinality_low_up(roster[doc,d+21..d+27],[n],[3],[4])) /\
         
         (if d = 57 then
                count(roster[doc,d+28..d+34],a,4)
          else true
          endif));
                
                
                
                
predicate AP_P_N_A(docs:doc)=
    forall (d in {1,29,57}) 
         ((count(roster[doc,d..d+6],p,2)) /\ 
         (count(roster[doc,d+7..d+13],p,4)) /\
         (global_cardinality_low_up(roster[doc,d+14..d+20],[n],[3],[4]))/\
        (count(roster[doc,d+21..d+27],a,4)) /\
                          
         
         (if d = 57 then
          count(roster[doc,d+28..d+34],p,2)
          else true
          endif));

        
 
predicate P_N_A_AP(docs:doc)=
    forall (d in {1,29,57}) 
          ((count(roster[doc,d..d+6],p,4)) /\
          (global_cardinality_low_up(roster[doc,d+7..d+13],[n],[3],[4]))/\
          (count(roster[doc,d+14..d+20],a,4)) /\
          (count(roster[doc,d+21..d+27],p,2)) /\
          
             (if d = 57 then
                count(roster[doc,d+28..d+34],p,4)
          else true
          endif));

        
constraint forall(doc in {A,B,C,D,E,F,G,H,J,K,L}) 
           ((global_cardinality([roster[doc,d] | d in  1..28 where d mod 7 = saturday],[n,a,p],[1,1,0])) \/
           (global_cardinality([roster[doc,d] | d in  1..28  where d mod 7 = saturday],[n,p,a],[1,1,0]))  \/
           (global_cardinality([roster[doc,d] | d in  1..28  where d mod 7 = saturday],[p,a,n],[1,1,0])));
           
constraint forall(doc in {A,B,C,D,E,F,G,H,J,K,L}) 
           ((global_cardinality([roster[doc,d] | d in  29..56 where d mod 7 = saturday],[n,a,p],[1,1,0])) \/
           (global_cardinality([roster[doc,d] | d in  29..56  where d mod 7 = saturday],[n,p,a],[1,1,0]))  \/
           (global_cardinality([roster[doc,d] | d in  29..56  where d mod 7 = saturday],[p,a,n],[1,1,0])));

constraint forall(doc in {A,B,C,D,E,F,G,H,J,K,L}) 
           ((global_cardinality([roster[doc,d] | d in  57..91  where d mod 7 = saturday],[n,a,p],[1,1,0],[1,1,1])) \/
           (global_cardinality([roster[doc,d] | d in   57..91  where d mod 7 = saturday],[n,p,a],[1,1,0],[1,1,1]))  \/
           (global_cardinality([roster[doc,d] | d in   57..91  where d mod 7 = saturday],[p,a,n],[1,1,0],[1,1,1])));


%constraint forall(doc in {A,B,C,D,E,F,G,H,J,K,L}) 
%           ((global_cardinality([roster[doc,d] | d in  57..91 where d mod 7 = saturday], [n,a,p],[1,1,0],[1,2,0])) \/
%           (global_cardinality([roster[doc,d] | d in  57..91  where d mod 7 = saturday], [n,p,a],[1,1,0],[1,2,0]))  \/
%           (global_cardinality([roster[doc,d] | d in  57..91  where d mod 7 = saturday], [p,a,n],[1,1,0],[2,1,0])));
           
           
           
constraint forall (doc in {A,B,C,D,E,F,G,H,J,K,L} , day in days)
        ((regular(roster[doc,..],s2)) /\
          (alloc[doc,day]=roster[doc,day]) /\
         (shifts_per_week(doc,4)) /\   %leavig this out slows it right down
         two_days_off_after_nights(doc) /\ /* two_days_off_after_four_shifts(doc,p)*/   one_day_off_after_four_shifts(doc,a) /\one_day_off_after_four_shifts(doc,p) /\
        (N_A_AP_P(doc) \/ A_AP_P_N(doc) \/ AP_P_N_A(doc) \/ P_N_A_AP(doc)));  




%%the final fly

constraint forall(d in days where d mod 7 = monday  )   (global_cardinality_low_up(alloc[..,d], [a,p,n,l],   [3, 3,2,0   ],   [4, 5,2,0   ] )); %tue
constraint forall(d in days where d mod 7 = tuesday  )  (global_cardinality_low_up(alloc[..,d], [a,p,n,l],   [3, 3,2,0   ],   [4, 5,2,0   ] )); %tue
constraint forall(d in days where d mod 7 = wednesday)  (global_cardinality_low_up(alloc[..,d], [a,p,n,l],   [3, 3,2,0   ],   [4, 5,2,0   ] )); %wed
constraint forall(d in days where d mod 7 = thursday )  (global_cardinality_low_up(alloc[..,d], [a,p,n,l],   [3, 3,2,0   ],   [4, 5,2,0   ] )); %thu
constraint forall(d in days where d mod 7 = friday   )  (global_cardinality_low_up(alloc[..,d], [a,p,n,l],   [3, 3,2,0   ],   [4, 5,2,0   ] )); %fri
constraint forall(d in days where d mod 7 = saturday )  (global_cardinality_low_up(alloc[..,d], [a,p,n,l],   [3, 3,2,0   ],   [3, 3,2,0   ] )); %sat 
constraint forall(d in days where d mod 7 = sunday   )  (global_cardinality_low_up(alloc[..,d], [a,p,n,l],   [3, 3,2,0   ],   [3, 3,2,0   ] )); %sun
 

                                                
solve satisfy; 

output ["M T W T F S S |M T W T F S S |M T W T F S S |M T W T F S S |M T W T F S S |M T W T F S S |M T W T F S S |M T W T F S S |M T W T F S S |M T W T F S S |M T W T F S S |M T W T F S S |M T W T F S S  \n"];
output["---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------\n"];
output[ show(alloc[doc,day]) ++ " " ++ if day mod 7 = 0 then "|" else "" endif  ++ if day = DAYS  then show(doc)++ "\n" else "" endif | doc in docs, day in days];
output["---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------\n"];
output["---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------\n"];
output [show(count(alloc[..,day],a)) ++ " " ++ if day mod 7 = sunday then "|" else "" endif  ++ if day = DAYS then "a" else "" endif | day in days] ;output["\n"];
output [show(count(alloc[..,day],p)) ++ " " ++ if day mod 7 = sunday then "|" else "" endif  ++ if day = DAYS then "p" else "" endif | day in days] ;output["\n"];
output [show(count(alloc[..,day],n)) ++ " " ++ if day mod 7 = sunday then "|" else "" endif  ++ if day = DAYS then "n" else "" endif | day in days] ;output["\n"];
output [show(count(alloc[..,day],l)) ++ " " ++ if day mod 7 = sunday then "|" else "" endif  ++ if day = DAYS then "l" else "" endif | day in days] ;output["\n"];

output ["\(doc)   " ++ show(count(roster[doc,..],a)) ++ " " ++ show(count(roster[doc,..],p)) ++  " " ++ show(count(roster[doc,..],n)) ++ "\n" | doc in docs  ];
