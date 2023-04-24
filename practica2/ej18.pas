program ej2;
const
	
	
type
	
	
//modulos
procedure informar(var arc: archivo);
var
	act : municipio;
	ant : municipio;
	casosMun: integer;
	casosLoc: integer;
	casosTot: integer;
begin
	reset(arc);
	leer(arc, act);
	casosTot:= 0;
	while (act.codLoc <> valor_alto) do begin
		ant:= act;
		casosLoc:= 0;
		while ((act.codLoc <> valor_alto) and (act.codLoc = ant.codLoc)) do begin
			casosMun:= 0;
			while ((act.codLoc <> valor_alto) and (act.codLoc = ant.codLoc) and (act.codMun = ant.codMun)) do begin
				writeln(act.nombre_hospital,'...........',act.cant_casosH);
				casosMun += act.cant_casosH;
				leer(arc,act);
			end;
			writeln('Cantidad de casos Municipio ', ant.nombMun)
			writeln(casosMun);
			casosLoc += casosMun;
		end;
		writeln('Cantidad de casos Localidad ', ant.nombLoc)
		writeln(casosMun);
		casosTot+= casosLoc;
	end;
	writeln('Cantidad de casos Totales en la provincia')
	writeln(casosTot);
	close(arc);
end;
	
//programa ppal
VAR
	
BEGIN
	
END.
