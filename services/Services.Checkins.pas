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
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  FireDAC.Stan.StorageBin,
  DataSet.Serialize,
  RESTRequest4D,
  Services.Hospedes;

type
  TServiceCheckin = class(TDataModule)
    mtCadastroCheckin: TFDMemTable;
    mtCadastroCheckinid: TIntegerField;
    mtCadastroCheckindataentrada: TDateField;
    mtCadastroCheckindatasaida: TDateField;
    mtCadastroCheckinadicionalveiculo: TBooleanField;
    mtCadastroCheckinhospede: TIntegerField;
    mtPesquisaCheckin: TFDMemTable;
    mtPesquisaCheckinid: TIntegerField;
    mtPesquisaCheckindataentrada: TDateField;
    mtPesquisaCheckindatasaida: TDateField;
    mtPesquisaCheckinadicionalveiculo: TBooleanField;
    mtPesquisaCheckinhospede: TIntegerField;
    mtPesquisaCheckinlkpHospede: TStringField;
    mtCadastroCheckinlkphospede: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    private
      { Private declarations }
    public
      procedure Salvar;
      procedure Listar;
      procedure Delete(const AId: string);
      procedure GetById(const AId: string);
  end;

const
  baseURL = 'http://localhost:9000';

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}
{ TServiceCheckin }

procedure TServiceCheckin.DataModuleCreate(Sender: TObject);
begin
  mtCadastroCheckin.Open;
  mtPesquisaCheckin.Open;
end;

procedure TServiceCheckin.Delete(const AId: string);
var
  LResponse: IResponse;
begin
  LResponse := TRequest.New.baseURL(baseURL).Resource('checkins').ResourceSuffix(AId).Delete;
  if not(LResponse.StatusCode = 204) then
    raise Exception.Create(LResponse.JSONValue.GetValue<string>('error'));

end;

procedure TServiceCheckin.GetById(const AId: string);
var
  LResponse: IResponse;
begin
  mtCadastroCheckin.EmptyDataSet;
  LResponse := TRequest.New.baseURL(baseURL).Resource('checkins').ResourceSuffix(AId)
    .DataSetAdapter(mtCadastroCheckin).Get;
  if not(LResponse.StatusCode = 200) then
    raise Exception.Create(LResponse.JSONValue.GetValue<string>('error'));

end;

procedure TServiceCheckin.Listar;
var
  LResponse: IResponse;
begin
  LResponse := TRequest.New.baseURL(baseURL).Resource('checkins').DataSetAdapter(mtPesquisaCheckin).Get;
  if not(LResponse.StatusCode = 200) then
    raise Exception.Create(LResponse.JSONValue.GetValue<string>('error'));

end;

procedure TServiceCheckin.Salvar;
var
  LRequest: IRequest;
  LResponse: IResponse;
begin
  LRequest := TRequest.New.baseURL(baseURL).Resource('checkins').AddBody(mtCadastroCheckin.ToJSONObject);
  if (mtCadastroCheckinid.AsInteger > 0) then
    LResponse := LRequest.ResourceSuffix(mtCadastroCheckinid.AsString).Put
  else
    LResponse := LRequest.Post;
  if not(LResponse.StatusCode in [200, 201, 204]) then
  raise Exception.Create(LResponse.JSONValue.GetValue<string>('error'));
  mtCadastroCheckin.EmptyDataSet;

end;

end.
