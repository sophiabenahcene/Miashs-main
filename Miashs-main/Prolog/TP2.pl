ecart(A,B,C):- A<B,C is B-A.
ecart(A,B,C):- B=<A,C is A-B.

% V�rifier si un nombre est premier
premier(N) :-
    N > 1,
    R is floor(sqrt(N)),
    \+ (between(2, R, X), N mod X =:= 0).

% V�rifier si deux nombres sont premiers, ont une diff�rence de 8 et des milliers diff�rents
premiersDiff8(A, B) :-
    between(1, 9999, A),
    B is A + 8,  % On �vite la redondance en calculant directement B
    B =< 9999,   % On s'assure que B reste dans la plage demand�e
    premier(A),
    premier(B),
    (A // 1000)=\= (B // 1000).   % V�rifier que les chiffres des milliers sont diff�rents

% Une liste vide ou une liste � un seul �l�ment est forc�ment constitu�e d'�l�ments uniques.
tousDifferents([]).
tousDifferents([X|L]) :-
    \+ member(X, L), % V�rifie que X n'est pas d�j� dans L
    tousDifferents(L). % V�rifie r�cursivement pour le reste de la liste:

% R�solution de l'�quation FRERE + SOEUR = BASTON
solution([F,R,E,S,O,U,B,A,T,N]) :-
    % Assigner des chiffres uniques aux lettres
    L = [F,R,E,S,O,U,B,A,T,N],
    tousDifferents(L), % V�rifie que tous les chiffres sont distincts
    between(0,9,F), between(0,9,R), between(0,9,E), between(0,9,S),
    between(0,9,O), between(0,9,U), between(0,9,B), between(0,9,A),
    between(0,9,T), between(0,9,N),

    % Les premiers chiffres des nombres ne doivent pas �tre 0
    F \= 0, S \= 0, B \= 0,

    % Conversion des mots en nombres
    FRERE is 10000*F + 1000*R + 100*E + 10*R + E,
    SOEUR is 10000*S + 1000*O + 100*E + 10*U + R,
    BASTON is 100000*B + 10000*A + 1000*S + 100*T + 10*O + N,

    % V�rifier l'�quation
    FRERE + SOEUR =:= BASTON,

    % Affichage de la solution
    writef("%d%d%d%d%d + %d%d%d%d%d = %d%d%d%d%d%d\n",
        [F,R,E,R,E,S,O,E,U,R,B,A,S,T,O,N]).
