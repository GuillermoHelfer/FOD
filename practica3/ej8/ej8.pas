program ej8;
const
    maeNom = "./maestro.txt/"
    cant_opciones = 3;
type

    subr_opciones = 0..cant_opciones -1;

    distribucion = record
        nombre = string [20]; //unico
        anio = integer;
        vKernel = integer;
        cantDev = integer;
        descrip = string[40];
    end;

    maestro = file of distribucion; //reutilizacion de espacio inv-list

//modulos
function ExisteDistribucion (unNombre : string): boolean;
var
    mae : maestro;
    mreg : distribucion;
    encontre : boolean;
begin
    Assign(mae, maeNom);
    Reset(mae);
    encontre := false;
    while ((not eof(mae))and(!encontre)) do begin
        Read(mae, mreg);
        encontre := mreg.nombre = unNombre;
    end;
    return encontre;
end;

procedure AltaDistribucion ();
var
    mae : maestro;
    mreg : distribucion;
    aux : distribucion;
    dis: distribucion;
begin
    writeln('ingrese el nombre de la distribucion');
    readln(dis.nombre);
    if (!ExisteDistribucion(dis.nombre) then begin
        writeln('ingrese el nombre de la distribucion');
        readln(dis.nombre);
        writeln('ingrese el nombre de la distribucion');
        readln(dis.nombre);
        writeln('ingrese el nombre de la distribucion');
        readln(dis.nombre);

        Assign(mae, maeNom);
        Reset(mae);
        Read(mae, mreg);
        if(mae.cantDev <> 0) then begin
            Seek(mae, mreg.cantDev * (-1));
            Read(mae, aux);
            Seek(mae, filePos(mae) - 1);
            Write(mae, dis);
            Seek(mae, 0);
            Write(aux);
        end
        else begin
            Seek(mae, FileSize(mae));
            Write(mae, dis);
        end;
        Close(mae);
    end
    else
        writeln('ya existe la distribucion');
end;

procedure BajaDistribucion ();
var
    mae : maestro;
    mreg: distribucion;
    aux : distribucion;
    nombre : string[20];
begin
    writeln('ingrese el nombre de la distribucion');
    readln(nombre);
    if (ExisteDistribucion(nombre)) then begin
        Assign(mae, maeNom);
        Reset(mae);
        Read(mae, mreg);
        aux:= mreg;
        while ((not eof(mae)) and (mreg.nombre <> nombre)) do
            Read(mae, mreg);
        Seek(mae, filepos(mae) - 1);
        Write(mae, aux);
        mreg.cod := (filePos(mae) - 1) * -1;
        Seek(mae, 0);
        Write(mreg);
        Close(mae);
    end
    else
        writeln('Distribucion no existente');
end;

procedure MostrarOpciones ();
var
    opt : subr_opciones;
begin
    writeln('ingrese la opcion que quiera: ');
    writeln('0 = salir');
    writeln('1 = AltaDistribucion');
    writeln('2 = BajaDistribucion');
    readln(opt);
    case op of
        0: writeln('saliendo...');
        1: AltaDistribucion();
        2: BajaDistribucion();
        else: writeln('opcion invalida, saliendo...');
    end;
end;

//programa ppal
begin
    mostrarOpciones();
end.
