%%% constants
row(t). row(b). %top, bottom
col(l). col(r). %left, right

paint(1..6). % white, red, blue, yellow, orange, green
face(1..6). % top, front, right, bottom, back, left

corner(R,C,F) :- row(R), col(C), face(F).
mid(X,F) :- row(X), face(F).     mid(X,F) :- col(X), face(F).

across(1,4). across(2,5). across(3,6). across(P2,P1) :- across(P1,P2). % opposed colors
acrossOrSame(P1,P2) :- across(P1,P2), paint(P1), paint(P2). acrossOrSame(P1,P1) :- paint(P1).


%%% rotate
1 { rotateClockwise(F,Time) : face(F) } 1 :- Time>-1, time(Time+1).
% don't loop
:- rotateClockwise(F0,Time), rotateClockwise(F1,Time+1), rotateClockwise(F2,Time+2), rotateClockwise(F3,Time+3), acrossOrSame(F0,F1), acrossOrSame(F0,F2), acrossOrSame(F0,F3), acrossOrSame(F1,F2), acrossOrSame(F1,F3), acrossOrSame(F2,F3), time(Time).


% rotation effects on rotated face
paintMid(r,Face,Paint,Time+1) :- rotateClockwise(Face,Time), paintMid(t,Face,Paint,Time), paint(Paint), face(Face), time(Time).
paintMid(b,Face,Paint,Time+1) :- rotateClockwise(Face,Time), paintMid(r,Face,Paint,Time), paint(Paint), face(Face), time(Time).
paintMid(l,Face,Paint,Time+1) :- rotateClockwise(Face,Time), paintMid(b,Face,Paint,Time), paint(Paint), face(Face), time(Time).
paintMid(t,Face,Paint,Time+1) :- rotateClockwise(Face,Time), paintMid(l,Face,Paint,Time), paint(Paint), face(Face), time(Time).
paintCorner(t,r,Face,Paint,Time+1) :- rotateClockwise(Face,Time), paintCorner(t,l,Face,Paint,Time), paint(Paint), face(Face), time(Time).
paintCorner(b,r,Face,Paint,Time+1) :- rotateClockwise(Face,Time), paintCorner(t,r,Face,Paint,Time), paint(Paint), face(Face), time(Time).
paintCorner(b,l,Face,Paint,Time+1) :- rotateClockwise(Face,Time), paintCorner(b,r,Face,Paint,Time), paint(Paint), face(Face), time(Time).
paintCorner(t,l,Face,Paint,Time+1) :- rotateClockwise(Face,Time), paintCorner(b,l,Face,Paint,Time), paint(Paint), face(Face), time(Time).

% rotation effects on opposite face
paintMid(t,Face+3,Paint,Time+1) :- rotateClockwise(Face,Time), paintMid(t,Face+3,Paint,Time), paint(Paint), face(Face), face(Face+3), time(Time).   paintMid(t,Face-3,Paint,Time+1) :- rotateClockwise(Face,Time), paintMid(t,Face-3,Paint,Time), paint(Paint), face(Face), face(Face-3), time(Time).
paintMid(r,Face+3,Paint,Time+1) :- rotateClockwise(Face,Time), paintMid(r,Face+3,Paint,Time), paint(Paint), face(Face), face(Face+3), time(Time).   paintMid(r,Face-3,Paint,Time+1) :- rotateClockwise(Face,Time), paintMid(r,Face-3,Paint,Time), paint(Paint), face(Face), face(Face-3), time(Time).
paintMid(b,Face+3,Paint,Time+1) :- rotateClockwise(Face,Time), paintMid(b,Face+3,Paint,Time), paint(Paint), face(Face), face(Face+3), time(Time).   paintMid(b,Face-3,Paint,Time+1) :- rotateClockwise(Face,Time), paintMid(b,Face-3,Paint,Time), paint(Paint), face(Face), face(Face-3), time(Time).
paintMid(l,Face+3,Paint,Time+1) :- rotateClockwise(Face,Time), paintMid(l,Face+3,Paint,Time), paint(Paint), face(Face), face(Face+3), time(Time).   paintMid(l,Face-3,Paint,Time+1) :- rotateClockwise(Face,Time), paintMid(l,Face-3,Paint,Time), paint(Paint), face(Face), face(Face-3), time(Time).
paintCorner(t,l,Face+3,Paint,Time+1) :- rotateClockwise(Face,Time), paintCorner(t,l,Face+3,Paint,Time), paint(Paint), face(Face), face(Face+3), time(Time).   paintCorner(t,l,Face-3,Paint,Time+1) :- rotateClockwise(Face,Time), paintCorner(t,l,Face-3,Paint,Time), paint(Paint), face(Face), face(Face-3), time(Time).
paintCorner(t,r,Face+3,Paint,Time+1) :- rotateClockwise(Face,Time), paintCorner(t,r,Face+3,Paint,Time), paint(Paint), face(Face), face(Face+3), time(Time).   paintCorner(t,r,Face-3,Paint,Time+1) :- rotateClockwise(Face,Time), paintCorner(t,r,Face-3,Paint,Time), paint(Paint), face(Face), face(Face-3), time(Time).
paintCorner(b,r,Face+3,Paint,Time+1) :- rotateClockwise(Face,Time), paintCorner(b,r,Face+3,Paint,Time), paint(Paint), face(Face), face(Face+3), time(Time).   paintCorner(b,r,Face-3,Paint,Time+1) :- rotateClockwise(Face,Time), paintCorner(b,r,Face-3,Paint,Time), paint(Paint), face(Face), face(Face-3), time(Time).
paintCorner(b,l,Face+3,Paint,Time+1) :- rotateClockwise(Face,Time), paintCorner(b,l,Face+3,Paint,Time), paint(Paint), face(Face), face(Face+3), time(Time).   paintCorner(b,l,Face-3,Paint,Time+1) :- rotateClockwise(Face,Time), paintCorner(b,l,Face-3,Paint,Time), paint(Paint), face(Face), face(Face-3), time(Time).

%%% rotation effects on neighboring faces
%% face 1
% changes
paintMid(t,6,Paint,Time+1) :- rotateClockwise(1,Time), paintMid(t,2,Paint,Time), paint(Paint), time(Time).
paintMid(t,5,Paint,Time+1) :- rotateClockwise(1,Time), paintMid(t,6,Paint,Time), paint(Paint), time(Time).
paintMid(t,3,Paint,Time+1) :- rotateClockwise(1,Time), paintMid(t,5,Paint,Time), paint(Paint), time(Time).
paintMid(t,2,Paint,Time+1) :- rotateClockwise(1,Time), paintMid(t,3,Paint,Time), paint(Paint), time(Time).
paintCorner(t,C,6,Paint,Time+1) :- rotateClockwise(1,Time), paintCorner(t,C,2,Paint,Time), col(C), paint(Paint), time(Time).
paintCorner(t,C,5,Paint,Time+1) :- rotateClockwise(1,Time), paintCorner(t,C,6,Paint,Time), col(C), paint(Paint), time(Time).
paintCorner(t,C,3,Paint,Time+1) :- rotateClockwise(1,Time), paintCorner(t,C,5,Paint,Time), col(C), paint(Paint), time(Time).
paintCorner(t,C,2,Paint,Time+1) :- rotateClockwise(1,Time), paintCorner(t,C,3,Paint,Time), col(C), paint(Paint), time(Time).
% persists
paintMid(X,Y,Paint,Time+1) :- rotateClockwise(1,Time), paintMid(X,Y,Paint,Time), paint(Paint), time(Time), X!=t, Y!=1, row(X), face(Y).
paintMid(X,Y,Paint,Time+1) :- rotateClockwise(1,Time), paintMid(X,Y,Paint,Time), paint(Paint), time(Time), X!=t, Y!=1, col(X), face(Y).
paintCorner(b,C,2,Paint,Time+1) :- rotateClockwise(1,Time), paintCorner(b,C,2,Paint,Time), col(C), paint(Paint), time(Time).
paintCorner(b,C,6,Paint,Time+1) :- rotateClockwise(1,Time), paintCorner(b,C,6,Paint,Time), col(C), paint(Paint), time(Time).
paintCorner(b,C,5,Paint,Time+1) :- rotateClockwise(1,Time), paintCorner(b,C,5,Paint,Time), col(C), paint(Paint), time(Time).
paintCorner(b,C,3,Paint,Time+1) :- rotateClockwise(1,Time), paintCorner(b,C,3,Paint,Time), col(C), paint(Paint), time(Time).


%% face 2
% changes
paintMid(l,3,Paint,Time+1) :- rotateClockwise(2,Time), paintMid(b,1,Paint,Time), paint(Paint), time(Time).
paintMid(t,4,Paint,Time+1) :- rotateClockwise(2,Time), paintMid(l,3,Paint,Time), paint(Paint), time(Time).
paintMid(r,6,Paint,Time+1) :- rotateClockwise(2,Time), paintMid(t,4,Paint,Time), paint(Paint), time(Time).
paintMid(b,1,Paint,Time+1) :- rotateClockwise(2,Time), paintMid(r,6,Paint,Time), paint(Paint), time(Time).
paintCorner(b,l,3,Paint,Time+1) :- rotateClockwise(2,Time), paintCorner(b,r,1,Paint,Time),  paint(Paint), time(Time).   paintCorner(t,l,3,Paint,Time+1) :- rotateClockwise(2,Time), paintCorner(b,l,1,Paint,Time), paint(Paint), time(Time).
paintCorner(t,r,4,Paint,Time+1) :- rotateClockwise(2,Time), paintCorner(t,l,3,Paint,Time),  paint(Paint), time(Time).   paintCorner(t,l,4,Paint,Time+1) :- rotateClockwise(2,Time), paintCorner(b,l,3,Paint,Time), paint(Paint), time(Time).
paintCorner(b,r,6,Paint,Time+1) :- rotateClockwise(2,Time), paintCorner(t,r,4,Paint,Time),  paint(Paint), time(Time).   paintCorner(t,r,6,Paint,Time+1) :- rotateClockwise(2,Time), paintCorner(t,l,4,Paint,Time), paint(Paint), time(Time).
paintCorner(b,l,1,Paint,Time+1) :- rotateClockwise(2,Time), paintCorner(b,r,6,Paint,Time),  paint(Paint), time(Time).   paintCorner(b,r,1,Paint,Time+1) :- rotateClockwise(2,Time), paintCorner(t,r,6,Paint,Time), paint(Paint), time(Time).
% persists
paintMid(X,1,Paint,Time+1) :- rotateClockwise(2,Time), paintMid(X,1,Paint,Time), paint(Paint), time(Time), X!=b, row(X).   paintMid(X,1,Paint,Time+1) :- rotateClockwise(2,Time), paintMid(X,1,Paint,Time), paint(Paint), time(Time), X!=b, col(X).
paintMid(X,3,Paint,Time+1) :- rotateClockwise(2,Time), paintMid(X,3,Paint,Time), paint(Paint), time(Time), X!=l, col(X).   paintMid(X,3,Paint,Time+1) :- rotateClockwise(2,Time), paintMid(X,3,Paint,Time), paint(Paint), time(Time), X!=l, row(X).
paintMid(X,4,Paint,Time+1) :- rotateClockwise(2,Time), paintMid(X,4,Paint,Time), paint(Paint), time(Time), X!=t, row(X).   paintMid(X,4,Paint,Time+1) :- rotateClockwise(2,Time), paintMid(X,4,Paint,Time), paint(Paint), time(Time), X!=t, col(X).
paintMid(X,6,Paint,Time+1) :- rotateClockwise(2,Time), paintMid(X,6,Paint,Time), paint(Paint), time(Time), X!=r, col(X).   paintMid(X,6,Paint,Time+1) :- rotateClockwise(2,Time), paintMid(X,6,Paint,Time), paint(Paint), time(Time), X!=r, row(X).
paintCorner(t,r,1,Paint,Time+1) :- rotateClockwise(2,Time), paintCorner(t,r,1,Paint,Time),  paint(Paint), time(Time).   paintCorner(t,l,6,Paint,Time+1) :- rotateClockwise(2,Time), paintCorner(t,l,6,Paint,Time), paint(Paint), time(Time).
paintCorner(t,l,1,Paint,Time+1) :- rotateClockwise(2,Time), paintCorner(t,l,1,Paint,Time),  paint(Paint), time(Time).   paintCorner(b,l,6,Paint,Time+1) :- rotateClockwise(2,Time), paintCorner(b,l,6,Paint,Time), paint(Paint), time(Time).
paintCorner(t,r,3,Paint,Time+1) :- rotateClockwise(2,Time), paintCorner(t,r,3,Paint,Time),  paint(Paint), time(Time).   paintCorner(b,l,4,Paint,Time+1) :- rotateClockwise(2,Time), paintCorner(b,l,4,Paint,Time), paint(Paint), time(Time).
paintCorner(b,r,3,Paint,Time+1) :- rotateClockwise(2,Time), paintCorner(b,r,3,Paint,Time),  paint(Paint), time(Time).   paintCorner(b,r,4,Paint,Time+1) :- rotateClockwise(2,Time), paintCorner(b,r,4,Paint,Time), paint(Paint), time(Time).


%% face 3
% changes
paintMid(r,1,Paint,Time+1) :- rotateClockwise(3,Time), paintMid(r,2,Paint,Time), paint(Paint), time(Time).
paintMid(r,2,Paint,Time+1) :- rotateClockwise(3,Time), paintMid(r,4,Paint,Time), paint(Paint), time(Time).
paintMid(r,4,Paint,Time+1) :- rotateClockwise(3,Time), paintMid(l,5,Paint,Time), paint(Paint), time(Time).
paintMid(l,5,Paint,Time+1) :- rotateClockwise(3,Time), paintMid(r,1,Paint,Time), paint(Paint), time(Time).
paintCorner(t,r,1,Paint,Time+1) :- rotateClockwise(3,Time), paintCorner(t,r,2,Paint,Time),  paint(Paint), time(Time).   paintCorner(b,r,1,Paint,Time+1) :- rotateClockwise(3,Time), paintCorner(b,r,2,Paint,Time), paint(Paint), time(Time).
paintCorner(t,r,2,Paint,Time+1) :- rotateClockwise(3,Time), paintCorner(t,r,4,Paint,Time),  paint(Paint), time(Time).   paintCorner(b,r,2,Paint,Time+1) :- rotateClockwise(3,Time), paintCorner(b,r,4,Paint,Time), paint(Paint), time(Time).
paintCorner(t,r,4,Paint,Time+1) :- rotateClockwise(3,Time), paintCorner(b,l,5,Paint,Time),  paint(Paint), time(Time).   paintCorner(b,r,4,Paint,Time+1) :- rotateClockwise(3,Time), paintCorner(t,l,5,Paint,Time), paint(Paint), time(Time).
paintCorner(b,l,5,Paint,Time+1) :- rotateClockwise(3,Time), paintCorner(t,r,1,Paint,Time),  paint(Paint), time(Time).   paintCorner(t,l,5,Paint,Time+1) :- rotateClockwise(3,Time), paintCorner(b,r,1,Paint,Time), paint(Paint), time(Time).
% persists
paintMid(X,1,Paint,Time+1) :- rotateClockwise(3,Time), paintMid(X,1,Paint,Time), paint(Paint), time(Time), X!=r, col(X).   paintMid(X,1,Paint,Time+1) :- rotateClockwise(3,Time), paintMid(X,1,Paint,Time), paint(Paint), time(Time), X!=r, row(X).
paintMid(X,2,Paint,Time+1) :- rotateClockwise(3,Time), paintMid(X,2,Paint,Time), paint(Paint), time(Time), X!=r, col(X).   paintMid(X,2,Paint,Time+1) :- rotateClockwise(3,Time), paintMid(X,2,Paint,Time), paint(Paint), time(Time), X!=r, row(X).
paintMid(X,4,Paint,Time+1) :- rotateClockwise(3,Time), paintMid(X,4,Paint,Time), paint(Paint), time(Time), X!=r, col(X).   paintMid(X,4,Paint,Time+1) :- rotateClockwise(3,Time), paintMid(X,4,Paint,Time), paint(Paint), time(Time), X!=r, row(X).
paintMid(X,5,Paint,Time+1) :- rotateClockwise(3,Time), paintMid(X,5,Paint,Time), paint(Paint), time(Time), X!=l, col(X).   paintMid(X,5,Paint,Time+1) :- rotateClockwise(3,Time), paintMid(X,5,Paint,Time), paint(Paint), time(Time), X!=l, row(X).
paintCorner(b,l,2,Paint,Time+1) :- rotateClockwise(3,Time), paintCorner(b,l,2,Paint,Time),  paint(Paint), time(Time).   paintCorner(t,l,4,Paint,Time+1) :- rotateClockwise(3,Time), paintCorner(t,l,4,Paint,Time), paint(Paint), time(Time).
paintCorner(t,l,2,Paint,Time+1) :- rotateClockwise(3,Time), paintCorner(t,l,2,Paint,Time),  paint(Paint), time(Time).   paintCorner(b,l,4,Paint,Time+1) :- rotateClockwise(3,Time), paintCorner(b,l,4,Paint,Time), paint(Paint), time(Time).
paintCorner(b,l,1,Paint,Time+1) :- rotateClockwise(3,Time), paintCorner(b,l,1,Paint,Time),  paint(Paint), time(Time).   paintCorner(b,r,5,Paint,Time+1) :- rotateClockwise(3,Time), paintCorner(b,r,5,Paint,Time), paint(Paint), time(Time).
paintCorner(t,l,1,Paint,Time+1) :- rotateClockwise(3,Time), paintCorner(t,l,1,Paint,Time),  paint(Paint), time(Time).   paintCorner(t,r,5,Paint,Time+1) :- rotateClockwise(3,Time), paintCorner(t,r,5,Paint,Time), paint(Paint), time(Time).


%% face 4
% changes
paintMid(b,2,Paint,Time+1) :- rotateClockwise(4,Time), paintMid(b,6,Paint,Time), paint(Paint), time(Time).
paintMid(b,6,Paint,Time+1) :- rotateClockwise(4,Time), paintMid(b,5,Paint,Time), paint(Paint), time(Time).
paintMid(b,5,Paint,Time+1) :- rotateClockwise(4,Time), paintMid(b,3,Paint,Time), paint(Paint), time(Time).
paintMid(b,3,Paint,Time+1) :- rotateClockwise(4,Time), paintMid(b,2,Paint,Time), paint(Paint), time(Time).
paintCorner(b,C,2,Paint,Time+1) :- rotateClockwise(4,Time), paintCorner(b,C,6,Paint,Time), col(C), paint(Paint), time(Time).
paintCorner(b,C,6,Paint,Time+1) :- rotateClockwise(4,Time), paintCorner(b,C,5,Paint,Time), col(C), paint(Paint), time(Time).
paintCorner(b,C,5,Paint,Time+1) :- rotateClockwise(4,Time), paintCorner(b,C,3,Paint,Time), col(C), paint(Paint), time(Time).
paintCorner(b,C,3,Paint,Time+1) :- rotateClockwise(4,Time), paintCorner(b,C,2,Paint,Time), col(C), paint(Paint), time(Time).
% persists
paintMid(X,Y,Paint,Time+1) :- rotateClockwise(4,Time), paintMid(X,Y,Paint,Time), paint(Paint), time(Time), X!=b, Y!=4, row(X), face(Y).
paintMid(X,Y,Paint,Time+1) :- rotateClockwise(4,Time), paintMid(X,Y,Paint,Time), paint(Paint), time(Time), X!=b, Y!=4, col(X), face(Y).
paintCorner(t,C,6,Paint,Time+1) :- rotateClockwise(4,Time), paintCorner(t,C,6,Paint,Time), col(C), paint(Paint), time(Time).
paintCorner(t,C,5,Paint,Time+1) :- rotateClockwise(4,Time), paintCorner(t,C,5,Paint,Time), col(C), paint(Paint), time(Time).
paintCorner(t,C,3,Paint,Time+1) :- rotateClockwise(4,Time), paintCorner(t,C,3,Paint,Time), col(C), paint(Paint), time(Time).
paintCorner(t,C,2,Paint,Time+1) :- rotateClockwise(4,Time), paintCorner(t,C,2,Paint,Time), col(C), paint(Paint), time(Time).

%% face 5
% changes
paintMid(r,3,Paint,Time+1) :- rotateClockwise(5,Time), paintMid(b,4,Paint,Time), paint(Paint), time(Time).
paintMid(t,1,Paint,Time+1) :- rotateClockwise(5,Time), paintMid(r,3,Paint,Time), paint(Paint), time(Time).
paintMid(l,6,Paint,Time+1) :- rotateClockwise(5,Time), paintMid(t,1,Paint,Time), paint(Paint), time(Time).
paintMid(b,4,Paint,Time+1) :- rotateClockwise(5,Time), paintMid(l,6,Paint,Time), paint(Paint), time(Time).
paintCorner(b,l,4,Paint,Time+1) :- rotateClockwise(5,Time), paintCorner(t,l,6,Paint,Time),  paint(Paint), time(Time).   paintCorner(b,r,4,Paint,Time+1) :- rotateClockwise(5,Time), paintCorner(b,l,6,Paint,Time), paint(Paint), time(Time).
paintCorner(b,l,6,Paint,Time+1) :- rotateClockwise(5,Time), paintCorner(t,l,1,Paint,Time),  paint(Paint), time(Time).   paintCorner(t,l,6,Paint,Time+1) :- rotateClockwise(5,Time), paintCorner(t,r,1,Paint,Time), paint(Paint), time(Time).
paintCorner(t,r,3,Paint,Time+1) :- rotateClockwise(5,Time), paintCorner(b,r,4,Paint,Time),  paint(Paint), time(Time).   paintCorner(b,r,3,Paint,Time+1) :- rotateClockwise(5,Time), paintCorner(b,l,4,Paint,Time), paint(Paint), time(Time).
paintCorner(t,r,1,Paint,Time+1) :- rotateClockwise(5,Time), paintCorner(b,r,3,Paint,Time),  paint(Paint), time(Time).   paintCorner(t,l,1,Paint,Time+1) :- rotateClockwise(5,Time), paintCorner(t,r,3,Paint,Time), paint(Paint), time(Time).
% persists
paintMid(X,1,Paint,Time+1) :- rotateClockwise(5,Time), paintMid(X,1,Paint,Time), paint(Paint), time(Time), X!=t, row(X).   paintMid(X,1,Paint,Time+1) :- rotateClockwise(5,Time), paintMid(X,1,Paint,Time), paint(Paint), time(Time), X!=t, col(X).
paintMid(X,3,Paint,Time+1) :- rotateClockwise(5,Time), paintMid(X,3,Paint,Time), paint(Paint), time(Time), X!=r, col(X).   paintMid(X,3,Paint,Time+1) :- rotateClockwise(5,Time), paintMid(X,3,Paint,Time), paint(Paint), time(Time), X!=r, row(X).
paintMid(X,4,Paint,Time+1) :- rotateClockwise(5,Time), paintMid(X,4,Paint,Time), paint(Paint), time(Time), X!=b, row(X).   paintMid(X,4,Paint,Time+1) :- rotateClockwise(5,Time), paintMid(X,4,Paint,Time), paint(Paint), time(Time), X!=b, col(X).
paintMid(X,6,Paint,Time+1) :- rotateClockwise(5,Time), paintMid(X,6,Paint,Time), paint(Paint), time(Time), X!=l, col(X).   paintMid(X,6,Paint,Time+1) :- rotateClockwise(5,Time), paintMid(X,6,Paint,Time), paint(Paint), time(Time), X!=l, row(X).
paintCorner(t,l,3,Paint,Time+1) :- rotateClockwise(5,Time), paintCorner(t,l,3,Paint,Time),  paint(Paint), time(Time).   paintCorner(b,r,6,Paint,Time+1) :- rotateClockwise(5,Time), paintCorner(b,r,6,Paint,Time), paint(Paint), time(Time).
paintCorner(b,l,3,Paint,Time+1) :- rotateClockwise(5,Time), paintCorner(b,l,3,Paint,Time),  paint(Paint), time(Time).   paintCorner(t,r,6,Paint,Time+1) :- rotateClockwise(5,Time), paintCorner(t,r,6,Paint,Time), paint(Paint), time(Time).
paintCorner(b,l,1,Paint,Time+1) :- rotateClockwise(5,Time), paintCorner(b,l,1,Paint,Time),  paint(Paint), time(Time).   paintCorner(t,r,4,Paint,Time+1) :- rotateClockwise(5,Time), paintCorner(t,r,4,Paint,Time), paint(Paint), time(Time).
paintCorner(b,r,1,Paint,Time+1) :- rotateClockwise(5,Time), paintCorner(b,r,1,Paint,Time),  paint(Paint), time(Time).   paintCorner(t,l,4,Paint,Time+1) :- rotateClockwise(5,Time), paintCorner(t,l,4,Paint,Time), paint(Paint), time(Time).


%% face 6
% changes
paintMid(l,1,Paint,Time+1) :- rotateClockwise(6,Time), paintMid(r,5,Paint,Time), paint(Paint), time(Time).
paintMid(r,5,Paint,Time+1) :- rotateClockwise(6,Time), paintMid(l,4,Paint,Time), paint(Paint), time(Time).
paintMid(l,4,Paint,Time+1) :- rotateClockwise(6,Time), paintMid(l,2,Paint,Time), paint(Paint), time(Time).
paintMid(l,2,Paint,Time+1) :- rotateClockwise(6,Time), paintMid(l,1,Paint,Time), paint(Paint), time(Time).
paintCorner(t,l,2,Paint,Time+1) :- rotateClockwise(6,Time), paintCorner(t,l,1,Paint,Time),  paint(Paint), time(Time).   paintCorner(b,l,2,Paint,Time+1) :- rotateClockwise(6,Time), paintCorner(b,l,1,Paint,Time), paint(Paint), time(Time).
paintCorner(b,l,4,Paint,Time+1) :- rotateClockwise(6,Time), paintCorner(b,l,2,Paint,Time),  paint(Paint), time(Time).   paintCorner(t,l,4,Paint,Time+1) :- rotateClockwise(6,Time), paintCorner(t,l,2,Paint,Time), paint(Paint), time(Time).
paintCorner(b,r,5,Paint,Time+1) :- rotateClockwise(6,Time), paintCorner(t,l,4,Paint,Time),  paint(Paint), time(Time).   paintCorner(t,r,5,Paint,Time+1) :- rotateClockwise(6,Time), paintCorner(b,l,4,Paint,Time), paint(Paint), time(Time).
paintCorner(t,l,1,Paint,Time+1) :- rotateClockwise(6,Time), paintCorner(b,r,5,Paint,Time),  paint(Paint), time(Time).   paintCorner(b,l,1,Paint,Time+1) :- rotateClockwise(6,Time), paintCorner(t,r,5,Paint,Time), paint(Paint), time(Time).
% persists
paintMid(X,1,Paint,Time+1) :- rotateClockwise(6,Time), paintMid(X,1,Paint,Time), paint(Paint), time(Time), X!=l, col(X).   paintMid(X,1,Paint,Time+1) :- rotateClockwise(6,Time), paintMid(X,1,Paint,Time), paint(Paint), time(Time), X!=l, row(X).
paintMid(X,2,Paint,Time+1) :- rotateClockwise(6,Time), paintMid(X,2,Paint,Time), paint(Paint), time(Time), X!=l, col(X).   paintMid(X,2,Paint,Time+1) :- rotateClockwise(6,Time), paintMid(X,2,Paint,Time), paint(Paint), time(Time), X!=l, row(X).
paintMid(X,4,Paint,Time+1) :- rotateClockwise(6,Time), paintMid(X,4,Paint,Time), paint(Paint), time(Time), X!=l, col(X).   paintMid(X,4,Paint,Time+1) :- rotateClockwise(6,Time), paintMid(X,4,Paint,Time), paint(Paint), time(Time), X!=l, row(X).
paintMid(X,5,Paint,Time+1) :- rotateClockwise(6,Time), paintMid(X,5,Paint,Time), paint(Paint), time(Time), X!=r, col(X).   paintMid(X,5,Paint,Time+1) :- rotateClockwise(6,Time), paintMid(X,5,Paint,Time), paint(Paint), time(Time), X!=r, row(X).
paintCorner(t,r,2,Paint,Time+1) :- rotateClockwise(6,Time), paintCorner(t,r,2,Paint,Time),  paint(Paint), time(Time).   paintCorner(b,r,4,Paint,Time+1) :- rotateClockwise(6,Time), paintCorner(b,r,4,Paint,Time), paint(Paint), time(Time).
paintCorner(b,r,2,Paint,Time+1) :- rotateClockwise(6,Time), paintCorner(b,r,2,Paint,Time),  paint(Paint), time(Time).   paintCorner(t,r,4,Paint,Time+1) :- rotateClockwise(6,Time), paintCorner(t,r,4,Paint,Time), paint(Paint), time(Time).
paintCorner(b,r,1,Paint,Time+1) :- rotateClockwise(6,Time), paintCorner(b,r,1,Paint,Time),  paint(Paint), time(Time).   paintCorner(t,l,5,Paint,Time+1) :- rotateClockwise(6,Time), paintCorner(t,l,5,Paint,Time), paint(Paint), time(Time).
paintCorner(t,r,1,Paint,Time+1) :- rotateClockwise(6,Time), paintCorner(t,r,1,Paint,Time),  paint(Paint), time(Time).   paintCorner(b,l,5,Paint,Time+1) :- rotateClockwise(6,Time), paintCorner(b,l,5,Paint,Time), paint(Paint), time(Time).

%%% conditions for solved faces
% faceFinished persists
faceFinished(Time,F) :- time(Time), face(F), paintMid(l,F,F,Time), paintMid(r,F,F,Time), paintMid(b,F,F,Time), paintMid(t,F,F,Time), paintCorner(t,l,F,F,Time), paintCorner(t,r,F,F,Time), paintCorner(b,l,F,F,Time), paintCorner(b,r,F,F,Time).
faceFinished(Time+1,F) :- faceFinished(Time,F), time(Time), face(F).

% faceFinished persists => cubeFinished persists
cubeFinished(Time) :- time(Time), faceFinished(Time,1), faceFinished(Time,2), faceFinished(Time,3), faceFinished(Time,4), faceFinished(Time,5), faceFinished(Time,6).


#show paintMid/4.
#show paintCorner/5.
#show rotateClockwise/2.
#show cubeFinished/1.