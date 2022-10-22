parent(philip, charles).
parent(philip,anne).
parent(charles, william).
ancestor(X,Y) :- parent(X,Y).
ancestor(X,Y) :- parent(X,Z), ancestor(Z,Y).
