program ej10;
const
	valor_alto = 29999;
	cant_categorias = 15;
type
	subrCategorias = 1..cant_categorias;

	empleado = record
		dpto: string[20];
		divi: string[20];
		numE: integer;
		cate: string[20];
		hsEx: integer;
	end;
	
	archivo = file of empleado;
	
	archCate = file of real;
	//ordenado por departamento > division > numero empleado
	
	cates = array[subrCategorias] of integer;
	
//modulos
procedure cargarArregloCategorias(var cat: cates, var arCa: archCate);
var
	i: subrCategorias;
begin
	for i:=1 to cant_categorias do
		read(arCa, i, cat[i]);
end;

procedure leer (var archivo: archivo, var emp: empleado);
begin
	if (not(EOF(archivo))) then
		read (archivo, dato);
	else
		dato.numE := valor_alto;
	seek(archivo, filepos(archivo) - 1);
end;

function calcMonto(var reg: empleado; cat: cates): real
begin
	return cat[reg.cate] * reg.hsEx;
end;

procedure informar(var arc: archivo; cat: cates);
var
	act : empleado;
	ant : empleado;
	horasDiv: integer;
	montoDiv: integer;
	horasDep: integer;
	montoDep: integer;
begin
	reset(arc);
	leer(arc, act);
	while (act.numE <> valor_alto) do begin
		ant:= act;
		horasDep:= 0;
		montoDep:= 0;
		writeln('Departamento: ', act.dpto);
		while ((not eof(arc)) and (act.dpto = ant.dpto)) do begin
			horasDiv:= 0;
			montoDiv:= 0;
			writeln('Division: ', act.divi);
			writeln('Numero de Empleado    Total de Hs.    Importe a cobrar');
			while ((act.numE <> valor_alto) and (act.dpto = ant.dpto) and (act.divi = ant.divi)) do begin
				writeln(act.numE,'             ',act.hsEx,'        ',calcMonto(act,cat));
				horasDiv += act.hsEx;
				montoDiv += calcMonto(act,cat);
				leer(arc,act);
			end;
			writeln('Total horas de division: ',horasDiv);
			writeln('Monto total de division: ',montoDiv);
			horasDep += horasDiv;
			montoDep += montoDiv;
		end;
		writeln('Total horas de departamento: ',horasDiv);
		writeln('Monto total de departamento: ',montoDiv);
	end;
	close(arc);
end;
	
//programa ppal
VAR
	arc : archivo;
	arCa : archCate;
	cat : cates;
BEGIN
	assign(arCa, 'archCategorias.txt');
	cargarArregloCategorias(arCa,cat);
	assign(arc, 'archEmpleados.txt');
	informar(arc,cat);
END.
