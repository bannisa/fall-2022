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

% define predicates for male and female that we will use later
female(W) :- wife(W,_); daughter(W,_).
male(P) :- husband(P,_);son(P,_).

% define new predicates using rules
husband(P,W) :- wife(W,P).
spouse(W,P)  :- wife(W,P); husband(W,P).
child(C,P) :- son(C,P); daughter(C,P).
parent(P,C) :- child(C,P).
grandparent(GP,X) :- parent(P,X), parent(GP,P).
grandchild(GC,GP) :- grandparent(GP,GC).
greatgrandparent(GGP,X) :- grandparent(GP,X), parent(GGP,GP).


% define predicates for sibling, sister and brother
% siblings are brothers that have the same mother and father
% to implement the siblings predicate I first define the mother and father predicates 
mother(M,X) :- parent(M,X), female(M).
father(F,X) :- parent(F,X), male(F).

sibling(S1, S2) :- mother(M,S2), mother(M,S1), S1 \= S2, father(F,S1), father(F,S2).

sister(S,X) :- sibling(S,X), female(S).
brother(B,X) :- sibling(B,X), male(B).

% define the following predicates: uncle, aunt, firstcousin, brotherinlaw, sisterinlaw

uncle(U,X) :- parent(P,X), brother(U,P).
aunt(U,X) :- parent(P,X), sister(U,P).
firstcousin(C,X) :- uncle(U,X), child(C,U); aunt(U,X), child(C,U).

% We can write rules in different ways, here is an alternative way
% to write the firstcousin rule
% firstcousin(X,Y) :- parent(P,Y),sibling(S,P),parent(S,X).

brotherinlaw(X,Y) :- brother(X,P), spouse(P,Y).
sisterinlaw(X,Y) :- sister(X,P), spouse(P,Y).

%
%
%

ancestor(AN,DC) :- child(DC,AN).
ancestor(AN,DC) :- child(DAN,AN), ancestor(DAN,DC).

%
%
%

decendent(DC,AN) :- parent(AN,DC).
decendent(NDC,AN) :- parent(AN,DAN), decendent(NDA,DAN).