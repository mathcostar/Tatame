unit Tatame.Service.Instrutor;

interface

uses
  Tatame.Model.Instrutor,
  System.SysUtils,
  Tatame.DataModule,
  System.Generics.Collections;

type
  EDadosInvalido = class(Exception)
  public
    constructor Create;
  end;

  IInstrutorService = interface
    procedure Salvar(const pInstrutor: TInstrutorModel);
    procedure Excluir(const pInstrutorID: Integer);

    function CarregarLista: TObjectList<TInstrutorModel>;
    function Autenticar(const pUsuario: string; const pSenha: string): Boolean;
  end;

  TInstrutorService = class(TInterfacedObject, IInstrutorService)
  private
    function DadosValidos(const pUsuario: string; const pSenha: string): Boolean;
  public
    procedure Salvar(const pInstrutor: TInstrutorModel);
    procedure Excluir(const pInstrutorID: Integer);

    function CarregarLista: TObjectList<TInstrutorModel>;
    function Autenticar(const pUsuario: string; const pSenha: string): Boolean;
  end;

implementation

uses
  Tatame.DAO.Instrutor;

{ TInstrutorService }

procedure TInstrutorService.Salvar(const pInstrutor: TInstrutorModel);
var
  lDAOInstrutor: TInstrutorDAO;
begin
  lDAOInstrutor := TInstrutorDAO.Create();
  try
    lDAOInstrutor.Salvar(pInstrutor);
  finally
    lDAOInstrutor.Free();
  end;
end;

procedure TInstrutorService.Excluir(const pInstrutorID: Integer);
var
  lDAOInstrutor: TInstrutorDAO;
begin
  lDAOInstrutor := TInstrutorDAO.Create();
  try
    lDAOInstrutor.Excluir(pInstrutorID);
  finally
    lDAOInstrutor.Free();
  end;
end;

function TInstrutorService.CarregarLista: TObjectList<TInstrutorModel>;
var
  lDAOInstrutor: IInstrutorDAO;
begin
  lDAOInstrutor := TInstrutorDAO.Create();
  Result := lDAOInstrutor.CarregarLista();
end;

function TInstrutorService.Autenticar(const pUsuario: string; const pSenha: string): Boolean;
var
  lDAOInstrutor: TInstrutorDAO;
begin
  if not DadosValidos(pUsuario, pSenha) then
    raise EDadosInvalido.Create();

  lDAOInstrutor := TInstrutorDAO.Create();
  try
    Result := lDAOInstrutor.Autenticar(pUsuario, pSenha);
  finally
    lDAOInstrutor.Free();
  end;
end;

function TInstrutorService.DadosValidos(const pUsuario: string; const pSenha: string): Boolean;
begin
  Result := (pUsuario <> '') and (pSenha <> '');
end;

{ EDadosInvalido }

constructor EDadosInvalido.Create;
begin
  inherited Create('Os campos não podem ficar vazios, por favor verifique.');
end;

end.
