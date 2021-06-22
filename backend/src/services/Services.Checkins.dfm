object ServiceCheckins: TServiceCheckins
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 155
  Width = 158
  object qryCadastroCheckins: TFDQuery
    CachedUpdates = True
    Connection = ServiceConnection.DBConnection
    SQL.Strings = (
      'select * from Checkin')
    Left = 64
    Top = 16
    object qryCadastroCheckinsID: TFDAutoIncField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qryCadastroCheckinshospede: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'hospede'
      Origin = 'hospede'
    end
    object qryCadastroCheckinsdataentrada: TDateField
      AutoGenerateValue = arDefault
      FieldName = 'dataentrada'
      Origin = 'dataentrada'
    end
    object qryCadastroCheckinsdatasaida: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'datasaida'
      Origin = 'datasaida'
      Size = 100
    end
    object qryCadastroCheckinsadicionalveiculo: TBooleanField
      AutoGenerateValue = arDefault
      FieldName = 'adicionalveiculo'
      Origin = 'adicionalveiculo'
    end
  end
  object qryPesquisaCheckins: TFDQuery
    Connection = ServiceConnection.DBConnection
    SQL.Strings = (
      'select * from Checkin')
    Left = 64
    Top = 80
    object qryPesquisaCheckinsID: TFDAutoIncField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qryPesquisaCheckinshospede: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'hospede'
      Origin = 'hospede'
    end
    object qryPesquisaCheckinsdataentrada: TDateField
      AutoGenerateValue = arDefault
      FieldName = 'dataentrada'
      Origin = 'dataentrada'
    end
    object qryPesquisaCheckinsdatasaida: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'datasaida'
      Origin = 'datasaida'
      Size = 100
    end
    object qryPesquisaCheckinsadicionalveiculo: TBooleanField
      AutoGenerateValue = arDefault
      FieldName = 'adicionalveiculo'
      Origin = 'adicionalveiculo'
    end
  end
end
