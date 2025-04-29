program ej6;
const
    valor_alto = 9999;
type
    prenda = record
        cod_prenda : integer;
        descripcion : string[30];
        colores : string [30];
        tipo_prenda : string[30];
        stock : integer;
        precio_unitario : double;
    end;

    maestro = file of prenda;

    obsoletas = file of integer;


//modulos

procedure leerPre (var mae:maestro; var dato: prenda);
begin
    if (not eof(mae)) then
        read(mae, dato)
    else
        dato.codigo:= valor_alto;
end;

procedure leerCod (var obs:obsoletas; var dato: integer);
begin
    if (not eof(obs)) then
        read(obs, dato)
   else
        dato.codigo:= valor_alto;
end;

procedure actualizar (var mae: maestro; var obs: obsoletas);
var
    mreg: prenda;
    oreg: integer;
begin
    reset(mae);
    reset(obs);
    leerPre(mae,mreg);
    leerCod(obs,oreg);
    while (mreg.codigo <> valor_alto) do begin
        if (mreg.codigo = oreg) then begin
            mreg.stock:= -1;
            seek(mae, filepos(mae) - 1);
            write(mae,mreg);
            leerCod(obs,oreg);
        end
        leerPre(mae,mreg);
    end;
    Close(mae);
    Close(obs);
end;

procedure compactar (var mae,aux: maestro);
var
    mreg: prenda;
begin
    assign(aux, 'auxiliar');
    reset(mae);
    rewrite(aux);
    leer(mae,mreg);
    while (mreg.codigo <> valor_alto) do begin
        if (mreg.stock <> -1) do
            write(aux,mae);
        leer(mae,mreg);
    end;
    Close(mae);
    Close(aux);
end;

//pp
VAR
    mae, aux : maestro;
    obs : obsoletas;
BEGIN
    assign(mae, 'maestro');
    assign(obs, 'obsoletas');
    actualizar(mae,obs);
    compactar(mae,aux);
    erase(mae);
    rename(aux, 'maestro');
END.
