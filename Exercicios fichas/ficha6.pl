duplica(X,Y) :- Y is 2*X.
map([X|Resto],F,[Y|Resto2]):-G=..[F,X,Y],G,map(Resto,F,Resto2).
map([],_,[]).

filtrar(X,F,P):- filtrar2(X,F,Y,L),append(Y,L,P).
filtrar2([X|Resto],F,[X|Resto2],L):-G=..[F,X],G, !,filtrar2(Resto,F,Resto2,L).
filtrar2([X|Xs],F,Ys,[X|L]):- filtrar2(Xs,F,Ys,L).
filtrar2([],_,[],[]).

mais_proximos(I,[N1-D1|Prox]) :-  setof(Dif-Nome,(idade(Nome,Id), Dif is Id - I),[D1-N1|L]), primeiros(D1,L,Prox).
 
primeiros(_,[],[]).
primeiros(D1,[_-N|L],[N|NL]) :- primeiros(D1,L,NL). 
 
%Dados para teste: 
idade(maria,30). 
idade(pedro,25). 
idade(jose,25). 
idade(rita,18). 
 

%-----------------------------------------------------------
f(X,Y):-Y is X*X. 
duplica(X,Y) :- Y is 2*X. 

map([],_,[]).
map([C|R],Transfor,[TC|CR]):- aplica(Transfor, [C,TC]),map(R,Transfor,CR).
aplica(P,LArgs) :- G =.. [P|LArgs],G. 


%t(X):- X =:= 3; X=:= 5; X=:=4.

aplica2(P,[],L2,[],[]).
temp(L,P,L2):-separa(L,P,L2,L3,L4).
separa(L,P,L2,L3,L4):-aplica2(P,L,L2,L3,L4),append(L3,L4,L2).
aplica2(P,[L|R],L2,[L|L3],L4):- G =.. [P|[L]],G,!,aplica2(P,R,L2,L3,L4).
aplica2(P,[L|R],L2,L3,[L|L4]):-aplica2(P,R,L2,L3,L4).

separa2(L,P,Res) :- sepDL(L,P,Res,Nots).
sepDL([],_,P,N). 

sepDL([V|L],P,[V|Y],N) :- aplica(P,[V]), !, sepDL(L,P,Y,N).
sepDL([V|L],P,Y,[V|N]) :- sepDL(L,P,Y,N).

%Dados para teste:
idade(maria,30).
idade(pedro,25).
idade(jose,25).
idade(rita,18). 

mais_proximas(I,L):- setof(M,idade(M,I),L).

mais_proximas(I,L):-mais_proximas2(I,L),mais_proximas3(I,L).
mais_proximas3(I,L):- I1 is I - 1,setof(M,idade(M,I1),L),mais_proximas3(I1,L).
mais_proximas3(I,L):- I1 is I - 1.
mais_proximas2(I,L):- I2 is I + 1,setof(M,idade(M,I2),L),mais_proximas2(I2,L).
mais_proximas2(I,L):- I2 is I + 1.

:- op(500,xfx,na).
:- op(500,xfy,ad).
:- op(500,yfx,ae). 

t(0+1, 1+0).
 t(X+0+1, X+1+0). 

t(X+1+1, Z) :- t(X+1, X1),t(X1+1, Z).
