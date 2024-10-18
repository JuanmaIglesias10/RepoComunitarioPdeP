subioA(prudencio, montaniaRusa(hulk)).
subioA(prudencio, autosChocadores).
subioA(hermenegildo, montaniaRusa(rockit)).
subioA(hermenegildo, simulador(minions)).
subioA(hermenegildo, autosChocadores).
subioA(rigoberta, simulador(ikran)).
subioA(brunilda, simulador(simpsons)).

disfruto(prudencio, montaniaRusa(hulk)).
disfruto(prudencio, autosChocadores).
disfruto(hermenegildo, simulador(minions)).
disfruto(rigoberta, simulador(ikran)).

foo(Persona) :-
    subioA(Persona,_),
    forall(subioA(Persona, Atraccion), disfruto(Persona, Atraccion)).

%3
esValiente(Persona):-
    subioA(Persona, montaniaRusa(_)).
    











































        
