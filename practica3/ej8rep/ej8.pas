program ej8;
const
    valor_alto = 'ZZZZZ';
    valor_base = 'aaaaa';
type
    distribucion =  record
        nombre: string[30];
        anio: string[30];
        kernel: string[30];
        cant_dev : integer;
        descripcion : string[30];
    end;

    archivo = file of distribucion;

//modulos

procedure leer (var a : archivo; dato : distribucion);
begin
    if (not eof(a)) then
        read(a,dato)
    else
        dato.nombre := valor_alto;
end;

function ExisteDistribucion (var a:archivo; nombre: string);
var
    mreg: distribucion;
    ok : boolean;
begin
    reset(mae);
    ok:= false;
    leer(mae,mreg);
    while ((mreg.nombre <> valor_alto)and(not ok)) do begin
        if (mreg.nombre = nombre)
            ok:= true
        leer(mae,mreg);
    end;
    close(mae);
    ExisteDistribucion := ok;
end;

procedure leerTeclado(var nue: distribucion)
begin
    writeln('ingrese el nombre de la distribucion');
    readln(nue.nombre);
    writeln('ingrese el anio lanzamiento de la distribucion');
    readln(nue.anio);
    writeln('ingrese la version del kernel de la distribucion');
    readln(nue.kernel);
    writeln('ingrese la cantidad de desarrolladores de la distribucion');
    readln(nue.cant_dev);
    writeln('ingrese la descripcion de la distribucion');
    readln(nue.descripcion);
end;

procedure AltaDistribucion (var a : archivo);
var
    nue, reg : distribucion;
    aux: distribucion;
begin
    leerTeclado(nue);
    if (not ExisteDistribucion(a,nue.nombre) then begin
        reset(a);
        leer(a, reg);
        if (reg.cant_dev < 0) then
            seek(a, reg.cant_dev * (-1));
            leer(a, aux);
            seek(a, filepos(a) - 1);
            write(a, nue);
            seek(a, 0);
            write(a, aux);
        end
        else begin
            seek(a, filesize(a));
            write(a, nue);
        end;
        close(a);
    end
    else
        writeln('Ya existe la distribucion');
end;

procedure BajaDistribucion (var a: archivo; dato: distribucion);
var
    reg, aux: distribucion;
    nombre : string[30];
begin
    writeln('ingrese el nombre de la distribucion a borrar');
    readln(nombre);
    if (ExisteDistribucion(a,nombre) then
        reset(a);
        leer(a, reg); 
        aux:= reg;
        while (reg.nombre <> valor_alto)and(reg.nombre <> nombre) do begin
            leer(a,reg);
        end;
        if (reg.nombre = nombre) then begin
            seek(a, filepos(a) - 1);  
            reg.cant_dev:= filepos(a) * (-1);
            write(a, aux);
            seek(a, 0);
            write(a, reg);
        end;
        close(a);
    end
    else
        writeln('Distribucion no existente');
end;

//pp
VAR

BEGIN

END.
