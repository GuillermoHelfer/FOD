program ej5repaso;
const
    valorAlto = 9999;

    n = 50;

type

    str = string[20];

    DireccionD = record
        calle: str;
        nro: str;
        piso: str;
        dpto: str;
        ciudad: str;
    end;

    nacimiento = record
        nroPartida: integer;
        nombre: str;
        apellido: str;
        direccion: DireccionD;
        matriculaNac: str;
        nombreMadre: str;
        apellidoMadre: str;
        DNIMadre: str;
        nombrePadre: str;
        apellidoPadre: str;
        DNIPadre str;
    end;

    fallecimiento = record;
        nroPartida: integer;
        DNI: str;
        nombre: str;
        apellido: str;
        matriculaDec: str;
        FechaDec: str;
        HoraDec: str;
        LugarDec: str;
    end;

    actaMaestra = record
        nroPartida: integer;
        nombre: str;
        apellido: str;
        direccion: DireccionD;
        matriculaNac: str;
        nombreMadre: str;
        apellidoMadre: str;
        DNIMadre: str;
        nombrePadre: str;
        apellidoPadre: str;
        DNIPadre: str;
        matriculaDec: str;
        FechaDec: str;
        HoraDec: str;
        LugarDec: str;
    end;

    maestro = file of actaMaestra;
    detalleNac = file of nacimiento;
    detalleDec = file of fallecimiento;

    detNacimientoArray = array [1..n] of detalleNac;
    detDecesosArray = array [1..n] of detalleDec;

    vectorNac = array [1..n] of nacimiento;
    vectorDec = array [1..n] of fallecimiento;

//modulos

procedure leerNacimiento (var det: detalleNac; var dato: nacimiento);
begin
    if (not EOF(det)) then
        read(det,dato);
    else
        dato:= valorAlto;
end;

procedure leerDeceso (var det: detalleDec; var dato: fallecimiento);
begin
    if (not EOF(det)) then
        read(det,dato);
    else
        dato:= valorAlto;
end;

procedure minimoNac(var vNac: vectorNac; var minNac: nacimiento; var nacimientos: detNacimientosArray);
var
    i, iMin: integer;
begin
    minNac.nroPartida := valorAlto;
    iMin := -1;
    for i to n do begin
        if (vNac[i].nroPartida <> valorAlto) then begin
            if (vNac[i].nroPartida < minNac.nroPartida) then begin
                minNac := nacimientos[i];
                iMin:= i;
            end;
        end;
    end;
    if (iMin <> -1) then
        leerNacimiento(nacimientos[i], vNac[i]);
end;

procedure minimoDec(var vDec: vectorDec; var minDec: fallecimiento; var decesos: derDecesosArray);
var
    i, iMin: integer;
begin
    minDec.nroPartida := valorAlto;
    iMin := -1;
    for i to n do begin
        if (vDec[i].nroPartida <> valorAlto) then begin
            if (vDec[i].nroPartida < minDec.nroPartida) then begin
                minDec := decesos[i];
                iMin:= i;
            end;
        end;
    end;
    if (iMin <> -1) then
        leerFallecimiento(decesos[i], vDec[i]);
end;

procedure crearMaestro (var mae: maestro; nacimientos: detNacimientosArray; decesos: detFallecimientosArray);
var
    minNac: nacimiento;
    minDec: fallecimiento;
    mReg: actaMaestra;
    i : integer;
    stringAux: string;
    vNac: vectorNac;
    vDec: vectorDec;
begin
    Rewrite(mReg);
    for i to n do begin
        Str (i,stringAux);
        Assign(nacimientos[i], 'detalleNAC'+stringAux);
        Reset(nacimientos[i]);
        leerNacimiento(nacimientos[i],vNac[i]);
        Assign(decesos[i], 'detalleDEC'+stringAux);
        Reset(decesos[i]);
        leerFallecimiento(decesos[i],vDec[i]);
    end;
    minimoNac(vNac, minNac, nacimientos);
    minimoDec(vDec, minDec, decesos);
    while (minNac.nroPartida <> valorAlto);
        if (minNac.nroPartida = minDec.nroPartida) then begin
            mReg.nroPartida = minNac.nroPartida;
            mReg.nombre = minNac.nombre;
            mReg.apellido = minNac.apellido;
            mReg.direccion = minNac.direccion;
            mReg.matriculaNac = minNac.matriculaNac;
            mReg.nombreMadre = minNac.nombreMadre;
            mReg.apellidoMadre = minNac.apellidoMadre;
            mReg.DNIMadre = minNac.DNIMadre;
            mReg.nombrePadre = minNac.nombrePadre;
            mReg.apellidoPadre = minNac.apellidoPadre;
            mReg.DNIPadre = minNac.DNIPadre;
            mReg.matriculaDec = minNac.matriculaDec;
            mReg.FechaDec = minNac.FechaDec;
            mReg.HoraDec = minNac.HoraDec;
            mReg.HoraDec = minNac.HoraDec;

            minimoDec(vDec, minDec, decesos);
        else
            mReg.nroPartida = minNac.nroPartida;
            mReg.nombre = minNac.nombre;
            mReg.apellido = minNac.apellido;
            mReg.direccion = minNac.direccion;
            mReg.matriculaNac = minNac.matriculaNac;
            mReg.nombreMadre = minNac.nombreMadre;
            mReg.apellidoMadre = minNac.apellidoMadre;
            mReg.DNIMadre = minNac.DNIMadre;
            mReg.nombrePadre = minNac.nombrePadre;
            mReg.apellidoPadre = minNac.apellidoPadre;
            mReg.DNIPadre = minNac.DNIPadre;
            mReg.matriculaDec = '';
            mReg.FechaDec = '';
            mReg.HoraDec = '';
            mReg.HoraDec = '';
        end;
        write(mae, mreg);
        minimoNac(vNac, minNac, nacimientos);
    end;
end;

procedure listarMaestro (var mae: maestro);
var
    mReg: actaMaestra;
begin
    Reset (mae);
	while (not eof (mae)) do begin
		read (mae,mReg);
		writeln ('|NRO: ',datos.nro,' |NOMBRE: ',datos.nombre,' |DIRECCION: ',datos.direccion,' |MATRICULA: ',datos.matricula);
		writeln ('NOMBRE MADRE: ',datos.nombreM,' |DNI MADRE: ',datos.dniM,' |NOMBRE PADRE: ', datos.nombreP,'| DNI PADRE: ', datos.dniP);
		writeln ('ESTA MUERTO?: ', seMurio,' |MATRICULA MEDICO: ', enEfecto.matricula);
		writeln ('FECHA: ', enEfecto.fecha,' |HORA DE FALLECIMIENTO: ',enEfecto.hora,' |LUGAR DE FALLECIMIENTO: ',enEfecto.lugar);
		writeln ('');
	end;
	close (mae);
end;

//programa pppal
VAR
    mae : maestro;
    nac : detNacimientosArray;
    dec : detDecesosArray;
BEGIN
    Assign(mae, 'maestro.txt');
    crearMaestro(mae, nac, dec);
    writeln('saliendo...');
    read();
END.
