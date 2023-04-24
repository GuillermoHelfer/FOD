program ej1;
const
	
type
	
	ingresos = record
		cod: integer;
		nom: string[20];
		mon: real;
	end;
	
	archIngPosee = file of ingresos;
	
	archIngNuevo = file of ingresos;
	
	
//modulos
procedure compactarArchivo(var old: archIngPosee; var new: archIngNuevo);
var
	regAct, regAnt : ingresos;
	regAux : ingresos;
begin
	rewrite(old);
	reset(new);
	while (not eof(old))do begin
		read(old, regAct);
		regAnt = regAct;
		while ((regAct.cod = regAnt.cod)&&(not eof(old))) do begin
			regAnt = regAct;
			regAct.monto += regAnt.monto;
			actualizarComisiones(regAnt,regAct);
			read(old, regAct);
		end;
		write(new.regAct);
	end;
end;


//programa principal
VAR
	
BEGIN
	
END.
