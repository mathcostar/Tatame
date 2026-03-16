object frmRelatorioInstrutores: TfrmRelatorioInstrutores
  Left = 0
  Top = 0
  Caption = 'Relat'#243'rio - Instrutores'
  ClientHeight = 268
  ClientWidth = 794
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object RLReport1: TRLReport
    Left = 0
    Top = 0
    Width = 794
    Height = 1123
    DataSource = dmPrincipal.dtsInstrutores
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    object RLBand1: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 107
      BandType = btTitle
      object rlblTitulo: TRLLabel
        Left = 153
        Top = 18
        Width = 412
        Height = 32
        Caption = 'RELAT'#211'RIO DE INSTRUTORES'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -27
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLLabel1: TRLLabel
        Left = 472
        Top = 74
        Width = 106
        Height = 16
        Caption = 'Data de emiss'#227'o:'
      end
      object RLSystemInfo1: TRLSystemInfo
        Left = 584
        Top = 74
        Width = 115
        Height = 16
        Info = itNow
        Text = ''
      end
    end
    object RLBand2: TRLBand
      Left = 38
      Top = 241
      Width = 718
      Height = 16
      BandType = btFooter
    end
    object RLDetailGrid1: TRLDetailGrid
      AlignWithMargins = True
      Left = 38
      Top = 145
      Width = 718
      Height = 96
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = True
      Borders.DrawRight = False
      Borders.DrawBottom = False
      object RLLabel3: TRLLabel
        Left = 40
        Top = 24
        Width = 74
        Height = 19
        Caption = 'Instrutor'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel2: TRLLabel
        Left = 457
        Top = 24
        Width = 156
        Height = 19
        Caption = 'Usu'#225'rio no sistema'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDBText1: TRLDBText
        Left = 40
        Top = 56
        Width = 36
        Height = 16
        DataField = 'nome'
        DataSource = dmPrincipal.dtsInstrutores
        Text = ''
      end
      object RLDBText2: TRLDBText
        Left = 457
        Top = 56
        Width = 46
        Height = 16
        DataField = 'usuario'
        DataSource = dmPrincipal.dtsInstrutores
        Text = ''
      end
    end
  end
end
