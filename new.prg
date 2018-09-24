#include "fileio.ch"
#include "inkey.ch"
#include "hbclass.ch"
#include "sqlrdd.ch"
#include "sqlodbc.ch"
#include "pgs.ch"

#define CRLF Chr( 13 ) + Chr( 10 )
#define padrao to "B+G/N, N/W,,,W/GR+"

REQUEST SQLRDD
REQUEST SR_ODBC
REQUEST SR_PGS

PROCEDURE main()
    public pega
    public w_jan
    public cNcc
    public oSql
    public name
    public cod
    public Conn
    public w 
    public x 
    public opcao 
    public files, text 
    public op 
    public cod := 0
    public Cnome := space( 30 ) 
    public cnpj := space( 11 )
    public idade
    public prod
    public prec := 0
    public cCod
    public nas :=  CTOD( "00/00/0000" )
    public ano, nascN
    public _sqlrdd := "SQLRDD"
    public server := "127.0.0.1"
    public user := "postgres"
    public bank := "toureiro"
    public password := "hbtdfinfo"
    public hora := time()
    set delimiters on
    set delimiters to "[]"
    set century on
    set date british
    set escape on
    set deleted on
    set color to "N/N+/N/BG+"
    use dbnames ALIAS registros
    index on c_id to registros
    index on c_id to registros02
    index on c_id to registros03
    set index to registros, registros02, registros03
    do while .T.
        use dbnames ALIAS registros
        cls
        @ 01, 07 say hora
        @ 02, 07 to 5, 55 double
        @ 04, 09 say "ESCOLHA: "
        @ 05, 07 to 21, 55 double
        @ 04, 44 say "ESC = EXIT"
        @ 08, 10 prompt "Adicionar registros "
        @ 10, 10 prompt "Remover registros "
        @ 12, 10 prompt "Editar registros "
        @ 14, 10 prompt "Visualizar registros "
        @ 16, 10 prompt "Gravar registros em .TXT"
        @ 18, 10 prompt "OOP - com DBF "
        @ 20, 10 prompt "Conexao com banco SQL "
        @ 20, 40 prompt "Sair "
        menu to op
        cls
        do case
        case op == 1
            DbGoBottom()
            cod := c_id
            cod++
            @ 2, 4 say "Informe seu nome: " get Cnome 
            @ 4, 4 say "Informe sua data de nascimento: " get nas 
            read
            DbAppend() 
            grava()
            cls
        case op == 2
            input "Informe o Numero do ID que deseja: " to x
            cls
            apaga()
        case op == 3
            input "Informe o Numero do ID que deseja: " to x 
            cls
            if DbSeek( x )
                cod := c_id
                cod := strzero(cod, 5)
                @ 2, 4 say "Informe um novo nome: " get Cnome 
                @ 4, 4 say "Informe sua data de nascimento nova: " get nas
                read
                grava()
                cls
            else
                wait "ESSE REGISTRO NAO EXISTE !"
            endif
        case op == 4
            DbGoTop()
            Do while ! eof()
            ? c_id, c_nomes, c_idades, c_datanasc
            DbSkip()
            enddo
            wait " "
        case op == 5 
            createdoc()
        wait "Registros gravados com sucesso"
        case op == 6
            cls
            obj := produto():new()
            obj_2 := cliente():new()
            obj_3 := fornecedor():new()
            do while .t.
                @ 02, 04 to 08, 18 double
                @ 03, 05 prompt "Clientes    "
                @ 04, 05 prompt "Produtos    "
                @ 05, 05 prompt "Fornecedor  "
                @ 06, 05 prompt "CONECTAR SQL"
                @ 09, 05 say "Esc=Sair"
                menu to opcao
                cls
                if Lastkey() == K_ESC
                    exit
                endif
                do case
                case opcao == 1
                    // OP��ES PARA CLIENTES
                    cls
                    @ 01, 02 say "Clientes: "
                    @ 02, 04 to 08, 20 double
                    @ 03, 05 prompt " Adicionar " message " Adicionar um cliente " 
                    @ 04, 05 prompt " Listar " message " Mostrar todos os clientes listados "
                    @ 05, 05 prompt " Remove " message " Remove um cliente "
                    @ 06, 05 prompt " Atualizar " message " Atualizar um cliente "
                    menu to op
                    if Lastkey() == K_ESC
                        exit
                    endif
                    cls 
                    do case 
                    case op == 1
                        addcli()
                        obj_2:adicionar()
                        cls
                    case op == 2
                        obj_2:listar()
                        cls
                    case op == 3
                        obj_2:excluir()
                        cls
                    case op == 4
                        atucli()
                        obj_2:atualizar()
                        cls
                    endcase
                    cls
                case  opcao == 2
                    // OP��ES PARA PRODUTOS
                    cls
                    @ 01, 02 say "Produtos: "
                    @ 02, 04 to 08, 20 double
                    @ 03, 05 prompt " Adicionar " message " Adicionar um produto " 
                    @ 04, 05 prompt " Listar " message " listar todos os produtos "
                    @ 05, 05 prompt " Remove " message " Remove um produto "
                    @ 06, 05 prompt " Atualizar " message " Atualizar um produto "
                    menu to op
                    if Lastkey() == K_ESC
                        exit
                    endif
                    do case 
                    case op == 1
                        addprod()
                        obj:adicionar()
                    case op == 2
                        obj:listar()
                    case op == 3
                        obj:excluir()
                    case op == 4
                        uprod()
                        obj:atualizar()
                    endcase
                    cls
                case opcao == 3
                    // OP��ES PARA FORNECEDOR
                    cls
                    @ 01, 02 say "Fornecedor: "
                    @ 02, 04 to 08, 20 double
                    @ 03, 05 prompt " Adicionar " message " Adicionar um fornecedor " 
                    @ 04, 05 prompt " Listar " message " listar todos os fornecedores "
                    @ 05, 05 prompt " Remove " message " Remove um fornecedor "
                    @ 06, 05 prompt " Atualizar " message " Atualizar um fornecedor "
                    menu to op
                    if Lastkey() == K_ESC
                        exit
                    endif
                    do case
                    case op == 1
                        addfor()
                        obj_3:adicionar()
                    case op == 2
                        obj_3:listar()
                    case op == 3 
                        obj_3:excluir()
                    case op == 4
                        atuafor()
                        obj_3:atualizar()
                    otherwise
                        wait "SEM ESCOLHA !"
                        exit
                    endcase
                    cls
                case op == 4
                    cls
                    Conn := "pgs="+server+";uid="+user+";dtb="+bank+";pwd="+password
                    ? cNcc := SR_AddConnection( CONNECT_POSTGRES, Conn )
                    if cNcc < 1
                        @ 02, 04 say "erro de conexao"
                    endif
                    sel := "select c_codigo from a_client"
                    use ( sel ) alias x_cliente new via _sqlrdd
                    SR_BeginTransaction()
                endcase
            enddo
    case op == 7 // CONEXÃO AO SQL 
            dbcloseare()
            Conn := "pgs="+server+";uid="+user+";dtb="+bank+";pwd="+password
            cNcc := SR_AddConnection( CONNECT_POSTGRES, Conn )
            sel := "select c_cod, c_nome, c_data from a_names"
            use a_names alias x_client new via _sqlrdd
            cls 
            if cNcc < 1
                ? "erro de conexao"
                exit
            else
                alert("conectou-se ao Sql") 
            endif
            @ 01, 04 say "Usando o Banco de clientes" 
            @ 02, 03 to 09, 38 double
            @ 03, 04 prompt "Adicionar registro: "
            @ 04, 04 prompt "Deletar registro: "
            @ 05, 04 prompt "Visualizar os registros: "
            @ 06, 04 prompt "Atualizar um registro: "
            @ 07, 04 prompt "Gravar registros em docomuento: "
            @ 08, 04 prompt "Mostra um so registro: "
            menu to op
            if Lastkey() == K_ESC
                cls
                exit
            endif
            do case
            case op == 1 
                cls
                input "Escolha como voce quer adicionar um registro (1)replace ou (2)insert: " to q 
                if q == 1
                    cls
                    addreplace()
                else
                    cls
                    addinsert()
                endif
            case op == 2
                delsql()
            case op == 3
                DbGoTop()
                ? "***********************************************************"
                ? "* C_COD  | C_NOME                 |  C_DATA_DE_REGISTRO   *"
                Do while ! eof()
                ? "*", c_cod, c_nome, c_data,"     *"
                DbSkip()
                enddo
                wait " "
            case op == 4
                cls
                upsql()
            case op == 5
                if FileValid( "docsql.txt" ) == .t.
                    FileDelete( "docsql.txt" )
                endif
                files := Fcreate( "docsql.txt", FC_NORMAL )
            do while ! eof()
                Fwrite( files, c_cod  )
                Fwrite( files, " " )
                Fwrite( files, c_nome, )
                Fwrite( files, " ")
                Fwrite( files, transform( c_data, "@E") + CRLF)
                DbSkip()
            enddo
            cls
            wait "Registros gravados com sucesso"
            case op == 6 
                cls
                order()
            endcase
    otherwise
        exit
    endcase
    enddo
    use
    wait "Clique algo para sair"
    cls
Return
/**************
* Fim do Main *
***************/

// clases 
class produto 
    data prod
    data cod 
    data preco 
    method adicionar()
    method listar()
    method excluir()
    method atualizar()
endclass

class cliente 
    data cli
    data codi
    data idad
    data nasc
    method adicionar()
    method listar()
    method excluir()
    method atualizar()
endclass

class fornecedor
    data name 
    data Ncnpj
    data key
    Method adicionar()
    Method listar()
    Method excluir()
    Method atualizar()
endclass

// metodos do produto
Method adicionar() class produto
    use dbprodutos alias produtos
    cls
    DbAppend()
    replace produtos->c_id with ::cod
    replace produtos->c_nome with ::prod
    replace produtos->c_preco with ::preco
    DbCommit()
    use
Return self

Method listar() class produto
    use dbprodutos alias produtos
    cls
    browse()
    wait " "
    use
Return self

Method excluir() class produto
    use dbprodutos alias produtos
    index on c_id to produtos
    set index to produtos
    apaga()
    use
Return self

Method atualizar() class produto 
    use dbprodutos alias produtos
    replace produtos->c_id with ::cod
    replace produtos->c_nome with ::prod
    replace produtos->c_preco with ::preco
    DbCommit()
    use
Return self

// metodos do cliente
Method adicionar() class cliente
    REPLACE registros->c_nomes WITH ::cli 
    REPLACE registros->c_datanasc WITH ::nasc 
    REPLACE registros->c_idades WITH ::idad 
    REPLACE registros->c_id WITH ::codi 
    DbCommit()
Return self

Method listar() class cliente
    cls
    browse()
Return self

Method excluir() class cliente
    cls
    apaga()
Return self

Method atualizar() class cliente
    REPLACE registros->c_nomes WITH ::cli
    REPLACE registros->c_datanasc WITH ::nasc
    REPLACE registros->c_idades WITH ::idad
    REPLACE registros->c_id WITH ::codi
    DbCommit()
Return self

// metodos do fornecedor
Method adicionar() class fornecedor
    replace fornece->c_id with ::key
    replace fornece->c_nome with ::name
    replace fornece->c_cnpj with ::Ncnpj 
    DbCommit()
    use
Return self

Method listar() class fornecedor
    use dbfornecedor alias fornece
    cls
    browse()
    use 
Return self

Method excluir() class fornecedor
    use dbfornecedor alias fornece
    apaga()
    use
Return self

Method atualizar() class fornecedor
    use dbfornecedor alias fornece
    replace fornece->c_id with ::key
    replace fornece->c_nome with ::name
    replace fornece->c_cnpj with ::Ncnpj
    DbCommit()
    use
Return self

// Fun��es
// atualiza um produto na tabela dbf
FUNCTION uprod()
    use dbprodutos
    index on c_id to produtos
    set index to produtos
    cls 
    input "Informe o ID do produto que deseja atualizar: " to x
    if DbSeek( x )
        cCod := c_id
        cls 
        @ 02, 04 say "Informe o novo nome do produto: " get Cnome
        @ 03, 04 say "Informe o novo preco do produto: " get prec
        read
    else
        wait "Produto nao existe"
    endif
    obj:prod := Cnome
    obj:preco := prec
    obj:cod := cCod
    cls
    use
Return nil

// adiciona um produto na tabela dbf
FUNCTION addprod()
    use dbprodutos alias produtos
    cls
    DbGoBottom()
    @ 02, 04 say "Informe o nome do produto: " get Cnome
    @ 04, 04 say "Informe o preco do produto: " get prec
    read
    cCod := c_id
    cCod++
    obj:prod := Cnome
    obj:preco := prec
    obj:cod := cCod
    cls
    use
Return nil

// adiciona um cliente na tabela dbf
FUNCTION addcli()
    DbGobottom()
    cod := c_id
    cod++
    @ 2, 4 say "Informe seu nome: " get Cnome
    @ 4, 4 say "Informe sua data de nascimento: " get nas
    read
    cls
    ano := Year( Date() )
    nascN := Year( nas )
    idade := ( ano - nascN )
    DbAppend()
    obj_2:codi := cod
    obj_2:cli := Cnome
    obj_2:idad := idade
    obj_2:nasc := nas
    cls
Return nil

// atualiza um cliente na tabela com dbf
FUNCTION atucli()
    input "Informe o Numero do ID que deseja: " to x 
    cls
    if DbSeek( x )
        cod := c_id
        @ 2, 4 say "Informe um novo nome: " get Cnome 
        @ 4, 4 say "Informe sua data de nascimento nova: " get nas
        read
        ano := Year( Date() )
        nascN := Year( nas )
        idade := ( ano - nascN )
        cls
        DbAppend()  
        obj_2:codi := cod
        obj_2:cli := Cnome
        obj_2:nasc := nas
        obj_2:idad := idade
    else
        wait "ESSE REGISTRO NAO EXISTE !"
    endif
Return nil

// adiciona um fornecedor na tabela dbf
FUNCTION addfor()
    use dbfornecedor alias fornece
    cls
    DbGobottom()
    cod := c_id
    cod++
    @ 2, 4 say "Informe o nome do fornecedor: " get Cnome
    @ 3, 4 say "Informe o CNPJ: " get cnpj
    read
    cls
    obj_3:name := Cnome
    obj_3:key := cod
    obj_3:Ncnpj := cnpj
    use
Return nil

// atualiza um fornecedor da tabela dbf
FUNCTION atuafor()
    use dbfornecedor alias fornece
    input "Informe o Numero do ID que deseja: " to x 
    cls
    if DbSeek( x )
        cod := c_id
        @ 2, 4 say " Informe um novo nome do forncedor: " get Cnome 
        @ 4, 4 say " Informe o novo cnpj: " get cnpj
        read
        cls
    else
        wait "ESSE REGISTRO NAO EXISTE !"
    endif
    obj_3:name := Cnome
    obj_3:key := cod
    obj_3:Ncnpj := cnpj
    use
Return nil 

//grava regitro na tabeka dbf
FUNCTION grava()
    ano := Year( Date() )
    nascN := Year( nas )
    idade := ( ano - nascN )
    REPLACE registros->c_nomes WITH Cnome
    REPLACE registros->c_datanasc WITH nas
    REPLACE registros->c_idades WITH idade
    REPLACE registros->c_id WITH cod
    DbCommit()
Return nil

//apaga um registro de qualquer tabela dbf
FUNCTION apaga()
    cls
    input "Informe o Numero do ID que deseja: " to x
    cls
    if DbSeek( x )
        DELETE
        pack
        DbCommit()
        wait "Registro apagado com sucesso"
    else
        wait "ESSE REGISTRO NAO EXISTE !"
    endif
Return nil

FUNCTION createdoc()
    if FileValid( "novo.txt" ) == .t.
        FileDelete( "novo.txt" )
    endif
    files := Fcreate( "novo.txt", FC_NORMAL )
    do while ! eof()
        Fwrite( files, str( c_id ) )
        Fwrite( files, " " )
        Fwrite( files, c_nomes, )
        Fwrite( files, " ")
        Fwrite( files, str( c_idades ) )
        Fwrite( files, " " )
        Fwrite( files, transform( c_datanasc, "@E") + CRLF)
        DbSkip()
    enddo
    wait "Registros gravados com sucesso"
Return nil

// funções do SQL
// função adicionar com insert, um registro na tabela com sql
FUNCTION addinsert()
    DbGoBottom()
    accept "informe um nome: " to name
    cod := c_cod
    cod := val( cod )
    cod := cod + 1
    cod := strzero( cod, 4 )
    date := date()
    oSql := SR_GetConnection( 1 )
    SR_BeginTransaction( cNcc )
    cSql := "insert into a_names( c_cod, c_nome, c_data ) values" + sqlExp( { cod, name, date } )
    oSql:Exec( cSql )
    SR_CommitTransaction()
Return nil

//função adiciona com replace um registro na tabela com sql
FUNCTION addreplace()
    DbGoBottom()
    cod := c_cod
    cod := val( cod )
    cod := cod + 1
    cod := strzero(cod, 4)
    cls
    accept "Informe um nome: " to name 
    ? oSql := SR_GetConnection( 1 )
    SR_BeginTransaction( cNcc )
    select x_client
    Append blank
    replace c_cod with cod
    replace c_nome with name
    replace c_data with date()
    browse()
    SR_CommitTransaction() 
Return nil

//função atualiza um registro na tabela com sql
FUNCTION upsql()
    DbGoBottom()
    cod := c_cod 
    cod := val( cod )
    cod := cod + 1
    cod := strzero( cod, 4 )
    cls
    date := date()
    accept "Informe o nome que deseja atualizar: " to nome
    accept "Informe um novo nome: " to name
    oSql := SR_GetConnection( 1 )
    SR_BeginTransaction( cNcc )
    x_client->( dbclosearea() )
    cSql := "update a_names set c_nome = " + sqlExp( name ) + "," +;
                              " c_cod  = " + sqlExp( cod  ) + "," +;
                              " c_data = " + sqlExp( date ) +;
                              "where c_nome = " + sqlExp( nome )
    oSql:Exec( cSql )
    SR_CommitTransaction()
Return nil

//função apaga um registro na tabela com sql
FUNCTION delsql()
    cls
    x_client->( dbclosearea() )
    oSql := SR_GetConnection( 1 )
    accept "informe o nome que deseja apagar: " to nome
    cSql := "delete from a_names where c_nome =" +;
    sqlExp( nome )
    oSql:Exec( cSql )
    use a_names alias x_client new via _sqlrdd
    browse()
    SR_CommitTransaction() 
Return nil

FUNCTION order()
    local p
    x_client->( dbclosearea() )
    oSql := SR_GetConnection( 1 )
    cls
    input " Informe o codigo que deseja: " to p 
    p := strzero( p, 4 )
    cSql := "select * from a_names where c_cod = " + sqlExp( p )
    use ( cSql ) alias x_client via _sqlrdd new shared
    browse()
Return nil

FUNCTION sqlExp( xCampo )
    Local cTexto
    If ValType( xCampo ) == "A"
        AEval( xCampo , { |X,I| xCampo[I] := If( ValType(X)=="D" .and. Empty(X), Nil , X ) } )
        cTexto := "(" + SR_SqlQuotedString( xCampo , SYSTEMID_POSTGR , .T. ) + ")"
    Else
       cTexto := SR_SqlQuotedString( xCampo , SYSTEMID_POSTGR , .T. ) 
    Endif
Return ( cTexto )