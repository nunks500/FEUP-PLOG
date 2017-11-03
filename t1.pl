%5,6,7,8,9,10,12,13 A),22,25
:-use_module(library(random)). /*used to randomize which player starts*/
:-use_module(library(lists)).

%createrandtab(0,0,0,0,0,0,0,0,Tabuleiro):-write(Tabuleiro).
%createrandtab(Q1,T1,B1,H1,Q2,T2,B2,H2,Tabuleiro):- random(1,9,U),
%((U == 1,(Q1 == 0 -> createrandtab(Q1,T1,B1,H1,Q2,T2,B2,H2,Tabuleiro); (Q3 is Q1 - 1, createrandtab(Q3,T1,B1,H1,Q2,T2,B2,H2,[' Q '|Tabuleiro]))));
%(U == 2, (T1 == 0 -> createrandtab(Q1,T1,B1,H1,Q2,T2,B2,H2,Tabuleiro); (T3 is T1 - 1, createrandtab(Q1,T3,B1,H1,Q2,T2,B2,H2,[' T '|Tabuleiro]))));
%(U == 3, (B1 == 0 -> createrandtab(Q1,T1,B1,H1,Q2,T2,B2,H2,Tabuleiro); (B3 is B1 - 1, createrandtab(Q1,T1,B3,H1,Q2,T2,B2,H2,[' B '|Tabuleiro]))));
%(U == 4, (H1 == 0 -> createrandtab(Q1,T1,B1,H1,Q2,T2,B2,H2,Tabuleiro); (H3 is H1 - 1, createrandtab(Q1,T1,B1,H3,Q2,T2,B2,H2,[' H '|Tabuleiro]))));
%(U == 5, (Q2 == 0 -> createrandtab(Q1,T1,B1,H1,Q2,T2,B2,H2,Tabuleiro); (Q3 is Q2 - 1, createrandtab(Q1,T1,B1,H1,Q3,T2,B2,H2,[' Q '|Tabuleiro]))));
%(U == 6, (T2 == 0 -> createrandtab(Q1,T1,B1,H1,Q2,T2,B2,H2,Tabuleiro); (T3 is T2 - 1, createrandtab(Q1,T1,B1,H1,Q2,T3,B2,H2,[' T '|Tabuleiro]))));
%(U == 7, (B2 == 0 -> createrandtab(Q1,T1,B1,H1,Q2,T2,B2,H2,Tabuleiro); (B3 is B2 - 1, createrandtab(Q1,T1,B1,H1,Q2,T2,B3,H2,[' B '|Tabuleiro]))));
%(U == 8, (H2 == 0 -> createrandtab(Q1,T1,B1,H1,Q2,T2,B2,H2,Tabuleiro); (H3 is H2 - 1, createrandtab(Q1,T1,B1,H1,Q2,T2,B2,H3,[' H '|Tabuleiro]))))).

board(B):-B=[
        [' Q ',' t ',' B ',' h ',' T ',' t ',' B ',' H '],
        [' q ',' b ',' H ',' B ',' H ',' T ',' Q ',' q '],
        [' Q ',' Q ',' T ',' h ',' h ',' T ',' b ',' b '],
        [' t ',' H ',' H ',' b ',' q ',' t ',' Q ',' B '],
        [' q ',' t ',' b ',' H ',' T ',' t ',' B ',' h '],
        [' q ',' B ',' H ',' B ',' h ',' T ',' Q ',' q '],
        [' Q ',' Q ',' h ',' H ',' T ',' B ',' t ',' b '],
        [' t ',' h ',' h ',' b ',' q ',' T ',' q ',' b ']
        ].


printab(Tabuleiro):-!,write('       0     1     2     3     4     5     6     7'),nl, printother(Tabuleiro,-1).
printL([]).
printL([R]):-!,write(' | '),write(R),write(' | ').
printL([H|R]):-!,write(' | '),write(H),printL(R).
printother([],_).
printother(G,-1):-!,write('     _______________________________________________'),nl,printother(G,0).
printother([H|R],Tab):-!,write(Tab),write('  '),printL(H),nl,Tab1 is Tab + 1,write('     _______________________________________________'),nl,printother(R,Tab1).
printurn(P2):-write('It is Player '),write(P2),write(' turn to play.'),nl,nl.

printurnbot(2):-write('It is the bot turn to play.'),nl,nl.
printurnbot(1):-write('It is Player 1 turn to play.'),nl,nl.

getPeca(X,Y,P,Tabuleiro):-append(Head,[L|Linha],Tabuleiro),length(Head,Y),append(Antes,[P|Resto],L),length(Antes,X).

changeplayer(1,P2):- P2 is 2.
changeplayer(2,P2):- P2 is 1.

checkoutofbounds(Xi,Yi,Xf,Yf):-(Xf > -1, Xi > -1, Xf < 8, Xi < 8, Yf > -1, Yi > -1,Yf < 8, Yi < 8);(write('Out of Range'),nl,fail).
checkifsameteam(P,P2):-(((P == ' t '; P == ' h ' ; P == ' q '; P ==' b '),(P2 == ' T '; P2 == ' B ' ; P2 == ' Q '; P2 == ' H '));((P2 == ' t '; P2 == ' h ' ; P2 == ' q '; P2 ==' b '),(P == ' T '; P == ' B '; P == ' Q '; P == ' H ')));(write('Cannot be pieces of the same team!!!'),nl,fail).

clearpath(Xi,Yi,Xf,Yf,Tabuleiro):- Yi == Yf, Xf < Xi, X2 is Xi - 1, X2 == Xf.
clearpath(Xi,Yi,Xf,Yf,Tabuleiro):- Yi == Yf, Xi < Xf, X2 is Xi + 1, X2 == Xf.
clearpath(Xi,Yi,Xf,Yf,Tabuleiro):- Yi == Yf,(Xf < Xi -> (X2 is Xi - 1, getPeca(X2,Yi,P,Tabuleiro), P == '   ',clearpath(X2,Yi,Xf,Yf,Tabuleiro))).
clearpath(Xi,Yi,Xf,Yf,Tabuleiro):- Yi == Yf,(Xi < Xf -> (X2 is Xi + 1, getPeca(X2,Yi,P,Tabuleiro), P == '   ',clearpath(X2,Yi,Xf,Yf,Tabuleiro))).
clearpath(Xi,Yi,Xf,Yf,Tabuleiro):- Xi == Xf, Yf < Yi, Y2 is Yi - 1, Y2 == Yf.
clearpath(Xi,Yi,Xf,Yf,Tabuleiro):- Xi == Xf, Yi < Yf, Y2 is Yi + 1, Y2 == Yf.
clearpath(Xi,Yi,Xf,Yf,Tabuleiro):- Xi == Xf,(Yf < Yi -> (Y2 is Yi - 1, getPeca(Xf,Y2,P,Tabuleiro), P == '   ',clearpath(Xf,Y2,Xf,Yf,Tabuleiro))).
clearpath(Xi,Yi,Xf,Yf,Tabuleiro):- Xi == Xf,(Yi < Yf -> (Y2 is Yi + 1, getPeca(Xf,Y2,P,Tabuleiro), P == '   ',clearpath(Xf,Y2,Xf,Yf,Tabuleiro))).

clearpathdiagonal(Xi,Yi,Xf,Yf,Tabuleiro):- Yi < Yf, Xf > Xi, X2 is Xi + 1, Y2 is Yi + 1, X2 == Xf, Y2 == Yf.
clearpathdiagonal(Xi,Yi,Xf,Yf,Tabuleiro):- Yi < Yf, Xf > Xi, X2 is Xi + 1, Y2 is Yi + 1,getPeca(X2,Y2,P,Tabuleiro), P == '   ',clearpathdiagonal(X2,Y2,Xf,Yf,Tabuleiro).
clearpathdiagonal(Xi,Yi,Xf,Yf,Tabuleiro):- Yi < Yf, Xf < Xi, X2 is Xi - 1, Y2 is Yi + 1, X2 == Xf, Y2 == Yf.
clearpathdiagonal(Xi,Yi,Xf,Yf,Tabuleiro):- Yi < Yf, Xf < Xi, X2 is Xi - 1, Y2 is Yi + 1,getPeca(X2,Y2,P,Tabuleiro), P == '   ',clearpathdiagonal(X2,Y2,Xf,Yf,Tabuleiro).
clearpathdiagonal(Xi,Yi,Xf,Yf,Tabuleiro):- Yi > Yf, Xf > Xi, X2 is Xi + 1, Y2 is Yi - 1, X2 == Xf, Y2 == Yf.
clearpathdiagonal(Xi,Yi,Xf,Yf,Tabuleiro):- Yi > Yf, Xf > Xi, X2 is Xi + 1, Y2 is Yi - 1,getPeca(X2,Y2,P,Tabuleiro), P == '   ',clearpathdiagonal(X2,Y2,Xf,Yf,Tabuleiro).
clearpathdiagonal(Xi,Yi,Xf,Yf,Tabuleiro):- Yi < Yf, Xf > Xi, X2 is Xi + 1, Y2 is Yi + 1, X2 == Xf, Y2 == Yf.
clearpathdiagonal(Xi,Yi,Xf,Yf,Tabuleiro):- Yi < Yf, Xf > Xi, X2 is Xi + 1, Y2 is Yi + 1,getPeca(X2,Y2,P,Tabuleiro), P == '   ',clearpathdiagonal(X2,Y2,Xf,Yf,Tabuleiro).
clearpathdiagonal(Xi,Yi,Xf,Yf,Tabuleiro):- Yi > Yf, Xf < Xi, X2 is Xi - 1, Y2 is Yi - 1, X2 == Xf, Y2 == Yf.
clearpathdiagonal(Xi,Yi,Xf,Yf,Tabuleiro):- Yi > Yf, Xf < Xi, X2 is Xi - 1, Y2 is Yi - 1,getPeca(X2,Y2,P,Tabuleiro), P == '   ',clearpathdiagonal(X2,Y2,Xf,Yf,Tabuleiro).  

horsemovement(Xi,Yi,Xf,Yf,Tabuleiro):- T is Xi + 1, Xf ==  T,T2 is Yi - 2,Yf == T2.
horsemovement(Xi,Yi,Xf,Yf,Tabuleiro):- T is Xi + 1, Xf ==  T,T2 is Yi + 2,Yf == T2.
horsemovement(Xi,Yi,Xf,Yf,Tabuleiro):- T is Xi + 2, Xf ==  T,T2 is Yi - 1,Yf == T2.
horsemovement(Xi,Yi,Xf,Yf,Tabuleiro):- T is Xi + 2, Xf ==  T,T2 is Yi + 1,Yf == T2.
horsemovement(Xi,Yi,Xf,Yf,Tabuleiro):- T is Xi - 1, Xf ==  T,T2 is Yi - 2,Yf == T2.
horsemovement(Xi,Yi,Xf,Yf,Tabuleiro):- T is Xi - 1, Xf ==  T,T2 is Yi + 2,Yf == T2.
horsemovement(Xi,Yi,Xf,Yf,Tabuleiro):- T is Xi - 2, Xf ==  T,T2 is Yi - 1,Yf == T2.
horsemovement(Xi,Yi,Xf,Yf,Tabuleiro):- T is Xi - 2, Xf ==  T,T2 is Yi + 1,Yf == T2.


replace(X,Y,P,P2,Tabuleiro,T):-append(Head,[L|Linha],Tabuleiro),length(Head,Y),append(Antes,[P|Resto],L), length(Antes,X),append(Antes,[P2|Resto],U),append(Head,[U|Linha],T).
makeplay(Xi,Yi,Xf,Yf,P,P2,Tabuleiro,NovoTabuleiro):-replace(Xi,Yi,P,'   ',Tabuleiro,T),replace(Xf,Yf,P2,P,T,NovoTabuleiro).

validmove(Xi,Yi,Xf,Yf,P,P2,Tabuleiro):- (P == ' t '; P == ' T '),clearpath(Xi,Yi,Xf,Yf,Tabuleiro),!.
validmove(Xi,Yi,Xf,Yf,P,P2,Tabuleiro):- (P == ' B '; P == ' b '),clearpathdiagonal(Xi,Yi,Xf,Yf,Tabuleiro),!.
validmove(Xi,Yi,Xf,Yf,P,P2,Tabuleiro):- (P == ' H '; P == ' h '),horsemovement(Xi,Yi,Xf,Yf,Tabuleiro),!.
validmove(Xi,Yi,Xf,Yf,P,P2,Tabuleiro):- (P == ' Q '; P == ' q '),(clearpathdiagonal(Xi,Yi,Xf,Yf,Tabuleiro);clearpath(Xi,Yi,Xf,Yf,Tabuleiro)),!.

playerpieces(2,Xi,Yi,Tabuleiro):-!,getPeca(Xi,Yi,P,Tabuleiro),!, ((P == ' t ' ; P == ' b '; P == ' h '; P == ' q ');(write('Play your own pieces.'),nl,fail)).
playerpieces(1,Xi,Yi,Tabuleiro):-!,getPeca(Xi,Yi,P,Tabuleiro),!, ((P == ' T ' ; P == ' B '; P == ' H '; P == ' Q ');(write('Play your own pieces.'),nl,fail)).

%gameover(1,NovoTabuleiro):- \+ ((getPeca(X,Y,' T ',NovoTabuleiro);getPeca(X,Y,' B ',NovoTabuleiro),getPeca(X,Y,' H ',NovoTabuleiro),getPeca(X,Y,' Q ',NovoTabuleiro));move(X,Y,XF,YF,NovoTabuleiro,_,1)).
gameover(1,NovoTabuleiro):-findall(Xi-Yi-Xf-Yf,(getPeca(Xi,Yi,P,NovoTabuleiro),(P == ' T ' ; P == ' B '; P == ' H '; P == ' Q '),getPeca(Xf,Yf,P2,NovoTabuleiro),(P2 == ' t ' ; P2 == ' b '; P2 == ' h '; P2 == ' q '),validmove(Xi,Yi,Xf,Yf,P,P2,NovoTabuleiro)),Q),length(Q,E),(E > 0);(printab(NovoTabuleiro),nl,write('Game Over. Player 2 wins'),fail),!.
gameover(2,NovoTabuleiro):-findall(Xi-Yi-Xf-Yf,(getPeca(Xi,Yi,P,NovoTabuleiro),(P == ' t ' ; P == ' b '; P == ' h '; P == ' q '),getPeca(Xf,Yf,P2,NovoTabuleiro),(P2 == ' T ' ; P2 == ' B '; P2 == ' H '; P2 == ' Q '),validmove(Xi,Yi,Xf,Yf,P,P2,NovoTabuleiro)),Q),length(Q,E),(E > 0);(printab(NovoTabuleiro),nl,write('Game Over. Player 1 wins'),fail),!.

gameoverbotbot(1,NovoTabuleiro):-findall(Xi-Yi-Xf-Yf,(getPeca(Xi,Yi,P,NovoTabuleiro),(P == ' T ' ; P == ' B '; P == ' H '; P == ' Q '),getPeca(Xf,Yf,P2,NovoTabuleiro),(P2 == ' t ' ; P2 == ' b '; P2 == ' h '; P2 == ' q '),validmove(Xi,Yi,Xf,Yf,P,P2,NovoTabuleiro)),Q),length(Q,E),(E > 0);(printab(NovoTabuleiro),nl,write('Game Over. Bot 2 wins'),fail),!.
gameoverbotbot(2,NovoTabuleiro):-findall(Xi-Yi-Xf-Yf,(getPeca(Xi,Yi,P,NovoTabuleiro),(P == ' t ' ; P == ' b '; P == ' h '; P == ' q '),getPeca(Xf,Yf,P2,NovoTabuleiro),(P2 == ' T ' ; P2 == ' B '; P2 == ' H '; P2 == ' Q '),validmove(Xi,Yi,Xf,Yf,P,P2,NovoTabuleiro)),Q),length(Q,E),(E > 0);(printab(NovoTabuleiro),nl,write('Game Over. Bot 1 wins'),fail),!.


getmove(Xi,Yi,Xf,Yf):-write('Column of the piece to move:'),read(Xi),write('Row of the piece to move: '),read(Yi),write('Column of the piece you want to move to'),read(Xf),write('Row of the piece you want to move to'),read(Yf),nl.
shuffle(Tabuleiro,Tabuleiro,8,8).
shuffle(Tab,Tabuleiro,TabLength,Q2):- append(Head,[L|Linha],Tab),length(Head,Q2),random_permutation(L,F),Q3 is Q2 + 1,append(Head,[F|Linha],NewTab),shuffle(NewTab,Tabuleiro,TabLength,Q3).
shuffleini(Tabuleiro, TabLength, Q1):-board(B),append(Head,[L|Linha],B),length(Head,Q1),random_permutation(L,F),Q2 is Q1 + 1,append(Head,[F|Linha],O),shuffle(O,Tabuleiro,TabLength,Q2). 
move(Xi,Yi,Xf,Yf,Tabuleiro,NovoTabuleiro,Player):-checkoutofbounds(Xi,Yi,Xf,Yf),!,playerpieces(Player,Xi,Yi,Tabuleiro),!,getPeca(Xi,Yi,P,Tabuleiro),getPeca(Xf,Yf,P2,Tabuleiro),checkifsameteam(P,P2),!,validmove(Xi,Yi,Xf,Yf,P,P2,Tabuleiro),makeplay(Xi,Yi,Xf,Yf,P,P2,Tabuleiro,NovoTabuleiro).
printboard(Tabuleiro,NovoTabuleiro,Player):-repeat,printab(Tabuleiro),getmove(Xi,Yi,Xf,Yf),move(Xi,Yi,Xf,Yf,Tabuleiro,NovoTabuleiro,Player).

getmovebot(A,B,C,D,NovoTabuleiro,2):- findall(Xi-Yi-Xf-Yf,(getPeca(Xi,Yi,P,NovoTabuleiro),(P == ' t ' ; P == ' b '; P == ' h '; P == ' q '),getPeca(Xf,Yf,P2,NovoTabuleiro),(P2 == ' T ' ; P2 == ' B '; P2 == ' H '; P2 == ' Q '),validmove(Xi,Yi,Xf,Yf,P,P2,NovoTabuleiro)),Q),random_member(A-B-C-D,Q).
getmovebot(A,B,C,D,NovoTabuleiro,1):- findall(Xi-Yi-Xf-Yf,(getPeca(Xi,Yi,P,NovoTabuleiro),(P == ' T ' ; P == ' B '; P == ' H '; P == ' Q '),getPeca(Xf,Yf,P2,NovoTabuleiro),(P2 == ' t ' ; P2 == ' b '; P2 == ' h '; P2 == ' q '),validmove(Xi,Yi,Xf,Yf,P,P2,NovoTabuleiro)),Q),random_member(A-B-C-D,Q).

getmovebotM(A,B,C,D,NovoTabuleiro,2):- findall(Xi-Yi-Xf-Yf,(getPeca(Xi,Yi,P,NovoTabuleiro),(P == ' t ' ; P == ' b '; P == ' h '; P == ' q '),getPeca(Xf,Yf,P2,NovoTabuleiro),(P2 == ' Q '),validmove(Xi,Yi,Xf,Yf,P,P2,NovoTabuleiro)),Q),random_member(A-B-C-D,Q).
getmovebotM(A,B,C,D,NovoTabuleiro,2):- findall(Xi-Yi-Xf-Yf,(getPeca(Xi,Yi,P,NovoTabuleiro),(P == ' t ' ; P == ' b '; P == ' h '; P == ' q '),getPeca(Xf,Yf,P2,NovoTabuleiro),(P2 == ' T '),validmove(Xi,Yi,Xf,Yf,P,P2,NovoTabuleiro)),Q),random_member(A-B-C-D,Q).
getmovebotM(A,B,C,D,NovoTabuleiro,2):- findall(Xi-Yi-Xf-Yf,(getPeca(Xi,Yi,P,NovoTabuleiro),(P == ' t ' ; P == ' b '; P == ' h '; P == ' q '),getPeca(Xf,Yf,P2,NovoTabuleiro),(P2 == ' B '),validmove(Xi,Yi,Xf,Yf,P,P2,NovoTabuleiro)),Q),random_member(A-B-C-D,Q).
getmovebotM(A,B,C,D,NovoTabuleiro,2):- findall(Xi-Yi-Xf-Yf,(getPeca(Xi,Yi,P,NovoTabuleiro),(P == ' t ' ; P == ' b '; P == ' h '; P == ' q '),getPeca(Xf,Yf,P2,NovoTabuleiro),(P2 == ' H '),validmove(Xi,Yi,Xf,Yf,P,P2,NovoTabuleiro)),Q),random_member(A-B-C-D,Q).

getmovebotM(A,B,C,D,NovoTabuleiro,1):- findall(Xi-Yi-Xf-Yf,(getPeca(Xi,Yi,P,NovoTabuleiro),(P == ' T ' ; P == ' B '; P == ' H '; P == ' Q '),getPeca(Xf,Yf,P2,NovoTabuleiro),(P2 == ' q '),validmove(Xi,Yi,Xf,Yf,P,P2,NovoTabuleiro)),Q),random_member(A-B-C-D,Q).
getmovebotM(A,B,C,D,NovoTabuleiro,1):- findall(Xi-Yi-Xf-Yf,(getPeca(Xi,Yi,P,NovoTabuleiro),(P == ' T ' ; P == ' B '; P == ' H '; P == ' Q '),getPeca(Xf,Yf,P2,NovoTabuleiro),(P2 == ' t '),validmove(Xi,Yi,Xf,Yf,P,P2,NovoTabuleiro)),Q),random_member(A-B-C-D,Q).
getmovebotM(A,B,C,D,NovoTabuleiro,1):- findall(Xi-Yi-Xf-Yf,(getPeca(Xi,Yi,P,NovoTabuleiro),(P == ' T ' ; P == ' B '; P == ' H '; P == ' Q '),getPeca(Xf,Yf,P2,NovoTabuleiro),(P2 == ' b '),validmove(Xi,Yi,Xf,Yf,P,P2,NovoTabuleiro)),Q),random_member(A-B-C-D,Q).
getmovebotM(A,B,C,D,NovoTabuleiro,1):- findall(Xi-Yi-Xf-Yf,(getPeca(Xi,Yi,P,NovoTabuleiro),(P == ' T ' ; P == ' B '; P == ' H '; P == ' Q '),getPeca(Xf,Yf,P2,NovoTabuleiro),(P2 == ' h '),validmove(Xi,Yi,Xf,Yf,P,P2,NovoTabuleiro)),Q),random_member(A-B-C-D,Q).

checklist([],NovoTabuleiro,Max,A,B,C,D,A,B,C,D,_).
checklist([Xi-Yi-Xf-Yf|Resto],NovoTabuleiro,Max,Xa,Ya,Xb,Yb,A,B,C,D,2):-getPeca(Xi,Yi,P,NovoTabuleiro),getPeca(Xf,Yf,P2,NovoTabuleiro),makeplay(Xi,Yi,Xf,Yf,P,P2,NovoTabuleiro,N3),findall(Xff-Yff,(getPeca(Xff,Yff,P3,N3),(P3 == ' T ' ; P3 == ' B '; P3 == ' H '; P3 == ' Q '),validmove(Xf,Yf,Xff,Yff,P,P3,N3),write(Xff-Yff),nl),T),length(T,N),write(Xi-Yi-Xf-Yf),nl,write(N),nl,(N > Max -> (checklist(Resto,NovoTabuleiro,N,Xi,Yi,Xf,Yf,A,B,C,D,2));checklist(Resto,NovoTabuleiro,Max,Xa,Ya,Xb,Yb,A,B,C,D,2)).
checklist([Xi-Yi-Xf-Yf|Resto],NovoTabuleiro,Max,Xa,Ya,Xb,Yb,A,B,C,D,1):-getPeca(Xi,Yi,P,NovoTabuleiro),getPeca(Xf,Yf,P2,NovoTabuleiro),makeplay(Xi,Yi,Xf,Yf,P,P2,NovoTabuleiro,N3),findall(Xff-Yff,(getPeca(Xff,Yff,P3,N3),(P3 == ' t ' ; P3 == ' b '; P3 == ' h '; P3 == ' q '),validmove(Xf,Yf,Xff,Yff,P,P3,N3),write(Xff-Yff),nl),T),length(T,N),write(Xi-Yi-Xf-Yf),nl,write(N),nl,(N > Max -> (checklist(Resto,NovoTabuleiro,N,Xi,Yi,Xf,Yf,A,B,C,D,1));checklist(Resto,NovoTabuleiro,Max,Xa,Ya,Xb,Yb,A,B,C,D,1)).

getmovebotH(A,B,C,D,NovoTabuleiro,2):- findall(Xi-Yi-Xf-Yf,(getPeca(Xi,Yi,P,NovoTabuleiro), (P == ' t ' ; P == ' b '; P == ' h '; P == ' q '),getPeca(Xf,Yf,P2,NovoTabuleiro),(P2 == ' T ' ; P2 == ' B '; P2 == ' H '; P2 == ' Q '),validmove(Xi,Yi,Xf,Yf,P,P2,NovoTabuleiro)),Q),checklist(Q,NovoTabuleiro,-1,Xa,Ya,Xb,Yb,A,B,C,D,2).
getmovebotH(A,B,C,D,NovoTabuleiro,1):- findall(Xi-Yi-Xf-Yf,(getPeca(Xi,Yi,P,NovoTabuleiro), (P == ' T ' ; P == ' B '; P == ' H '; P == ' Q '),getPeca(Xf,Yf,P2,NovoTabuleiro),(P2 == ' t ' ; P2 == ' b '; P2 == ' h '; P2 == ' q '),validmove(Xi,Yi,Xf,Yf,P,P2,NovoTabuleiro)),Q),checklist(Q,NovoTabuleiro,-1,Xa,Ya,Xb,Yb,A,B,C,D,1).

printboardbot(Tabuleiro,NovoTabuleiro,Player,Dificulty):-printab(Tabuleiro),(Dificulty == 'E' -> getmovebot(Xi,Yi,Xf,Yf,Tabuleiro,Player);(Dificulty == 'M' -> getmovebotM(Xi,Yi,Xf,Yf,Tabuleiro,Player));(Dificulty == 'H' -> getmovebotH(Xi,Yi,Xf,Yf,Tabuleiro,Player))),write(Xi-Yi-Xf-Yf),move(Xi,Yi,Xf,Yf,Tabuleiro,NovoTabuleiro,Player),!.

cicle(Tabuleiro,Player):-gameover(2,NovoTabuleiro),!,gameover(1,NovoTabuleiro),printurn(Player),printboard(Tabuleiro,NovoTabuleiro,Player),changeplayer(Player,P2),cicle(NovoTabuleiro,P2).

ciclebot(Tabuleiro,2,Dificulty):-gameover(2,Tabuleiro),!,gameover(1,Tabuleiro),printurnbot(2),printboardbot(Tabuleiro,NovoTabuleiro,2,Dificulty),changeplayer(2,P2),!,ciclebot(NovoTabuleiro,P2,Dificulty).
ciclebot(Tabuleiro,1,Dificulty):-gameover(1,Tabuleiro),!,gameover(2, Tabuleiro),printurnbot(1),printboard(Tabuleiro,NovoTabuleiro,1),changeplayer(1,P2),!,ciclebot(NovoTabuleiro,P2,Dificulty).

ciclebotbot(Tabuleiro,Player,Dificulty):-gameoverbotbot(1,Tabuleiro),!,gameoverbotbot(2,Tabuleiro),printurnbot(Player),printboardbot(Tabuleiro,NovoTabuleiro,Player,Dificulty),changeplayer(Player,P2),!,ciclebotbot(NovoTabuleiro,P2,Dificulty).

xadrez:- shuffleini(Tabuleiro , 8 , 0),random(1,3,Player),cicle(Tabuleiro,Player).
bot(Dificulty):- shuffleini(Tabuleiro , 8 , 0),random(1,3,Player),ciclebot(Tabuleiro,Player,Dificulty).
botbot(Dificulty):- shuffleini(Tabuleiro, 8, 0),random(1,3,Player),ciclebotbot(Tabuleiro,Player,Dificulty).
main:-bot('H').

%printab(Tabuleiro),getmove(Xi,Yi,Xf,Yf),checkoutofbounds(Xi,Yi,Xf,Yf),move(Xi,Yi,Xf,Yf,Tabuleiro,NovoTabuleiro),cicle(NovoTabuleiro).
