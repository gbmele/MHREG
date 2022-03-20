%          M	T	W	T	F	S	S
/*1	p	o	o	o	n	n	n */  string: w1 =  "( p o o o n n n)";
/*2	o	o	o	a	a	a	a */  string: w2 =  "( o o o a a a a)";
/*3	o	a	a	a	a	o	o */  string: w3 =  "( o a a a a o o)"; 
/*4	o	o	p	p	o	p	p */  string: w4 =  "( o o p p o p p)";
/*5	p	p	p	o	p	o	o */  string: w5 =  "( p p p o p o o)";
/*6	n	n	n	n	o	o	o */  string: w6 =  "( n n n n o o o)";
/*7	o	o	p	o	a	a	a */  string: w7 =  "( o o p o a a a)";
/*8	p	o	o	o	p	p	p */  string: w8 =  "( p o o o p p p)";
/*9	o	a	a	a	a	o	o */  string: w9 =  "( o a a a a o o)";
/*10	p	p	p	p	o	o	o */  string: w10 = "( p p p p o o o)";
/*11	p	o	o	o	n	n	n */  string: w11 = "( p o o o n n n)";
/*12	o	o	o	a	a	a	a */  string: w12 = "( o o o a a a a)";
/*13	a	o	a	a	a	o	o */  string: w13 = "( a o a a a o o)";
/*14	a	a	o	o	o	p	p */  string: w14 = "( a a o o o p p)";
/*15	o	p	p	p	p	o	o */  string: w15 = "( o p p p p o o)";
/*16	n	n	n	n	o	o	o */  string: w16 = "( n n n n o o o)";
/*17	o	o	a	o	p	p	p */  string: w17 = "( o o a o p p p)";
/*18	p	p	p	p	o	o	o */  string: w18 = "( p p p p o o o)";
/*19	o	a	a	o	o	a	a */  string: w19 = "( o a a o o a a)";
/*20	p	p	p	o	p	o	o */  string: w20 = "( p p p o p o o)";
/*
count

a	2	4	5	5	6	4	4
p	7	5	7	4	5	4	4
n	2	2	2	2	2	2	2
*/
							


include "globals.mzn";
include "table.mzn";


int: monday     = 1;   %% why did u do this??    
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
set of int: days = 1..DAYS;   %%13 weeks
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

predicate shifts_per_block (docs: doc,shifts: sh, int: num ) =     %%THIS IS PAY FORTNIGHT
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
        
        
predicate no_nights_next_three_weeks(docs:doc)=
  forall(d in 1..DAYS-21)
        (on_night(doc,d) ->(no_night(doc,d+21)));         

predicate no_nights_next_two_weeks(docs:doc)=
  forall(d in 1..DAYS-14)
        (on_night(doc,d) ->(no_night(doc,d+14)));         

predicate no_nights_next_week(docs:doc)=
  forall(d in 1..DAYS-7)
        (on_night(doc,d) ->(no_night(doc,d+7)));         
  
predicate no_nights(docs: doc) =
    no_nights_next_week(doc) ;%  /\ no_nights_next_two_weeks(doc) ; %/\ no_nights_next_three_weeks(doc);           

string: s1 = "(p o o o n n n | o o o a a a a | n n n n o o o | p p p p o o o | o p p p p o o |o o o p p p p | o o p p o p p | o a a a a o o | o o a a o a a | o a a o o p p | o a o o o p p p | o a a a a o o | a a a a o o o  | o o p p o a a  | a o p p p o o | a o o o n n n | o a o o p p p   )*";

constraint forall (doc in {A,B,C,D,E,F,G,H,J,K,L,M} ,day in days) 
  ((alloc[doc,day]=roster[doc,day]) /\
  (regular(roster[doc,..],s1)) /\
  shifts_per_week(doc,4) /\ no_mon_after_sun(doc)  /\ no_consec_weekends(doc)) ;  % /\ no_nights(doc)); 
  
      
%%SET UP NIGHTS  
constraint forall(doc in {A,B,C,D,E,F,G,H,J,K,L,M}) 
           % (global_cardinality_low_up([roster[doc,d] | d in  1..DAYS],[n,a],[9,16],[15,25])      /\
            ((global_cardinality_low_up([roster[doc,d] | d in  1..28]  ,[n,a,p],   [3,4,4], [4,6,6]        ))    /\
             (global_cardinality_low_up([roster[doc,d] | d in 29..56]  ,[n,a,p],   [3,4,4], [4,6,6]        ))    /\
             (global_cardinality_low_up([roster[doc,d] | d in 57..91]  ,[n,a,p],   [3,4,4], [4,8,8])));
        



%%the final fly

constraint forall(d in days where d mod 7 = monday  )   (global_cardinality_low_up(alloc[..,d], [a,p,n,l],   [4, 3,4,0   ],   [4, 5,4,0   ] )); %tue
constraint forall(d in days where d mod 7 = tuesday  )  (global_cardinality_low_up(alloc[..,d], [a,p,n,l],   [4, 3,4,0   ],   [4, 5,4,0   ] )); %tue
constraint forall(d in days where d mod 7 = wednesday)  (global_cardinality_low_up(alloc[..,d], [a,p,n,l],   [4, 3,4,0   ],   [4, 5,4,0   ] )); %wed
constraint forall(d in days where d mod 7 = thursday )  (global_cardinality_low_up(alloc[..,d], [a,p,n,l],   [4, 3,4,0   ],   [4, 5,4,0   ] )); %thu
constraint forall(d in days where d mod 7 = friday   )  (global_cardinality_low_up(alloc[..,d], [a,p,n,l],   [4, 3,4,0   ],   [4, 5,4,0   ] )); %fri
constraint forall(d in days where d mod 7 = saturday )  (global_cardinality_low_up(alloc[..,d], [a,p,n,l],   [3, 3,4,0   ],   [3, 3,4,0   ] )); %sat 
constraint forall(d in days where d mod 7 = sunday   )  (global_cardinality_low_up(alloc[..,d], [a,p,n,l],   [3, 3,4,0   ],   [3, 3,4,0   ] )); %sun
 

                                                
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

