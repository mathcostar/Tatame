unit Tatame.View.Login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Tatame.DataModule;

type
  TfrmLogin = class(TForm)
    lblUsuario: TLabel;
    pnlLogin: TPanel;
    pnlPrimeiroAcesso: TPanel;
    lblSenha: TLabel;
    edtUsuario: TEdit;
    edtSenha: TEdit;
    btnEntrar: TButton;
    lblPrimeiroAcesso: TLabel;
    chkMostrarSenha: TCheckBox;
    procedure btnEntrarClick(Sender: TObject);
    procedure lblPrimeiroAcessoClick(Sender: TObject);
    procedure chkMostrarSenhaClick(Sender: TObject);
  private
    procedure Entrar;
    procedure LimparCampos;
  end;

var
  frmLogin: TfrmLogin;

implementation

uses
  Tatame.Service.Instrutor,
  Tatame.View.InstrutorCadastroNovo,
  Tatame.View.TelaPrincipal;

{$R *.dfm}

procedure TfrmLogin.btnEntrarClick(Sender: TObject);
begin
  Entrar();
end;

procedure TfrmLogin.chkMostrarSenhaClick(Sender: TObject);
begin
  if chkMostrarSenha.Checked then
    edtSenha.PasswordChar := #0
  else
    edtSenha.PasswordChar := '*';
end;

procedure TfrmLogin.Entrar;
var
  lInstrutorService: TInstrutorService;
  lTelaPrincipal: TfrmPrincipal;
begin
  lInstrutorService := TInstrutorService.Create();
  try
    try
      if not lInstrutorService.Autenticar(edtUsuario.Text, edtSenha.Text) then
        ShowMessage('Login inválido.' + sLineBreak + 'Caso seja seu primeiro acesso, por favor clique abaixo em ''Primeiro acesso''.')
      else
        begin
          lTelaPrincipal := TfrmPrincipal.Create(nil);
          try
            Self.Hide();
            LimparCampos();
            lTelaPrincipal.ShowModal();
          finally
            if lTelaPrincipal.FLogoff then
              Self.Show()
            else
              Application.Terminate;
            FreeAndNil(lTelaPrincipal);
          end;
        end;
    except
      on E: Exception do
        ShowMessage(E.Message);
    end;
  finally
    lInstrutorService.Free();
  end;
end;

procedure TfrmLogin.lblPrimeiroAcessoClick(Sender: TObject);
var
  lInstrutorCadastro: TfrmNovoInstrutor;
begin
  lInstrutorCadastro := TfrmNovoInstrutor.Create(nil);
  try
    lInstrutorCadastro.ShowModal();
  finally
    FreeAndNil(lInstrutorCadastro);
  end;
end;

procedure TfrmLogin.LimparCampos;
begin
  edtUsuario.Clear();
  edtSenha.Clear();
end;

end.
