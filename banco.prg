REQUEST DBFCDX
procedure main()
    registros := {;
          {"c_id", "N", 5, 0},;
      {"c_nomes", "C", 30, 0},;
     {"c_idades", "N", 8, 0 },;
     {"c_datanasc", "D", 8, 0};
    }
    DbCreate("dbnames", registros, "DBFCDX", "MYALIAS") 
    browse()
return 