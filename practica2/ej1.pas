program ej1;
const
	valorAlto = 9999;
type
	ingresos = record
		cod: integer;
		nom: string[20];
		mon: real;
	end;
	
	archivo = file of ingresos;
	
	
//modulos
procedure leer (var dato : ingresos , var arc: archivo);
begin
	if (not eof (arc))
		read(arc, dato);
	else
		dato.cod = valorAlto;
end;

procedure compactarArchivo(var old: archivo; var new: archivo);
var
	aux, actual : ingresos;
begin
	reset(old);
	assign(new, 'nuevo');
	rewrite(new);
	leer(old, actual);
	while (actual.cod <> valorAlto) do begin
		aux.cod := actual.cod;
		aux.nom := actual.nom;
		aux.mon := 0;
		while (actual.cod = aux.cod) do begin
			leer(old, actual);
			aux.mon = aux.mon + actual.mon;
		end;
		write(new, aux);
	end;
	close(old);
	close(new);
end;


//programa principal
VAR
	
BEGIN
	
END.
