append3([],L,L).
append3([X|L1],L2,[X|L3]):-append3(L1,L2,L3).

inverter(Lista,InvLista):- rev(Lista,[],InvLista). 
rev([X|L],K,R):-rev(L,[X|K],R).
rev([],K,K).

membro(X,[]):-fail.
membro(X,[Q|L]):-X = Q.
membro(X,[Q|L]):-membro(X,L). 

last([X],X).
last([L|Q],X):-last(Q,X).

last1(L,Q,X):-append(X,[Q],L).

q([M|_],1,M).
q([L|R],N,M):-N > 1,N1 is N - 1,q(R,N1,M).

delete_one(X,L1,L2):-append(La,[X|Lb],L1),append(La,Lb,L2).

delete_all(X,[],[]).
delete_all(X,[L1|R],L2):-L1 = X,delete_all(X,R,L2).
delete_all(X,[L1|R],[L1|L2]):-delete_all(X,R,L2).

delete_all2(X,[],[]):-!.
delete_all2(X,[X|R],L2):-!,delete_all2(X,R,L2).       %NAO PERCEBI.PERGUNTAR
delete_all2(X,[L1|R],L2):-!,delete_all2(X,R,L3),append([L1],L3,L2).

delete_all_list([],L2,L2).
delete_all_list([LX|R],L1,L2):-delete_all2(LX,L1,L4),delete_all_list(R,L4,L2).

before(X,Y,[X|R]).
before(X,Y,[Y|R]):-fail.
before(X,Y,[L1|R]):-L1\= Y,before(X,Y,R). % FAZER COM append

conta2([],N,N).
conta(Lista,N):-conta2(Lista,N,0).
conta2([Lista|R],N,M):-N1 is M + 1,conta2(R,N,N1).

conta_elem2(X,[],M,M).
conta_elem(X,Lista,N):-conta_elem2(X,Lista,N,0).
conta_elem2(X,[X|R],N,M):-M1 is M + 1,conta_elem2(X,R,N,M1).
conta_elem2(X,[Lista|R],N,M):- conta_elem2(X,R,N,M).

substitui(X,Y,[],[]).    %nao devia ser substitui(X,Y,[],Lista2). ??
substitui(X,Y,[X|R],Lista2):-substitui(X,Y,R,L3),append([Y],L3,Lista2).
substitui(X,Y,[Lista1|R],Lista2):-substitui(X,Y,R,L3),append([Lista1],L3,Lista2).

elimina_duplicados([], []).
elimina_duplicados([Lista1|R],Lista2):-member(Lista1,R),elimina_duplicados(R,Lista2).
elimina_duplicados([First|Rest],[First|NewRest]):- \+(member(First, Rest)), elimina_duplicados(Rest, NewRest).

ordenada([N]).
ordenada([Lista|[Lista2|R]]):-integer(Lista),Lista < Lista2,ordenada([Lista2|R]).

orden2([],[]).
orden2([Q],[Q]).
orden([],[]).
temp(L2,L2,1).
orden(L1,L2):-length(L1,M),temp(L1,L2,M).
temp([L1|R],L2,M):-M > 1,orden2([L1|R],L3),M1 is M - 1,temp(L3,L2,M1).
orden2([L1,L2|R1],[L1|R2]):- L2 > L1,orden2([L2|R1],R2).
orden2([L1,L2|R1],[L2|R2]):- L2 < L1,orden2([L1|R1],R2).

achata_lista([],[]).
achata_lista(L1,[L1]):-atomic(L1).
achata_lista([L1|R],L2):-achata_lista(L1,L3),achata_lista(R,L4),write(L3),write(L4),append(L3,L4,L2).

permutar(L1,L2):- permutation(L1,L2).


lista_ate(N,L):-lista(N,L,0).
lista_entre(N1,N2,L):-N3 is N1-1,lista(N2,L,N3).
lista(N,[],N).
lista(N,L,M):-M < N,M1 is M + 1,lista(N,L2,M1),append([M1],L2,L).


soma_lista(L, Soma):-soma(L,Soma,0).
soma([],Soma,Soma).
soma([L|R],Soma,M):-S is L + M,soma(R,Soma,S).
par(N):-mod(N,2) =:= 0. 
impar(N):-mod(N,2) =:= 1. 

lista_pares(N, Lista):-pares(N,Lista,1).
pares(M,[],M).
pares(N,Lista,M):-M < N,par(M),M1 is M + 1,pares(N,Lista2,M1),append([M],Lista2,Lista).
pares(N,Lista,M):-M < N,M1 is M + 1,pares(N,Lista,M1).

lista_impares(N, Lista):-impares(N,Lista,0).
impares(M,[],P):-P - M =:= 1.
impares(N,Lista,M):-M =< N ,impar(M),M1 is M + 1,impares(N,Lista2,M1),append([M],Lista2,Lista).
impares(N,Lista,M):-M =< N ,M1 is M + 1,impares(N,Lista,M1).

primo(N):-primotest(N,2).
primotest(N,N).
primotest(N,M):-N > M, \+(mod(N,M) =:= 0),M1 is M + 1,primotest(N,M1).

lista_primos(N, Lista):-lista_test(N,Lista,2).
lista_test(N,[],N).
lista_test(N,Lista,M):-primo(M),M1 is M + 1,lista_test(N,Lista2,M1),append([M],Lista2,Lista).
lista_test(N,Lista,M):-M1 is M + 1,lista_test(N,Lista,M1).

produto_interno([],[],[]).
produto_interno([L1|R1], [L2|R2], N):-length([L1|R1],M),length([L2|R2],P), P =:= M,produto_interno(R1,R2,N1),U is L1 * L2,append([U],N1,N).

misterio([],[]). 
misterio([X],[X]). 
misterio([X,Y|L],[X,censurado|M]):- misterio(L,M).

:- use_module(library(lists)).
palindromo(L1):-reverse(L1,L1).

palindromo1([]).
palindromo1([_]).
palindromo1(L1):-append([H|T], [H], L1),palindromo1(T).

doble([],[]).
doble([L1|R],L2):-doble(R,L3),append([L1,L1],L3,L2).

triple(L1,L2,N):-quad(L1,L2,N,0).
quad([],[],N,0).
quad([L1|R],L2,N,M):-M < N,M1 is M + 1,quad([L1|R],L3,N,M1),append([L1],L3,L2). 
quad([L1|R],L2,N,M):-M >= N, M1 is 0, quad(R,L2,N,M1).

run(L1,X):-runl(L1,X,1).
runl([],[],M).
runl([L1,L1|R],X,M):-M1 is M + 1,runl([L1|R],X,M1).
runl([L1|R],X,M):- M \= 1,append([[M,L1]],L3,X),M1 is 1,runl(R,L3,M1).
runl([L1|R],X,M):- M =:= 1,append([L1],L3,X),M1 is 1,runl(R,L3,M1).

des([],L2).
des([[L1,R]|R2],L2):-descomp([[L1,R]|R2],L2,R).
descomp([L1],[],0).
descomp([[L1,R1]],[],0).
descomp([[L1,R],R2],L2,R3):-R3 =:= 0,descomp([R2],L2,1).

%descomp([L1,[L4,L3]|R],L2,R3):-R3 \= 0,descomp([[L4,L3]|R],L2,L3).
descomp([[L1,R],[R2,R4]|R5],L2,R3):-R3 =:= 0,descomp([[R2,R4]|R5],L2,R4).
descomp([[L1,R]|R2],L2,R3):-R3 \= 0,R4 is R3 - 1,descomp([[L1,R]|R2],L3,R4),append([L1],L3,L2).
descomp([R|R2],L2,R3):-R3 \= 0,R4 is R3 - 1,descomp([R|R2],L3,R4),append([R],L3,L2).


dropN(L1,N,L2):-aux(L1,N,L2,0).
aux([],N,[],P):-N -P =:= 1.
aux([L1|R],N,L2,N):-aux(R,N,L2,0).
aux([L1|R],N,L2,M):-N > M,M1 is M + 1,aux(R,N,L3,M1),append([L1],L3,L2).

slice(L1,N1,N2,L):-slice2(L1,N1,N2,L,1).
slice2([],N1,N2,[],P).
slice2([L1|R],N1,N2,L,M):-M < N1,M1 is M + 1,slice2(R,N1,N2,L,M1).
slice2([L1|R],N1,N2,L,M):-M >= N1, M =< N2,M1 is M + 1,slice2(R,N1,N2,L3,M1),append([L1],L3,L).
slice2([L1|R],N1,N2,L,M):-M > N1, M > N2,M1 is M + 1,slice2(R,N1,N2,L,M1).

rodar(L,N,X):-rodar2(L,N,X,0).
rodar2(X,N,X,N).
rodar2([L|R],N,X,M):-N > M,M1 is M + 1,append(R,[L],X1),rodar2(X1,N,X,M1).
rodar2(L,N,X,M):-length(L,N2),N3 is N2 + N,rodar2(L,N3,X,M).
:- use_module(library(random)).

rdn_selectN(L1,0,[]).
rdn_selectN(L1,N,L2):- N1 is N - 1,length(L1,S),random(0,S,T),nth0(T,L1,K),rdn_selectN(L1,N1,L3),append([K],L3,L2).

rdn_select(0,M,[]).
rdn_select(N,M,L):-N1 is N - 1,random(0,M,T),rdn_select(N1,M,L2),append([T],L2,L).

rdn_permut(L1,L2):-rdn_permut2(L1,L2).
rdn_permut2([],[]).
rdn_permut2([L1],L2):-rdn_permut2([],L3),append([L1],L3,L2).
rdn_permut2([L1,L2|R],L4):-random(0,2,T),T =:= 1,rdn_permut2([L1|R],L3),append([L2],L3,L4).
rdn_permut2([L1,L2|R],L4):-rdn_permut2([L2|R],L3),append([L1],L3,L4).

%bsort(L1,L1).
%bsort([],L2).
bsort(L1,L2):-length(L1,N),N1 is N*N,bsort2(L1,L1,L2,N1).
bsort2(L7,[],L4,N):-write(L4).

bsort2(L7,[L1],L3,N):-N > 0,N1 is N - 1,write(L3),bsort2(L7,[],L4,N1),append([L1],L4,L3).
bsort2(L7,[L1,L2|R],L3,N):-N > 0,N1 is N - 1,L2 < L1,bsort2(L7,[L1|R],L4,N1),append([L2],L4,L3).
bsort2(L7,[L1,L2|R],L3,N):-N >0,N1 is N - 1,L1 < L2,bsort2(L7,[L2|R],L4,N1),append([L1],L4,L3).
bsort2(L7,[],L4,P):-P is 0.


