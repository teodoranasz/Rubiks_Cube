% solved cube

paintMid(l,F,F,0) :- face(F).
paintMid(r,F,F,0) :- face(F).
paintMid(b,F,F,0) :- face(F).
paintMid(t,F,F,0) :- face(F).
paintCorner(t,l,F,F,0) :- face(F).
paintCorner(t,r,F,F,0) :- face(F).
paintCorner(b,l,F,F,0) :- face(F).
paintCorner(b,r,F,F,0) :- face(F).



% example: requires clockwise rotations 1, 2, 4, 2

paintMid(t,6,5,0).
paintMid(b,6,2,0).
paintMid(r,6,3,0).
paintMid(l,6,6,0).
paintMid(b,4,4,0).
paintMid(r,3,3,0).
paintMid(l,2,2,0).
paintMid(l,1,1,0).
paintMid(r,5,5,0).
paintMid(l,5,5,0).
paintMid(r,1,4,0).
paintMid(r,2,3,0).
paintMid(l,3,4,0).
paintMid(t,5,3,0).
paintMid(t,1,1,0).
paintMid(t,2,6,0).
paintMid(t,3,2,0).
paintMid(l,4,6,0).
paintMid(r,4,4,0).
paintMid(b,5,6,0).
paintMid(b,2,2,0).
paintMid(b,3,5,0).
paintMid(b,1,1,0).
paintMid(t,4,1,0).
paintCorner(t,r,6,5,0).
paintCorner(b,r,1,4,0).
paintCorner(t,l,6,5,0).
paintCorner(t,l,5,4,0).
paintCorner(t,r,5,3,0).
paintCorner(t,r,3,3,0).
paintCorner(t,r,2,3,0).
paintCorner(t,r,1,5,0).
paintCorner(t,r,4,2,0).
paintCorner(b,r,4,4,0).
paintCorner(b,r,3,5,0).
paintCorner(b,r,2,4,0).
paintCorner(b,r,5,1,0).
paintCorner(b,r,6,3,0).
paintCorner(b,l,3,6,0).
paintCorner(b,l,6,2,0).
paintCorner(b,l,5,6,0).
paintCorner(b,l,2,2,0).
paintCorner(b,l,4,6,0).
paintCorner(b,l,1,1,0).
paintCorner(t,l,3,2,0).
paintCorner(t,l,1,1,0).
paintCorner(t,l,2,6,0).
paintCorner(t,l,4,1,0).

% example: requires clockwise rotations 3, 2, 3, 2, 4, 2, 1

paintMid(b,6,2,0).
paintMid(t,6,5,0).
paintMid(r,6,4,0).
paintMid(l,6,6,0).
paintMid(b,4,4,0).
paintMid(l,3,3,0).
paintMid(r,2,5,0).
paintMid(r,1,4,0).
paintMid(l,5,3,0).
paintMid(r,5,5,0).
paintMid(l,1,1,0).
paintMid(l,2,2,0).
paintMid(r,3,4,0).
paintMid(t,3,5,0).
paintMid(t,2,1,0).
paintMid(t,1,1,0).
paintMid(t,5,3,0).
paintMid(r,4,6,0).
paintMid(l,4,6,0).
paintMid(b,3,1,0).
paintMid(b,2,2,0).
paintMid(b,5,6,0).
paintMid(b,1,2,0).
paintMid(t,4,3,0).
paintCorner(t,r,6,3,0).
paintCorner(b,r,1,4,0).
paintCorner(t,l,6,5,0).
paintCorner(t,l,5,4,0).
paintCorner(t,r,5,3,0).
paintCorner(t,r,1,2,0).
paintCorner(t,r,2,6,0).
paintCorner(t,r,3,6,0).
paintCorner(t,r,4,5,0).
paintCorner(b,r,4,6,0).
paintCorner(b,r,2,4,0).
paintCorner(b,r,3,1,0).
paintCorner(b,r,5,1,0).
paintCorner(b,r,6,4,0).
paintCorner(b,l,3,3,0).
paintCorner(b,l,6,6,0).
paintCorner(b,l,5,2,0).
paintCorner(b,l,2,2,0).
paintCorner(b,l,4,5,0).
paintCorner(b,l,1,2,0).
paintCorner(t,l,2,1,0).
paintCorner(t,l,1,1,0).
paintCorner(t,l,3,5,0).
paintCorner(t,l,4,3,0).

