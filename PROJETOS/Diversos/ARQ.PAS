PROGRAM INCLUI;
USES CRT;
TYPE carro = RECORD
     placa: string[7];
     marca: string[20];
     ano: integer;
END;

frota = FILE OF carro;

VAR DETRAN: frota;
    CARROS: carro;
    PLACA: string[7];
    MARCA: string[20];
    ANO, K, I: integer;
    ACHOU: boolean;

BEGIN {Programa Principal}
   CLRSCR;
   ASSIGN (DETRAN, 'G:\CARROS.DAT');
   REWRITE (DETRAN);
   K:= FILESIZE (DETRAN);
   CLOSE (DETRAN);
end.