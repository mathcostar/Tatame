object frmNovoInstrutor: TfrmNovoInstrutor
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Cadastrar Instrutor'
  ClientHeight = 447
  ClientWidth = 339
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  TextHeight = 15
  object grpDados: TGroupBox
    Left = 6
    Top = 6
    Width = 323
    Height = 187
    Caption = 'Dados Cadastrais'
    TabOrder = 0
    object lblNome: TLabel
      Left = 18
      Top = 21
      Width = 36
      Height = 15
      Caption = 'Nome:'
    end
    object lblUsuario: TLabel
      Left = 18
      Top = 79
      Width = 43
      Height = 15
      Caption = 'Usu'#225'rio:'
    end
    object lblSenha: TLabel
      Left = 18
      Top = 135
      Width = 35
      Height = 15
      Caption = 'Senha:'
    end
    object edtNome: TEdit
      Left = 18
      Top = 42
      Width = 287
      Height = 23
      TabOrder = 0
    end
    object edtUsuario: TEdit
      Left = 18
      Top = 100
      Width = 287
      Height = 23
      TabOrder = 1
    end
    object edtSenha: TEdit
      Left = 18
      Top = 156
      Width = 184
      Height = 23
      PasswordChar = '*'
      TabOrder = 2
    end
    object chkMostrarSenha: TCheckBox
      Left = 208
      Top = 159
      Width = 97
      Height = 17
      Caption = 'Exibir senha'
      TabOrder = 3
      OnClick = chkMostrarSenhaClick
    end
  end
  object grpEndereco: TGroupBox
    Left = 6
    Top = 199
    Width = 323
    Height = 203
    Caption = 'Endere'#231'o'
    TabOrder = 1
    object lblCEP: TLabel
      Left = 18
      Top = 27
      Width = 24
      Height = 15
      Caption = 'CEP:'
    end
    object lblLogradouro: TLabel
      Left = 114
      Top = 27
      Width = 65
      Height = 15
      Caption = 'Logradouro:'
    end
    object lblEstado: TLabel
      Left = 18
      Top = 91
      Width = 38
      Height = 15
      Caption = 'Estado:'
    end
    object lblCidade: TLabel
      Left = 114
      Top = 91
      Width = 40
      Height = 15
      Caption = 'Cidade:'
    end
    object lblBairro: TLabel
      Left = 18
      Top = 152
      Width = 34
      Height = 15
      Caption = 'Bairro:'
    end
    object edtCEP: TEdit
      Left = 18
      Top = 48
      Width = 79
      Height = 23
      TabOrder = 0
      OnExit = edtCEPExit
    end
    object edtLogradouro: TEdit
      Left = 114
      Top = 48
      Width = 191
      Height = 23
      TabOrder = 1
    end
    object edtEstado: TEdit
      Left = 18
      Top = 112
      Width = 79
      Height = 23
      TabOrder = 2
    end
    object edtCidade: TEdit
      Left = 114
      Top = 112
      Width = 191
      Height = 23
      TabOrder = 3
    end
    object edtBairro: TEdit
      Left = 18
      Top = 168
      Width = 287
      Height = 23
      TabOrder = 4
    end
  end
  object btnCancelar: TButton
    Left = 175
    Top = 408
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 2
  end
  object btnGravar: TButton
    Left = 256
    Top = 408
    Width = 75
    Height = 25
    Caption = 'Gravar'
    TabOrder = 3
    OnClick = btnGravarClick
  end
end
