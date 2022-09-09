program MATRIZ1;
uses CRT;
var X: array[1..999, 1..3] of string[20];
    Z,I,tam,B: integer;
    CON, CON2, CON3: real;
    VET: array[1..3] of string[20];
begin
I:= 1;
tam:=0;
Z:=1;
B:=7;
 while(true)do
  begin
   CLRSCR;
   gotoxy(10,3);
   write('');
   gotoxy(10,4);
   write('PROGRAMA MATRIZ 1');
   gotoxy(10,5);
   write('PARA SAIR DIGITE FIM NO NOME');
   gotoxy(10,7);
   write('Digite o nome do empregado: ');
   readln(X[I,1]);
   gotoxy(10,7);
   clreol;
    if (X[I,1] = 'FIM') or (I=999) then break;
     repeat
      gotoxy(10,7);
      write('Digite o registro do empregado: ');
      readln(X[I,2]);
      tam:=length(X[I,2]);
      gotoxy(10,7);
      clreol;
       if (tam <> 3) then
       begin
        gotoxy(10,9);
        write('Deve ter tres digitos!');
        gotoxy(10,9);
        clreol;
      end;
     until (tam = 3);
     repeat
      gotoxy(10,7);
      write('Digite o dia: ');
      readln(VET[1]);
      gotoxy(10,7);
      clreol;
      gotoxy(10,7);
      write('Digite o mes: ');
      readln(VET[2]);
      gotoxy(10,7);
      clreol;
      gotoxy(10,7);
      write('Digite o ano: ');
      readln(VET[3]);
      clreol;
      val (VET[1], CON, Z);
      val (VET[2], CON2, Z);
      val (VET[3], CON3, Z);
     until(CON>=1) and (CON<= 31) and (CON2>=1) and (CON2<= 12) and
      (CON3>= 1960) and (CON3<= 2009) and (Z=0);
       X[I,3]:= (VET[1] + '/' + VET[2] + '/' + VET[3]);
       I:=I+1;
    end;
    for I:=1 to (I-1) do
     begin
      for Z:=1 to 3 do
       begin
        if (Z = 1) then
        BEGIN
        GOTOXY(10,B);
        write(X[I,Z],' ');
        END
        else if (Z=2) then
        begin
        GOTOXY(20,B);
        write(X[I,Z],' ');
        end
        else if (Z=3) then
        begin
        GOTOXY(25,B);
        write(X[I,Z],' ');
        B:=B+1;
        end;
       end;
    end;
  readkey;
end.