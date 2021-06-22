unit Services.Hospedes;

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
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  System.JSON,
  DataSet.Serialize,
  FireDAC.UI.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Phys,
  FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef,
  FireDAC.VCLUI.Wait,
  FireDAC.ConsoleUI.Wait,
  FireDAC.FMXUI.Wait;

type
  TServiceHospedes = class(TDataModule)
    qryCadastroHospedes: TFDQuery;
    qryPesquisaHospedes: TFDQuery;
    qryCadastroHospedesID: TFDAutoIncField;
    qryCadastroHospedesNOME: TStringField;
    qryCadastroHospedesdocumento: TStringField;
    qryCadastroHospedestelefone: TStringField;
    qryPesquisaHospedesID: TFDAutoIncField;
    qryPesquisaHospedesNOME: TStringField;
    qryPesquisaHospedesdocumento: TStringField;
    qryPesquisaHospedestelefone: TStringField;
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

implementation

uses
  Services.Connection;

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}
{ TServiceHospedes }

function TServiceHospedes.Append(const AJson: TJSONObject): Boolean;
  begin
    qryCadastroHospedes.SQL.Add('where 1<>1');
    qryCadastroHospedes.Open();
    qryCadastroHospedes.LoadFromJSON(AJson, False);
    Result := qryCadastroHospedes.ApplyUpdates(0) = 0;
  end;

procedure TServiceHospedes.DataModuleCreate(Sender: TObject);
  begin
    qryCadastroHospedes.Active := True;
    qryPesquisaHospedes.Active := True;
  end;

procedure TServiceHospedes.Delete(AId: integer);
  begin
    qryCadastroHospedes.SQL.Clear;
    qryCadastroHospedes.SQL.Add('DELETE FROM CLIENTES WHERE ID = :ID');
    qryCadastroHospedes.ParamByName('ID').Value := AId;
    qryCadastroHospedes.ExecSQL;
  end;

function TServiceHospedes.GetById(const AId: string): TFDQuery;
  begin
    qryCadastroHospedes.SQL.Add('where id = :id');
    qryCadastroHospedes.ParamByName('id').AsInteger := AId.ToInteger;
    qryCadastroHospedes.Open();
    Result := qryCadastroHospedes;
  end;

function TServiceHospedes.ListAll: TFDQuery;
  begin
    qryPesquisaHospedes.Open();
    Result := qryPesquisaHospedes;
  end;

function TServiceHospedes.Update(const AJson: TJSONObject; AId: integer): Boolean;
  begin
    qryCadastroHospedes.Close;
    qryCadastroHospedes.SQL.Add('where id = :id');
    qryCadastroHospedes.ParamByName('ID').Value := AId;
    qryCadastroHospedes.Open();
    qryCadastroHospedes.MergeFromJSONObject(AJson, False);
    Result := qryCadastroHospedes.ApplyUpdates(0) = 0;
  end;

end.
