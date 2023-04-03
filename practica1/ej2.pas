Program ej2;

Type 
	archivo= file of integer;
	
//modulos
procedure Recorrido(var arc_log: archivo);
var 
	nro: integer;
	suma: integer;
	cant: integer;
begin
	suma:= 0;
	cant:= 0;
	reset(arc_log); {archivo ya creado, abrir como lect/escr}
	while not eof(arc_log) do begin
		read(arc_log, nro);
		suma += nro;
		cant += 1;
		if (nro < 1500) then
			writeln(nro);
	end;
	writeln('el promedio de los numeros ingresados es: ', suma/cant:0:2);
	close(arc_log);
	{close(arc_log);}
end;

//programa principal
Var 
	arc_log: archivo;
	arc_fis: string[12];
	nro: integer;
	aux: integer;
BEGIN
	writeln('ingrese el nombre del archivo');
	read(arc_fis);
	assign(arc_log, arc_fis);
	rewrite(arc_log); {se crea el archivo}
	read(nro);
	while(nro <> 3000) do begin
		write(arc_log, nro); {se escribe en el archivo cada numero}
		read(nro);
	end;
	Close(arc_log);
	Recorrido(arc_log);
END.
