program ej2rep;
const
    valorAlto = 9999;
type
    alumnos = record
        codigo : integer;
        apellido : string[20];
        nombre : string[20];
        cursadas : integer;
        aprobadas: integer;
    end;

    alumnosDet = record
        codigo : integer;
        aprobo : boolean;
    end;

    maestro = file of alumnos;
    detalle = file of alumnosDet;

//modulos
procedure leer (var arc: maestro; var dato: alumnos);
begin
    if (not EOF(arc)) then
        read(arc,dato)
    else
        dato.codigo = valorAlto;
end;

procedure actualizarMaestro(var arc: maestro; var det: detalle);
var
    mreg: alumnos;
    dreg: alumnosDet;
begin
    Reset(mae);
    Reset(det);
    leer(mae, mreg);
    leer(det, dreg);
    while (mreg.codigo <> valorAlto) then begin
        while (dreg.codigo < mreg.codigo)do begin
            leer(det,dreg);
        end;
        while (dreg.codigo = mreg.codigo)do begin
            if (dreg.aprobo) then
                mreg.aprobadas = mreg.aprobadas + 1;
            else
                mreg.cursadas = mreg.cursadas + 1;
            leer(det,dreg);
        end;
        seek(mae, filepos(mae) - 1);
        writeln(mae, mreg);
        leer(mae, mreg);
    end;
    Close(mae);
    Close(det);
end;

procedure listarAlumnosCursada(mae);
var
    txtNuevo : maestro;
    mreg: alumnos;
    nombre : string;
begin
    writln('ingrese el nombre del txt donde se deben listar los alumnos');
    readln(nombre);
    Assign(txtNuevo, nombre);
    Rewrite(txtNuevo);
    Reset(mae);
    leer(mae,mreg);
    while (mreg.codigo <> valorAlto) do begin
        if ((mreg.cursadas - mreg.aprobadas) > 4)
            writeln(txtNuevo, mreg);
        leer(mae, mreg);
    end;
    Close(mae);
    Close(txtNuvo);
end;

procedure mostrarMenu (var mae: maestro; var det: detalle);
var
    option : integer;
begin
    writeln('ingrese una opcion por teclado:');
    writeln('1: actualizar el archivo maestro');
    writeln('2: Listar en arch txt alumnos cuatro materias cursada sin final');
    readln(option);
    case option of
        1: actualizarMaestro(mae,det);
        2: listarAlumnosCursada(mae);
        else writeln('no es una opcion valida');
    end;
end;

//prog ppal
VAR
    mae : maestro;
    det : detalle;
BEGIN
    Assign(mae, 'maestro.txt');
    Assign(det, 'detalle.txt');
    mostrarmenu(mae,det);
    writeln('Terminado. Pulse cualquier tecla para salir.');
    read();
END.
