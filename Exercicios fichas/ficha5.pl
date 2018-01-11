a(N):- N \= 5, N \= 4, !,N \= 3, N \= 2.
a(N):- N \= 7, N \= 99.

dados(um).
dados(dois).
dados(tres).
cut_teste_a(X) :-dados(X).
cut_teste_a('ultima_clausula'). 

cut_teste_b(X):-dados(X), !.
cut_teste_b('ultima_clausula'). 

cut_teste_c(X,Y) :-dados(X),!,dados(Y).
cut_teste_c('ultima_clausula'). 

max(X, Y, Z, X):- X>Y, X>Z, !.
max(X, Y, Z, Y):- Y>X, Y>Z, !.
max(_, _, Z, Z). 

unificavel([],_,[]).
unificavel([T|Resto],T1,Resto1):- \+ T=T1,!,unificavel(Resto,T1,Resto1).
unificavel([T|Resto],T1,[T|Resto1]):- unificavel(Resto,T1,Resto1). 


 imaturo(X):- adulto(X), !, fail.
 imaturo(X).
 adulto(X):- pessoa(X), !, idade(X, N), N>=18.
 adulto(X):- tartaruga(X), !, idade(X, N), N>=50. 