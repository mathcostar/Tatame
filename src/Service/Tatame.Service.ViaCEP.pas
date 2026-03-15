unit Tatame.Service.ViaCEP;

interface

uses
  Tatame.Model.Endereco;

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

function TViaCEPService.BuscarEndereco(const pCEP: string): TEnderecoModel;
var
  lHTTP: THTTPClient;
  lResposta: IHTTPResponse;
  lJSON: TJSONObject;
  lCEPLimpo: string;
begin
  Result := TEnderecoModel.Create();

  lCEPLimpo := pCEP.Replace('-', '').Replace('.', '').Trim();

  lHTTP := THTTPClient.Create();
  try
    lResposta := lHTTP.Get('https://viacep.com.br/ws/' + lCEPLimpo + '/json/');

    lJSON := TJSONObject.ParseJSONValue(lResposta.ContentAsString()) as TJSONObject;
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
