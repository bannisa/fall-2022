suits(spades).
suits(hearts).
suits(dimands).


/**
 *  H1 | H2 | H3
 * --------------
 *  H4 | H5 | H6
 * --------------
 *  H7 | H8 | H9
 */

grid(H1,H2,H3,H4,H5,H6,H7,H8,H9) :- suits(H1),suits(H2),suits(H3),suits(H4),suits(H5),suits(H6),suits(H7),suits(H8),suits(H9),
                                    H1 \= H2, H1 \= H3, H2 \= H3, /**first row*/
                                    H4 \= H1, H4 \= H5, H4 \= H6, H5 \= H2, H5 \= H6, H6 \= H3, /**middle row*/
                                    H7 \= H1, H7 \= H4, H7 \= H8, H7 \= H9, /** last row first col*/
                                    H8 \= H2, H8 \= H5, H8 \= H9, /**second col, last row*/
                                    H9 \= H3, H9 \= H6. /**last col, last row*/
