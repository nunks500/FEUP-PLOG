:-use_module(library(clpfd)).
:-use_module(library(lists)).

atividade(1,'refeicao',2).
atividade(2,'jogo de futebol',2).
atividade(3,'brainstorm',2).

%atividade('workshop de madeira').
%atividade('sudoku challenge').
%atividade('aula de cozinha').

participante(1,'Joao','M',1.70,16,'cantar').
participante(2,'Maria','F',1.85,25,'inteligente').
participante(3,'Filipe','M',1.60,31,'bricolage').
participante(4,'Henrique','M',1.62,28,'inteligente').
participante(5,'Bond','M',1.50,31,'forte').
participante(6,'Gordon Ramsey','M',1.90,50,'cozinha').
participante(7,'Joel','M',1.90,50,'cozinha').

participant(L):- findall(Id,participante(Id,_,_,_,_,_),L).
ativities(L):- findall(Id,atividade(Id,_,_),L).

ndifferent(_,_,N,N).
ndifferent(L,N,Count,N3):-sublist(L,S,Count,N),all_different(S),Count1 is Count + N,ndifferent(L,N,Count1,N3).

%printList(L,TamanhoGrupo,TamanhoGrupo,L,N,NumeroElem,NumeroElem):-nl,nl.
%printList([L|Resto],Contador,TamanhoGrupo,L2,N,NumeroElem,R):- NumeroElem1 is NumeroElem + 1,Contador1 is Contador + 1, NumeroElem1 =< N, write(NumeroElem1),participante(L,Nome,_,_,Age,_),write(Nome-Age),nl,printList(Resto,Contador1,TamanhoGrupo,L2,N,NumeroElem1,R),!.
%printList(L,Contador,TamanhoGrupo,L2,N,NumeroElem,R):- NumeroElem1 is NumeroElem + 1,Contador1 is Contador + 1,write(NumeroElem1),printList(L,Contador1,TamanhoGrupo,L2,N,NumeroElem1,R),!.


%printGroup([],_,_,_,_,_,_).

%printGroup(L,0,TamanhoGrupo,1,N3,N,NumeroElem):-
%write('-----------------------------------------------------------------------------------------          Groups for Event: '),atividade(NumeroEvento,Nome),write(Nome),write('\n'),
%write('Group 1'),nl,nl,N4 is N3 + TamanhoGrupo,
%printList(L,0,TamanhoGrupo,L2,N,NumeroElem,R),printGroup(L2,1,TamanhoGrupo,1,N4,N,R).

%printGroup(L,Contador,TamanhoGrupo,NumeroEvento,N,N,NumeroElem):-NumeroEvento1 is NumeroEvento + 1,
%write('-----------------------------------------------------------------------------------------          Groups for Event: '),atividade(NumeroEvento1,Nome),write(Nome),write('\n'),
%write('Group 1'),nl,nl,
%printList(L,0,TamanhoGrupo,L2,N,0,R),printGroup(L2,1,TamanhoGrupo,NumeroEvento1,TamanhoGrupo,N,R).

%printGroup(L,Contador,TamanhoGrupo,NumeroEvento,N3,N,NumeroElem):-
%write('-----------------------------------------------------------------------------------------\n'),
%Contador1 is Contador + 1,write('Group '),write(Contador1),nl,nl, N4 is N3 + TamanhoGrupo,
%printList(L,0,TamanhoGrupo,L2,N,NumeroElem,R),printGroup(L2,Contador1,TamanhoGrupo,NumeroEvento,N4,N,R).

%sortbyrepetition(L,N,N,Event):-

%sortbyrepetition(L,N,N,_).
%sortbyrepetition(L,Index,N,Event):- atividade(Event,_,Largura),sublist(L,S,Index,Largura),Index3 is Index + Largura,length(S,P),Index2 is Index + N,Event2 is Event + 1,atividade(Event2,_,Largura2),sublist(L,S1,Index2,Largura2),append(S,S1,Final),length(S1,P2),PDiff #= P + P2 - 1,nvalue(PDiff,Final),sortbyrepetition(L,Index3,N,Event).

%iterador(L,S,N,Event,Final):- Event1 is Event + 1,N is Final * Event1.
%iterador(L,S,Iterador,Event,N):- length(S,P),atividade(Event,_,Largura),sublist(L,S2,Iterador,Largura),NovoIterador is Iterador + Largura,length(S2,P2),append(S,S2,ListaFinal),Size #= P + P2 - 1,nvalue(Size, ListaFinal),iterador(L,S,NovoIterador,Event,N).

%sortbyrepetition(L,Index,N,Event):- atividade(Event,_,Largura),sublist(L,S,Index,Largura),Event1 is Event + 1,Iterador is Event1 + N,iterador(L,S,Iterador,Event1,N).%,sortbyrepetition(L,Index,N,Event1).

iterador(L,S,Iterador,Event,N):- Iterador #>= Event * N.
iterador(L,S,Iterador,Event,N):- length(S,P),atividade(Event,_,Largura), sublist(L,S2,Iterador,Largura),NovoIterador is Iterador + Largura,length(S2,P2),append(S,S2,ListaFinal),Size #= P + P2 - 1 #\/ Size #= P + P2 ,nvalue(Size, ListaFinal),iterador(L,S,NovoIterador,Event,N).
iterador(L,S,Iterador,Event,N):- length(S,P),atividade(Event,_,Largura),Checker is Iterador + Largura ,Checker > Event*N,NewLargura is Checker - (Event*N).%,write(NewLargura),  sublist(L,S2,Iterador,NewLargura),NovoIterador is Iterador + NewLargura,length(S2,P2),append(S,S2,ListaFinal),Size #= P + P2 - 1 #\/ Size #= P + P2 ,nvalue(Size, ListaFinal).


%sortbyrepetition(L,Index,N,Event):- ativities(A),length(A,Num),Num = Event.

sortbyrepetition(L,Index,N,Event,CurrentEvent,Index2):- ativities(A),length(A,Num),Num = 1.

sortbyrepetition(L,Index,N,Event,CurrentEvent,Index2):- atividade(Event,_,Largura),mod(N,Largura) =:= 0,Index2 \= 0,ativities(A),length(A,Num),Temp is Num*N , Temp - Index2 =:= N.


sortbyrepetition(L,Index,N,Event,CurrentEvent,Index2):- ativities(A),length(A,Num),Num = Event,atividade(CurrentEvent,_,Largura),Index3 is Index2 + Largura ,sortbyrepetition(L,0,N,CurrentEvent,CurrentEvent,Index3).
sortbyrepetition(L,Index,N,Event,CurrentEvent,Index2):- Index2 \= 0,mod(Index2,N) =:= 0,CurrentEvent2 is CurrentEvent + 1,atividade(CurrentEvent2,_,Largura),sublist(L,S,Index2,Largura),Event1 is CurrentEvent2 + 1,Iterador is Index + N*CurrentEvent2 ,iterador(L,S,Iterador,Event1,N),sortbyrepetition(L,Iterador,N,Event1,CurrentEvent2,Index2).

sortbyrepetition(L,Index,N,Event,CurrentEvent,Index2):- atividade(CurrentEvent,_,Largura),sublist(L,S,Index2,Largura),Event1 is Event + 1,Iterador is Index + N*CurrentEvent ,iterador(L,S,Iterador,Event1,N),sortbyrepetition(L,Iterador,N,Event1,CurrentEvent,Index2).
%,Temp is Iterador + N ,Event2 is Event + 2,iterador(L,S,Temp,Event2,N).%

sortbyrepetition(L,Index,N,Event,CurrentEvent,Index2):- Index2 \= 0,ativities(A),length(A,Num),Temp is Num*N ,Ajust is mod(N,Index2),N \= Ajust, Temp - Index2 =:= N + Ajust.


printList(L,TamanhoGrupo,NumeroElem,N2,N,NumGrupo,NumeroElem):- N =< NumeroElem.

printList(L,TamanhoGrupo,NumeroElem,-1,N,NumGrupo,NumeroFinal):- N >= NumeroElem,write('-----------------------------------------------------------------------------------------\n'),
write('Group '),write(NumGrupo),nl,NumGrupo1 is NumGrupo + 1,printList(L,TamanhoGrupo,NumeroElem,0,N,NumGrupo1,NumeroFinal),!.

printList(L,TamanhoGrupo,NumeroElem,TamanhoGrupo,N,NumGrupo,NumeroFinal):-N >= NumeroElem,printList(L,TamanhoGrupo,NumeroElem,-1,N,NumGrupo,NumeroFinal),!.

printList([L|Resto],TamanhoGrupo,NumeroElem,N2,N,NumGrupo,NumeroFinal):- NumeroElem1 is NumeroElem + 1,N3 is N2 + 1,N >= NumeroElem1,Elem is L,participante(Elem,Nome,_,_,Age,_),write(Nome-Age),nl,printList(Resto,TamanhoGrupo,NumeroElem1,N3,N,NumGrupo,NumeroFinal),!.

printGroup(_,_,NumeroEvento,_,NumeroEvento).

printGroup(L,N,NumeroEvento,NumeroElem,N2):- NumeroEvento1  is NumeroEvento + 1,write('-----------------------------------------------------------------------------------------          Groups for Event: '),atividade(NumeroEvento1,Nome,Tamanho),write(Nome),write('\n'),
printList(L,Tamanho,NumeroElem,-1,N,1,NumeroFinal),length(L3,N),append(L3,L2,L),printGroup(L2,N,NumeroEvento1,0,N2),!.

solver(L):- participant(P),
ativities(A),
length(P,N),
length(A,N2),
N3 #= N2 * N,
length(L,N3),
domain(L,1,N),
ndifferent(L,N,0,N3),
sortbyrepetition(L,0,N,1,1,0),
labeling([],L),
write(L),
printGroup(L,N,0,0,N2).
%printGroup(L,0,TamanhoGrupo,1,0,N,0).