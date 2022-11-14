
person(lisa, female, 180, 30, phd).
person(jenny, female, 167, 25, hs).
person(bob, male, 180, 40, phd).
person(charles, male, 190, 30, masters).
person(arnold, male, 177, 29, hs).

education(0,college).
education(1,hs).
education(2,masters).
education(3,phd).

edu_le(A,B) :- education(Z,A), education(C,B), Z >= C.


dateable(F,M) :- person(F,G1,H1,A1,E1), person(M,G2,H2,A2,E2), F \= M, female == G1, male == G2, H2 >= H1, edu_le(E2,E1), A1 =< A2, not((A2-10) > A1).