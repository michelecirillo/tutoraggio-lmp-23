peso(primo,1).
peso(amico,2).
peso(collega,3).

conoscenza(p1,p2,primo).
conoscenza(p1,p3,amico).
conoscenza(p1,p5,collega).
conoscenza(p2,p3,primo).
conoscenza(p2,p5,primo).
conoscenza(p3,p4,collega).
conoscenza(p4,p5,amico).

catena_conoscenza(P1,P2,[Catena]):-
    conoscenza(P1,P2,Catena).
catena_conoscenza(P1,P2,[E|R]):-
    conoscenza(P1,P3,E),
    catena_conoscenza(P3,P2,R).
peso_catena([],0).
peso_catena([A|R],N):-
    peso(A,N1),
    peso_catena(R,N2),
    N is N1 + N2.
listaPesiCatene([],[]).
listaPesiCatene([A|R1],[(A,B)|R2]):-
    peso_catena(A,B),
    listaPesiCatene(R1,R2).

min_catena([(L,P)],L,P).
min_catena([(L,P)|R],L,P):-
    min_catena(R,_,P1),
    P=<P1,!.
min_catena([_|R],L1,P1):-
    min_catena(R,L1,P1),!.

catena_conoscenza_da_percorrere(P1,P2,Catena):-
    setof(C,catena_conoscenza(P1,P2,C),ListaTutteCatene),
    listaPesiCatene(ListaTutteCatene,ListaPesi),
    min_catena(ListaPesi,Catena,_).