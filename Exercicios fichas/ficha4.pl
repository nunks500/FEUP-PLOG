ligado(a,b,7). 
ligado(f,i,5). 
ligado(a,c,4). 
ligado(f,j,3). 
ligado(b,d,6). 
ligado(f,k,9). 
ligado(b,e,8). 
ligado(g,l,1). 
ligado(b,f,1). 
ligado(g,m,1). 
ligado(c,g,2). 
ligado(k,n,3). 
ligado(d,h,4). 
ligado(l,o,3).
ligado(d,i,1). 
ligado(i,f,1).

determina(NF,NF,[NF]).
determina(N,NF,S):-prof3(N,NF,S,0).

prof(NF,NF,[NF],_).
prof(N,NF,S,I):-ligado(N,F,Q),Q1 is I + Q,prof(F,NF,S1,Q1),append([N],S1,S).

prof3(NF,NF,S,Q).
prof3(N,NF,S,Q):-prof2(N,NF,S,[],Q).
prof2(NF,NF,[NF|S],S,T):-write(T).
prof2(N,NF,S,S1,T):-ligado(N,F,Q),Q1 is Q + T,\+member(N,S1),prof2(F,NF,S,[N|S1],Q1).

%largura(NF,NF,_).
%largura(N,NF,S):-bagof(F,ligado(N,F),[L|R]),largura(L,NF,S).

% Acha todos os X onde Y esta satisfeito e retorna numa lista Y 
ache_todos(X, Y, Z):- bagof(X, Y, Z), !. 
ache_todos(_, _, []). 
 
% Estende a fila ate um filho N1 de N, verificando se N1  // não pertence à fila, prevenindo, assim, ciclos 
estende_ate_filho([N|Trajectoria], [N1,N|Trajectoria]):-  ligado(N, N1),  \+member(N1, Trajectoria). 
 
% Encontra o caminho Solucao entre No_inicial e No_Meta 
resolva_larg(No_inicial, No_meta, Solucao):-  largura([[No_inicial]], No_meta, Solucao). 
 
% Realiza a pesquisa em largura 
largura([[No_meta|T]|_],No_meta,[No_meta|T]).  
largura([T|Fila],No_meta,Solucao):-ache_todos(ExtensaoAteFilho,estende_ate_filho(T,ExtensaoAteFilho),Extensoes),    concatena(Fila, Extensoes, FilaExtendida),    largura(FilaExtendida, No_meta, Solucao).

disponibilidade(pedro, [disp(2,4), disp(13,20), disp(25,28)]).
disponibilidade(joel, [disp(1,4), disp(10,20), disp(25,28)]).
disponibilidade(maria, [disp(0,4), disp(15,20), disp(25,28)]).

ou(D,L):-findall(Q,(disponibilidade(Q,R),ver(D,Q,R)),L).
ver(D,R,[]):-fail.
ver(D,R,[disp(L,L2)|R2]):-D >= L, D =< L2.
ver(D,R,[disp(L,L2)|R2]):-ver(D,R,R2).

reu([],D,L8,L8).
reu([L|R],D,L2,L3):-findall(poss(X,Y),(disponibilidade(L,R2),reu2(R2,D,T,X,Y)),L4),reu(R,D,L2,[L4|L3]).
reu2([],D,T,X,Y):-fail.
reu2([disp(L,L2)|R2],D,T,L,L2):- L2 - L >= D.
reu2([disp(L,L2)|R2],D,T,X,Y):- reu2(R2,D,T,X,Y).
ligacao(1, 2). 
ligacao(1, 3). 
ligacao(2, 4). 
ligacao(3, 4). 
ligacao(3,6). 
ligacao(4, 6). 
ligacao(5,6).
ligacao2(X,Y):-ligacao(X,Y).
ligacao2(X,Y):-ligacao(Y,X).

caminho2(N,NF,C):-caminho(N,NF,C,[],5).
caminho(NF,NF,[NF|C],C,M).
%caminho(N,NF,C,C2,M):- \+member(N,C2),M > 0,M1 is M - 1,ligacao2(N,NF),caminho(NF,NF,C,[N|C2],M1).
caminho(NI,NF,C,C2,M):- \+member(NI,C2),M > 0,M1 is M - 1,NI \= NF,ligacao2(NI,F),caminho(F,NF,C,[NI|C2],M1).

ciclos(N,N2,L):-findall(Ciclo,caminho(N,N,Ciclo,[],N2),L).