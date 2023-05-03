program pr3ej1;
Const
	cantOpciones = 8;
Type
	subr_option = 0..cantOpciones;

	Empleado = record
		num: integer;
		apellido: string;
		nombre: string;
		edad: integer;
		dni: string[10];
	end;
	
	archEmp= file of Empleado;
	
//modulos
Procedure CargarDatos(var arc_log: archEmp);
var
	emp: Empleado;
begin
	rewrite(arc_log); {se crea el archivo}
	
	writeln('ingrese el apellido');
	read(emp.apellido);
	while(emp.apellido <> 'fin') do begin
		writeln('ingrese el nombre');
		read(emp.nombre);
		writeln('ingrese la edad');
		read(emp.edad);
		writeln('ingrese el dni');
		read(emp.dni);
		writeln('ingrese el num de empleado');
		read(emp.num);
		
		write(arc_log, emp); {se escribe en el archivo cada numero}
		
		writeln(' ');
		writeln('ingrese el apellido');
		read(emp.apellido);
	end;
	close(arc_log);
end;

procedure ImprimirDatos(emp: Empleado);
begin
	write('apellido:' , emp.apellido);
	write(' nombre: ' , emp.nombre);
	write(' edad: ' , emp.edad);
	write(' dni: ' , emp.dni);
	write(' numero: ' , emp.num);
end;

procedure Opcion1(var arc_log: archEmp);
var
	criterio: string;
	key: string;
	emp: Empleado;
begin
	Reset(arc_log);
	writeln('ingrese "nombre" o "apellido" para elegir su criterio');
	read(criterio);
	if (criterio = 'nombre')then begin
		writeln('ingrese el nombre del empleado');
		read(key);
		while not eof(arc_log)do begin
			read(arc_log, emp);
			if (emp.nombre = key) then begin
				ImprimirDatos(emp);
			end;
		end;
	end
	else begin
		if (criterio = 'apellido')then begin
			writeln('ingrese el apellido del empleado');
			read(key);
			while not eof(arc_log)do begin
				read(arc_log, emp);
				if (emp.apellido = key) then begin
					ImprimirDatos(emp);
				end;
			end;
		end
		else begin
			writeln('criterio incorrecto, saliendo');
		end;
	end;
	close(arc_log);
end;

procedure Opcion2(var arc_log: archEmp);
var
	emp: Empleado;
begin
	Reset(arc_log);
	while not eof(arc_log) do begin
		read(arc_log, emp);
		ImprimirDatos(emp);
	end;
	close(arc_log);
end;

procedure Opcion3(var arc_log: archEmp);
var
	emp: Empleado;
begin
	Reset(arc_log);
	while not eof(arc_log) do begin
		read(arc_log, emp);
		if (emp.edad > 70) then
			ImprimirDatos(emp);
	end;
	close(arc_log);
end;

function controlUnicidad ( dni: string; var arc_log: archEmp ) : boolean;
var
	esUnico: boolean;
	emp: Empleado;
begin
	esUnico:= true;
	reset(arc_log);
	while (not EOF(arc_log) and (esUnico)) do begin
			read(arc_log, emp);
			if (emp.dni = dni)then
				esUnico:= false;
	end;
	close(arc_log);
	controlUnicidad := esUnico; 
end;

procedure Opcion4(var arc_log: archEmp);
var
	emp: Empleado;
begin
	emp.dni := '0';
	Rewrite(arc_log);
	Seek(arc_log, fileSize(arc_log) - 1);
	while (emp.dni <> '00')do begin
		writeln('ingrese otro dni de empleado o 00 para terminar');
		read(emp.dni);
		if ((emp.dni <> '00') and (controlUnicidad(emp.dni, arc_log)))then begin
			writeln('ingrese apellido');
			read(emp.apellido);
			writeln('ingrese nombre');
			read(emp.nombre);
			writeln('ingrese numero empleado');
			read(emp.num);
			writeln('ingrese edad');
			read(emp.edad);
			Write(arc_log, emp);
		end;
	end;
	Close(arc_log);
end;

function buscarEmpleadoDevolverPos(var arc_log: archEmp; dni: string): integer; //devuelve -1 si no encontro
var
	found: boolean;
	emp: Empleado;
begin
	found:= false;
	reset(arc_log);
	while( (not EOF(arc_log)) and (not found) ) do begin
		read(arc_log, emp);
		if (emp.dni = dni)then
			found:= true
	end;
	if (found) then
		buscarEmpleadoDevolverPos:= filePos(arc_log) - 1;
	buscarEmpleadoDevolverPos:= -1;
end;

procedure Opcion5(var arc_log: archEmp);
var
	emp: Empleado;
	dni: string;
	pos: integer;
begin
	writeln('ingrese el dni del empleado a modificar o 00 para terminar');
	read(dni);
	pos:= buscarEmpleadoDevolverPos(arc_log, dni);
	Rewrite(arc_log);
	while ((dni<> '00') and (pos <> -1)) do begin
		seek(arc_log, pos -1);
		read(emp);
		writeln('ingrese la edad modificada');
		read(emp.edad);
		seek(arc_log, pos -1);
		write(emp);
		
		writeln('ingrese el dni del empleado a modificar o 00 para terminar');
		read(dni);
		pos:= buscarEmpleadoDevolverPos(arc_log, dni);
	end;
	Close(arc_log);
end;
procedure Opcion6(arc_log: archEmp);
var
	data: Empleado;
	nuevo_log: archEmp;
	nuevo_fis: string[12];
begin
	nuevo_fis:= 'todos_empleados.txt'
	Reset(arc_log);
	Assign(nuevo_log, nuevo_fis);
	Rewrite(nuevo_log);
	while not eof(arc_log) do begin
		Read(arc_log, data);
		Write(nuevo_log, data);
	end;
	close(nuevo_log);
	close(arc_log);
end;

procedure Opcion7(arc_log: archEmp);
var
	emp: Empleado;
	nuevo_log : archEmp;
	nuevo_fis : string[12];
begin
	nuevo_fis:= '“faltaDNIEmpleado.txt'
	Assign(nuevo_log,nuevo_fis);
	Reset(arc_log);
	Rewrite(nuevo_log);
	while not eof(arc_log) do begin
		Read(arc_log, emp);
		if (emp.dni = '00')then
			Write(nuevo_log, emp);
	end;
	Close(nuevo_log);
	Close(arc_log);
end;

procedure Opcion8(arc_log: archEmp);
var
	emp: Empleado;
	dniEli: string[10];
	posEli: integer;
	i: integer;
begin
	Rewrite(arc_log);
	writeln('ingrese el dni del empleado a buscar');
	readln(dniEli);
	posEli := buscarEmpleadoDevolverPos(arc_log, dniELi);
	if (posEli <> -1) then begin
		Seek(arc_log, filesize(arc_log)-1);
		Read(arc_log, emp);
		Seek(arc_log, posEli);
		Writeln(arc_log, emp);
		Seek(arc_log, filesize(arc_log)-1);
		truncate(arc_log);
	end
	else
		writeln('no se encontro al empleado, saliendo...');
	Close(nuevo_log);
	Close(arc_log);
end;

Procedure MenuOpciones(var arc_log: archEmp);
var
	option: subr_option;
begin
	writeln('ingrese el numero de una de las sig opciones:');
	writeln('0: salir');
	writeln('1: Listar en pantalla los datos de empleados que tengan un nombre o apellido determinado.');
	writeln('2: Listar en pantalla los empleados de a uno por línea.');
	writeln('3: Listar en pantalla empleados mayores de 70 años, próximos a jubilarse.');
	writeln('4: Agregar uno o mas empleados al final del archivo');
	writeln('5: Modificar edad de uno o mas empleados');
	writeln('6: Exportar el contenido del archivo a un archivo de texto llamado “todos_empleados.txt”.');
	writeln('7: Exportar a un archivo de texto llamado: “faltaDNIEmpleado.txt”, los empleados que no tengan cargado el DNI (DNI en 00).');
	writeln('8: Eliminar un registro del archivo de texto.');
	read(option);
	case option of
		0: writeln('saliendo');
		1: Opcion1(arc_log);
		2: Opcion2(arc_log);
		3: Opcion3(arc_log);
		4: Opcion4(arc_log);
		5: Opcion5(arc_log);
		6: Opcion6(arc_log);
		7: Opcion7(arc_log);
		8: Opcion8(arc_log);
		else writeln('opcion invalida, saliendo');
	end;
end;

//programa ppal	
VAR
	arc_log: archEmp;
	arc_fis: string[12];
BEGIN
	writeln('ingrese el nombre del archivo');
	read(arc_fis);
	assign(arc_log, arc_fis);
	CargarDatos(arc_log);
	MenuOpciones(arc_log);
END.
