program ej3;
const
	valorAlto = 9999;
	cantSucursales = (30 - 1);
type
	subr_sucursales = 0..cantSucursales;

	producto = record
		codigo: integer;
		nombre: string[15];
		desc: string [50];
		stockDis: integer;
		stockMin: integer;
		precio: real;
	end;
	
	productoDet = record
		codigo: integer;
		cantVendida: integer;
	end;
	
	maestro = file of producto; 			 //ordenado por cod de prod
	detalle = file of productoDet; 			 //ordenado por cod de prod
	
	arregloSuc = array[subr_sucursales] of detalle;
	
//modulos
procedure leer(	var archivo: detalle; var dato: alumnoDet);
begin
    if (not(EOF(archivo))) then
		read (archivo, dato)
    else 
		dato.codigo := valorAlto;
end;

function obtenerMinimo(var v : arregloSuc) : integer;
var
	reg : productoDet;
	codMin : integer;
	i : integer;
	iMin: integer;
begin
	codMin:= 9998;
	iMin := -1;
	for (i:= 0 to cantSucursales) do begin
		leer(v[i], reg);
		if (reg.codigo < codMin) then
			codMin:= reg.codigo;
			iMin:= i;
		seek(v[i] , filepos(v[i]) - 1);
	end;
	return iMin;
end;

procedure actualizarMaestro (var mae:maestro; var vector: arregloSuc);
var
	mreg: producto;
	dreg: productoDet;
	prevReg: productoReg;
	ventas: integer;
	i: integer;
	minAct: integer;
begin
	reset(mae);
	for (i:= 0 to (cantSucursales - 1)) do
		reset(v[i]);
		
	read(mae,mreg);
	minAct := obtenerMinimo(vector);
	
	while ( minAct <> -1 ) do begin // quedan detalles
		leer(v[minAct], dreg);
		prevReg := dreg;
		ventas:= 0;
		while ((prevReg.codigo = dreg.codigo)&&(minAct <> -1)) do begin
			ventas += dreg.cantVendida;
			minAct := obtenerMinimo(vector);
			leer(v[minAct],dreg);
		end;
		
		while (mae.codigo <> prevReg.codigo) do
			read(mae, mreg);
		mreg.stockDisp -= ventas;
		seek(mae, filepos(mae) -1);
		write(mae, mreg);
		if (not eof(mae)) then
			read(mae, mreg);
	end;
	
	close(mae);
	for (i:= 0 to (cantSucursales - 1)) do
		close(v[i]);
end;
	
//programa ppal
VAR
	
BEGIN
	
END.

