program ej14;
const
	valor_alto = 'ZZZZZZ'
type

	vueloMae = record
		destino: string[20];
		fecha: string[10];
		hora: string[5];
		lugares: integer;
	end;
	
	vueloDet = record
		destino: string[20];
		fecha: string[10];
		hora: string[5];
		comprados: integer; 
	end;


	maestro = file of vueloMae;
	
	detalle = file of vueloDet;
	//no se registro ninguna venta para un asiento que no este dispo.
	
	nodo = record
		data: vueloMae;
		sig: lista;
	end;
	
	lista = ^nodo;
	
	
//modulos

procedure leer (var archivo: detalle, var dato: vueloDet);
begin
	if (not(EOF(archivo))) then
		read (archivo, dato);
	else
		dato.destino := valor_alto;
	seek(archivo, filepos(archivo) - 1);
end;

function mismoVuelo(dreg, ant: vueloDet): boolean;
begin
	return ((dreg.destino = ant.destino) and (dreg.fecha = ant.fecha) 
		and (dreg.hora = ant.hora));
end;

procedure calcularMin( var det1, det2: detalle; var min: vueloDet);
var
	act: vueloDet;
begin
	min.destino:= valor_alto;
	leer(det1, act);
	if (act.destino < min.destino) then
		min:= act;
	leer(det2, act);
	if(act.destino <= min.destino)then begin
		min:= act;
		seek(det1, filepos(det1)-1);
	end
	else
		seek(det2, filepos(det2)-1);
end;

procedure agregarAlFinal( var l, ult:lista; data:vueloDet);
var
	nue: lista;
begin
	new(nue);
	nue^.data:= data;
	if (l = nil)then
		l:= nue;
	else
		ult^.sig:= nue;
	ult:= nue;
end;

procedure procesar(var mae: maestro; var det1, det2: detalle, base: integer, var l:lista);
var
	mreg: vueloMae;
	dreg: vueloDet;
	ant : vueloDet;
	ult: lista;
begin
	reset(mae);
	reset(det1);
	reset(det2);
	read(mae,mreg);
	calcularMin(det1,det2,dreg);
	while (dreg.destino <> valor_alto) do begin
		while (mreg.destino <> dreg.destino) do
			read(mae, mreg);
		while (mreg.fecha <> dreg.fecha) do
			read(mae, mreg);
		while (mreg.hora <> dreg.hora) do
			read(mae, mreg);
		while ((dreg.destino <> valor_alto) and (mismoVuelo(dreg,ant))) do begin
			mreg.lugares -= dreg.ventas;
			calcularMin(det1,det2,dreg);
		end;
		seek(mae, filepos(mae) - 1);
		write(mae, mreg);
		if (mreg.lugares < base) then
			agregarAlFinal(l,ult,mreg);
	end;
	close(mae);
	close(det1);
	close(det2);
end;
	
//programa ppal
VAR
	mae: maestro;
	det1: detalle;
	det2: detalle;
	base: integer;
	l : lista;
BEGIN
	assign(mae, 'master.txt');
	assign(det1, 'detail_1.txt');
	assign(det1, 'detail_2.txt');
	writeln('------------------'
	writeln('se generara una lista con los vuelos que tengan menos') 
	writeln('asientos dispoibles de los que ud. ingrese por teclado:');
	read(base);
	procesar(mae,det1,det2,base,l);
END.
