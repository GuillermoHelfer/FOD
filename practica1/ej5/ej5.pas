program ej5;
type

	celular = record
		codigo: integer;
		nombre: string[20];
		descr: string;
		marca: string[10];
		precio: real;
		stockMin : integer;
		stock : integer;
	end;
	
	archCel = file of celular;
	
//modulos
	
procedure listarCelulares(var arch : archivo);
var
  reg : celular;
begin
	reset(arch);
	while(not eof(arch)) do begin
		read(arch,reg);
		if(reg.stock < reg.stockMin) then
			writeln(reg.codigo,'',reg.marca,' ',reg.nombre,' ',reg.precio:2:2,' ',reg.stock);
	end;
	close(arch);
end;
	
procedure cargarArchivo(var arc_log: archCel)
var
	txt : Text;
	reg : celular;
begin
	assign(txt,'celulares.txt');
	reset(txt);
	rewrite(arc_log);
	while (not eof(txt))do begin
		readln(txt,reg.codigo,reg.precio,reg.marca);
		readln(txt,reg.stock,reg.stockMin,reg.desc);
		readln(txt,reg.nombre;
		write(arch,reg);
	end;
	close(txt);
	close(arc_log);
end;

procedure crearArchivoTxt(var arch : archCel);
var
  reg : celular;
  txt : Text;
begin
	assign(txt,'celulares.txt');
	reset(arch);
	rewrite(txt);
	while(not eof(arch)) do begin
		read(arch,reg);
		writeln(txt,reg.codigo,' ',reg.precio:0:2,reg.marca);
		writeln(txt,reg.stock,' ',reg.stockMin,reg.descrip);
		writeln(txt,reg.nombre);
	end;
	close(arch);
	close(txt);
end;
	
procedure presentarMenu(var arc_log: archCel);
var
	option : char;
begin
	writeln('----------------------------------------');
	writeln('a : cargar el archivo');
	writeln('b : celulares con stock menor al minimo');
	writeln('c : celulares que su descripcion contiene la cadena ingresada');
	writeln('d : crear archivo txt para futuras cargas');
	readln(op);
	writeln('----------------------------------------');	
	
	case op of
		'a' : cargarArchivo(arc_log);
		'b' : listarCelulares(arc_log);
		'c' : contieneCadena(arc_log);
		'd' : crearArchivoTxt(arc_log);
	end;
end;

VAR
	arc_log : archCel;
	arc_fis : string[20];
BEGIN
	writeln('ingrese el nombre del archivo');
	read(arc_fis);
	assign(arc_log, arc_fis);
	presentarMenu(arc_log);
END.
