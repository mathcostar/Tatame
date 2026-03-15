unit Tatame.DAO.Instrutor;

interface

uses
  Tatame.Model.Instrutor,
  System.Classes,
  FireDAC.Comp.Client,
  FireDAC.Stan.Param,
  Data.DB,
  Tatame.DataModule,
  System.Generics.Collections;

type
  IInstrutorDAO = interface
    procedure Salvar(const pInstrutor: TInstrutorModel);
    procedure Excluir(const pInstrutorID: Integer);

    function CarregarLista: TObjectList<TInstrutorModel>;
    function Autenticar(const pUsuario: string; const pSenha: string): Boolean;
  end;

  TInstrutorDAO = class(TInterfacedObject, IInstrutorDAO)
  private
    FConexao: TFDConnection;
  public
    constructor Create;

    procedure Salvar(const pInstrutor: TInstrutorModel);
    procedure Excluir(const pInstrutorID: Integer);

    function CarregarLista: TObjectList<TInstrutorModel>;
    function Autenticar(const pUsuario: string; const pSenha: string): Boolean;
  end;

implementation

uses
  System.SysUtils;

constructor TInstrutorDAO.Create;
begin
  FConexao := TdmPrincipal.GetInstancia.fdConexao;
end;

procedure TInstrutorDAO.Salvar(const pInstrutor: TInstrutorModel);
var
  lQuery: TFDQuery;
begin
  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := FConexao;

    if pInstrutor.ID = 0 then
      begin
        lQuery.SQL.Add('INSERT INTO tatame.instrutores (nome, cep, logradouro, estado, cidade, bairro, usuario, senha)');
        lQuery.SQL.Add('VALUES (:nome, :cep, :logradouro, :estado, :cidade, :bairro, :usuario, :senha)');
      end
    else
      begin
        lQuery.SQL.Add('UPDATE tatame.instrutores');
        lQuery.SQL.Add('   SET nome       = :nome,');
        lQuery.SQL.Add('       cep        = :cep,');
        lQuery.SQL.Add('       logradouro = :logradouro,');
        lQuery.SQL.Add('       estado     = :estado,');
        lQuery.SQL.Add('       cidade     = :cidade,');
        lQuery.SQL.Add('       bairro     = :bairro,');
        lQuery.SQL.Add('       usuario    = :usuario,');
        lQuery.SQL.Add('       senha      = :senha');
        lQuery.SQL.Add(' WHERE id = :id');

        lQuery.Params.ParamByName('id').AsInteger := pInstrutor.ID;
      end;

    lQuery.Params.ParamByName('nome').AsString       := pInstrutor.Nome;
    lQuery.Params.ParamByName('cep').AsString        := pInstrutor.Endereco.CEP;
    lQuery.Params.ParamByName('logradouro').AsString := pInstrutor.Endereco.Logradouro;
    lQuery.Params.ParamByName('estado').AsString     := pInstrutor.Endereco.Estado;
    lQuery.Params.ParamByName('cidade').AsString     := pInstrutor.Endereco.Cidade;
    lQuery.Params.ParamByName('bairro').AsString     := pInstrutor.Endereco.Bairro;
    lQuery.Params.ParamByName('usuario').AsString    := pInstrutor.Usuario;
    lQuery.Params.ParamByName('senha').AsString      := pInstrutor.Senha;

    lQuery.ExecSQL();
  finally
    lQuery.Free();
  end;
end;

procedure TInstrutorDAO.Excluir(const pInstrutorID: Integer);
var
  lQuery: TFDQuery;
begin
  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := FConexao;

    lQuery.SQL.Add('DELETE FROM tatame.instrutores');
    lQuery.SQL.Add(' WHERE id = :id');

    lQuery.Params.ParamByName('id').AsInteger := pInstrutorID;

    lQuery.ExecSQL();
  finally
    lQuery.Free();
  end;
end;

function TInstrutorDAO.CarregarLista: TObjectList<TInstrutorModel>;
var
  lQuery: TFDQuery;
  lInstrutor: TInstrutorModel;
begin
  Result := TObjectList<TInstrutorModel>.Create(True);

  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := FConexao;

    lQuery.SQL.Add('SELECT *');
    lQuery.SQL.Add('  FROM tatame.instrutores');
    lQuery.SQL.Add('ORDER BY nome');

    lQuery.Open();

    while not lQuery.Eof do
      begin
        lInstrutor := TInstrutorModel.Create();

        lInstrutor.ID                  := lQuery.FieldByName('id').AsInteger;
        lInstrutor.Nome                := lQuery.FieldByName('nome').AsString;
        lInstrutor.Usuario             := lQuery.FieldByName('usuario').AsString;
        lInstrutor.Senha               := lQuery.FieldByName('senha').AsString;
        lInstrutor.Endereco.CEP        := lQuery.FieldByName('cep').AsString;
        lInstrutor.Endereco.Logradouro := lQuery.FieldByName('logradouro').AsString;
        lInstrutor.Endereco.Estado     := lQuery.FieldByName('estado').AsString;
        lInstrutor.Endereco.Cidade     := lQuery.FieldByName('cidade').AsString;
        lInstrutor.Endereco.Bairro     := lQuery.FieldByName('bairro').AsString;

        Result.Add(lInstrutor);

        lQuery.Next();
      end;
  finally
    lQuery.Free();
  end;
end;

function TInstrutorDAO.Autenticar(const pUsuario: string; const pSenha: string): Boolean;
var
  lQuery: TFDQuery;
begin
  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := FConexao;

    lQuery.SQL.Add('SELECT nome');
    lQuery.SQL.Add('  FROM tatame.instrutores');
    lQuery.SQL.Add(' WHERE usuario = :usuario');
    lQuery.SQL.Add('   AND senha   = :senha');

    lQuery.ParamByName('usuario').AsString := pUsuario;
    lQuery.ParamByName('senha').AsString   := pSenha;

    lQuery.Open();

    Result := not lQuery.IsEmpty();
  finally
    lQuery.Free();
  end;
end;

end.
