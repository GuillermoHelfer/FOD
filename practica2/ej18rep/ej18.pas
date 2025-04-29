program ej18;
const
    valor_alto = 9999;
type

    stri = string[30];

    caso = record
        cod_localidad : stri;
        nombre_localidad : stri;
        cod_municipio : stri;  
        nombre_municipio : stri;
        cod_hospital : stri;
        nombre_hoospital : stri;
        fecha : stri;
        cant_casos : integer;
    end;

    detRec = record
        nombre_localidad: stri;
        nombre_municipio: stri;
        casos_mun : integer;
    end;

    maestro = file of caso;

    detalle = file of detRec;

//modulos
procedure leer(var mae:maestro; var dato: caso);
begin
    if (not eof(mae)) then
        read(mae,dato);
    else
        dato.cod_localidad:= valor_alto
end;

procedure informar(var mae: maestro; var det:detalle);
var
    mreg: caso;
    dreg : detReg;
    localidad_act: stri;
    municipio_act: stri;
    hospital_act: stri;
    c_pro, c_loc, c_mun, c_hos: integer;
begin
    Reset(mae);
    Reset(det);
    leer(mae,mreg);
    c_pro:= 0;
    while (mreg.cod_localidad <> valor_alto) do begin
        localidad_act:= mreg.nombre_localidad; c_loc:= 0;
        while ((mreg.nombre_localidad = localidad_act)) do begin
            municipio_act := mreg.cod_municipio; c_mun:= 0;
            while((mreg.cod_municipio = municipio_act)and(mreg.nombre_localidad = localidad_act)) do begin
                hospital_act:= mreg.cod_hosital; c_hos:= 0;
                while ((mreg.cod_hospital = hospital_act)and(mreg.cod_municipio = municipio_act)and(mreg.nombre_localidad = localidad_act)) do begin
                    c_hos:= c_hos + mreg.cant_casos;
                    leer(mae,mreg);
                end; 
                write('       Nombre: Hospital ', hospital_act, '------');
                writeln('       Cantidad de casos: ', c_hos);
                c_mun:= c_mun + c_hos;
            end;
            write('   Nombre: Municipio ', municipio_act, '------');
            writeln('   Cantidad de casos: ', c_mun);
            c_loc:= c_loc + c_mun;
            if (c_mun > 1500) then begin
                dreg.nombre_localidad = localidad_act;
                dreg.nombre_municipio = municipio_act;
                dreg.casos_mun = c_mun;
                write(det,dreg);
            end;
        end;
        write('Nombre: Localidad ', localidad_act, '------');
        writeln('Cantidad de casos: ', c_loc);
        c_pro:= c_pro + c_mun;
    end;
    writeln('');
    writeln('Cantidad de casos Totales en la Provincia: ', c_prov);
    Close(mae);
    Close(det);
end;

//programa ppal.
VAR
    mae: maestro;
    det: detalle;
BEGIN
    assign(mae, 'maestro');
    informar(mae, det);
END.
