program CadastroProduto;

uses
  System.StartUpCopy,
  FMX.Forms,
  Principal in 'Principal.pas' {FormularioPrincipal},
  Models in 'Models.pas',
  DAO in 'DAO.pas',
  Produto in 'Produto.pas' {FormularioProduto};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormularioPrincipal, FormularioPrincipal);
  //Application.CreateForm(TFormularioProduto, FormularioProduto);
  Application.Run;
end.
