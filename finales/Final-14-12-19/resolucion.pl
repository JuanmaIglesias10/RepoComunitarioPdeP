stock(boedo, sillon(comun, 3), 4).
stock(boedo, silla(madera), 12).
stock(flores, sillon(cama, 2), 1).
stock(flores, silla(metal), 4).
stock(belgrano, sillon(reclinable, 2), 3).
stock(belgrano, silla(madera), 8).

busca(mati, mesa(circular,vidrio), 1).
busca(mati, silla(metal), 4).
busca(leo,sillon(cama,2),1).
busca(leo,sillon(reclinable,1),1).

trabaja(Sucursal,Material):-
    stock(Sucursal, Producto, _),
    tieneMaterial(Sucursal,Producto, Material).

tieneMaterial(Sucursal,silla(_), Material):-
    stock(Sucursal,silla(Material), _).

tieneMaterial(Sucursal,mesa(_,_), Material):-
    stock(Sucursal, mesa(_, Material), _).

tieneMaterial(_,sillon(_,_), madera).

esIdeal(Sucursal,Cliente):-
    stock(Sucursal,_,_),
    busca(Cliente,_,_),
    forall(busca(Cliente,Producto,_), stock(Sucursal, Producto, Cantidad)),
    Cantidad > 0.

