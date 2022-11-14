divisiable(DD,DV) :- DV > 1, 0 =:= (DD mod DV).
divisiable(DD,DV) :- DV-1 > 1, divisiable(DD,DV-1).

isPrime(2) :- true,!.
isPrime(X) :- X < 2, false,!.
isPrime(X) :- X >= 3, not(divisiable(X,X // 2)).