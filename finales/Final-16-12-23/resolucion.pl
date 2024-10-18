tiene(tito,arboles,5).
tiene(tito,problemas,2).
tiene(tito,autos,10).
tiene(juanma,metrosDePinga,15).


predicadoMisterioso(Persona, Cosa, CantidadMax) :-
    tiene(Persona, Cosa, CantidadMax),
    forall(tiene(Persona, _ , Cantidad), CantidadMax >= Cantidad).