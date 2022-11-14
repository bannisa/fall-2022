person(scarlet).
person(mustard).
person(peacock).
person(plum).

implicates(scarlet,Z) :- Z \= scarlet.
implicates(mustard,Z) :- Z = plum.
implicates(peacock,Z) :- Z = mustard.
implicates(plum,Z) :- Z \= plum.

criminial(C) :- person(C),person(A), person(B), person(D), person(E),
                A \= B, A \= D, A \= E, B \= D, B \= E, D \= E,
                implicates(A,C), not(implicates(B,C)), not(implicates(D,C)), not(implicates(E,C)).
