%------------------------------------------------------------------
% Prolog program to represent a family tree
% 

wife(mum,george).
wife(kydd,spencer).
wife(elizabeth,philip).
wife(diana,charles).
wife(anne,mark).
wife(sarah,andrew).
daughter(elizabeth,george).
daughter(elizabeth,mum).
daughter(margaret,george).
daughter(margaret,mum).
daughter(diana,spencer).
daughter(diana,kydd).
daughter(anne,elizabeth).
daughter(anne,philip).
daughter(zara,anne).
daughter(zara,mark).
daughter(beatrice,sarah).
daughter(beatrice,andrew).
daughter(eugenie,sarah).
daughter(eugenie,andrew).
son(charles,elizabeth).
son(charles,philip).
son(andrew,elizabeth).
son(andrew,philip).
son(edward,elizabeth).
son(edward,philip).
son(william,diana).
son(william,charles).
son(harry,diana).
son(harry,charles).
son(peter,anne).
son(peter,mark).

female(W) :- wife(W,_); daughter(W,_).
male(P) :- husband(P,_);son(P,_).

husband(P,W) :- wife(W,P).
spouse(W,P)  :- wife(W,P); husband(W,P).
child(C,P) :- son(C,P); daughter(C,P).
parent(P,C) :- child(C,P).
grandparent(GP,X) :- parent(P,X), parent(GP,P).
grandchild(GC,GP) :- grandparent(GP,GC).
greatgrandparent(GGP,X) :- grandparent(GP,X), parent(GGP,GP).

mother(M,X) :- parent(M,X), female(M).
father(F,X) :- parent(F,X), male(F).
siblings(S1, S2) :- mother(M,S2), mother(M,S1), S1 \= S2, father(F,S1), father(F,S2).
sister(S,X) :- sibling(S,X),female(S).
brother(B,X) :- sibling(B,X), male(B).

uncle(U,X) :- parent(P,X), brother(U,P).
aunt(U,X) :- parent(P,X), sister(U,P).
firstcousin(C,X) :- uncle(U,X), child(C,U); aunt(U,X), child(C,U).
% alternative way
% firstcousin(X,Y) :- parent(P,Y),sibling(S,P),parent(S,X).

brotherinlaw(X,Y) :- brother(X,P), spouse(P,Y).
brotherinlaw(X,Y) :- brother(Y,P), spouse(X,P).
sisterinlaw(X,Y) :- sister(X,P), spouse(P,Y).
sisterinlaw(X,Y) :- sister(Y,P), spouse(X,P).















