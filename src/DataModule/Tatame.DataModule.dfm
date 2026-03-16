object dmPrincipal: TdmPrincipal
  OnCreate = DataModuleCreate
  Height = 208
  Width = 314
  object fdConexao: TFDConnection
    Params.Strings = (
      'Database=tatame'
      'User_Name=postgres'
      'Password=#abc123#'
      'Server=localhost'
      'DriverID=PG')
    LoginPrompt = False
    Left = 120
    Top = 8
  end
  object fdDriverLink: TFDPhysPgDriverLink
    VendorLib = 'C:\Program Files (x86)\PostgreSQL\psqlODBC\bin\libpq.dll'
    Left = 32
    Top = 8
  end
  object dtsInstrutores: TDataSource
    DataSet = tblInstrutores
    Left = 32
    Top = 80
  end
  object tblInstrutores: TFDTable
    IndexFieldNames = 'id'
    Connection = fdConexao
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = 'tatame.instrutores'
    Left = 120
    Top = 80
    object tblInstrutoresnome: TWideStringField
      FieldName = 'nome'
      Origin = 'nome'
      Size = 100
    end
    object tblInstrutoresusuario: TWideStringField
      FieldName = 'usuario'
      Origin = 'usuario'
      Size = 50
    end
    object tblInstrutoresid: TIntegerField
      FieldName = 'id'
      Origin = 'id'
    end
  end
  object dtsAlunos: TDataSource
    DataSet = tblAlunos
    Left = 32
    Top = 144
  end
  object tblAlunos: TFDTable
    IndexFieldNames = 'id'
    Connection = fdConexao
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = 'tatame.alunos'
    Left = 120
    Top = 144
    object tblAlunosid: TIntegerField
      FieldName = 'id'
      Origin = 'id'
    end
    object tblAlunosnome: TWideStringField
      FieldName = 'nome'
      Origin = 'nome'
      Size = 100
    end
    object tblAlunosfaixa_id: TSmallintField
      FieldName = 'faixa_id'
      Origin = 'faixa_id'
    end
    object tblAlunosinstrutor_id: TIntegerField
      FieldName = 'instrutor_id'
      Origin = 'instrutor_id'
    end
    object tblAlunosnome_instrutor: TWideStringField
      FieldKind = fkLookup
      FieldName = 'nome_instrutor'
      LookupDataSet = tblInstrutores
      LookupKeyFields = 'id'
      LookupResultField = 'nome'
      KeyFields = 'instrutor_id'
      Lookup = True
    end
    object tblAlunosfaixa: TStringField
      FieldKind = fkLookup
      FieldName = 'faixa'
      LookupDataSet = tblFaixas
      LookupKeyFields = 'id'
      LookupResultField = 'nome'
      KeyFields = 'faixa_id'
      Lookup = True
    end
  end
  object dtsFaixas: TDataSource
    DataSet = tblFaixas
    Left = 216
    Top = 80
  end
  object tblFaixas: TFDTable
    IndexFieldNames = 'id'
    AggregatesActive = True
    Connection = fdConexao
    ResourceOptions.AssignedValues = [rvEscapeExpand]
    TableName = 'tatame.faixas'
    Left = 216
    Top = 136
  end
end
