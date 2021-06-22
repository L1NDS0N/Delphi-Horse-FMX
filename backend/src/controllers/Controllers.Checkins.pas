unit Controllers.Checkins;

interface

procedure Registry;

implementation

uses
  Horse,
  System.JSON,
  Services.Checkins,
  System.SysUtils,
  Dataset.Serialize, Services.Connection;

procedure DoList(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  var
    LService: TServiceCheckins;
  begin
    LService := TServiceCheckins.Create(nil);
    try
      Res.Send(LService.ListAll.ToJSONArray);
    finally
      LService.Free;
    end;
  end;

procedure DoGet(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  var
    LId: string;
    LService: TServiceCheckins;
  begin
    LService := TServiceCheckins.Create(nil);
    try
      LId := Req.Params.Items['id'];
      if LService.GetById(LId).IsEmpty then
        raise EHorseException.Create(THTTPStatus.NotFound, 'Not Found');
      Res.Send(LService.qryCadastroCheckins.ToJSONObject());
    finally
      LService.Free;
    end;
  end;

procedure DoPost(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  var
    LService: TServiceCheckins;
    LData: TJsonObject;
  begin
    LService := TServiceCheckins.Create(nil);
    try
      LData := Req.Body<TJsonObject>;
      if LService.Append(LData) then
        Res.Send(LService.qryCadastroCheckins.ToJSONObject).Status(201);
    finally
      LService.Free;
    end;
  end;

procedure DoUpdate(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  var
    AID: Integer;
    LService: TServiceCheckins;
    LData: TJsonObject;
  begin
    LService := TServiceCheckins.Create(nil);
    try
      LData := Req.Body<TJsonObject>;
      AID := Req.Params.Items['id'].ToInteger;
      if LService.Update(LData, AID) then
        Res.Send(LService.qryCadastroCheckins.ToJSONObject).Status(200);
    finally
      LService.Free;
    end;
  end;

procedure DoDelete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  var
    AID: Integer;
    LService: TServiceCheckins;
  begin
    LService := TServiceCheckins.Create(nil);
    try
      AID := Req.Params.Items['id'].ToInteger;
      LService.Delete(AID);
      Res.Send(LService.qryCadastroCheckins.ToJSONObject).Status(204);
    finally
      LService.Free;
    end;

  end;

procedure Registry;
  var
    LConnection: TServiceConnection;
  begin
    LConnection := TServiceConnection.Create(nil);
    THorse.Get('/checkins', DoList);
    THorse.Get('/checkins/:id', DoGet);
    THorse.Post('/checkins', DoPost);
    THorse.Put('/checkins/:id', DoUpdate);
    THorse.Delete('/checkins/:id', DoDelete);
  end;

end.
