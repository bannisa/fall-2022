higherValue(king,queen).
higherValue(queen,jack).

winsOver(X,Y) :- X = Y.
winsOver(X,Y) :- higherValue(X,Y).
winsOver(X,Y) :- higherValue(X,Z), winsOver(Z,Y).
