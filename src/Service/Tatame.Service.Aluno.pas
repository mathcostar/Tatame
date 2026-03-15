unit Tatame.Service.Aluno;

interface

uses
  Tatame.Model.Aluno,
  System.SysUtils,
  System.Generics.Collections;

type
  IAlunoService = interface
    procedure Salvar(const pAluno: TAlunoModel);
    procedure Excluir(const pAlunoID: Integer);

    function CarregarLista: TObjectList<TAlunoModel>;
  end;

  TAlunoService = class(TInterfacedObject, IAlunoService)
  public
    procedure Salvar(const pAluno: TAlunoModel);
    procedure Excluir(const pAlunoID: Integer);

    function CarregarLista: TObjectList<TAlunoModel>;
  end;

implementation

uses
  Tatame.DAO.Aluno;

{ TAlunoService }

procedure TAlunoService.Salvar(const pAluno: TAlunoModel);
var
  lDAOAluno: TAlunoDAO;
begin
  lDAOAluno := TAlunoDAO.Create();
  try
    lDAOAluno.Salvar(pAluno);
  finally
    lDAOAluno.Free();
  end;
end;

procedure TAlunoService.Excluir(const pAlunoID: Integer);
var
  lDAOAluno: TAlunoDAO;
begin
  lDAOAluno := TAlunoDAO.Create();
  try
    lDAOAluno.Excluir(pAlunoID);
  finally
    lDAOAluno.Free();
  end;
end;

function TAlunoService.CarregarLista: TObjectList<TAlunoModel>;
var
  lDAOAluno: IAlunoDAO;
begin
  lDAOAluno := TAlunoDAO.Create();
  Result := lDAOAluno.CarregarLista();
end;

end.
