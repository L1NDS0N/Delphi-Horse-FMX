program HTBackendProj;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  Horse,
  Horse.Jhonson,
  Horse.HandleException,
  System.SysUtils,
  Services.Connection in 'src\services\Services.Connection.pas' {ServiceConnection: TDataModule} ,
  Services.Hospedes in 'src\services\Services.Hospedes.pas' {ServiceHospedes: TDataModule} ,
  Controllers.Hospedes in 'src\controllers\Controllers.Hospedes.pas',
  Services.Checkins in 'src\services\Services.Checkins.pas' {ServiceCheckins: TDataModule} ,
  Controllers.Checkins in 'src\controllers\Controllers.Checkins.pas';

begin

  THorse.Use(Jhonson).Use(HandleException);
  Controllers.Checkins.Registry;
  Controllers.Hospedes.Registry;
  THorse.Listen(9000);

end.
