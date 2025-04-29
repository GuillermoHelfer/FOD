program ej9;
const
    valor-alto = 9999;

type

    mesa = record
        codProv = string[20];
        codLoca = string[20];
        numero = integer;
        cantVotos = integer;
    end;

    maestro = file of mesa;

//modulos

procedure leer (var mae: maestro; var dato: mesa);
begin
    if (not eof(mae)) then
        read(mae, dato);
    else
        dato.codProv:= valor-alto;
end;

procedure contabilizar (var mae: maestro);
var
    mreg : mesa;
    provAct, locaAct: integer;
    votosLoca, votosProv, votosGral: integer;
begin
    Reset(mae);
    leer(mae, mreg);
    votosGral:= 0;
    while (mreg.codProv <> valor-alto) do begin
        votosProv:= 0;
        provAct:= mreg.codProv;
        writeln('Codigo de Provincia ', provAct);
        while ((mreg.codProv = provAct)and(mreg.codProv <> valor-alto)) do begin
            votosLoca:= 0;
            locaAct:= mreg.codLoca;
            while ((mreg.codProv = provAct)and(mreg.codLoca = locaAct)and(mreg.codProv <> valor-alto)) do begin
                leer(mae, mreg);
                votosLoca:= votosLoca + 1;
            end;
            votosProv:= votosProv + votosLoca;
            write('Codigo de Localidad ', locaAct);
            write('                    ');
            write('Total de Votos ', votosLoca);
        end;
        votosGral:= votosGral + votosProv;
        writeln('Total de Votos Provincia: ', votosProv);
    end;
    writeln('Total General de Votos: ', votosGral);
    Close(mae);
end;


//programa ppal
VAR
    mae : maestro;
BEGIN
    assign(mae, 'maestro.txt');
    contabilizar(mae);
END.
