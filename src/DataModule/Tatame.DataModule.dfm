object dmPrincipal: TdmPrincipal
  OnCreate = DataModuleCreate
  Height = 208
  Width = 314
  object fdConexao: TFDConnection
    Params.Strings = (
      'Database=tatame'
      'User_Name=postgres'
      'Password=123'
      'Server=localhost'
      'DriverID=PG')
    LoginPrompt = False
    Left = 136
    Top = 32
  end
  object fdDriverLink: TFDPhysPgDriverLink
    VendorLib = 'C:\Program Files (x86)\PostgreSQL\psqlODBC\bin\libpq.dll'
    Left = 40
    Top = 32
  end
end
