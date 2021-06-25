object ServiceCheckin: TServiceCheckin
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 150
  Width = 181
  object mtCadastroCheckin: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 72
    Top = 16
    object mtCadastroCheckinid: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'id'
    end
    object mtCadastroCheckindataentrada: TDateField
      FieldName = 'dataentrada'
    end
    object mtCadastroCheckindatasaida: TDateField
      FieldName = 'datasaida'
    end
    object mtCadastroCheckinadicionalveiculo: TBooleanField
      FieldName = 'adicionalveiculo'
    end
    object mtCadastroCheckinhospede: TIntegerField
      FieldName = 'hospede'
    end
    object mtCadastroCheckinlkphospede: TStringField
      FieldKind = fkLookup
      FieldName = 'lkphospede'
      LookupDataSet = ServiceHospedes.mtPesquisaHospedes
      LookupKeyFields = 'id'
      LookupResultField = 'nome'
      KeyFields = 'hospede'
      Lookup = True
    end
  end
  object mtPesquisaCheckin: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    FormatOptions.AssignedValues = [fvMaxBcdPrecision, fvMaxBcdScale]
    FormatOptions.MaxBcdPrecision = 2147483647
    FormatOptions.MaxBcdScale = 1073741823
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode]
    ResourceOptions.Persistent = True
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 72
    Top = 80
    object mtPesquisaCheckinid: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'id'
    end
    object mtPesquisaCheckindataentrada: TDateField
      FieldName = 'dataentrada'
    end
    object mtPesquisaCheckindatasaida: TDateField
      FieldName = 'datasaida'
    end
    object mtPesquisaCheckinadicionalveiculo: TBooleanField
      FieldName = 'adicionalveiculo'
    end
    object mtPesquisaCheckinhospede: TIntegerField
      FieldName = 'hospede'
    end
    object mtPesquisaCheckinlkpHospede: TStringField
      FieldKind = fkLookup
      FieldName = 'lkpHospede'
      LookupDataSet = ServiceHospedes.mtPesquisaHospedes
      LookupKeyFields = 'id'
      LookupResultField = 'nome'
      KeyFields = 'hospede'
      Lookup = True
    end
  end
end
