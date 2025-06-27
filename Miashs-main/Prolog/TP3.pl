score([],[],0).
score([X|Y1],[X|Y2],R1):-score(Y1,Y2,R2),R1 is R2+1.
score([X1|Y1],[X2|Y2],R):-X1\=X2,score(Y1,Y2,R).
qcm(BonnesReponses) :-
    BonnesReponses = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10],

    % Chaque �l�ment de la liste doit �tre soit a, b, c, ou d
    member(A1, [a, b, c, d]),
    member(A2, [a, b, c, d]),
    member(A3, [a, b, c, d]),
    member(A4, [a, b, c, d]),
    member(A5, [a, b, c, d]),
    member(A6, [a, b, c, d]),
    member(A7, [a, b, c, d]),
    member(A8, [a, b, c, d]),
    member(A9, [a, b, c, d]),
    member(A10, [a, b, c, d]),

    % Anciennes feuilles de r�ponses
    F1 = [b,c,b,a,c,c,c,d,c,c],
    F2 = [b,d,c,a,d,d,c,c,a,b],
    F3 = [d,a,b,b,d,d,c,d,a,b],
    F4 = [c,d,c,b,d,b,b,c,a,a],

    % Scores correspondants (fournis dans l'�nonc�)
    score(F1, BonnesReponses, 7),
    score(F2, BonnesReponses, 6),
    score(F3, BonnesReponses, 5),
    score(F4, BonnesReponses, 3).

% D�finition correcte de min(X1, X2, Min)
min(X1, X2, X1) :- X1 < X2.
min(X1, X2, X2) :- X2 =< X1.

% Remplir le seau de 5 litres (X1)
action([X1, X2], [5, X2]) :- X1 < 5.

% Remplir le seau de 3 litres (X2)
action([X1, X2], [X1, 3]) :- X2 < 3.

% Transvider le seau de 5 litres vers le seau de 3 litres
action([X1, X2], [Y1, Y2]) :-
    X1 > 0, X2 < 3,
    min(X1, 3 - X2, X3), % Calculer la quantit� transf�rable
    Y1 is X1 - X3,
    Y2 is X2 + X3.

% Transvider le seau de 3 litres vers le seau de 5 litres
action([X1, X2], [Y1, Y2]) :-
    X2 > 0, X1 < 5,
    min(X2, 5 - X1, X3), % Calculer la quantit� transf�rable
    Y1 is X1 + X3,
    Y2 is X2 - X3.

% Vider compl�tement le seau de 5 litres
action([X1, X2], [0, X2]) :- X1 \= 0.

% Vider compl�tement le seau de 3 litres
action([X1, X2], [X1, 0]) :- X2 \= 0.

% Condition d'arr�t : si le premier �l�ment est [4,_], on a trouv� une solution
solution([[4,_] | _]) :- !.

% Recherche r�cursive d'une solution
solution([X | Y]) :-
    action(X, X1),  % G�n�rer un nouvel �tat � partir de X
    \+ member(X1, [X | Y]),  % V�rifier que l'�tat n'a pas encore �t� visit�
    ,write(X1),solution([X1, X | Y]).  % Continuer la recherche avec le nouvel �tat





