salto_cavalo(X/Y,X1/Y1):- X2 is X - 1, Y2 is Y - 2,Y2 > 0, X2 > 0,Y1 is Y2,X1 is X2.
salto_cavalo(X/Y,X1/Y1):- X2 is X - 2, Y2 is Y - 1,X2 > 0,Y2 < 0,X1 is X2,Y1 is Y2.
salto_cavalo(X/Y,X1/Y1):- X2 is X + 1, Y2 is Y - 2,Y2 > 0, X2 < 9,Y1 is Y2,X1 is X2.
salto_cavalo(X/Y,X1/Y1):- X2 is X + 2, Y2 is Y - 1,X2 < 9,Y2 > 0,X1 is X2,Y1 is Y2.

salto_cavalo(X/Y,X1/Y1):- X2 is X - 1, Y2 is Y + 2,Y2 < 9, X2 > 0,Y1 is Y2,X1 is X2.
salto_cavalo(X/Y,X1/Y1):- X2 is X - 2, Y2 is Y + 1,X2 > 0,Y2 < 9,X1 is X2,Y1 is Y2.
salto_cavalo(X/Y,X1/Y1):- X2 is X + 1, Y2 is Y + 2,Y2 < 9, X2 < 9,Y1 is Y2,X1 is X2.
salto_cavalo(X/Y,X1/Y1):- X2 is X + 2, Y2 is Y + 1,X2 < 9,Y2 < 9,X1 is X2,Y1 is Y2.

trajeto([X1]).
trajeto([X,X1|R]):-salto_cavalo(X,X1),trajeto([X1|R]).

mapa(['o','o','x','o','o']).

start :-mapa(X),impmap(X),nl,move(X,X,I).
move([],Y,X):- Y \= X,write(X),nl,move(X,X,G).
move([],Y,X):- write('GAME OVER MOTHERFUKER').
move(['x','o','o'|R],Y,I):-append(I,['o','x','x'],L3),move(R,Y,L3).
move(['o','o','x'|R],Y,I):-append(['x','x','o'],I,L3),move(R,Y,L3).
move([X|R],Y,I):-append(I,[X],L3),move(R,Y,L3). 
impmap(X) :-temp(X).
temp([]).
temp(X):-write(X).