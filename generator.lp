%%% constants
row(t). row(b). %top, bottom
col(l). col(r). %left, right

paint(1..6). % white, red, blue, yellow, orange, green
face(1..6). % top, front, right, bottom, back, left

corner(R,C,F) :- row(R), col(C), face(F).
mid(X,F) :- row(X), face(F).     mid(X,F) :- col(X), face(F).

across(1,4). across(2,5). across(3,6). across(P2,P1) :- across(P1,P2). % opposed colors
acrossOrSame(P1,P2) :- across(P1,P2), paint(P1), paint(P2). acrossOrSame(P1,P1) :- paint(P1).

% clockwise corner colors
clockwiseCorner(1,3,2). clockwiseCorner(1,5,3). clockwiseCorner(1,6,5). clockwiseCorner(1,2,6).
clockwiseCorner(2,3,4). clockwiseCorner(2,4,6).
clockwiseCorner(3,5,4).
clockwiseCorner(4,5,6).

clockwiseCorner(Y,Z,X) :- clockwiseCorner(X,Y,Z).

%%% basic
% well-def
1{ paintCorner(R,C,F,Paint,0) : paint(Paint) }1 :- corner(R,C,F).
1{ paintMid(X,F,Paint,0) : paint(Paint) }1 :- mid(X,F).
% right distribution of colors
4{ paintCorner(R,C,F,Paint,0) : corner(R,C,F) }4 :- paint(Paint).
4{ paintMid(X,F,Paint,0) : mid(X,F) }4 :- paint(Paint).

%%% mids
% neighboring mid tiles not identical colors
:- paintMid(b,1,Paint,0), paintMid(t,2,Paint,0), paint(Paint).
:- paintMid(r,1,Paint,0), paintMid(t,3,Paint,0), paint(Paint).
:- paintMid(t,1,Paint,0), paintMid(t,5,Paint,0), paint(Paint).
:- paintMid(l,1,Paint,0), paintMid(t,6,Paint,0), paint(Paint).

:- paintMid(r,2,Paint,0), paintMid(l,3,Paint,0), paint(Paint).
:- paintMid(r,3,Paint,0), paintMid(l,5,Paint,0), paint(Paint).
:- paintMid(r,5,Paint,0), paintMid(l,6,Paint,0), paint(Paint).
:- paintMid(r,6,Paint,0), paintMid(l,2,Paint,0), paint(Paint).

:- paintMid(b,4,Paint,0), paintMid(b,5,Paint,0), paint(Paint).
:- paintMid(r,4,Paint,0), paintMid(b,3,Paint,0), paint(Paint).
:- paintMid(t,4,Paint,0), paintMid(b,2,Paint,0), paint(Paint).
:- paintMid(l,4,Paint,0), paintMid(b,6,Paint,0), paint(Paint).

% neighboring mid stones not opposing colors
:- paintMid(b,1,P1,0), paintMid(t,2,P2,0), across(P1,P2).   :- paintMid(b,1,P1,0), paintMid(t,2,P2,0), across(P1,P2).
:- paintMid(r,1,P1,0), paintMid(t,3,P2,0), across(P1,P2).   :- paintMid(r,1,P1,0), paintMid(t,3,P2,0), across(P1,P2).
:- paintMid(t,1,P1,0), paintMid(t,5,P2,0), across(P1,P2).   :- paintMid(t,1,P1,0), paintMid(t,5,P2,0), across(P1,P2).
:- paintMid(l,1,P1,0), paintMid(t,6,P2,0), across(P1,P2).   :- paintMid(l,1,P1,0), paintMid(t,6,P2,0), across(P1,P2).

:- paintMid(r,2,P1,0), paintMid(l,3,P2,0), across(P1,P2).   :- paintMid(r,2,P1,0), paintMid(l,3,P2,0), across(P1,P2).
:- paintMid(r,3,P1,0), paintMid(l,5,P2,0), across(P1,P2).   :- paintMid(r,3,P1,0), paintMid(l,5,P2,0), across(P1,P2).
:- paintMid(r,5,P1,0), paintMid(l,6,P2,0), across(P1,P2).   :- paintMid(r,5,P1,0), paintMid(l,6,P2,0), across(P1,P2).
:- paintMid(r,6,P1,0), paintMid(l,2,P2,0), across(P1,P2).   :- paintMid(r,6,P1,0), paintMid(l,2,P2,0), across(P1,P2).

:- paintMid(b,4,P1,0), paintMid(b,5,P2,0), across(P1,P2).   :- paintMid(b,4,P1,0), paintMid(b,5,P2,0), across(P1,P2).
:- paintMid(r,4,P1,0), paintMid(b,3,P2,0), across(P1,P2).   :- paintMid(r,4,P1,0), paintMid(b,3,P2,0), across(P1,P2).
:- paintMid(t,4,P1,0), paintMid(b,2,P2,0), across(P1,P2).   :- paintMid(t,4,P1,0), paintMid(b,2,P2,0), across(P1,P2).
:- paintMid(l,4,P1,0), paintMid(b,6,P2,0), across(P1,P2).   :- paintMid(l,4,P1,0), paintMid(b,6,P2,0), across(P1,P2).

% derive adjacent mids
adj(P1,P2) :- paintMid(b,1,P1,0), paintMid(t,2,P2,0), paint(P1), paint(P2).
adj(P1,P2) :- paintMid(r,1,P1,0), paintMid(t,3,P2,0), paint(P1), paint(P2).
adj(P1,P2) :- paintMid(t,1,P1,0), paintMid(t,5,P2,0), paint(P1), paint(P2).
adj(P1,P2) :- paintMid(l,1,P1,0), paintMid(t,6,P2,0), paint(P1), paint(P2).

adj(P1,P2) :- paintMid(r,2,P1,0), paintMid(l,3,P2,0), paint(P1), paint(P2).
adj(P1,P2) :- paintMid(r,3,P1,0), paintMid(l,5,P2,0), paint(P1), paint(P2).
adj(P1,P2) :- paintMid(r,5,P1,0), paintMid(l,6,P2,0), paint(P1), paint(P2).
adj(P1,P2) :- paintMid(r,6,P1,0), paintMid(l,2,P2,0), paint(P1), paint(P2).

adj(P1,P2) :- paintMid(b,4,P1,0), paintMid(b,5,P2,0), paint(P1), paint(P2).
adj(P1,P2) :- paintMid(r,4,P1,0), paintMid(b,3,P2,0), paint(P1), paint(P2).
adj(P1,P2) :- paintMid(t,4,P1,0), paintMid(b,2,P2,0), paint(P1), paint(P2).
adj(P1,P2) :- paintMid(l,4,P1,0), paintMid(b,6,P2,0), paint(P1), paint(P2).

adj(P2,P1) :- adj(P1,P2).

% require all mids
:- not adj(1,2).
:- not adj(1,3). :- not adj(2,3).
:- not adj(1,5). :- not adj(2,4). :- not adj(3,4). :- not adj(4,5).
:- not adj(1,6). :- not adj(2,6). :- not adj(3,5). :- not adj(4,6). :- not adj(5,6).

%%% corners
% neighboring mid tiles not identical colors
:- paintCorner(b,r,1,X,0), paintCorner(t,l,3,X,0), paint(X). :- paintCorner(b,r,1,X,0), paintCorner(t,r,2,X,0), paint(X). :- paintCorner(t,l,3,X,0), paintCorner(t,r,2,X,0), paint(X).
:- paintCorner(t,r,1,X,0), paintCorner(t,l,5,X,0), paint(X). :- paintCorner(t,r,1,X,0), paintCorner(t,r,3,X,0), paint(X). :- paintCorner(t,l,5,X,0), paintCorner(t,r,3,X,0), paint(X).
:- paintCorner(t,l,1,X,0), paintCorner(t,l,6,X,0), paint(X). :- paintCorner(t,l,1,X,0), paintCorner(t,r,5,X,0), paint(X). :- paintCorner(t,l,6,X,0), paintCorner(t,r,5,X,0), paint(X).
:- paintCorner(b,l,1,X,0), paintCorner(t,l,2,X,0), paint(X). :- paintCorner(b,l,1,X,0), paintCorner(t,r,6,X,0), paint(X). :- paintCorner(t,l,2,X,0), paintCorner(t,r,6,X,0), paint(X).

:- paintCorner(b,r,2,X,0), paintCorner(b,l,3,X,0), paint(X). :- paintCorner(b,r,2,X,0), paintCorner(t,r,4,X,0), paint(X). :- paintCorner(b,l,3,X,0), paintCorner(t,r,4,X,0), paint(X).
:- paintCorner(b,r,3,X,0), paintCorner(b,l,5,X,0), paint(X). :- paintCorner(b,r,3,X,0), paintCorner(b,r,4,X,0), paint(X). :- paintCorner(b,l,5,X,0), paintCorner(b,r,4,X,0), paint(X).
:- paintCorner(b,r,5,X,0), paintCorner(b,l,6,X,0), paint(X). :- paintCorner(b,r,5,X,0), paintCorner(b,l,4,X,0), paint(X). :- paintCorner(b,l,6,X,0), paintCorner(b,l,4,X,0), paint(X).
:- paintCorner(b,r,6,X,0), paintCorner(b,l,2,X,0), paint(X). :- paintCorner(b,r,6,X,0), paintCorner(t,l,4,X,0), paint(X). :- paintCorner(b,l,2,X,0), paintCorner(t,l,4,X,0), paint(X).

% neighboring corner stones neighboring colors
:- paintCorner(b,r,1,X,0), paintCorner(t,l,3,Y,0), paintCorner(t,r,2,Z,0), not clockwiseCorner(X,Y,Z).
:- paintCorner(t,r,1,X,0), paintCorner(t,r,3,Z,0), paintCorner(t,l,5,Y,0), not clockwiseCorner(X,Y,Z).
:- paintCorner(t,l,1,X,0), paintCorner(t,l,6,Y,0), paintCorner(t,r,5,Z,0), not clockwiseCorner(X,Y,Z).
:- paintCorner(b,l,1,X,0), paintCorner(t,l,2,Y,0), paintCorner(t,r,6,Z,0), not clockwiseCorner(X,Y,Z).

:- paintCorner(b,r,2,X,0), paintCorner(b,l,3,Y,0), paintCorner(t,r,4,Z,0), not clockwiseCorner(X,Y,Z).
:- paintCorner(b,r,3,X,0), paintCorner(b,l,5,Y,0), paintCorner(b,r,4,Z,0), not clockwiseCorner(X,Y,Z).
:- paintCorner(b,r,5,X,0), paintCorner(b,l,6,Y,0), paintCorner(b,l,4,Z,0), not clockwiseCorner(X,Y,Z).
:- paintCorner(b,r,6,X,0), paintCorner(b,l,2,Y,0), paintCorner(t,l,4,Z,0), not clockwiseCorner(X,Y,Z).

% derive neighboring corners
cornerIs(X,Y,Z) :- paintCorner(b,r,1,X,0), paintCorner(t,l,3,Y,0), paintCorner(t,r,2,Z,0).
cornerIs(X,Y,Z) :- paintCorner(t,r,1,X,0), paintCorner(t,r,3,Z,0), paintCorner(t,l,5,Y,0).
cornerIs(X,Y,Z) :- paintCorner(t,l,1,X,0), paintCorner(t,l,6,Y,0), paintCorner(t,r,5,Z,0).
cornerIs(X,Y,Z) :- paintCorner(b,l,1,X,0), paintCorner(t,l,2,Y,0), paintCorner(t,r,6,Z,0).

cornerIs(X,Y,Z) :- paintCorner(b,r,2,X,0), paintCorner(b,l,3,Y,0), paintCorner(t,r,4,Z,0).
cornerIs(X,Y,Z) :- paintCorner(b,r,3,X,0), paintCorner(b,l,5,Y,0), paintCorner(b,r,4,Z,0).
cornerIs(X,Y,Z) :- paintCorner(b,r,5,X,0), paintCorner(b,l,6,Y,0), paintCorner(b,l,4,Z,0).
cornerIs(X,Y,Z) :- paintCorner(b,r,6,X,0), paintCorner(b,l,2,Y,0), paintCorner(t,l,4,Z,0).

cornerIs(Y,Z,X) :- cornerIs(X,Y,Z).

% require all corners
:- clockwiseCorner(X,Y,Z), not cornerIs(X,Y,Z).

#show paintMid/4.
#show paintCorner/5.