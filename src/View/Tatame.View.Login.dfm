object frmLogin: TfrmLogin
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Tatame - Autentica'#231#227'o'
  ClientHeight = 147
  ClientWidth = 289
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object pnlLogin: TPanel
    Left = 0
    Top = 0
    Width = 289
    Height = 112
    Align = alClient
    Caption = 'pnlLogin'
    ShowCaption = False
    TabOrder = 0
    object lblUsuario: TLabel
      Left = 16
      Top = 28
      Width = 43
      Height = 15
      Caption = 'Usu'#225'rio:'
    end
    object lblSenha: TLabel
      Left = 24
      Top = 66
      Width = 35
      Height = 15
      Caption = 'Senha:'
    end
    object edtUsuario: TEdit
      Left = 65
      Top = 25
      Width = 121
      Height = 23
      TabOrder = 0
      TextHint = 'Informe o usu'#225'rio...'
    end
    object edtSenha: TEdit
      Left = 65
      Top = 63
      Width = 121
      Height = 23
      PasswordChar = '*'
      TabOrder = 1
      TextHint = 'Informe a senha...'
    end
    object btnEntrar: TButton
      Left = 200
      Top = 25
      Width = 75
      Height = 23
      Caption = 'Entrar'
      TabOrder = 2
      OnClick = btnEntrarClick
    end
    object chkMostrarSenha: TCheckBox
      Left = 194
      Top = 66
      Width = 83
      Height = 17
      Caption = 'Exibir senha'
      TabOrder = 3
      OnClick = chkMostrarSenhaClick
    end
  end
  object pnlPrimeiroAcesso: TPanel
    Left = 0
    Top = 112
    Width = 289
    Height = 35
    Align = alBottom
    Caption = 'pnlPrimeiroAcesso'
    Color = clActiveBorder
    ParentBackground = False
    ShowCaption = False
    TabOrder = 1
    object lblPrimeiroAcesso: TLabel
      Left = 1
      Top = 1
      Width = 287
      Height = 33
      Align = alClient
      Alignment = taCenter
      Caption = 'Primeiro acesso? Clique aqui!'
      Color = clSkyBlue
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clDarkblue
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
      OnClick = lblPrimeiroAcessoClick
      ExplicitWidth = 159
      ExplicitHeight = 15
    end
  end
end
