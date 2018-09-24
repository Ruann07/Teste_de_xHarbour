REQUEST DBFCDX
procedure main()
    fornece := {;
    { "c_id", "N", 5, 0}, ;
    { "c_nome", "C", 40, 0}, ;
    { "c_cnpj", "N", 11, 0} ;
    }
    DbCreate("dbfornecedor", fornece, "DBFCDX", "MYALIAS")
    browse()
return 