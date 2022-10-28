implicates("Mrs. Peacock","Colonel Mustard").
implicates("Colonel Mustard","Professor Plum").

criminial(X):- not(implicates(X,Y)), implicates(Y,X).
