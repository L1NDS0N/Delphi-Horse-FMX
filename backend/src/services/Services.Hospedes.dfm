object ServiceHospedes: TServiceHospedes
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 134
  Width = 148
  object qryCadastroHospedes: TFDQuery
    CachedUpdates = True
    Connection = ServiceConnection.DBConnection
    SQL.Strings = (
      'select * '
      'from Hospedes')
    Left = 56
    Top = 16
    object qryCadastroHospedesID: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qryCadastroHospedesNOME: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 100
    end
    object qryCadastroHospedesdocumento: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'documento'
      Origin = 'documento'
      Size = 100
    end
    object qryCadastroHospedestelefone: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'telefone'
      Origin = 'telefone'
      Size = 100
    end
  end
  object qryPesquisaHospedes: TFDQuery
    Connection = ServiceConnection.DBConnection
    SQL.Strings = (
      'select *'
      'from hospedes')
    Left = 56
    Top = 72
    object qryPesquisaHospedesID: TFDAutoIncField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qryPesquisaHospedesNOME: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 100
    end
    object qryPesquisaHospedesdocumento: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'documento'
      Origin = 'documento'
      Size = 100
    end
    object qryPesquisaHospedestelefone: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'telefone'
      Origin = 'telefone'
      Size = 100
    end
  end
end
