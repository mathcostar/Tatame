unit Tatame.Model.Aluno;

interface

uses
  Tatame.Model.Endereco;

type
  TAlunoModel = class
  private
    FID: Integer;
    FNome: string;
    FFaixaID: SmallInt;
    FNomeFaixa: string;
    FInstrutorID: Integer;
    FNomeInstrutor: string;
    FEndereco: TEnderecoModel;
  public
    constructor Create;
    destructor Destroy; override;

    property ID: Integer read FID write FID;
    property Nome: string read FNome write FNome;
    property FaixaID: SmallInt read FFaixaID write FFaixaID;
    property NomeFaixa: string read FNomeFaixa write FNomeFaixa;
    property InstrutorID: Integer read FInstrutorID write FInstrutorID;
    property NomeInstrutor: string read FNomeInstrutor write FNomeInstrutor;
    property Endereco: TEnderecoModel read FEndereco write FEndereco;
  end;

implementation

constructor TAlunoModel.Create;
begin
  FEndereco := TEnderecoModel.Create();
end;

destructor TAlunoModel.Destroy;
begin
  FEndereco.Free();

  inherited;
end;

end.
