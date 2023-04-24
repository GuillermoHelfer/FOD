program ej2;
const
	valorAlto = 9999;
type
	alumno = record
		codigo: integer;
		apellido: string[15];
		nombre: string[15];
		cursadas: integer;
		aprobadas: integer;
	end;
	
	alumnoDet = record
		codigo: integer;
		aprobada: boolean;
	end;
	
	materia = record
		aprobada : boolean;
	end;
	
	maestro = file of alumno;
	detalle = file of alumnoDet;
	
//modulos
procedure leer(	var archivo: detalle; var dato: alumnoDet);
begin
    if (not(EOF(archivo))) then
		read (archivo, dato)
    else 
		dato.codigo := valorAlto;
end;


procedure actualizarMaestro(var mae: maestro; var det: detalle);
var
	mreg: alumno;
	dreg: alumnoDet;
	aux: integer;
	totApro, totCurs: integer;
begin
	reset(mae);
	reset(det);
	read(mae,mreg);
	leer(det,dreg);
	while (dreg.codigo <> valorAlto)do begin
		aux := dreg.codigo;
		totApro := 0;
		totCurs:= 0;
		while (aux = dreg.codigo)do begin
			if (dreg.aprobada) then
				totApro+= 1
			else
				totCurs+= 1;
			leer(det, dreg);
		end;
		while (mreg.codigo <> aux) do
			read(mae, mreg);
		mreg.aprobadas += totApro;
		mreg.cursadas += totCurs;
		seek(mae, filepos(mae)-1);
		write(mae,mreg);
		if (not eof(mae)) then
			read(mae, mreg);
	end;
	close(mae);
	close(det);
end;

procedure listarAlumnosDebenMuchosFinales(var mae: maestro)
var
	mreg: alumno;
begin
	reset(mae);
	leer(mae);
	while (mae.codigo <> valorAlto) do begin
		if (mreg.aprobadas > mreg.cursadas + 4)
			writeln('El alumno:', mreg.apellido, mreg.nombre, ' debe mas de 4 finales');
		leer(mae);
	end;
	close(mae);
end;

procedure procedure

//programa ppal
VAR
	mae: maestro;
	det: detalle;
BEGIN
	assign(mae, 'maestro.dat');
	assign(det, 'detalle.dat');
	actualizarMaestro(mae,det);
	listarAlumnosDebenMuchosFinales(mae);
END.
