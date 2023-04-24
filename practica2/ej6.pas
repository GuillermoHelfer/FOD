program ej2;
const
	valorAlto = 9999;
	cantDetalles = 10;
type
	subr_cantDetalles = 1..cantDetalles;

	covichosMas = record
		codLocal: string;
		nomLocal: string;
		codCepa: string;
		nomCepa: string;
		casosAct: integer;
		casosNue: integer;
		casosRec: integer;
		casosFal: integer;
	end;

	covichosDet = record
		codLocal: string;
		codCepa: string;
		casosAct: integer;
		casosNue: integer;
		casosRec: integer;
		casosFal: integer;
	end;
	
	maestro = file of covichoMas;
	detalle = file of covichoDet;
	
	vDetalles = new array [subr_cantDetalles] of detalle;
	
//modulos
procedure leer (var archivo: detalle);
var 
	dato: covichosDet;
begin
	if (not(EOF(archivo))) then
		read (archivo, dato);
	else
		dato.codLocal := valor_alto;
	seek(archivo, filepos(archivo) - 1);
end;

procedure minimo(var min: covichosDet; var vDet: vDetalles);
var
	i: subr_cantDetalles;
	act: covichosDet;
	minPos: integer;
begin
	min.codLocal:= valorAlto;
	minPos:= -1;
	for (i:= 1 to cantDetalles) do begin
		leer(vDet[i], act);
		if((act.codLocal < min.codLocal) or ((act.codLocal = min.codLocal) and (act.codCepa < min.codCepa)) then begin
			min:= act;
			minPos:= i;
		end;
	end;
	if (min.codLocal <> valorAlto) then
		seek(vDet[minPos], filepos(vDet[minPos]) + 1);
end;

procedure abrirArchivos(var vDet: vDetalles);
var
	i: subr_cantDetalles;
	s: string;
begin
	for (i:= 1 to cantDetalles) do begin
		Str(i,s);
		assign(vDet[i], 'det'+s);
		reset(vDet[i]);
	end;
	assign(ma,'master');
    reset(ma);
end;

procedure cerrarArchivos(var vDet: vDetalles; var mae: maestro);
var
	i: subr_cantDetalles;
begin
	close(mae);
	for i:= 1 to cantDetalles do
		close(vDet[i]);
end;

procedure actualizarMaestro(var vDet : vDetalles; var mae : maestro);
var
	dreg: covichoDet;
	mreg: covichoMas;
begin
	abrirArchivos(vDet);
	obtenerMinimo(dreg,vDet);
	while (dreg.codLocal<>valorAlto) do begin
		leer(mae, mreg);
		while((mreg.codLocal = dreg.codLocal) or (mreg.codCepa <> dreg.codCepa)) do
			read(mae,mreg);
		while ((mreg.codLocal = dreg.codLocal) and (mreg.codCepa = dreg.codCepa)) do begin
			mreg.casosFal += dreg.casosFal;
			mreg.casosRec += dreg.casosRec;
			mreg.casosAct := dreg.casosAct;
			mreg.casosNue := dreg.casosNue;
			obtenerMinimo(dreg,vDet);
		end;
		seek(mae, filepos(mae) - 1);
		write(mae,mreg);
	end;
	cerrarArchivos(vDet, mae);
end;
	
	
//programa ppal
VAR
	vDet: vDetalles;
	mae: maestro;
BEGIN
	actualizarMaestro(vDet, mae);
END.
