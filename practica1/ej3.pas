Program ej3;
Const
	cantOpciones = 3;
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

Procedure MenuOpciones(var arc_log: archEmp);
var
	option: subr_option;
begin
	writeln('ingrese el numero de una de las sig opciones:');
	writeln('0: salir');
	writeln('1: Listar en pantalla los datos de empleados que tengan un nombre o apellido determinado.');
	writeln('2: Listar en pantalla los empleados de a uno por línea.');
	writeln('3: Listar en pantalla empleados mayores de 70 años, próximos a jubilarse.');
	read(option);
	case option of
		0: writeln('saliendo');
		1: Opcion1(arc_log);
		2: Opcion2(arc_log);
		3: Opcion3(arc_log);
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
