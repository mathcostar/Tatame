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
  Tatame.Model.Instrutor;

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

    procedure Salvar;
    procedure BuscarCEP;
  public
    procedure CarregarInstrutor(const pInstrutor: TInstrutorModel);
  end;

implementation

uses
  Tatame.Service.Instrutor,
  Tatame.Service.ViaCEP,
  Tatame.Model.Endereco;

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

procedure TfrmNovoInstrutor.edtCEPExit(Sender: TObject);
begin
  BuscarCEP();
end;

procedure TfrmNovoInstrutor.BuscarCEP;
var
  lViaCEPService: TViaCEPService;
  lEndereco: TEnderecoModel;
begin
  if edtCEP.Text = '' then
    Exit;

  lViaCEPService := TViaCEPService.Create();
  try
    try
      lEndereco := lViaCEPService.BuscarEndereco(edtCEP.Text);
      try
        if lEndereco.Logradouro = '' then
          begin
            ShowMessage('CEP não encontrado.');
            Exit;
          end;

        edtLogradouro.Text := lEndereco.Logradouro;
        edtBairro.Text     := lEndereco.Bairro;
        edtCidade.Text     := lEndereco.Cidade;
        edtEstado.Text     := lEndereco.Estado;
      finally
        lEndereco.Free();
      end;
    except
      on E: Exception do
        ShowMessage('Erro ao buscar CEP: ' + E.Message);
    end;
  finally
    lViaCEPService.Free();
  end;
end;

procedure TfrmNovoInstrutor.Salvar;
var
  lInstrutorService: TInstrutorService;
  lInstrutor: TInstrutorModel;
begin
  lInstrutor := TInstrutorModel.Create();
  try
    lInstrutor.ID              := FInstrutorID;
    lInstrutor.Nome            := edtNome.Text;
    lInstrutor.Usuario         := edtUsuario.Text;
    lInstrutor.Senha           := edtSenha.Text;
    lInstrutor.Endereco.CEP        := edtCEP.Text;
    lInstrutor.Endereco.Logradouro := edtLogradouro.Text;
    lInstrutor.Endereco.Estado     := edtEstado.Text;
    lInstrutor.Endereco.Cidade     := edtCidade.Text;
    lInstrutor.Endereco.Bairro     := edtBairro.Text;

    lInstrutorService := TInstrutorService.Create();
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

end.
