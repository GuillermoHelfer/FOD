program ej6;
const
    maeNom = './maestro.txt';

type

    prendas = record
        cod_prenda : integer;
        descripcion : string[40];
        colores : string[20];
        tipo_prenda : string[15];
        stock : integer;
        precio_unitario : double;
    end;

    maestro = file of prendas;

    detalle = file of integer;

//modulos
procedure BajaLogicaPrendas (var mae : maestro; var mae det);
var
    mreg : prenda;
    dreg : integer;
begin
    Rewrite(mae);
    Reset(det);
    Read(mae, mreg);
    Read(det, dreg);
    while(not eof(mae)) do begin
        while((not eof(mae))and(mreg.cod_prenda < dreg.cod_prenda)) do
            Read(mae, mreg);
        mreg.cod_prenda := -1;
        Seek(mae, filepos(mae) - 1);
        Write(mae, mreg);
    end;
    Close(mae);
    Close(det);
end;

procedure CompactarArchivo (var mae : maestro);
var
    mreg : prenda;
    nue : maestro;
begin
    Assign(nue, './NueAux.txt');
    Rewrite(nue);
    Reset(mae);
    while (not eof(mae) do begin
        Read(mae, mreg);
        if (mreg.stock <> -1) then
            Write(nue, mreg);
    end;
    Close(mae);
    Assign(nue, maeNom);
end;

procedure ActualizarPrendas (var mae : maestro; var det : detalle);
begin
    BajaLogicaPrendas(mae,det);
    CompactarArchivo(mae);
end;

//programa principal
var
    mae : maestro;
    conf : string;
    det: detalle;
    detNom : string;
begin
    writeln('ingrese "OK" para actualizar stock');
    readln(conf);
    if (conf = 'OK')then begin
        writeln('ingrese el nombre del archivo detalle');
        readln(detNom);
        assign(det, detNom);
        assign(mae, maeNom);
        ActualizarPrendas(mae,det);
    end;
end.
