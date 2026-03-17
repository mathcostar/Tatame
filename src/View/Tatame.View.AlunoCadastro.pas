unit Tatame.View.AlunoCadastro;

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
  Tatame.Model.Aluno,
  System.UITypes;

type
  TfrmCadastroAluno = class(TForm)
    pnlBotoes: TPanel;
    btnExcluir: TButton;
    btnEditar: TButton;
    btnNovo: TButton;
    pnlAlunos: TPanel;
    edtPesquisar: TEdit;
    sgdAlunos: TStringGrid;
    procedure FormShow(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure sgdAlunosClick(Sender: TObject);
    procedure edtPesquisarChange(Sender: TObject);
  private
    FAlunos: TObjectList<TAlunoModel>;
    FTodosAlunos: TObjectList<TAlunoModel>;
    FAlunoSelecionado: TAlunoModel;

    procedure CarregarAlunos;
    procedure PreencherGrid;
    procedure AjustarColunas;
    procedure AbrirCadastro(const pAluno: TAlunoModel);
    procedure Pesquisar;
  public
    destructor Destroy; override;
  end;

implementation

uses
  Tatame.Service.Aluno,
  Tatame.View.AlunoCadastroNovo,
  Math;

{$R *.dfm}

destructor TfrmCadastroAluno.Destroy;
begin
  FAlunos.Free();
  FTodosAlunos.Free();

  inherited;
end;

procedure TfrmCadastroAluno.FormShow(Sender: TObject);
begin
  sgdAlunos.ColCount := 4;
  sgdAlunos.RowCount := 2;
  sgdAlunos.FixedRows := 1;
  sgdAlunos.FixedCols := 0;
  sgdAlunos.Options := sgdAlunos.Options + [goRowSelect];

  sgdAlunos.Cells[0, 0] := 'Nome';
  sgdAlunos.Cells[1, 0] := 'Faixa';
  sgdAlunos.Cells[2, 0] := 'Instrutor';
  sgdAlunos.Cells[3, 0] := 'Cidade';

  AjustarColunas();
  CarregarAlunos();
end;

procedure TfrmCadastroAluno.AjustarColunas;
var
  lLarguraTotal: Integer;
begin
  lLarguraTotal := sgdAlunos.ClientWidth;

  sgdAlunos.ColWidths[0] := Round(lLarguraTotal * 0.35);
  sgdAlunos.ColWidths[1] := Round(lLarguraTotal * 0.15);
  sgdAlunos.ColWidths[2] := Round(lLarguraTotal * 0.30);
  sgdAlunos.ColWidths[3] := Round(lLarguraTotal * 0.20);
end;

procedure TfrmCadastroAluno.CarregarAlunos;
var
  lAlunoService: TAlunoService;
begin
  FreeAndNil(FTodosAlunos);
  FreeAndNil(FAlunos);
  FAlunoSelecionado := nil;

  lAlunoService := TAlunoService.Create();
  try
    FTodosAlunos := lAlunoService.CarregarLista();
  finally
    lAlunoService.Free();
  end;

  edtPesquisar.Text := '';

  Pesquisar();
end;

procedure TfrmCadastroAluno.Pesquisar;
var
  lAlunoService: TAlunoService;
begin
  FreeAndNil(FAlunos);

  lAlunoService := TAlunoService.Create;
  try
    FAlunos := lAlunoService.PesquisarPorFiltro(edtPesquisar.Text);
  finally
    lAlunoService.Free;
  end;

  FAlunoSelecionado := nil;
  PreencherGrid();
end;

procedure TfrmCadastroAluno.PreencherGrid;
var
  I: Integer;
  lAluno: TAlunoModel;
begin
  sgdAlunos.RowCount := Max(2, FAlunos.Count + 1);

  for i := 0 to FAlunos.Count - 1 do
  begin
    lAluno := FAlunos[i];

    sgdAlunos.Cells[0, i + 1] := lAluno.Nome;
    sgdAlunos.Cells[1, i + 1] := lAluno.NomeFaixa;
    sgdAlunos.Cells[2, i + 1] := lAluno.NomeInstrutor;
    sgdAlunos.Cells[3, i + 1] := lAluno.Endereco.Cidade;
  end;
end;

procedure TfrmCadastroAluno.sgdAlunosClick(Sender: TObject);
var
  lLinha: Integer;
  lIndice: Integer;
begin
  lLinha := sgdAlunos.Row;

  if lLinha < 1 then
    begin
      FAlunoSelecionado := nil;
      Exit();
    end;

  lIndice := lLinha - 1;

  if (lIndice >= 0) and (lIndice < FAlunos.Count) then
    FAlunoSelecionado := FAlunos[lIndice]
  else
    FAlunoSelecionado := nil;
end;

procedure TfrmCadastroAluno.edtPesquisarChange(Sender: TObject);
begin
  Pesquisar();
end;

procedure TfrmCadastroAluno.AbrirCadastro(const pAluno: TAlunoModel);
var
  lNovoAluno: TfrmNovoAluno;
begin
  lNovoAluno := TfrmNovoAluno.Create(nil);
  try
    if Assigned(pAluno) then
      lNovoAluno.CarregarAluno(pAluno);

    if lNovoAluno.ShowModal() = mrOk then
      CarregarAlunos();
  finally
    lNovoAluno.Free();
  end;
end;

procedure TfrmCadastroAluno.btnNovoClick(Sender: TObject);
begin
  AbrirCadastro(nil);
end;

procedure TfrmCadastroAluno.btnEditarClick(Sender: TObject);
begin
  if not Assigned(FAlunoSelecionado) then
    begin
      ShowMessage('Por favor, selecione um aluno para editar.');
      Exit();
    end;

  AbrirCadastro(FAlunoSelecionado);
end;

procedure TfrmCadastroAluno.btnExcluirClick(Sender: TObject);
var
  lAlunoService: TAlunoService;
begin
  if not Assigned(FAlunoSelecionado) then
    begin
      ShowMessage('Por favor, selecione um aluno para excluir.');
      Exit();
    end;

  if MessageDlg('Deseja realmente excluir o aluno "' + FAlunoSelecionado.Nome + '"?',
    mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit();

  lAlunoService := TAlunoService.Create();
  try
    try
      lAlunoService.Excluir(FAlunoSelecionado.ID);
      ShowMessage('Aluno excluído com sucesso.');
      CarregarAlunos();
    except
      on E: Exception do
        ShowMessage('Erro ao excluir: ' + E.Message);
    end;
  finally
    lAlunoService.Free();
  end;
end;

end.
