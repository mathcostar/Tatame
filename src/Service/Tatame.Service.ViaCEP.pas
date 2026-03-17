unit Tatame.Service.ViaCEP;

interface

uses
  System.Classes,
  Tatame.Model.Endereco;

type
  TOnCEPEncontrado = procedure(const pEndereco: TEnderecoModel) of object;
  TOnCEPErro = procedure(const pMensagem: string) of object;

type
  TCEPBuscaThread = class(TThread)
  private
    FCEP: string;
    FEndereco: TEnderecoModel;
    FErroMensagem: string;
    FOnEncontrado: TOnCEPEncontrado;
    FOnErro: TOnCEPErro;

    procedure DoEncontrado;
    procedure DoErro;
  protected
    procedure Execute; override;
  public
    constructor Create(const pCEP: string; pOnEncontrado: TOnCEPEncontrado; pOnErro: TOnCEPErro);
    destructor Destroy; override;
  end;

type
  TViaCEPService = class
  public
    function BuscarEndereco(const pCEP: string): TEnderecoModel;
  end;

implementation

uses
  System.Net.HttpClient,
  System.JSON,
  System.SysUtils;

{ TCEPBuscaThread }

constructor TCEPBuscaThread.Create(const pCEP: string; pOnEncontrado: TOnCEPEncontrado; pOnErro: TOnCEPErro);
begin
  inherited Create(True);

  FCEP            := pCEP;
  FOnEncontrado   := pOnEncontrado;
  FOnErro         := pOnErro;
  FEndereco       := nil;
  FreeOnTerminate := True;
end;

destructor TCEPBuscaThread.Destroy;
begin
  FEndereco.Free();
  inherited;
end;

procedure TCEPBuscaThread.Execute;
var
  lService: TViaCEPService;
begin
  lService := TViaCEPService.Create();
  try
    try
      FEndereco := lService.BuscarEndereco(FCEP);

      if Terminated then
        Exit();

      if (FEndereco = nil) or (FEndereco.Cidade = '') then
      begin
        FErroMensagem := 'CEP não encontrado.';
        Synchronize(DoErro);
      end
      else
        Synchronize(DoEncontrado);

    except
      on E: Exception do
      begin
        if not Terminated then
        begin
          FErroMensagem := 'Erro ao buscar CEP: ' + E.Message;
          Synchronize(DoErro);
        end;
      end;
    end;
  finally
    lService.Free();
  end;
end;

procedure TCEPBuscaThread.DoEncontrado;
begin
  if Assigned(FOnEncontrado) then
    FOnEncontrado(FEndereco);
end;

procedure TCEPBuscaThread.DoErro();
begin
  if Assigned(FOnErro) then
    FOnErro(FErroMensagem);
end;

{ TViaCEPService }

function TViaCEPService.BuscarEndereco(const pCEP: string): TEnderecoModel;
var
  lHTTP     : THTTPClient;
  lResposta : IHTTPResponse;
  lJSON     : TJSONObject;
  lCEPLimpo : string;
begin
  Result := TEnderecoModel.Create();

  lCEPLimpo := pCEP.Replace('-', '').Replace('.', '').Trim();

  lHTTP := THTTPClient.Create();
  try
    lResposta := lHTTP.Get('https://viacep.com.br/ws/' + lCEPLimpo + '/json/');

    lJSON := TJSONObject.ParseJSONValue(lResposta.ContentAsString) as TJSONObject;
    try
      if lJSON = nil then
        Exit();

      if lJSON.GetValue('erro') <> nil then
        Exit();

      Result.CEP        := lJSON.GetValue<string>('cep');
      Result.Logradouro := lJSON.GetValue<string>('logradouro');
      Result.Bairro     := lJSON.GetValue<string>('bairro');
      Result.Cidade     := lJSON.GetValue<string>('localidade');
      Result.Estado     := lJSON.GetValue<string>('uf');
    finally
      lJSON.Free();
    end;
  finally
    lHTTP.Free();
  end;
end;

end.
