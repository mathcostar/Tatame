unit Tatame.View.InstrutorCadastroNovo;

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
  Tatame.Model.Instrutor,
  Tatame.Model.Endereco;

type
  TfrmNovoInstrutor = class(TForm)
    grpDados: TGroupBox;
    lblNome: TLabel;
    lblUsuario: TLabel;
    edtNome: TEdit;
    edtUsuario: TEdit;
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
    lblSenha: TLabel;
    edtSenha: TEdit;
    chkMostrarSenha: TCheckBox;
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure chkMostrarSenhaClick(Sender: TObject);
    procedure edtCEPExit(Sender: TObject);
  private
    FInstrutorID: Integer;
    FCEPBuscando: Boolean;

    procedure Salvar;
    procedure BuscarCEP;

    procedure OnCEPEncontrado(const pEndereco: TEnderecoModel);
    procedure OnCEPErro(const pMensagem: string);

    function Validar: Boolean;
  public
    procedure CarregarInstrutor(const pInstrutor: TInstrutorModel);
  end;

implementation

uses
  Tatame.Service.Instrutor,
  Tatame.Service.ViaCEP;

{$R *.dfm}

procedure TfrmNovoInstrutor.CarregarInstrutor(const pInstrutor: TInstrutorModel);
begin
  FInstrutorID := pInstrutor.ID;

  edtNome.Text       := pInstrutor.Nome;
  edtUsuario.Text    := pInstrutor.Usuario;
  edtSenha.Text      := pInstrutor.Senha;
  edtCEP.Text        := pInstrutor.Endereco.CEP;
  edtLogradouro.Text := pInstrutor.Endereco.Logradouro;
  edtEstado.Text     := pInstrutor.Endereco.Estado;
  edtCidade.Text     := pInstrutor.Endereco.Cidade;
  edtBairro.Text     := pInstrutor.Endereco.Bairro;
end;

procedure TfrmNovoInstrutor.edtCEPExit(Sender: TObject);
begin
  BuscarCEP();
end;

procedure TfrmNovoInstrutor.BuscarCEP;
begin
  if edtCEP.Text = '' then
    Exit;

  if FCEPBuscando then
    Exit;

  FCEPBuscando              := True;
  grpEndereco.Enabled       := False;
  lblConsultandoCEP.Visible := True;

  TCEPBuscaThread.Create(edtCEP.Text, OnCEPEncontrado, OnCEPErro).Start;
end;

procedure TfrmNovoInstrutor.OnCEPEncontrado(const pEndereco: TEnderecoModel);
begin
  edtLogradouro.Text := pEndereco.Logradouro;
  edtBairro.Text     := pEndereco.Bairro;
  edtCidade.Text     := pEndereco.Cidade;
  edtEstado.Text     := pEndereco.Estado;

  lblConsultandoCEP.Visible := False;
  grpEndereco.Enabled       := True;
  FCEPBuscando              := False;
end;

procedure TfrmNovoInstrutor.OnCEPErro(const pMensagem: string);
begin
  lblConsultandoCEP.Visible := False;
  grpEndereco.Enabled       := True;
  FCEPBuscando              := False;

  ShowMessage(pMensagem);
end;

procedure TfrmNovoInstrutor.btnGravarClick(Sender: TObject);
begin
  Salvar();
end;

procedure TfrmNovoInstrutor.btnCancelarClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmNovoInstrutor.chkMostrarSenhaClick(Sender: TObject);
begin
  if chkMostrarSenha.Checked then
    edtSenha.PasswordChar := #0
  else
    edtSenha.PasswordChar := '*';
end;

procedure TfrmNovoInstrutor.Salvar;
var
  lInstrutorService: TInstrutorService;
  lInstrutor: TInstrutorModel;
begin
  if not Validar then
  begin
    ShowMessage('Por favor, preencha todos os campos.');
    Exit;
  end;

  lInstrutor := TInstrutorModel.Create();
  try
    lInstrutor.ID                  := FInstrutorID;
    lInstrutor.Nome                := edtNome.Text;
    lInstrutor.Usuario             := edtUsuario.Text;
    lInstrutor.Senha               := edtSenha.Text;
    lInstrutor.Endereco.CEP        := edtCEP.Text;
    lInstrutor.Endereco.Logradouro := edtLogradouro.Text;
    lInstrutor.Endereco.Estado     := edtEstado.Text;
    lInstrutor.Endereco.Cidade     := edtCidade.Text;
    lInstrutor.Endereco.Bairro     := edtBairro.Text;

    lInstrutorService := TInstrutorService.Create;
    try
      try
        lInstrutorService.Salvar(lInstrutor);
        ShowMessage('Instrutor salvo com sucesso.');
        ModalResult := mrOk;
      except
        on E: Exception do
          ShowMessage('Erro ao salvar: ' + E.Message);
      end;
    finally
      lInstrutorService.Free();
    end;
  finally
    lInstrutor.Free();
  end;
end;

function TfrmNovoInstrutor.Validar: Boolean;
begin
  Result := (edtNome.Text <> '')       and
            (edtCEP.Text <> '')        and
            (edtLogradouro.Text <> '') and
            (edtEstado.Text <> '')     and
            (edtCidade.Text <> '')     and
            (edtBairro.Text <> '')     and
            (edtUsuario.Text <> '')    and
            (edtSenha.Text <> '');
end;

end.
