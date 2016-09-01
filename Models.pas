unit Models;

interface

uses
  Mormot, SynCommons, MormotSQLite3, SynDBFireDAC, System.SysUtils;

type
  TProduto = class(TSQLRecord)
    private
      fDescricao: RawUTF8;
      fPreco: Double;
    public
      function PrecoFormatado: string;
    published
      property Descricao: RawUTF8 read fDescricao write fDescricao;
      property Preco: Double read fPreco write fPreco;
  end;

implementation


{ TProduto }

function TProduto.PrecoFormatado: string;
begin
  Result := Format('R$ %.2f', [Self.Preco]);
end;

end.
