genero(el38,rock).
genero(sisters,reggae).
genero(muchoPorHacer,rock).
genero(tusOjos,reggae).
genero(bastara,reggae).
genero(asd,rock).

toca(el38, divididos).
toca(sisters, divididos).
toca(muchoPorHacer, riff).
toca(tusOjos, losCafres).
toca(bastara, losCafres).
toca(asd,asdfghj).

rockera(Banda):-
    toca(_,Banda),
    findall(Tema, noTieneTemasDeRock(Banda), Temas),
    length(Temas, 0).

noTieneTemasDeRock(Banda):-
    toca(Tema,Banda),
    genero(Tema,Genero),
    Genero \= rock.