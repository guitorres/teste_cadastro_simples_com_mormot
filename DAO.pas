unit DAO;

interface

uses
  Mormot, SynCommons, SynDB, MormotSqlite3, SynSQLite3Static, SynSQLite3,
  SynDBFireDAC, MormotDB, Models;

type
  TDAO = class
    private
      fConexao: TSQLRestClientDB;
      fModelo: TSQLModel;
    public
      property Conexao: TSQLRestClientDB read fConexao write fConexao;
      constructor Create(nomeBancoDeDados: string = 'banco.sqlite');
      destructor Destroy;
  end;

implementation

{ TDAO }

destructor TDAO.Destroy;
begin
  fModelo.Free;
  Conexao.Free;
end;

constructor TDAO.Create(nomeBancoDeDados: string);
begin
  fModelo := TSQLModel.Create([TProduto]);
  Conexao := TSQLRestClientDB.Create(fModelo, nil, nomeBancoDeDados, TSQLRestServerDB);
  Conexao.Server.CreateMissingTables();
end;

end.
