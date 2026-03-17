unit Tatame.View.InstrutorCadastro;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.Grids,
  System.Generics.Collections,
  Tatame.Model.Instrutor,
  System.UITypes;

type
  TfrmCadastroInstrutor = class(TForm)
    pnlBotoes: TPanel;
    pnlInstrutores: TPanel;
    btnExcluir: TButton;
    btnEditar: TButton;
    btnNovo: TButton;
    sgdInstrutores: TStringGrid;
    edtPesquisar: TEdit;
    procedure btnNovoClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sgdInstrutoresClick(Sender: TObject);
    procedure edtPesquisarChange(Sender: TObject);
  private
    FInstrutores: TObjectList<TInstrutorModel>;
    FInstrutorSelecionado: TInstrutorModel;

    procedure CarregarInstrutores;
    procedure PreencherGrid;
    procedure AbrirCadastro(const pInstrutor: TInstrutorModel);
  public
    destructor Destroy; override;
  end;

implementation

uses
  Tatame.View.InstrutorCadastroNovo,
  Tatame.Service.Instrutor;

{$R *.dfm}

destructor TfrmCadastroInstrutor.Destroy;
begin
  FInstrutores.Free();

  inherited;
end;

procedure TfrmCadastroInstrutor.edtPesquisarChange(Sender: TObject);
var
  lService: TInstrutorService;
begin
  FreeAndNil(FInstrutores);
  FInstrutorSelecionado := nil;

  lService := TInstrutorService.Create;
  try
    FInstrutores := lService.PesquisarPorFiltro(edtPesquisar.Text);
  finally
    lService.Free;
  end;

  PreencherGrid;
end;

procedure TfrmCadastroInstrutor.FormShow(Sender: TObject);
begin
  sgdInstrutores.ColCount := 4;
  sgdInstrutores.RowCount := 2;
  sgdInstrutores.FixedRows := 1;
  sgdInstrutores.FixedCols := 0;
  sgdInstrutores.Options := sgdInstrutores.Options + [goRowSelect];

  sgdInstrutores.ColWidths[0] := 200;
  sgdInstrutores.ColWidths[1] := 120;
  sgdInstrutores.ColWidths[2] := 150;
  sgdInstrutores.ColWidths[3] := 80;

  sgdInstrutores.Cells[0, 0] := 'Nome';
  sgdInstrutores.Cells[1, 0] := 'Usuário';
  sgdInstrutores.Cells[2, 0] := 'Cidade';
  sgdInstrutores.Cells[3, 0] := 'Estado';

  CarregarInstrutores();
end;

procedure TfrmCadastroInstrutor.CarregarInstrutores;
var
  lInstrutorService: TInstrutorService;
begin
  FreeAndNil(FInstrutores);
  FInstrutorSelecionado := nil;

  lInstrutorService := TInstrutorService.Create();
  try
    FInstrutores := lInstrutorService.CarregarLista();
  finally
    lInstrutorService.Free();
  end;

  PreencherGrid();
end;

procedure TfrmCadastroInstrutor.PreencherGrid;
var
  lInstrutor: TInstrutorModel;
  lLinha: Integer;
begin
  if FInstrutores.Count = 0 then
    sgdInstrutores.RowCount := 2
  else
    sgdInstrutores.RowCount := FInstrutores.Count + 1;

  for lLinha := 1 to sgdInstrutores.RowCount - 1 do
    begin
      sgdInstrutores.Cells[0, lLinha] := '';
      sgdInstrutores.Cells[1, lLinha] := '';
      sgdInstrutores.Cells[2, lLinha] := '';
      sgdInstrutores.Cells[3, lLinha] := '';
    end;

  lLinha := 1;
  for lInstrutor in FInstrutores do
    begin
      sgdInstrutores.Cells[0, lLinha] := lInstrutor.Nome;
      sgdInstrutores.Cells[1, lLinha] := lInstrutor.Usuario;
      sgdInstrutores.Cells[2, lLinha] := lInstrutor.Endereco.Cidade;
      sgdInstrutores.Cells[3, lLinha] := lInstrutor.Endereco.Estado;

      Inc(lLinha);
    end;
end;

procedure TfrmCadastroInstrutor.sgdInstrutoresClick(Sender: TObject);
var
  lLinhaSelecionada: Integer;
  lIndice: Integer;
begin
  lLinhaSelecionada := sgdInstrutores.Row;

  if lLinhaSelecionada < 1 then
    begin
      FInstrutorSelecionado := nil;
      Exit();
    end;

  lIndice := lLinhaSelecionada - 1;

  if (lIndice >= 0) and (lIndice < FInstrutores.Count) then
    FInstrutorSelecionado := FInstrutores[lIndice]
  else
    FInstrutorSelecionado := nil;
end;

procedure TfrmCadastroInstrutor.AbrirCadastro(const pInstrutor: TInstrutorModel);
var
  lCadastrarInstrutor: TfrmNovoInstrutor;
begin
  lCadastrarInstrutor := TfrmNovoInstrutor.Create(nil);
  try
    if Assigned(pInstrutor) then
      lCadastrarInstrutor.CarregarInstrutor(pInstrutor);

    if lCadastrarInstrutor.ShowModal() = mrOk then
      CarregarInstrutores();
  finally
    lCadastrarInstrutor.Free();
  end;
end;

procedure TfrmCadastroInstrutor.btnNovoClick(Sender: TObject);
begin
  AbrirCadastro(nil);
end;

procedure TfrmCadastroInstrutor.btnEditarClick(Sender: TObject);
begin
  if not Assigned(FInstrutorSelecionado) then
    begin
      ShowMessage('Por favor, selecione um instrutor para editar.');
      Exit();
    end;

  AbrirCadastro(FInstrutorSelecionado);
end;

procedure TfrmCadastroInstrutor.btnExcluirClick(Sender: TObject);
var
  lInstrutorService: TInstrutorService;
begin
  if not Assigned(FInstrutorSelecionado) then
    begin
      ShowMessage('Por favor, selecione um instrutor para excluir.');
      Exit();
    end;

  if MessageDlg('Deseja realmente excluir o instrutor "' + FInstrutorSelecionado.Nome + '"?',
    mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit();

  lInstrutorService := TInstrutorService.Create();
  try
    try
      lInstrutorService.Excluir(FInstrutorSelecionado.ID);
      ShowMessage('Instrutor excluído com sucesso.');
      CarregarInstrutores();
    except
      on E: Exception do
        ShowMessage('Erro ao excluir: ' + E.Message);
    end;
  finally
    lInstrutorService.Free();
  end;
end;

end.
