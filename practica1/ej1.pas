Program ejer1;

Type 
	archivo: file of integer;
	
Var 
	arc_log: archivo;
	arc_fis: string[12];
	nro: integer;

BEGIN
	writeln ('ingrese el nombre del archivo');
	read (arc_fis);
	assign (arc_log, arc_fis);
	rewrite (arc_log); {se crea el archivo}
	read (nro);
	while (nro <> 3000) do begin
		write (arc_log, nro); {se escribe en el archivo cada numero}
		read (nro);
	end;
	close (arc_log); {se cierra el archivo abierto con rewrite}
END;
