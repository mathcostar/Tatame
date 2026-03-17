unit Tatame.View.AlunoCadastroNovo;

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
  Tatame.Model.Aluno,
  Tatame.Model.Instrutor,
  Tatame.Model.Endereco,
  System.Generics.Collections;

type
  TfrmNovoAluno = class(TForm)
    grpDados: TGroupBox;
    lblNome: TLabel;
    lblFaixa: TLabel;
    lblInstrutor: TLabel;
    edtNome: TEdit;
    cmbFaixa: TComboBox;
    cmbInstrutor: TComboBox;
    grpEndereco: TGroupBox;
    lblCEP: TLabel;
    lblLogradouro: TLabel;
    lblEstado: TLabel;
    lblCidade: TLabel;
    lblBairro: TLabel;
    lblConsultandoCEP: TLabel;
    edtCEP: TEdit;
    edtLogradouro: TEdit;
    edtEstado: TEdit;
    edtCidade: TEdit;
    edtBairro: TEdit;
    btnCancelar: TButton;
    btnGravar: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure edtCEPExit(Sender: TObject);
  private
    FAlunoID     : Integer;
    FInstrutores : TObjectList<TInstrutorModel>;
    FCEPBuscando : Boolean;

    procedure PreencherFaixas;
    procedure PreencherInstrutores;
    procedure Salvar;
    procedure BuscarCEP;

    procedure OnCEPEncontrado(const pEndereco: TEnderecoModel);
    procedure OnCEPErro(const pMensagem: string);

    function Validar: Boolean;
  public
    destructor Destroy; override;

    procedure CarregarAluno(const pAluno: TAlunoModel);
  end;

implementation

uses
  Tatame.Service.Aluno,
  Tatame.Service.Instrutor,
  Tatame.Service.ViaCEP;

{$R *.dfm}

destructor TfrmNovoAluno.Destroy;
begin
  FInstrutores.Free;
  inherited;
end;

procedure TfrmNovoAluno.FormCreate(Sender: TObject);
begin
  FCEPBuscando := False;
  PreencherFaixas();
  PreencherInstrutores();
end;

procedure TfrmNovoAluno.PreencherFaixas;
begin
  cmbFaixa.Items.Clear;
  cmbFaixa.Items.AddObject('Branca',  TObject(1));
  cmbFaixa.Items.AddObject('Amarela', TObject(2));
  cmbFaixa.Items.AddObject('Laranja', TObject(3));
  cmbFaixa.Items.AddObject('Verde',   TObject(4));
  cmbFaixa.Items.AddObject('Azul',    TObject(5));
  cmbFaixa.Items.AddObject('Roxa',    TObject(6));
  cmbFaixa.Items.AddObject('Marrom',  TObject(7));
  cmbFaixa.Items.AddObject('Preta',   TObject(8));
end;

procedure TfrmNovoAluno.PreencherInstrutores;
var
  lInstrutorService: TInstrutorService;
  lInstrutor: TInstrutorModel;
begin
  lInstrutorService := TInstrutorService.Create;
  try
    FInstrutores := lInstrutorService.CarregarLista;
  finally
    lInstrutorService.Free();
  end;

  cmbInstrutor.Items.Clear();

  for lInstrutor in FInstrutores do
    cmbInstrutor.Items.AddObject(lInstrutor.Nome, lInstrutor);
end;

function TfrmNovoAluno.Validar: Boolean;
begin
  Result := (edtNome.Text <> '')       and
            (edtCEP.Text <> '')        and
            (edtLogradouro.Text <> '') and
            (edtEstado.Text <> '')     and
            (edtCidade.Text <> '')     and
            (edtBairro.Text <> '')     and
            (cmbFaixa.ItemIndex > -1)  and
            (cmbInstrutor.ItemIndex > -1);
end;

procedure TfrmNovoAluno.CarregarAluno(const pAluno: TAlunoModel);
var
  I: Integer;
begin
  FAlunoID := pAluno.ID;

  edtNome.Text       := pAluno.Nome;
  edtCEP.Text        := pAluno.Endereco.CEP;
  edtLogradouro.Text := pAluno.Endereco.Logradouro;
  edtEstado.Text     := pAluno.Endereco.Estado;
  edtCidade.Text     := pAluno.Endereco.Cidade;
  edtBairro.Text     := pAluno.Endereco.Bairro;

  for I := 0 to cmbFaixa.Items.Count - 1 do
    if Integer(cmbFaixa.Items.Objects[I]) = pAluno.FaixaID then
      begin
        cmbFaixa.ItemIndex := I;
        Break;
      end;

  for I := 0 to cmbInstrutor.Items.Count - 1 do
    if TInstrutorModel(cmbInstrutor.Items.Objects[I]).ID = pAluno.InstrutorID then
      begin
        cmbInstrutor.ItemIndex := I;
        Break;
      end;
end;

procedure TfrmNovoAluno.edtCEPExit(Sender: TObject);
begin
  BuscarCEP;
end;

procedure TfrmNovoAluno.BuscarCEP;
begin
  if edtCEP.Text = '' then
    Exit();

  if FCEPBuscando then
    Exit();

  FCEPBuscando              := True;
  grpEndereco.Enabled       := False;
  lblConsultandoCEP.Visible := True;

  TCEPBuscaThread.Create(edtCEP.Text, OnCEPEncontrado, OnCEPErro).Start;
end;

procedure TfrmNovoAluno.OnCEPEncontrado(const pEndereco: TEnderecoModel);
begin
  edtLogradouro.Text := pEndereco.Logradouro;
  edtBairro.Text     := pEndereco.Bairro;
  edtCidade.Text     := pEndereco.Cidade;
  edtEstado.Text     := pEndereco.Estado;

  lblConsultandoCEP.Visible := False;
  grpEndereco.Enabled       := True;
  FCEPBuscando              := False;
end;

procedure TfrmNovoAluno.OnCEPErro(const pMensagem: string);
begin
  lblConsultandoCEP.Visible := False;
  grpEndereco.Enabled       := True;
  FCEPBuscando              := False;

  ShowMessage(pMensagem);
end;

procedure TfrmNovoAluno.btnGravarClick(Sender: TObject);
begin
  Salvar();
end;

procedure TfrmNovoAluno.btnCancelarClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmNovoAluno.Salvar;
var
  lAlunoService: TAlunoService;
  lAluno: TAlunoModel;
begin
  if not Validar then
    begin
      ShowMessage('Por favor, preencha todos os campos.');
      Exit();
    end;

  lAluno := TAlunoModel.Create;
  try
    lAluno.ID          := FAlunoID;
    lAluno.Nome        := edtNome.Text;
    lAluno.FaixaID     := SmallInt(Integer(cmbFaixa.Items.Objects[cmbFaixa.ItemIndex]));
    lAluno.InstrutorID := TInstrutorModel(cmbInstrutor.Items.Objects[cmbInstrutor.ItemIndex]).ID;
    lAluno.Endereco.CEP        := edtCEP.Text;
    lAluno.Endereco.Logradouro := edtLogradouro.Text;
    lAluno.Endereco.Estado     := edtEstado.Text;
    lAluno.Endereco.Cidade     := edtCidade.Text;
    lAluno.Endereco.Bairro     := edtBairro.Text;

    lAlunoService := TAlunoService.Create;
    try
      try
        lAlunoService.Salvar(lAluno);
        ShowMessage('Aluno salvo com sucesso.');
        ModalResult := mrOk;
      except
        on E: Exception do
          ShowMessage('Erro ao salvar: ' + E.Message);
      end;
    finally
      lAlunoService.Free();
    end;
  finally
    lAluno.Free();
  end;
end;

end.
