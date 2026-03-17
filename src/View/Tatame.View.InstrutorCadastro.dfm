object frmCadastroInstrutor: TfrmCadastroInstrutor
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Cadastro de Instrutores'
  ClientHeight = 404
  ClientWidth = 598
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnShow = FormShow
  TextHeight = 15
  object pnlBotoes: TPanel
    Left = 0
    Top = 0
    Width = 598
    Height = 41
    Align = alTop
    Caption = 'pnlBotoes'
    ShowCaption = False
    TabOrder = 0
    object btnExcluir: TButton
      AlignWithMargins = True
      Left = 166
      Top = 4
      Width = 75
      Height = 33
      Align = alLeft
      Caption = 'Excluir'
      TabOrder = 0
      OnClick = btnExcluirClick
    end
    object btnEditar: TButton
      AlignWithMargins = True
      Left = 85
      Top = 4
      Width = 75
      Height = 33
      Align = alLeft
      Caption = 'Editar'
      TabOrder = 1
      OnClick = btnEditarClick
    end
    object btnNovo: TButton
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 75
      Height = 33
      Align = alLeft
      Caption = 'Novo'
      TabOrder = 2
      OnClick = btnNovoClick
    end
  end
  object pnlInstrutores: TPanel
    Left = 0
    Top = 41
    Width = 598
    Height = 363
    Align = alClient
    Caption = 'pnlInstrutores'
    ShowCaption = False
    TabOrder = 1
    object edtPesquisar: TEdit
      Left = 1
      Top = 1
      Width = 596
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      TextHint = 'Comece a pesquisar...'
      OnChange = edtPesquisarChange
    end
    object sgdInstrutores: TStringGrid
      Left = 1
      Top = 24
      Width = 596
      Height = 338
      Align = alClient
      FixedRows = 0
      TabOrder = 1
      OnClick = sgdInstrutoresClick
    end
  end
end
