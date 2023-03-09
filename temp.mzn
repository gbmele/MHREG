int: DOC = 5;
int: DAY = 14;

set of int: doc = 1..DOC;
set of int: day = 1..DAY;

array[1..DOC,1..DAY] of var  0..5: R;

%constraint forall(d in doc,y in day)(R[d,y]=0);

constraint forall (d in doc, y in 1..DAY-1)(if R[d,y]=2 then R[d,y+1] =0 else true endif);



constraint count(R[1,1..7],2,1) /\ count(R[1,1..7],1,3);
constraint count(R[1,8..14],2,1) /\ count(R[1,8..14],1,3);

output[show2d(R)];