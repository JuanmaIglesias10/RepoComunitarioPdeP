% estaEn(Peli,Personaje)
estaEn(buscandoNemo,nemo).
estaEn(buscandoNemo,dory).
estaEn(quienEnganio,rogerRabbit).
estaEn(quienEnganio,doom).
estaEn(quienEnganio,eddie).
estaEn(naufrago,chuck).

% esAnimado(Personaje)
esAnimado(nemo).
esAnimado(dory).
esAnimado(rogerRabbit).
esAnimado(doom). % Ups, spoiler

aptaParaAmargos(Peli):-
    findall(Pers,(estaEn(Peli,Pers),esAnimado(Pers)),Ps),
    length(Ps, C), C = 0.

seDivierte(Personaje):-
    findall(Animado,
        (estaEn(Peli1,Personaje),
         estaEn(Peli2,Animado),
         Peli1 = Peli2,
         esAnimado(Animado)),
    Compas),
    length(Compas, C), C >= 1.
