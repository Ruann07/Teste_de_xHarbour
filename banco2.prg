Request DBFCDX
procedure main()
     produtos := {;
      {"c_cod", "N", 5, 0},;
     {"c_name", "C", 30, 0},;
     {"c_preco", "N", 6, 0};
     }
     DbCreate("dbprodutos", produtos, "DBFCDX", "MYALIAS")
     browse()
return