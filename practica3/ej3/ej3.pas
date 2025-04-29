program pr3ej3;
type
	
	novela = record
		codigo: integer;
		genero: string[15];
		nombre: string[20];
		duracion: real; //en hs
		director: string[20];
		precio: real;
	end;
	
	maestro = file of novela;
	
//modulos
procedure crearAgregar(var mae : maestro);
var
	data: novela;
	nombreFis: string;
begin
	writeln('ingrese el nombre del archivo de texto');
	readln(nombreFis);
	assign(mae, nombreFis);
	rewrite(mae);
	data.codigo:= 0;
	Write(mae, data);
	Write('ingrese el codigo de la novela a ingresar o 0 para teminar');
	Readln(data.codigo);
	while(data.codigo <> 0) do begin
		writeln('ingrese el genero de la novela');
		readln(data.genero);
		writeln('ingrese el nombre de la novela');
		readln(data.nombre);
		writeln('ingrese la duracion en horas de la novela');
		readln(data.duracion);
		writeln('ingrese el director de la novela');
		readln(data.director);
		writeln('ingrese el precio de la novela');
		readln(data.precio);
		Write(mae, data);
		
		writeln('ingrese el codigo de otra novela');
		readln(data.codigo);
	end;
	Close(mae);
end;

procedure altaNovela (var mae: maestro);
var
	nov: novela;
	reg: novela;
begin
	writeln('ingrese el codigo de la novela');
	readln(nov.codigo);
	writeln('ingrese el genero de la novela');
	readln(nov.genero);
	writeln('ingrese el nombre de la novela');
	readln(nov.nombre);
	writeln('ingrese la duracion de la novela');
	readln(nov.duracion);
	writeln('ingrese el director de la novela');
	readln(nov.director);
	writeln('ingrese el precio de la novela');
	readln(nov.precio);
	Reset(mae);
	Read(mae, reg);
	if (reg.codigo < 0) then begin //se puede aprovechar espacio
		Seek(mae, (reg.codigo * -1));
		Read(mae, reg);
		Seek(mae, filePos(mae) - 1);
		Write(mae, nov);
		Seek(mae, 0);
		Write(mae, reg);
	end
	else begin
		Seek(mae, fileSize(mae));
		Write(mae, nov);
	end;
	Close(mae);
	writeln('novela ingresada correctamente al sistema');
	writeln('terminando...');
end;

procedure modificarNovela (var mae: maestro);
var
	nov : novela;
	reg: novela;
begin
	writeln('ingrese el codigo de la novela');
	readln(nov.codigo);
	writeln('ingrese el genero de la novela');
	readln(nov.genero);
	writeln('ingrese el nombre de la novela');
	readln(nov.nombre);
	writeln('ingrese la duracion de la novela');
	readln(nov.duracion);
	writeln('ingrese el director de la novela');
	readln(nov.director);
	writeln('ingrese el precio de la novela');
	readln(nov.precio);
	Reset(mae);
    Read(mae, reg);
	while ((not eof(mae)) and (reg.codigo <> nov.codigo)) do
        Read(mae, reg);
    if (reg.codigo = nov.codigo) then begin
        Seek(mae, filePos(mae) -1);
        Write(mae, nov);
        writeln('se ha modificado exitosamente la novela con codigo= ', nov.codigo);
    end
    else
        writeln('no se ha encontrado una novela que tenga el codigo ingresado');
    close(mae);
end;

procedure eliminarNovela(var mae: maestro);
var
	nov: integer;
    reg: novela;
	aux: novela;
begin
    writeln('ingrese el codigo de la novela');
	readln(nov);
	Reset(mae);
    Read(mae, reg);
    aux:= reg;
    while ((not eof(mae)) and (reg.codigo <> nov)) do
        Read(mae, reg);
    if (reg.codigo = nov) then begin
        writeln(reg.codigo);
        writeln(reg.nombre);
        readln(nov);
        Seek(mae, filePos(mae) -1);
        Write(mae, aux);
        Seek(mae, 0);
        reg.codigo := (reg.codigo * (-1));
        Write(mae, reg);
    end
    else
        writeln('no se ha encontrado una novela con el codigo ingresado');
    close(mae);
end;

procedure leer(var mae: maestro; var dato: novela);
begin
    if (not eof(mae))then
        read(mae, dato)
    else
        dato.codigo := 9999;
end;

procedure imprimirUnaNovela(var mae: maestro);
var
    dato : novela;
    buscar: integer;
begin
    Reset(mae);
    writeln('ingrese el codigo de la novela a buscar');
    readln(buscar);
    leer(mae, dato);
    while ((dato.codigo <> 9999) and (dato.codigo <> buscar)) do begin
        leer(mae, dato)
    end;
    if (dato.codigo <> 9999) then begin
        writeln(dato.codigo);
        writeln(dato.nombre);
    end;
    Close(mae);
end;

procedure mantenerArchivo (var mae: maestro);
var
	nombreFis: string;
	option: integer;
begin
	writeln('ingrese el nombre del archivo de texto');
	readln(nombreFis);
	Assign(mae, nombreFis);
	writeln('ingrese el numero de una de las sig opciones:');
	writeln('0: salir');
	writeln('1: Dar de alta una novela leyendo la informacion desde teclado.');
	writeln('2: Modificar los datos de una novela leyendo la informacion desde teclado.');
	writeln('3: Eliminar una novela cuyo codigo es ingresado por teclado');
    writeln('4: Imprimir una novela');
    readln(option);
	case option of
		0: writeln('saliendo...');
		1: altaNovela(mae);
		2: modificarNovela(mae);
		3: eliminarNovela(mae);
        4: imprimirUnaNovela(mae);
		else writeln('opcion incorrecta, saliendo...');
	end;
end;

procedure presentarMenu(var mae: maestro);
var
	option: integer;
begin
	writeln('ingrese el numero de una de las sig opciones:');
	writeln('0: salir');
	writeln('1: Crear el archivo y cargarlo a partir de datos ingresados por teclado.');
	writeln('2: Abrir el archivo existente y permitir su mantenimiento.');
    readln(option);
	case option of
		0: writeln('saliendo...');
		1: crearAgregar(mae);
		2: mantenerArchivo(mae);
		else writeln('opcion invalida, terminando programa...');
	end;
end;

	
//programa ppal
VAR
	mae : maestro;
BEGIN
	presentarMenu(mae);
    readln();
END.
