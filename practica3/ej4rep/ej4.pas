program ej4;
const
    valor_alto = 9999;
    string_alto = 'ZZZZZZZZ';
type

    reg_flor = record
        nombre: String[45];
        codigo:integer;
    end;

    tArchFlores = file of reg_flor;

//modulos
procedure leer(var a: tArchFlores; var dato: reg_flor);
begin
    if (not eof(a)) then
        read(a,dato);
    else
        dato.codigo:= valor_alto;
end;

procedure agregarFlor (var a: tArchFlores ; nombre: string; codigo:integer);
var
    reg, aux: reg_flor;
begin
    Reset(a);
    reg.nombre := nombre;
    reg.codigo := codigo; 
    leer(a,aux);
    if (aux.codigo < 0) then begin
        seek(a, aux.codigo * (-1));
        leer(a,aux);
        seek(a, filepos(a) - 1);
        write(a,reg);
        seek(a, 0);
        write(a, aux);
    end
    else begin
        seek(a, filesize(a));
        write(a,reg);
    end;
    Close(a);
end;

procedure listarOmitiendo(var a: tArchFlores);
var
    reg: reg_flor;
begin
    Reset(a);
    leer(a,reg);
    while (reg.codigo <> valor_alto) do begin
        if (reg.codigo > 0) then
            writeln('nombre= ', reg.nombre, ', codigo= ', reg.codigo);
    end;
    Close(a);
end;

procedure eliminarFlor (var a: tArchFlores; flor:reg_flor);
var
    reg: reg_flor;
    top: integer;
    x: reg_flor;
begin
    Reset(a);
    leer(a,reg);
    top:= reg.codigo;
    while ((reg.codigo <> valor_alto)and(reg.codigo <> flor.codigo)) do
        leer(a,reg);
    if (reg.codigo = flor.codigo) then begin
        x.nombre:= reg.nombre;
        x.codigo:= reg.codigo * (-1);
        reg.codigo:= top;
        seek(a, filepos(a) - 1);
        write(a,reg);
        seek(a,1);
        write(a,x);
    end;
    Close(a);
end;

//programa ppal.
VAR
    a : tArchFlores;
    nom : string;
    cod : int;
    flo: reg_flor;
BEGIN
    assign(a, 'flores');

    writeln('ingrese el nombre de la flor a ingresar');
    readln(nom);
    writeln('ingrese el codigo de la flor a ingresar');
    readln(cod);

    agregarFlor(a,nom,cod);
    listarOmitiendo(a);

    
    writeln('ingrese el nombre de la flor a ingresar');
    readln(flo.nombre);
    writeln('ingrese el codigo de la flor a ingresar');
    readln(flo.codigo);

    eliminarFlor(a,flo);

    writeln('saliendo...');
    read();
END.
