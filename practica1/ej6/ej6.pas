program ej6;
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

procedure agregarCelulares (var arc : archCel)
var
	cel : celular;
begin
	rewrite(arc_log);
	writeln('ingrese el codigo de un nuevo celular o -1 para terminar');
	readln(cel.cod);
	while (cel.cod <> -1) do begin
		writeln('ingrese el precio del celular');
		readln(cel.precio);
		writeln('ingrese la marca del celular');
		readln(cel.precio);
		writeln('ingrese el stock del celular');
		readln(cel.precio);
		writeln('ingrese el stock minimo del celular');
		readln(cel.precio);
		writeln('ingrese la descripcion del celular');
		readln(cel.precio);
		writeln('ingrese el nombre del celular');
		readln(cel.precio);
		writeln('----------------------------------------');
		
		seek(arc, filesize(arc));
		writeln(arc,cel.codigo,' ',cel.precio:0:2,cel.marca);
		writeln(arc,cel.stock,' ',cel.stockMin,cel.descrip);
		writeln(arc,cel.nombre);
		
		writeln('ingrese el codigo de un nuevo celular o -1 para terminar');
		readln(cel.cod);
	end;
	close(arc_log);
end;

procedure modificarStock(var arc : archCel);
var
	nom : string[20];
	cel : celular;
begin
	writeln('ingrese el nombre del celular a modificar su stock');
	readln(nom);
	rewrite(arc);
	while( not eof(arc) && ) do begin
		readln(arc,cel.codigo,cel.precio,cel.marca);
		if ( cel.nombre == nom) then begin
			readln(arc,cel.stock,cel.stockMin,cel.desc);
			readln(arc,cel.nombre);
			
			writeln('cual sera el nuevo stock del celular ', cel.nombre, ' ?');
			readln(cel.stock);
			seek(arc,filepos(arc) - 1);
			
			writeln(arc,cel.codigo,' ',cel.precio:0:2,cel.marca);
			writeln(arc,cel.stock,' ',cel.stockMin,cel.descrip);
			writeln(arc,cel.nombre);
		end;
	end;
	close(arc);
end;

procedure exportarSinStock(var arc: archCel);
var
	cel : celular;
	txt : Text;
begin
	rewrite(arc);
	Assign(txt, 'SinStock.txt');
	reset(txt);
	while (not eof(arc))do begin
		readln(arc,cel.codigo,cel.precio,cel.marca);
		readln(arc,cel.stock,cel.stockMin,cel.desc);
		if (cel.stock = 0) then begin
			readln(arc,cel.nombre);
			
		end;
		
	end;
	close(arc);
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
	writeln('e : agregar uno o mas celulares al final por teclado');
	writeln('f : modificar stock de un celular dado');
	writeln('g : exportar celulares sin stock al archivo "SinStock.txt"');
	readln(op);
	writeln('----------------------------------------');	
	
	case op of
		'a' : cargarArchivo(arc_log);
		'b' : listarCelulares(arc_log);
		'c' : contieneCadena(arc_log);
		'd' : crearArchivoTxt(arc_log);
		'e' : agregarCelulares(arc_log);
		'f' : modificarStock(arc_log);
		'g' : exportarSinStock(arc_log);
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
