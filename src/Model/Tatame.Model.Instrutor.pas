unit Tatame.Model.Instrutor;

interface

uses
  Tatame.Model.Endereco;

type
  TInstrutorModel = class
  private
    FID: Integer;
    FNome: string;
    FEndereco: TEnderecoModel;
    FUsuario: string;
    FSenha: string;
  public
    constructor Create;
    destructor Destroy; override;

    property ID: Integer read FID write FID;
    property Nome: string read FNome write FNome;
    property Endereco: TEnderecoModel read FEndereco write FEndereco;
    property Usuario: string read FUsuario write FUsuario;
    property Senha: string read FSenha write FSenha;
  end;
implementation

constructor TInstrutorModel.Create;
begin
  FEndereco := TEnderecoModel.Create();
end;

destructor TInstrutorModel.Destroy;
begin
  FEndereco.Free();

  inherited;
end;

end.
