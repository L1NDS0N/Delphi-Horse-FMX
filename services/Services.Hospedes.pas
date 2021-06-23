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
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  DataSet.Serialize,
  RESTRequest4D;

type
  TServiceHospedes = class(TDataModule)
    mtCadastroHospedes: TFDMemTable;
    mtCadastroHospedesid: TIntegerField;
    mtCadastroHospedesnome: TStringField;
    mtCadastroHospedesdocumento: TStringField;
    mtCadastroHospedestelefone: TStringField;
    mtPesquisaHospedes: TFDMemTable;
    mtPesquisaHospedesid: TIntegerField;
    mtPesquisaHospedesdocumento: TStringField;
    mtPesquisaHospedestelefone: TStringField;
    mtPesquisaHospedesnome: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    private
      { Private declarations }
    public
      procedure Salvar;
      procedure Listar;
      procedure Delete(const AId: string);
      procedure GetById(const AId: string);
  end;

var
  baseURL: String;
  //na inicialização do projeto, remover a declaração da criação do form durante o tempo de execução
  //ServiceHospedes: TServiceHospedes;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}

procedure TServiceHospedes.DataModuleCreate(Sender: TObject);
begin
  baseURL := 'http://localhost:9000';
  mtCadastroHospedes.Open;
  mtPesquisaHospedes.Open;
end;

procedure TServiceHospedes.Delete(const AId: string);
var
  LResponse: IResponse;
begin
  LResponse := TRequest.New.baseURL(baseURL).Resource('hospedes').ResourceSuffix(AId).Delete;
  if not(LResponse.StatusCode = 204) then
    raise Exception.Create(LResponse.JSONValue.GetValue<string>('error'));
end;

procedure TServiceHospedes.GetById(const AId: string);
var
  LResponse: IResponse;
begin
  mtCadastroHospedes.EmptyDataSet;
  LResponse := TRequest.New.baseURL(baseURL).Resource('hospedes').ResourceSuffix(AId)
    .DataSetAdapter(mtCadastroHospedes).Get;
  if not(LResponse.StatusCode = 200) then
    raise Exception.Create(LResponse.JSONValue.GetValue<string>('error'));
end;

procedure TServiceHospedes.Listar;
var
  LResponse: IResponse;
begin
  LResponse := TRequest.New.baseURL(baseURL).Resource('hospedes').DataSetAdapter(mtPesquisaHospedes).Get;
  if not(LResponse.StatusCode = 200) then
    raise Exception.Create(LResponse.JSONValue.GetValue<string>('error'));
end;

procedure TServiceHospedes.Salvar;
var
  LRequest: IRequest;
  LResponse: IResponse;
begin
  LRequest := TRequest.New.baseURL(baseURL).Resource('hospedes').AddBody(mtCadastroHospedes.ToJSONObject);
  if (mtCadastroHospedesid.AsInteger > 0) then
    LResponse := LRequest.ResourceSuffix(mtCadastroHospedesid.AsString).Put
  else
    LResponse := LRequest.Post;
  if not(LResponse.StatusCode in [201, 204]) then
    raise Exception.Create(LResponse.JSONValue.GetValue<string>('error'));
  mtCadastroHospedes.EmptyDataSet;
end;

end.
