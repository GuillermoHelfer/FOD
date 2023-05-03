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
procedure crearAgregar(var mae : maestro)
var
	data: novela;
	nombreFis: string;
begin
	writeln('ingrese el nombre del archivo de texto);
	readln(nombreFis);
	assign(mae, nombreFis);
	rewrite(mae);
	data.codigo:= 0;
	Writeln(mae, data);
	writeln('ingrese el codigo de la novela a ingresar o 0 para teminar);
	readln(data.codigo);
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
		Writeln(data);
		
		writeln('ingrese el codigo de otra novela');
		readln(data.codigo);
	end;
	Close(mae);
end;

procedure mantenerArchivo (var mae: maestro)
var
	nombreFis: string;
	option: integer;
begin
	writeln('ingrese el nombre del archivo de texto);
	readln(nombreFis);
	assign(mae, nombreFis);
	writeln('ingrese el numero de una de las sig opciones:');
	writeln('0: salir');
	writeln('1: Dar de alta una novela leyendo la información desde teclado.');
	writeln('2: Modificar los datos de una novela leyendo la información desde teclado.');
	writeln('3: Eliminar una novela cuyo código es ingresado por teclado');
	case option of
		0: writeln('saliendo...');
		1: altaNovela(mae);
		2: modificarNovela(mae);
		3: eliminarNovela(mae);
		else writeln('opcion incorrecta, saliendo...');
	end;
end;

procedure presentarMenu(var mae: maestro)
var
	option: integer;
begin
	writeln('ingrese el numero de una de las sig opciones:');
	writeln('0: salir');
	writeln('1: Crear el archivo y cargarlo a partir de datos ingresados por teclado.');
	writeln('1: Abrir el archivo existente y permitir su mantenimiento.');
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
END.
