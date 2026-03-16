unit Tatame.View.RelatorioAlunos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport;

type
  TfrmRelatorioAlunos = class(TForm)
    RLReport1: TRLReport;
    RLBand1: TRLBand;
    rlblTitulo: TRLLabel;
    RLLabel1: TRLLabel;
    RLSystemInfo1: TRLSystemInfo;
    RLBand2: TRLBand;
    RLDetailGrid1: TRLDetailGrid;
    RLLabel3: TRLLabel;
    RLLabel2: TRLLabel;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLLabel4: TRLLabel;
    RLDBText3: TRLDBText;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  Tatame.DataModule;

{$R *.dfm}

end.
