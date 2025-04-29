program ej7rep;

const

    VALOR_ALTO = 9999;

type

    producto = record
        codigo: integer;
        nombre: string[20];
        precio: double;
        stockAct: integer;
        stockMin: integer;
    end;

    venta = record
        codigo: integer;
        cantidad: integer;
    end;

    maestro =  file of producto;

    detalle = file of venta;

//modulos
procedure leerProducto (var mae: maestro; var dato: producto);
begin
    if (not eof(mae)) then
        read(mae,dato)
    else
        dato.codigo := VALOR_ALTO;
end;

procedure leerVenta (var det: detalle; var dato: venta);
begin
    if (not eof(det)) then
        read(det,dato)
    else
        dato.codigo := VALOR_ALTO;
end;

procedure actualizarMaestro (var mae: maestro; var det: detalle);
var
    mreg: producto;
    dreg: venta;
begin
    Reset(mae);
    Reset(det);
    leerProducto(mae,mreg);
    leerVenta(det,dreg);
    while (dreg.codigo <> VALOR_ALTO) do begin
        while (dreg.codigo < mreg.codigo) do begin
            leerProducto(mae,mreg);
        end;
        while (mreg.codigo = dreg.codigo) do begin
            mreg.stockAct:= mreg.stockAct - dreg.cantidad;
            leerVenta(det,dreg);
        end;
        seek(mae, filepos(mae) - 1);
        write(mae, mreg);
        leerProducto(mae,mreg);
    end;
    Close(mae);
    Close(det);
end;

procedure listarBajoMinimo (var mae: maestro);
var
    mreg: producto;
begin
    leerProducto(mae, mreg);
    writeln('productos que estan por debajo del stock minimo: ');
    writeln('');
    while(not EOF(mae)) do begin
        if (mreg.stockAct < mreg.stockMin) then begin
            writeln('----------------');
            writeln('codigo: ', mreg.codigo);
            writeln('nombre: ', mreg.nombre);
            writeln('');
        end;
    end;
end;

//programa ppal.
VAR
    mae: maestro;
    det: detalle;
BEGIN
    assign(mae, 'maestro.txt');
    assign(det, 'detalle.txt');
    actualizarMaestro(mae,det);
    listarBajoMinimo(mae);
END.
