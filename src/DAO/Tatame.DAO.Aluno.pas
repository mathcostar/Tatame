unit Tatame.DAO.Aluno;

interface

uses
  Tatame.Model.Aluno,
  System.Classes,
  FireDAC.Comp.Client,
  FireDAC.Stan.Param,
  Data.DB,
  Tatame.DataModule,
  System.Generics.Collections;

type
  IAlunoDAO = interface
    procedure Salvar(const pAluno: TAlunoModel);
    procedure Excluir(const pAlunoID: Integer);

    function CarregarLista: TObjectList<TAlunoModel>;
  end;

  TAlunoDAO = class(TInterfacedObject, IAlunoDAO)
  private
    FConexao: TFDConnection;

    function CarregarDaQuery(const pQuery: TFDQuery): TObjectList<TAlunoModel>;
  public
    constructor Create;

    procedure Salvar(const pAluno: TAlunoModel);
    procedure Excluir(const pAlunoID: Integer);

    function CarregarLista: TObjectList<TAlunoModel>;
  end;

implementation

uses
  System.SysUtils;

constructor TAlunoDAO.Create;
begin
  FConexao := TdmPrincipal.GetInstancia.fdConexao;
end;

procedure TAlunoDAO.Salvar(const pAluno: TAlunoModel);
var
  lQuery: TFDQuery;
begin
  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := FConexao;

    if pAluno.ID = 0 then
      begin
        lQuery.SQL.Add('INSERT INTO tatame.alunos (nome, faixa_id, instrutor_id, cep, estado, cidade, bairro)');
        lQuery.SQL.Add('VALUES (:nome, :faixa_id, :instrutor_id, :cep, :estado, :cidade, :bairro)');
      end
    else
      begin
        lQuery.SQL.Add('UPDATE tatame.alunos');
        lQuery.SQL.Add('   SET nome         = :nome,');
        lQuery.SQL.Add('       faixa_id     = :faixa_id,');
        lQuery.SQL.Add('       instrutor_id = :instrutor_id,');
        lQuery.SQL.Add('       cep          = :cep,');
        lQuery.SQL.Add('       estado       = :estado,');
        lQuery.SQL.Add('       cidade       = :cidade,');
        lQuery.SQL.Add('       bairro       = :bairro');
        lQuery.SQL.Add(' WHERE id = :id');

        lQuery.Params.ParamByName('id').AsInteger := pAluno.ID;
      end;

    lQuery.Params.ParamByName('nome').AsString          := pAluno.Nome;
    lQuery.Params.ParamByName('faixa_id').AsInteger     := pAluno.FaixaID;
    lQuery.Params.ParamByName('instrutor_id').AsInteger := pAluno.InstrutorID;
    lQuery.Params.ParamByName('cep').AsString           := pAluno.Endereco.CEP;
    lQuery.Params.ParamByName('estado').AsString        := pAluno.Endereco.Estado;
    lQuery.Params.ParamByName('cidade').AsString        := pAluno.Endereco.Cidade;
    lQuery.Params.ParamByName('bairro').AsString        := pAluno.Endereco.Bairro;

    lQuery.ExecSQL();
  finally
    lQuery.Free();
  end;
end;

procedure TAlunoDAO.Excluir(const pAlunoID: Integer);
var
  lQuery: TFDQuery;
begin
  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := FConexao;

    lQuery.SQL.Add('DELETE FROM tatame.alunos');
    lQuery.SQL.Add(' WHERE id = :id');

    lQuery.Params.ParamByName('id').AsInteger := pAlunoID;

    lQuery.ExecSQL();
  finally
    lQuery.Free();
  end;
end;

function TAlunoDAO.CarregarDaQuery(const pQuery: TFDQuery): TObjectList<TAlunoModel>;
var
  lAluno: TAlunoModel;
begin
  Result := TObjectList<TAlunoModel>.Create(True);

  while not pQuery.Eof do
    begin
      lAluno := TAlunoModel.Create();

      lAluno.ID              := pQuery.FieldByName('id').AsInteger;
      lAluno.Nome            := pQuery.FieldByName('nome').AsString;
      lAluno.FaixaID         := pQuery.FieldByName('faixa_id').AsInteger;
      lAluno.NomeFaixa       := pQuery.FieldByName('nome_faixa').AsString;
      lAluno.InstrutorID     := pQuery.FieldByName('instrutor_id').AsInteger;
      lAluno.NomeInstrutor   := pQuery.FieldByName('nome_instrutor').AsString;
      lAluno.Endereco.CEP    := pQuery.FieldByName('cep').AsString;
      lAluno.Endereco.Estado := pQuery.FieldByName('estado').AsString;
      lAluno.Endereco.Cidade := pQuery.FieldByName('cidade').AsString;
      lAluno.Endereco.Bairro := pQuery.FieldByName('bairro').AsString;

      Result.Add(lAluno);

      pQuery.Next();
    end;
end;

function TAlunoDAO.CarregarLista: TObjectList<TAlunoModel>;
var
  lQuery: TFDQuery;
begin
  lQuery := TFDQuery.Create(nil);
  try
    lQuery.Connection := FConexao;

    lQuery.SQL.Add('SELECT a.*,');
    lQuery.SQL.Add('       f.nome AS nome_faixa,');
    lQuery.SQL.Add('       i.nome AS nome_instrutor');
    lQuery.SQL.Add('  FROM tatame.alunos a');
    lQuery.SQL.Add('  LEFT JOIN tatame.faixas      f ON f.id = a.faixa_id');
    lQuery.SQL.Add('  LEFT JOIN tatame.instrutores i ON i.id = a.instrutor_id');
    lQuery.SQL.Add('ORDER BY a.nome');

    lQuery.Open();

    Result := CarregarDaQuery(lQuery);
  finally
    lQuery.Free();
  end;
end;

end.
