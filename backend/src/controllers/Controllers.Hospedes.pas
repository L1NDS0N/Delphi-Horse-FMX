unit Controllers.Hospedes;

interface

procedure Registry;

implementation

uses
  Horse,
  Services.Hospedes,
  Dataset.Serialize,
  System.JSON,
  System.SysUtils,
  Vcl.Dialogs,
  Horse.Commons,
  Services.Connection;

procedure DoList(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  var
    LService: TServiceHospedes;
  begin
    LService := TServiceHospedes.Create(nil);
    try
      Res.Send(LService.ListAll.ToJSONArray);
    finally
      LService.Free;
    end;
  end;

procedure DoGet(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  var
    LId: string;
    LService: TServiceHospedes;
  begin
    LService := TServiceHospedes.Create(nil);
    try
      LId := Req.Params.Items['id'];
      if LService.GetById(LId).IsEmpty then
        raise EHorseException.Create(THTTPStatus.NotFound, 'Not Found');
      Res.Send(LService.qryCadastroHospedes.ToJSONObject());
    finally
      LService.Free;
    end;
  end;

procedure DoPost(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  var
    LService: TServiceHospedes;
    LData: TJsonObject;
  begin
    LService := TServiceHospedes.Create(nil);
    try
      LData := Req.Body<TJsonObject>;
      if LService.Append(LData) then
        Res.Send(LService.qryCadastroHospedes.ToJSONObject).Status(201);
    finally
      LService.Free;
    end;
  end;

procedure DoUpdate(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  var
    AID: Integer;
    LService: TServiceHospedes;
    LData: TJsonObject;
  begin
    LService := TServiceHospedes.Create(nil);
    try
      LData := Req.Body<TJsonObject>;
      AID := Req.Params.Items['id'].ToInteger;
      if LService.Update(LData, AID) then
        Res.Send(LService.qryCadastroHospedes.ToJSONObject).Status(200);
    finally
      LService.Free;
    end;
  end;

procedure DoDelete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  var
    AID: Integer;
    LService: TServiceHospedes;
  begin
    LService := TServiceHospedes.Create(nil);
    try
      AID := Req.Params.Items['id'].ToInteger;
      LService.Delete(AID);
      Res.Send(LService.qryCadastroHospedes.ToJSONObject).Status(204);
    finally
      LService.Free;
    end;

  end;

procedure Registry;
  var
    LConnection: TServiceConnection;
  begin
    LConnection := TServiceConnection.Create(nil);
    THorse.Get('/hospedes', DoList);
    THorse.Get('/hospedes/:id', DoGet);
    THorse.Post('/hospedes', DoPost);
    THorse.Put('/hospedes/:id', DoUpdate);
    THorse.Delete('/hospedes/:id', DoDelete);
  end;

end.
