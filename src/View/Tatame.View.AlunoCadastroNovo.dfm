object frmNovoAluno: TfrmNovoAluno
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Cadastrar Aluno'
  ClientHeight = 477
  ClientWidth = 339
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnCreate = FormCreate
  TextHeight = 15
  object grpDados: TGroupBox
    Left = 6
    Top = 6
    Width = 323
    Height = 217
    Caption = 'Dados Cadastrais'
    TabOrder = 0
    object lblNome: TLabel
      Left = 18
      Top = 21
      Width = 36
      Height = 15
      Caption = 'Nome:'
    end
    object lblFaixa: TLabel
      Left = 18
      Top = 79
      Width = 29
      Height = 15
      Caption = 'Faixa:'
    end
    object lblInstrutor: TLabel
      Left = 18
      Top = 135
      Width = 48
      Height = 15
      Caption = 'Instrutor:'
    end
    object edtNome: TEdit
      Left = 18
      Top = 42
      Width = 287
      Height = 23
      TabOrder = 0
    end
    object cmbFaixa: TComboBox
      Left = 18
      Top = 100
      Width = 287
      Height = 23
      Style = csDropDownList
      TabOrder = 1
    end
    object cmbInstrutor: TComboBox
      Left = 18
      Top = 156
      Width = 287
      Height = 23
      Style = csDropDownList
      TabOrder = 2
    end
  end
  object grpEndereco: TGroupBox
    Left = 6
    Top = 229
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
    object lblConsultandoCEP: TLabel
      Left = 18
      Top = 74
      Width = 100
      Height = 15
      Caption = 'Consultando CEP...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsItalic]
      ParentFont = False
      Visible = False
    end
    object edtCEP: TEdit
      Left = 18
      Top = 48
      Width = 79
      Height = 23
      MaxLength = 8
      NumbersOnly = True
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
    Top = 438
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 2
    OnClick = btnCancelarClick
  end
  object btnGravar: TButton
    Left = 256
    Top = 438
    Width = 75
    Height = 25
    Caption = 'Gravar'
    TabOrder = 3
    OnClick = btnGravarClick
  end
end
