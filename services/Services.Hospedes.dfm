object ServiceHospedes: TServiceHospedes
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 85
  Width = 281
  object mtCadastroHospedes: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 64
    Top = 16
    object mtCadastroHospedesid: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object mtCadastroHospedesnome: TStringField
      FieldName = 'nome'
    end
    object mtCadastroHospedesdocumento: TStringField
      FieldName = 'documento'
    end
    object mtCadastroHospedestelefone: TStringField
      FieldName = 'telefone'
    end
  end
  object mtPesquisaHospedes: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 192
    Top = 16
    object mtPesquisaHospedesid: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object mtPesquisaHospedesdocumento: TStringField
      FieldName = 'documento'
    end
    object mtPesquisaHospedestelefone: TStringField
      FieldName = 'telefone'
    end
    object mtPesquisaHospedesnome: TStringField
      FieldName = 'nome'
      Size = 100
    end
  end
end
