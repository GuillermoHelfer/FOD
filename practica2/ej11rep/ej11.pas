program ej11;
const
    VALOR_ALTO = 'ZZZZZZ';
type

    provincia = record
        nombre: string;
        cantAlf: integer;
        cantEnc: integer;
    end;

    provinciaDET = record
        nombre: string;
        localidad: string;
        cantAlf: integer;
        cantEnc: integer;
    end;

    maestro = file of provincia;

    detalle = file of provinciaDET;

//modulos

procedure leerProv (var mae: maestro; var dato: provincia);
begin
    if (not eof(mae)) then
        read(mae, dato)
    else
        dato.nombre := VALOR_ALTO;
end;

procedure leerProvDET (var det: detalle; var dato: provinciaDET);
begin
    if (not eof(det)) then
        read(det, dato)
    else
        dato.nombre := VALOR_ALTO;
end;

procedure minimo (var det1, det2 : detalle; var min: provinciaDET);
var
    d1reg, d2reg: provinciaDET;
begin
    leerProvDet(det1, d1reg);
    leerProvDet(det2, d2reg);
    if (d1reg.nombre <= d2reg.nombre) then begin
        seek(det2, filepos(det2) - 1);
        min:= d1reg;
    end
    else begin
        if (d2reg.nombre < d1reg.nombre) then begin
            seek(det2, filepos(det2) - 1);
            min:= d2reg;
        end;
    end;
end;

procedure actualizar (var mae: maestro; var det1, det2: detalle);
var
    mreg : provincia;
    min : provinciaDET;
begin
    Reset(mae);
    Reset(det1);
    Reset(det2);
    leerProv(mae, mreg);
    minimo(det1,det2,min);
    while (mreg.nombre <> VALOR_ALTO) do begin
        while (mreg.nombre < min.nombre) do
            leerProv(mae, mreg);
        while (mreg.nombre = min.nombre) do begin
            mreg.cantAlf:= mreg.cantAlf + min.cantAlf;
            mreg.cantEnc:= mreg.cantEnc + min.cantEnc;
            minimo(det1,det2,min);
        end;
        seek(mae, filepos(mae) - 1);
        write(mae, mreg);
    end;
    Close(mae);
    Close(det1);
    Close(det2);
end;

//programa ppal.
VAR
    mae: maestro;
    det1, det2: detalle;
BEGIN
     assign(mae, 'maestro.txt');
     assign(det1, 'detalle1.txt');
     assign(det2, 'detalle2.txt');
     actualizar(mae,det1,det2);
     writeln('');
     read();
END.
