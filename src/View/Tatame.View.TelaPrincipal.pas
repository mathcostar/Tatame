unit Tatame.View.TelaPrincipal;

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
  Vcl.ToolWin,
  Vcl.ComCtrls,
  Vcl.ExtCtrls,
  Vcl.ButtonGroup,
  Vcl.Buttons,
  Vcl.StdCtrls,
  Vcl.Imaging.pngimage,
  System.ImageList,
  Vcl.ImgList;

type
  TfrmPrincipal = class(TForm)
    pnlBotoes: TPanel;
    pnlLogo: TPanel;
    btnInstrutores: TSpeedButton;
    btnAlunos: TSpeedButton;
    btnRelatorioInstrutores: TSpeedButton;
    btnRelatorioAlunos: TSpeedButton;
    btnLogoff: TSpeedButton;
    pnlSecoes: TPanel;
    lblSecaoCadastro: TLabel;
    lblSecaoRelatorios: TLabel;
    lblDivisao: TLabel;
    imgPrincipal: TImage;
    imglstPrincipal: TImageList;
    lblDivisaoDois: TLabel;
    procedure btnInstrutoresClick(Sender: TObject);
    procedure btnAlunosClick(Sender: TObject);
    procedure btnLogoffClick(Sender: TObject);
    procedure btnRelatorioInstrutoresClick(Sender: TObject);
    procedure btnRelatorioAlunosClick(Sender: TObject);
  public
    FLogoff: Boolean;
  end;

implementation

uses
  Tatame.View.InstrutorCadastro,
  Tatame.View.AlunoCadastro,
  Tatame.View.RelatorioInstrutores,
  Tatame.View.RelatorioAlunos;

{$R *.dfm}

procedure TfrmPrincipal.btnInstrutoresClick(Sender: TObject);
var
  lInstrutorCadastro: TfrmCadastroInstrutor;
begin
  lInstrutorCadastro := TfrmCadastroInstrutor.Create(nil);
  try
    lInstrutorCadastro.ShowModal();
  finally
    FreeAndNil(lInstrutorCadastro);
  end;
end;

procedure TfrmPrincipal.btnLogoffClick(Sender: TObject);
begin
  FLogoff := True;
  ModalResult := mrCancel;
end;

procedure TfrmPrincipal.btnRelatorioAlunosClick(Sender: TObject);
var
  lRelatorioAlunos: TfrmRelatorioAlunos;
begin
  lRelatorioAlunos := TfrmRelatorioAlunos.Create(nil);
  try
    lRelatorioAlunos.RLReport1.Preview();
  finally
    FreeAndNil(lRelatorioAlunos);
  end;
end;

procedure TfrmPrincipal.btnRelatorioInstrutoresClick(Sender: TObject);
var
  lRelatorioInstrutores: TfrmRelatorioInstrutores;
begin
  lRelatorioInstrutores := TfrmRelatorioInstrutores.Create(nil);
  try
    lRelatorioInstrutores.RLReport1.Preview();
  finally
    FreeAndNil(lRelatorioInstrutores);
  end;
end;

procedure TfrmPrincipal.btnAlunosClick(Sender: TObject);
var
  lAlunoCadastro: TfrmCadastroAluno;
begin
  lAlunoCadastro := TfrmCadastroAluno.Create(nil);
  try
    lAlunoCadastro.ShowModal();
  finally
    FreeAndNil(lAlunoCadastro);
  end;
end;

end.
