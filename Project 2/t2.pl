:-use_module(library(clpfd)).
:-use_module(library(lists)).

%Base de Dados sobre atividades
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
atividade(1,'refeicao',4,'futebol').
atividade(2,'jogo de futebol',2,'forte').
%atividade(3,'brainstorm',2,'cozinha').

%atividade('workshop de madeira').
%atividade('sudoku challenge').
%atividade('aula de cozinha').

%Base de Dados sobre participantes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
participante(1,'Joao','futebol').
participante(2,'Maria','futebol').
participante(3,'Filipe','futebol').
participante(4,'Henrique','forte').
participante(5,'Bond','forte').
participante(6,'Gordon Ramsey','cozinha').
participante(7,'Joel','cozinha').
participante(8,'Paulo','cozinha').

participant(L):- findall(Id,participante(Id,_,_),L).
ativities(L):- findall(Id,atividade(Id,_,_,_),L).

%Restrição que garante que a lista de 1 a N tem IDs de participantes diferentes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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


%Predicado que recebe uma lista e compara a mesma com todas as outras de um Índice até ao fim dos índices
%garantindo a restrição de pessoas não se repetirem em atividades diferentes.
%Tenta ainda colocar em cada grupo, uma pessoa com habilidade para concluir a tarefa dessa atividade com sucesso
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

iterador(L,S,Iterador,Event,N,Sum,Sum,CurrentEvent):- Iterador #>= Event * N.
iterador(L,S,Iterador,Event,N,Sum,Sum,CurrentEvent):- length(S,P),atividade(Event,_,Largura,_),Checker is Iterador + Largura ,Checker > Event*N,NewLargura is Checker - (Event*N),sublist(L,S2,Iterador,NewLargura),atividade(Event,_,_,Habilidade),participante(Id,_,Habilidade),member(Id,S2).%,write(NewLargura),  sublist(L,S2,Iterador,NewLargura),NovoIterador is Iterador + NewLargura,length(S2,P2),append(S,S2,ListaFinal),Size #= P + P2 - 1 #\/ Size #= P + P2 ,nvalue(Size, ListaFinal).
iterador(L,S,Iterador,Event,N,Sum,Sum,CurrentEvent):- length(S,P),atividade(Event,_,Largura,_),Checker is Iterador + Largura ,Checker > Event*N,NewLargura is Checker - (Event*N).%,write(NewLargura),  sublist(L,S2,Iterador,NewLargura),NovoIterador is Iterador + NewLargura,length(S2,P2),append(S,S2,ListaFinal),Size #= P + P2 - 1 #\/ Size #= P + P2 ,nvalue(Size, ListaFinal).

iterador(L,S,Iterador,Event,N,I,Sum,CurrentEvent):- length(S,P),atividade(Event,_,Largura,_), sublist(L,S2,Iterador,Largura),NovoIterador is Iterador + Largura,length(S2,P2),append(S,S2,ListaFinal),Temp is P + P2 ,Temp2 is P + P2 - 1,atividade(CurrentEvent,_,_,Habilidade),participante(Id,_,Habilidade),member(Id,S),atividade(Event,_,_,Habilidade2),participante(Id2,_,Habilidade2),member(Id2,S2),nl,Size in Temp2..Temp,nvalue(Size, ListaFinal),Size2 #= Size + I,iterador(L,S,NovoIterador,Event,N,Size2,Sum,CurrentEvent).
iterador(L,S,Iterador,Event,N,I,Sum,CurrentEvent):- length(S,P),atividade(Event,_,Largura,_), sublist(L,S2,Iterador,Largura),NovoIterador is Iterador + Largura,length(S2,P2),append(S,S2,ListaFinal),Temp is P + P2 ,Temp2 is P + P2 - 1,Size in Temp2..Temp,nvalue(Size, ListaFinal),Size2 #= Size + I,iterador(L,S,NovoIterador,Event,N,Size2,Sum,CurrentEvent).

%sortbyrepetition(L,N,N,Event,CurrentEvent,Index2):- ativities(A),length(A,Num),CurrentEvent2 is CurrentEvent + 1,Num = CurrentEvent2..

% Predicados que tratam de selecionar as sublistas corretas para comparação com as outras.
% Ter em atenção que este predicado é muito extenso pelo facto de haverem múltiplas combinações
% para os grupos já que a largura dos grupos pode ser ou não múltipla do número de participantes

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sortbyrepetition(L,Index,N,Event,CurrentEvent,Index2,I,Sum):- ativities(A),length(A,Num),CurrentEvent = Num,Temp is CurrentEvent - 1,atividade(Temp,_,Largura,_),Event1 is Event - 1,sublist(L,S,Index2,Largura),Iterador is Temp * N,iterador(L,S,Iterador,Event1,N,I,T,CurrentEvent),Sum #= T.

sortbyrepetition(L,Index,N,Event,CurrentEvent,Index2,I,Sum):- ativities(A),length(A,Num),Num = 1.

sortbyrepetition(L,Index,N,Event,CurrentEvent,Index2,I,Sum):- atividade(Event,_,Largura,_),mod(N,Largura) =:= 0,Index2 \= 0,ativities(A),length(A,Num),Temp is Num*N , Temp - Index2 =:= N.

%sortbyrepetition(L,Index,N,Event,CurrentEvent,Index2):- ativities(A),length(A,Num),Num = Event,atividade(CurrentEvent,_,Largura), mod(N,Largura) \= 0, CurrentEvent2 is CurrentEvent + 1,atividade(CurrentEvent2,_,Largura),sublist(L,S,Index2,Largura),Event1 is CurrentEvent2 + 1,Iterador is Index + N*CurrentEvent2 ,iterador(L,S,Iterador,Event1,N),write(Iterador),sortbyrepetition(L,Iterador,N,Event1,CurrentEvent2,Index2).

sortbyrepetition(L,Index,N,Event,CurrentEvent,Index2,I,Sum):- ativities(A),length(A,Num),Num = Event,atividade(CurrentEvent,_,Largura,_),mod(N,Largura) =:= 0,Index3 is Index2 + Largura ,sortbyrepetition(L,0,N,CurrentEvent,CurrentEvent,Index3,I,Sum).
%sortbyrepetition(L,Index,N,Event,CurrentEvent,Index2):- ativities(A),length(A,Num),Num = Event,write('hhhhhh'),atividade(CurrentEvent,_,Largura),mod(N,Largura) \= 0,Index3 is Index2 + Largura,sortbyrepetition(L,0,N,CurrentEvent,CurrentEvent,Index3).
%sortbyrepetition(L,Index,N,Event,CurrentEvent,Index2):- ativities(A),length(A,Num),Num = Event,write('hhhhhh'),atividade(CurrentEvent,_,Largura),mod(N,Largura) \= 0,mod(N,Index2) \= 0,Index3 is Index2 + Largura, (( Index3 > N*CurrentEvent -> Index4 is N*CurrentEvent);(Index4 is Index2 + Largura)) ,sortbyrepetition(L,0,N,CurrentEvent,CurrentEvent,Index4).
sortbyrepetition(L,Index,N,Event,CurrentEvent,Index2,I,Sum):- ativities(A),length(A,Num),Num = Event,atividade(CurrentEvent,_,Largura,_),mod(N,Largura) \= 0,mod(N,Index2) \= 0,Index3 is Index2 + Largura, (( Index2 < N*(CurrentEvent-1) -> Index4 is N*(CurrentEvent-1));(Index4 is Index2 + Largura)) ,sortbyrepetition(L,0,N,CurrentEvent,CurrentEvent,Index4,I,Sum),!.


%sortbyrepetition(L,Index,N,Event,CurrentEvent,Index2):- Index2 \= 0,mod(Index2,N) =:= 0,CurrentEvent2 is CurrentEvent + 1,atividade(CurrentEvent2,_,Largura),sublist(L,S,Index2,Largura),Event1 is CurrentEvent2 + 1,Iterador is  N*CurrentEvent2 ,iterador(L,S,Iterador,Event1,N),write(Iterador),sortbyrepetition(L,Iterador,N,Event1,CurrentEvent2,Index2).

sortbyrepetition(L,Index,N,Event,CurrentEvent,Index2,I,Sum):-  Index2 \= 0, Index2 < CurrentEvent*N,atividade(CurrentEvent,_,Largura,_),Index2 + Largura >= N * CurrentEvent,NovaLargura is N*CurrentEvent - Index2,sublist(L,S,Index2,NovaLargura),atividade(CurrentEvent,_,_,Habilidade),participante(Id,_,Habilidade),member(Id,S),CurrentEvent2 is CurrentEvent + 1,Event1 is CurrentEvent2 + 1,Iterador is Index + N*CurrentEvent2 ,sortbyrepetition(L,Iterador,N,Event1,CurrentEvent2,Index2,I,Sum),!.
sortbyrepetition(L,Index,N,Event,CurrentEvent,Index2,I,Sum):-  Index2 \= 0, Index2 < CurrentEvent*N,atividade(CurrentEvent,_,Largura,_),Index2 + Largura >= N * CurrentEvent,NovaLargura is N*CurrentEvent - Index2,sublist(L,S,Index2,NovaLargura),CurrentEvent2 is CurrentEvent + 1,Event1 is CurrentEvent2 + 1,Iterador is Index + N*CurrentEvent2 ,sortbyrepetition(L,Iterador,N,Event1,CurrentEvent2,Index2,I,Sum),!.


sortbyrepetition(L,Index,N,Event,CurrentEvent,Index2,I,Sum):- ativities(A),length(A,Num),CurrentEvent2 is CurrentEvent + 1,Num = CurrentEvent2,atividade(CurrentEvent,_,Largura,_), \+ sublist(L,S,Index2,Largura).

sortbyrepetition(L,Index,N,Event,CurrentEvent,Index2,I,Sum):- atividade(CurrentEvent,_,Largura,_),Index2 + Largura =< N * CurrentEvent,sublist(L,S,Index2,Largura),Event1 is Event + 1,Iterador is Index + N*CurrentEvent ,iterador(L,S,Iterador,Event1,N,I,T,CurrentEvent),sortbyrepetition(L,Iterador,N,Event1,CurrentEvent,Index2,T,Sum),!.
sortbyrepetition(L,Index,N,Event,CurrentEvent,Index2,I,Sum):- atividade(CurrentEvent,_,Largura,_),Index2 + Largura > N * CurrentEvent,Iterador is Index + N*CurrentEvent,Event1 is Event + 1,sortbyrepetition(L,Iterador,N,Event1,CurrentEvent,Index2,I,Sum).

sortbyrepetition(L,Index,N,Event,CurrentEvent,Index2,I,Sum):- Index2 \= 0,CurrentEvent2 is CurrentEvent + 1,atividade(CurrentEvent2,_,Largura,_),sublist(L,S,Index2,Largura),Event1 is CurrentEvent2 + 1,Iterador is Index + N*CurrentEvent2 ,iterador(L,S,Iterador,Event1,N,I,Sume,CurrentEvent),sortbyrepetition(L,Iterador,N,Event1,CurrentEvent2,Index2,Sume,Sum).

%,Temp is Iterador + N ,Event2 is Event + 2,iterador(L,S,Temp,Event2,N).%

%sortbyrepetition(L,Index,N,Event,CurrentEvent,Index2,I,Sum):- Index2 \= 0,ativities(A),length(A,Num),Temp is Num*N ,Ajust is mod(N,Index2),N \= Ajust, Temp - Index2 =:= N + Ajust.

%Imprime informação no monitor
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
printList(L,TamanhoGrupo,NumeroElem,N2,N,NumGrupo,NumeroElem):- N =< NumeroElem.

printList(L,TamanhoGrupo,NumeroElem,-1,N,NumGrupo,NumeroFinal):- N >= NumeroElem,write('-----------------------------------------------------------------------------------------\n'),
write('Group '),write(NumGrupo),nl,NumGrupo1 is NumGrupo + 1,printList(L,TamanhoGrupo,NumeroElem,0,N,NumGrupo1,NumeroFinal),!.

printList(L,TamanhoGrupo,NumeroElem,TamanhoGrupo,N,NumGrupo,NumeroFinal):-N >= NumeroElem,printList(L,TamanhoGrupo,NumeroElem,-1,N,NumGrupo,NumeroFinal),!.

printList([L|Resto],TamanhoGrupo,NumeroElem,N2,N,NumGrupo,NumeroFinal):- NumeroElem1 is NumeroElem + 1,N3 is N2 + 1,N >= NumeroElem1,Elem is L,participante(Elem,Nome,Habilidade),write(Nome-Habilidade),nl,printList(Resto,TamanhoGrupo,NumeroElem1,N3,N,NumGrupo,NumeroFinal),!.

printGroup(_,_,NumeroEvento,_,NumeroEvento).

printGroup(L,N,NumeroEvento,NumeroElem,N2):- NumeroEvento1  is NumeroEvento + 1,write('-----------------------------------------------------------------------------------------          Groups for Event: '),atividade(NumeroEvento1,Nome,Tamanho,_),write(Nome),write('\n'),
printList(L,Tamanho,NumeroElem,-1,N,1,NumeroFinal),length(L3,N),append(L3,L2,L),printGroup(L2,N,NumeroEvento1,0,N2),!.

%Predicados de estatística
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
reset_timer :- statistics(walltime,_).  

print_time :-

        statistics(walltime,[_,T]),

        TS is ((T//10)*10)/1000,

        nl, write('Time: '), write(TS), write('s'), nl, nl.

%Parte inicial do programa
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
solver(L):- participant(P),
ativities(A),
length(P,N),
length(A,N2),
N3 #= N2 * N,
length(L,N3),
domain(L,1,N),
ndifferent(L,N,0,N3),
sortbyrepetition(L,0,N,1,1,0,0,Sum),
reset_timer,
labeling([maximize(Sum),all],L),nl,
%write(Sum),nl,
printGroup(L,N,0,0,N2),nl,
write('### STATISTICS ###'),nl,
    fd_statistics,print_time,nl.