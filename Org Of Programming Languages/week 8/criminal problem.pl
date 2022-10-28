implicates("Colonel Mustard","Professor Plum").
implicates("Mrs. Peacock","Colonel Mustard").

criminial(X) :- implicates(X,Y), not(implicates(Y,_)).
