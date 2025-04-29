program ej2;
const
    valor_alto = 'ZZZZZZ';
    clave_borrado = '@';
type

    asistente = record
        numero : integer;
        Ape_Nom : string[30];
        email : string[30];
        dni : string [9];
    end;

    archivo = file of asistente;

//modulos

procedure leer(var arc: archivo; var dato: asistente);
begin
    if (not eof(arc)) then
        read(arc,dato)
    else
        dato.dni:= valor_alto;
end;

procedure generarArchivo (var arc: archivo);
var
    reg: asistente;

begin
    Reset(arc);
    leer(arc,reg);
    while(reg.dni <> valor_alto) do begin
        if (reg.numero < 1000) then begin
            seek(arc, filepos(arc) - 1);
            reg.nom_Ape:= (clave_borrado + reg.nom_Ape);
            write(arc,reg);
        end;
        leer(arc,dato);
    end;
end;

//programa ppal.
VAR

BEGIN

END.
