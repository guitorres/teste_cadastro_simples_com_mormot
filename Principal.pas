unit Principal;

interface

uses
  DAO, Models, Produto,

  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView,
  System.Generics.Collections, SynCommons;

type
  TFormularioPrincipal = class(TForm)
    PanelMenu: TPanel;
    BotaoNovoProduto: TButton;
    BotaoEditarProduto: TButton;
    BotaoRemoverProduto: TButton;
    ListaProdutos: TListView;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BotaoRemoverProdutoClick(Sender: TObject);
    procedure BotaoNovoProdutoClick(Sender: TObject);
    procedure BotaoEditarProdutoClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    fDAO: TDAO;

    procedure ListarProdutos;
    procedure RemoverProduto;
    procedure GravarProduto(produto: TProduto);
  public
    { Public declarations }
  end;

var
  FormularioPrincipal: TFormularioPrincipal;

implementation

{$R *.fmx}

procedure TFormularioPrincipal.BotaoEditarProdutoClick(Sender: TObject);
var
  produto: TProduto;
  id_selecionado: Integer;
begin
  if Assigned(ListaProdutos.Selected) then
  begin
    id_selecionado := TListViewItem(ListaProdutos.Selected).Tag;
    FormularioProduto := TFormularioProduto.Create(Application);
    produto := TProduto.CreateAndFillPrepare(fdao.Conexao, [id_selecionado]);
    produto.FillOne;
    try
      FormularioProduto.Produto := produto;
      if FormularioProduto.ShowModal = mrOk then
        GravarProduto(FormularioProduto.produto);
    finally
      FormularioProduto.Free;
      produto.Free;
    end;
  end;
end;

procedure TFormularioPrincipal.BotaoNovoProdutoClick(Sender: TObject);
var
  produto: TProduto;
begin
  FormularioProduto := TFormularioProduto.Create(Application);
  produto := TProduto.Create;
  try
    FormularioProduto.Produto := produto;
    if FormularioProduto.ShowModal = mrOk then
      GravarProduto(FormularioProduto.produto);
  finally
    FormularioProduto.Free;
    produto.Free;
  end;
end;

procedure TFormularioPrincipal.BotaoRemoverProdutoClick(Sender: TObject);
begin
  RemoverProduto;
end;

procedure TFormularioPrincipal.Button1Click(Sender: TObject);
var
  produto: TProduto;
begin
  fdao.Conexao.Delete(TProduto, 'id > 0');

  produto := tproduto.CreateAndFillPrepare(AnyTextFileToRawUTF8(IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'produtos.json'));
  while produto.FillOne do
    fDAO.Conexao.Add(produto, True);

  ListarProdutos;
end;

procedure TFormularioPrincipal.FormCreate(Sender: TObject);
begin
  fDAO := TDAO.Create();
end;

procedure TFormularioPrincipal.FormDestroy(Sender: TObject);
begin
  fDAO.Free;
end;

procedure TFormularioPrincipal.FormShow(Sender: TObject);
begin
  ListarProdutos;
end;

procedure TFormularioPrincipal.GravarProduto(produto: TProduto);
begin
  fdao.Conexao.AddOrUpdate(produto);
  ListarProdutos;
end;

procedure TFormularioPrincipal.ListarProdutos;
var
  produto: TProduto;
  produtos: TObjectList<TProduto>;
begin
  Produtos := fDAO.Conexao.RetrieveList<TProduto>('', []);
  ListaProdutos.Items.Clear;

  for produto in Produtos do
    with ListaProdutos.Items.Add do
    begin
      Tag := produto.ID;
      Text := produto.Descricao;
      Detail := produto.PrecoFormatado;
    end;
end;

procedure TFormularioPrincipal.RemoverProduto;
var
  item: TListViewItem;
begin
  item := TListViewItem(ListaProdutos.Selected);
  if Assigned(item) then
  begin
    fDAO.Conexao.Delete(TProduto, item.Tag);
    ListaProdutos.Items.Delete(item.Index);
  end;
end;

end.
