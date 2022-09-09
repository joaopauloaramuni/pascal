
    ASSIGN (ARQ, 'BD.DAT');
    (*$I-*);
    RESET (ARQ);
    (*$I+*);

    IF (IORESULT <> 0) THEN
      BEGIN
         WRITELN ('O ARQUIVO AINDA NAO EXISTE NO DISCO. SERA CRIADO AGORA');
         REWRITE (ARQ);
         WRITELN ('ARQUIVO CRIADO. PRESSIONE QUALQUER TECLA...');
         READKEY;
      END;
