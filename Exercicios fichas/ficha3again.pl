

x([],L,L). 
x([X|L1],L2,[X|L3]):- x(L1,L2,L3).

inverter(L1,L2):-rev(L1,[],L2).
rev([],L,L).
rev([X|L1],L2,L3):- rev(L1,[X|L2],L3).

membro(X,[X|L]).
membro(X,[Y|L]):-membro(X,L).

membro2(X,L):- append([Y|T],[X|P],L).

last(L,X):-append([Y|R],[X],L).

n(Y,[Y|Lista],0).
n(Elemento,[Y|Lista],X):-X > 0, X1 is X - 1, n(Elemento,Lista,X1). 

delete_one(X,L1,L2):-append(L4,[X|Lista],L1),append(L4,Lista,L2).

delete_all(X,L1,L2):- rep(X,L1,L2).
rep(X,L1,L2):-delete_one(X,L1,L4),rep(X,L4,L3).
rep(X,L2,L2).

delete_all2(X,[],L3,[]).
delete_all2(X,[X|L1],L2,L3):-delete_all2(X,L1,L2,L3),!.
delete_all2(X,[Y|L1],L2,[Y|L3]):-delete_all2(X,L1,L2,L3).

deletelist([],L2,L2).
deletelist([LX|R],L1,L2):-delete_all2(LX,L1,L4,L5),deletelist(R,L5,L2).

before(A,B,L):- append(_,[A|R],L1),!,append(L1,[B|L3],L),!.

conta(Lista, N):- length(Lista,N).
conta_elem(X,[],T,T).
conta_elem(X, [X|Lista], N ,T):- T1 is T + 1,conta_elem(X,Lista,N,T1),!.
conta_elem(X, [Y|Lista], N, T):- conta_elem(X,Lista,N,T). 

substitui(X,Y,[],[]).
substitui(X,Y,[X|Lista1],[Y|Lista2]):-substitui(X,Y,Lista1,Lista2),!.
substitui(X,Y,[Z|Lista1],[Z|Lista2]):-substitui(X,Y,Lista1,Lista2). 

elimina_duplicados([],[]).
elimina_duplicados([X|Lista1],Lista2):- member(X,Lista1),elimina_duplicados(Lista1,Lista2).
elimina_duplicados([X|Lista1],[X|Lista2]):- \+ member(X,Lista1), elimina_duplicados(Lista1,Lista2).  

ordenada([X]).
ordenada([X,Y|Lista]):-Y > X,ordenada([Y|Lista]).

ordenabig(L5,0,L5).
ordenabig(L1,X,L3):- X > 0, X1 is X - 1, ordena(L1,L5),ordenabig(L5,X1,L3).

ordena([X],[X]).
ordena([X,Y|Lista],[Y|Lista2]):- X > Y,ordena([X|Lista],Lista2).
ordena([X,Y|Lista],[X|Lista2]):- Y > X, ordena([Y|Lista],Lista2).

achata([],[]).
achata(X,[X]):-atomic(X).
achata([H|Resto],L):- achata(H,L1),achata(Resto,L2),append(L1,L2,L).

%perm(X,L):- mselect(X,L,[]).

%mselect([A|B],L,R):- mselect(A,L,M), mselect(B,M,R).
%mselect([],L,L).

lista_ate(N,N,[]).
lista_ate(N,Y,[Y|L]):- N > Y, Y1 is Y + 1, lista_ate(N,Y1,L).
par(N):-mod(N,2) =:= 0. 

listapar(0,[]).
listapar(N,[N|L]):- N > 0, par(N), N1 is N - 1, listapar(N1,L),!.
listapar(N,L):-N1 is N - 1, listapar(N1,L).

primo(N,1).
primo(N,M):- \+ (mod(N,M) =:= 0), M1 is M - 1, primo(N,M1).

lista_primos(1,[]).
lista_primos(N,[N|Resto]):- M is N - 1,primo(N,M),N1 is N - 1,lista_primos(N1,Resto).
lista_primos(N,Resto):-N1 is N - 1,lista_primos(N1,Resto).

produto_interno([],[],N,N).
produto_interno([L1|R], [L2|R2], N , N1):- N2 is N1 + (L1 * L2), produto_interno(R,R2,N,N2).

palindromo1([]).
palindromo1([_]).
palindromo1(L1):-append([H|T], [H], L1),palindromo1(T).

dobro([],[]).
dobro([H|Resto],[H,H|Resto2]):-dobro(Resto,Resto2).

nvezes([],_,_,[]).
nvezes([H|Resto],C,T,L):- C =:= 0, nvezes(Resto,T,T,L). 
nvezes([H|Resto],C,T,[H|L]):- C > 0, C1 is C - 1, nvezes([H|Resto],C1,T,L).

run([],T,_,T).
run([X],L,C,T):-(C =:= 1 -> append([[X]],L,L3);(append([[X,C]],L,L3))),run([],L3,C,T).
run([H1,H2|Resto],L,C,T):- H1 \= H2, append([[H1,C]],L,L3),run([H2|Resto],L3,1,T).
run([H1,H2|Resto],L2,C,T):- H1 == H2, C1 is C + 1,run([H2|Resto],L2,C1,T). 

decomp([],L3,L3).
decomp([[H,L]|R],L2,L3):- decomp2([[H,L]|R],L5,H),!,append(L2,L5,L6),decomp(R,L6,L3).
decomp2(_,[],0).
decomp2([[H,L]|R],[H|L2],T):- T1 is T - 1, decomp2([[H,L]|R],L2,T1).

drop([],_,_,[],L4).
drop([H|L],N,T,L2,L4):-T =:= 0,drop(L,N,N,L2,L4). 
drop([H|L],N,T,[H|L2],L4):-T1 is T - 1,drop(L,N,T1,L2,L4). 
slice(_,X1,X2,[],X2).
slice([H|L],X1,X2,L2,T):- T1 is T + 1, T1 < X1, slice(L,X1,X2,L2,T1).
slice([H|L],X1,X2,[H|L2],T):- T1 is T + 1, T1 >= X1,X2 >= T1,slice(L,X1,X2,L2,T1).

rodar(L,N,L2):-N > 0,length(L3,N),append(L3,L4,L),append(L4,L3,L2).
rodar(L,N,L2):-N < 0,N2 is N * -1,length(L,N3),N4 is N3 - N2,length(L3,N4),append(L3,L4,L),append(L4,L3,L2).

:-use_module(library(random)).
:-use_module(library(lists)).
rdn_selectN(_,0,L3,L3).
rdn_selectN(L,X,L2,L3):- length(L,N2),random(0,N2,T),nth0(T,L,Y),append([Y],L2,L5),X1 is X - 1,rdn_selectN(L,X1,L5,L3),!.

rnd_select(0,_,L3,L3).
rnd_select(X1,X2,L,L3):- random(0,X2,Y),append(L,[Y],L2),X3 is X1-1,rnd_select(X3,X2,L2,L3).

per([],L6,L6).
per(L1,L2,L6):- length(L1,N),random(0,N,N2),nth0(N2,L1,X),append(L3,[X|R],L1),append(L3,R,L4),append(L2,[X],L5),per(L4,L5,L6).