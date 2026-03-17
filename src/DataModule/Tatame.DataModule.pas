unit Tatame.DataModule;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.PG,
  FireDAC.Phys.PGDef,
  FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  FireDAC.UI.Intf, Datasnap.DBClient;

type
  TdmPrincipal = class(TDataModule)
    fdConexao: TFDConnection;
    fdDriverLink: TFDPhysPgDriverLink;
    dtsInstrutores: TDataSource;
    tblInstrutores: TFDTable;
    tblInstrutoresnome: TWideStringField;
    tblInstrutoresusuario: TWideStringField;
    tblInstrutoresid: TIntegerField;
    dtsAlunos: TDataSource;
    tblAlunos: TFDTable;
    tblAlunosid: TIntegerField;
    tblAlunosnome: TWideStringField;
    dtsFaixas: TDataSource;
    tblFaixas: TFDTable;
    tblAlunosfaixa_id: TSmallintField;
    tblAlunosinstrutor_id: TIntegerField;
    tblAlunosnome_instrutor: TWideStringField;
    tblAlunosfaixa: TStringField;
    procedure DataModuleCreate(Sender: TObject);
  private
    class var FInstancia: TdmPrincipal;

    procedure Conectar;
    procedure CriarBanco;
    procedure ConectarBancoSistema;
    procedure CriarEstrutura;

    function BancoExiste: Boolean;
  public
    class function GetInstancia: TdmPrincipal;
    class procedure LiberarInstancia;
  end;

implementation

uses
  Vcl.Dialogs;

{$R *.dfm}

{ TdmPrincipal }

class function TdmPrincipal.GetInstancia: TdmPrincipal;
begin
  if not Assigned(FInstancia) then
    FInstancia := TdmPrincipal.Create(nil);

  Result := FInstancia;
end;

class procedure TdmPrincipal.LiberarInstancia;
begin
  FreeAndNil(FInstancia);
end;

procedure TdmPrincipal.Conectar;
var
  lSenha: string;
begin
  lSenha := '123';

  fdConexao.Connected := False;
  fdConexao.Params.Clear;
  fdConexao.DriverName := 'PG';
  fdConexao.Params.Add('Server=localhost');
  fdConexao.Params.Add('Database=postgres');
  fdConexao.Params.Add('User_Name=postgres');
  fdConexao.Params.Add('Password=' + lSenha);
  fdConexao.Params.Add('Port=5432');
  fdConexao.LoginPrompt := False;

  try
    fdConexao.Connected := True;
  except
    lSenha := InputBox('Conexão com banco', 'Informe a senha do PostgreSQL:', '');
    fdConexao.Params.Values['Password'] := lSenha;
    fdConexao.Connected := True;
  end;
end;

procedure TdmPrincipal.DataModuleCreate(Sender: TObject);
begin
  Conectar();

  if not BancoExiste() then
    begin
      CriarBanco();
      ConectarBancoSistema();
      CriarEstrutura();
    end
  else
    ConectarBancoSistema();

  if not tblInstrutores.Active then
    tblInstrutores.Open();

  if not tblAlunos.Active then
    tblAlunos.Open();

  if not tblFaixas.Active then
    tblFaixas.Open();
end;

function TdmPrincipal.BancoExiste: Boolean;
var
  lQuery: TFDQuery;
begin
  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := fdConexao;

    lQuery.SQL.Add('SELECT 1 FROM pg_database WHERE datname = ''tatame''');

    lQuery.Open();

    Result := not lQuery.IsEmpty();
  finally
    lQuery.Free();
  end;
end;

procedure TdmPrincipal.CriarBanco;
var
  lQuery: TFDQuery;
begin
  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := fdConexao;
    lQuery.ExecSQL('CREATE DATABASE tatame ENCODING ''UTF8''');
  finally
    lQuery.Free();
  end;
end;

procedure TdmPrincipal.ConectarBancoSistema;
begin
  fdConexao.Connected := False;
  fdConexao.Params.Database := 'tatame';
  fdConexao.Connected := True;
end;

procedure TdmPrincipal.CriarEstrutura;
var
  lQuery: TFDQuery;
begin
  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := fdConexao;

    lQuery.ExecSQL('CREATE SCHEMA IF NOT EXISTS tatame;');

    lQuery.SQL.Add('CREATE TABLE IF NOT EXISTS tatame.faixas (');
    lQuery.SQL.Add('  id   SMALLINT PRIMARY KEY,');
    lQuery.SQL.Add('  nome VARCHAR(50) NOT NULL');
    lQuery.SQL.Add(')');
    lQuery.ExecSQL();
    lQuery.SQL.Clear();

    lQuery.SQL.Add('INSERT INTO tatame.faixas (id, nome) VALUES');
    lQuery.SQL.Add('  (1, ''Branca''),');
    lQuery.SQL.Add('  (2, ''Amarela''),');
    lQuery.SQL.Add('  (3, ''Laranja''),');
    lQuery.SQL.Add('  (4, ''Verde''),');
    lQuery.SQL.Add('  (5, ''Azul''),');
    lQuery.SQL.Add('  (6, ''Roxa''),');
    lQuery.SQL.Add('  (7, ''Marrom''),');
    lQuery.SQL.Add('  (8, ''Preta'')');
    lQuery.ExecSQL();
    lQuery.SQL.Clear();

    lQuery.SQL.Add('CREATE TABLE IF NOT EXISTS tatame.instrutores (');
    lQuery.SQL.Add('  id         SERIAL PRIMARY KEY,');
    lQuery.SQL.Add('  nome       VARCHAR(100),');
    lQuery.SQL.Add('  cep        VARCHAR(9),');
    lQuery.SQL.Add('  logradouro VARCHAR(50),');
    lQuery.SQL.Add('  estado     VARCHAR(50),');
    lQuery.SQL.Add('  cidade     VARCHAR(50),');
    lQuery.SQL.Add('  bairro     VARCHAR(100),');
    lQuery.SQL.Add('  usuario    VARCHAR(50) UNIQUE,');
    lQuery.SQL.Add('  senha      VARCHAR(50)');
    lQuery.SQL.Add(')');
    lQuery.ExecSQL();
    lQuery.SQL.Clear();

    lQuery.SQL.Add('INSERT INTO tatame.instrutores (nome, usuario, senha)');
    lQuery.SQL.Add('SELECT ''Administrador'', ''admin'', ''admin''');
    lQuery.SQL.Add('WHERE NOT EXISTS (');
    lQuery.SQL.Add('  SELECT 1 FROM tatame.instrutores WHERE usuario = ''admin''');
    lQuery.SQL.Add(')');
    lQuery.ExecSQL();
    lQuery.SQL.Clear();

    lQuery.SQL.Add('CREATE TABLE IF NOT EXISTS tatame.alunos (');
    lQuery.SQL.Add('  id           SERIAL PRIMARY KEY,');
    lQuery.SQL.Add('  nome         VARCHAR(100),');
    lQuery.SQL.Add('  faixa_id     SMALLINT,');
    lQuery.SQL.Add('  instrutor_id INTEGER,');
    lQuery.SQL.Add('  cep          VARCHAR(9),');
    lQuery.SQL.Add('  logradouro   VARCHAR(100),');
    lQuery.SQL.Add('  estado       VARCHAR(50),');
    lQuery.SQL.Add('  cidade       VARCHAR(50),');
    lQuery.SQL.Add('  bairro       VARCHAR(100),');
    lQuery.SQL.Add('  CONSTRAINT fk_aluno_faixa');
    lQuery.SQL.Add('    FOREIGN KEY (faixa_id)     REFERENCES tatame.faixas(id),');
    lQuery.SQL.Add('  CONSTRAINT fk_aluno_instrutor');
    lQuery.SQL.Add('    FOREIGN KEY (instrutor_id) REFERENCES tatame.instrutores(id)');
    lQuery.SQL.Add(')');
    lQuery.ExecSQL();
  finally
    lQuery.Free();
  end;
end;

end.
