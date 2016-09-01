unit Produto;

interface

uses
  Models,

  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, FMX.ListBox, FMX.Edit;

type
  TFormularioProduto = class(TForm)
    PanelMenu: TPanel;
    BotaoCancelar: TButton;
    BotaoConfirmar: TButton;
    ListBoxItem1: TListBoxItem;
    Label1: TLabel;
    edtProduto: TEdit;
    ListBoxItem2: TListBoxItem;
    Label2: TLabel;
    edtPReco: TEdit;
    procedure BotaoCancelarClick(Sender: TObject);
    procedure BotaoConfirmarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    fProduto: TProduto;
  public
    { Public declarations }
    property Produto: TProduto read fProduto write fProduto;
  end;

var
  FormularioProduto: TFormularioProduto;

implementation

{$R *.fmx}

procedure TFormularioProduto.BotaoCancelarClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFormularioProduto.BotaoConfirmarClick(Sender: TObject);
begin
  if edtProduto.Text = EmptyStr then
    Showmessage('informar produto')
  else if StrToFloatDef(edtPReco.Text, -1) < 0 then
    showmessage('informar preço válido')
  else
  begin
    Produto.Descricao := edtProduto.Text;
    produto.Preco := String.ToDouble(edtpreco.text);
    ModalResult := mrOk;
  end;
end;

procedure TFormularioProduto.FormShow(Sender: TObject);
begin
  if Assigned(produto) and (produto.ID > 0) then
  begin
    edtProduto.Text := Produto.Descricao;
    edtpreco.Text := Double.ToString(produto.Preco);
  end;
  if edtProduto.CanFocus then
    edtProduto.SetFocus;
end;

end.
