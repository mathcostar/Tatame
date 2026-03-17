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
    function PesquisarPorFiltro(const pFiltro: string): TObjectList<TInstrutorModel>;
  end;

  TInstrutorService = class(TInterfacedObject, IInstrutorService)
  private
    function DadosValidos(const pUsuario: string; const pSenha: string): Boolean;
  public
    procedure Salvar(const pInstrutor: TInstrutorModel);
    procedure Excluir(const pInstrutorID: Integer);

    function CarregarLista: TObjectList<TInstrutorModel>;
    function Autenticar(const pUsuario: string; const pSenha: string): Boolean;
    function PesquisarPorFiltro(const pFiltro: string): TObjectList<TInstrutorModel>;
  end;

implementation

uses
  Tatame.DAO.Instrutor;

{ TInstrutorService }

procedure TInstrutorService.Salvar(const pInstrutor: TInstrutorModel);
var
  lDAOInstrutor: IInstrutorDAO;
begin
  lDAOInstrutor := TInstrutorDAO.Create();
  lDAOInstrutor.Salvar(pInstrutor);
end;

procedure TInstrutorService.Excluir(const pInstrutorID: Integer);
var
  lDAOInstrutor: IInstrutorDAO;
begin
  lDAOInstrutor := TInstrutorDAO.Create();
  lDAOInstrutor.Excluir(pInstrutorID);
end;

function TInstrutorService.Autenticar(const pUsuario, pSenha: string): Boolean;
var
  lDAOInstrutor: IInstrutorDAO;
begin
  if not DadosValidos(pUsuario, pSenha) then
    raise EDadosInvalido.Create;

  lDAOInstrutor := TInstrutorDAO.Create();
  Result := lDAOInstrutor.Autenticar(pUsuario, pSenha);
end;

function TInstrutorService.CarregarLista: TObjectList<TInstrutorModel>;
var
  lDAOInstrutor: IInstrutorDAO;
begin
  lDAOInstrutor := TInstrutorDAO.Create();
  Result := lDAOInstrutor.CarregarLista();
end;

function TInstrutorService.DadosValidos(const pUsuario: string; const pSenha: string): Boolean;
begin
  Result := (pUsuario <> '') and (pSenha <> '');
end;

function TInstrutorService.PesquisarPorFiltro(const pFiltro: string): TObjectList<TInstrutorModel>;
var
  lDAOInstrutor: IInstrutorDAO;
begin
  lDAOInstrutor := TInstrutorDAO.Create();
  Result := lDAOInstrutor.PesquisarPorFiltro(pFiltro);
end;

{ EDadosInvalido }

constructor EDadosInvalido.Create;
begin
  inherited Create('Os campos não podem ficar vazios, por favor verifique.');
end;

end.
