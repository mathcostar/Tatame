program Tatame;

uses
  Vcl.Forms,
  Tatame.View.Login in 'src\View\Tatame.View.Login.pas' {frmLogin},
  Tatame.DataModule in 'src\DataModule\Tatame.DataModule.pas' {dmPrincipal},
  Tatame.View.InstrutorCadastro in 'src\View\Tatame.View.InstrutorCadastro.pas',
  Tatame.Model.Instrutor in 'src\Model\Tatame.Model.Instrutor.pas',
  Tatame.Model.Endereco in 'src\Model\Tatame.Model.Endereco.pas',
  Tatame.Model.Aluno in 'src\Model\Tatame.Model.Aluno.pas',
  Tatame.View.TelaPrincipal in 'src\View\Tatame.View.TelaPrincipal.pas',
  Tatame.View.InstrutorCadastroNovo in 'src\View\Tatame.View.InstrutorCadastroNovo.pas' {frmNovoInstrutor},
  Tatame.Service.Instrutor in 'src\Service\Tatame.Service.Instrutor.pas',
  Tatame.DAO.Instrutor in 'src\DAO\Tatame.DAO.Instrutor.pas',
  Tatame.DAO.Aluno in 'src\DAO\Tatame.DAO.Aluno.pas',
  Tatame.Service.Aluno in 'src\Service\Tatame.Service.Aluno.pas',
  Tatame.Service.ViaCEP in 'src\Service\Tatame.Service.ViaCEP.pas',
  Tatame.View.AlunoCadastro in 'src\View\Tatame.View.AlunoCadastro.pas' {frmCadastroAluno},
  Tatame.View.AlunoCadastroNovo in 'src\View\Tatame.View.AlunoCadastroNovo.pas' {Form2},
  Tatame.View.RelatorioInstrutores in 'src\View\Relatorios\Tatame.View.RelatorioInstrutores.pas' {frmRelatorioInstrutores},
  Tatame.View.RelatorioAlunos in 'src\View\Relatorios\Tatame.View.RelatorioAlunos.pas' {frmRelatorioAlunos};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.Run;
end.
