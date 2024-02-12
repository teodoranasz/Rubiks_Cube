paintMid(l,F,F,0) :- face(F).
paintMid(r,F,F,0) :- face(F).
paintMid(b,F,F,0) :- face(F).
paintMid(t,F,F,0) :- face(F).
paintCorner(t,l,F,F,0) :- face(F).
paintCorner(t,r,F,F,0) :- face(F).
paintCorner(b,l,F,F,0) :- face(F).
paintCorner(b,r,F,F,0) :- face(F).

rotateClockwise(F,Time) :- rotateCounterClockwise(F,Time), time(Time), face(F).
rotateClockwise(F,Time+1) :- rotateCounterClockwise(F,Time), time(Time), face(F).
rotateClockwise(F,Time+2) :- rotateCounterClockwise(F,Time), time(Time), face(F).

