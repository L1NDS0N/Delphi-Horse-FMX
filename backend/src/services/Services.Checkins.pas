unit Services.Checkins;

interface

uses
  System.SysUtils,
  System.Classes,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  Data.DB,
  System.JSON,
  DataSet.Serialize,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TServiceCheckins = class(TDataModule)
    qryCadastroCheckins: TFDQuery;
    qryPesquisaCheckins: TFDQuery;
    qryCadastroCheckinsID: TFDAutoIncField;
    qryCadastroCheckinshospede: TIntegerField;
    qryCadastroCheckinsdataentrada: TDateField;
    qryCadastroCheckinsadicionalveiculo: TBooleanField;
    qryPesquisaCheckinsID: TFDAutoIncField;
    qryPesquisaCheckinshospede: TIntegerField;
    qryPesquisaCheckinsdataentrada: TDateField;
    qryPesquisaCheckinsadicionalveiculo: TBooleanField;
    qryPesquisaCheckinsdatasaida: TDateField;
    qryCadastroCheckinsdatasaida: TDateField;
    procedure DataModuleCreate(Sender: TObject);
    private
      { Private declarations }
    public
      function ListAll: TFDQuery;
      function Append(const AJson: TJSONObject): Boolean;
      procedure Delete(AId: integer);
      function Update(const AJson: TJSONObject; AId: integer): Boolean;
      function GetById(const AId: string): TFDQuery;
  end;

var
  ServiceCheckins: TServiceCheckins;

implementation

uses
  Services.Connection;
{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}
{ TDataModule1 }

function TServiceCheckins.Append(const AJson: TJSONObject): Boolean;
  begin
    qryCadastroCheckins.SQL.Add('where 1<>1');
    qryCadastroCheckins.Open();
    qryCadastroCheckins.LoadFromJSON(AJson, False);
    Result := qryCadastroCheckins.ApplyUpdates(0) = 0;
  end;

procedure TServiceCheckins.DataModuleCreate(Sender: TObject);
  begin
    qryCadastroCheckins.Active := True;
    qryPesquisaCheckins.Active := True;
  end;

procedure TServiceCheckins.Delete(AId: integer);
  begin
    qryCadastroCheckins.SQL.Clear;
    qryCadastroCheckins.SQL.Add('DELETE FROM CHECKIN WHERE ID = :ID');
    qryCadastroCheckins.ParamByName('ID').Value := AId;
    qryCadastroCheckins.ExecSQL;
  end;

function TServiceCheckins.GetById(const AId: string): TFDQuery;
  begin
    qryCadastroCheckins.SQL.Add('where id = :id');
    qryCadastroCheckins.ParamByName('id').AsInteger := AId.ToInteger;
    qryCadastroCheckins.Open();
    Result := qryCadastroCheckins;
  end;

function TServiceCheckins.ListAll: TFDQuery;
  begin
    qryPesquisaCheckins.Open();
    Result := qryPesquisaCheckins;
  end;

function TServiceCheckins.Update(const AJson: TJSONObject; AId: integer): Boolean;
  begin
    qryCadastroCheckins.Close;
    qryCadastroCheckins.SQL.Add('where id = :id');
    qryCadastroCheckins.ParamByName('ID').Value := AId;
    qryCadastroCheckins.Open();
    qryCadastroCheckins.MergeFromJSONObject(AJson, False);
    Result := qryCadastroCheckins.ApplyUpdates(0) = 0;
  end;

end.
