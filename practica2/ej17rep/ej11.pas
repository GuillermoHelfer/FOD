program ej17;
const
    valor_alto = 9999;

    n = 10;
type
    str = string[20];

    moto = record
        codigo: integer;
        nombre: str;
        descripcion: str;
        modelo: str;
        marca: str;
        stock: integer;
    end;

    venta = record
        codigo: integer;
        precio: double;
        fecha: str;
    end;

    maestro =  file of moto;

    detalle = file of venta;

    vDetalles = array [1..n] of detalle;

//modulos

procedure leerProd (var mae:maestro; var dato:producto)
begin
    if (not eof(mae)) then
        read(mae,dato)
    else
        dato.codigo = valor_alto;
end;

procedure leerVenta (var det:detalle; var dato:venta)
begin
    if (not eof(det))then
        read(det,dato);
    else
        dato.codigo = valor_alto;
end;

procedure minimo (var vDet: vDetalles; var min: venta);
var
    i, iMin: integer;
    aux: venta;
begin
    min.codigo:= valor_alto;
    i:= 1;
    iMin:= -1;
    for i to n do begin
        leerVenta(vDet[i], aux);
        if (aux.codigo < min.codigo) then
            iMin:= i;
        seek(vDet[i], filepos(vDet[i]) - 1);
    end;
    if (iMin <> -1) then
        leerVenta(vDet[iMin], min);
end;

procedure ActualizarInformar (var mae: maestro; var vDet: vDetalles);
var
    mreg: producto;
    min: venta;
    i: integer;
    cantAct, codAct: integer;
    cantMax, codMax: integer;
begin
    Reset(mae);
    for i:= 1 to n do begin
        Reset(vDet[i]);
    leerProd(mae, mreg);
    minimo(vDet, min);
    cantMax:= -1;
    codMax:= valor_alto;
    while (mreg.codigo <> valor_alto) do begin
        while (mreg.codigo < min.codigo) do
            leerProd(mae, mreg);
        codAct:= mae.codigo;
        cantAct:= 0;
        while (mreg.codigo = min.codigo) do begin
            mreg.stock:= mreg.stock - 1;
            cantAct:= cantAct + 1;
            minimo(vDet,min);
        end;
        if (cantAct > cantMax) then begin
            cantMax:= cantAct;
            codMax:= codAct
        end;
        seek(mae, filepos(mae) - 1);
        write(mae, mreg);
        leerProd(mae, mreg);
    end;
    writeln('la moto mas vendida fue: ', codMax);
    Close(mae);
    for i to n do
        Close(vDet[i]);
end;

//programa ppal.
VAR
    mae: maestro;
    vDet: vDetalles;
    i: integer;
    nombre: string;
BEGIN
    assign(mae, 'maestro');
    for i to n do begin
        Str(i,nombre);
        Assign(vDet[i], 'detalle' +  nombre);
    end;
    actualizarInformar(mae, vDet);
END.

