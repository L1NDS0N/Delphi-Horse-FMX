program HTProject;

uses
  System.StartUpCopy,
  FMX.Forms,
  Views.Principal in 'Views\Views.Principal.pas' {frmPrincipal},
  Providers.Frames.Hospede in 'providers\Providers.Frames.Hospede.pas' {FrameHospede: TFrame},
  Providers.Types in 'providers\Providers.Types.pas',
  Services.Hospedes in 'services\Services.Hospedes.pas' {ServiceHospedes: TDataModule},
  Providers.Frames.Checkin in 'providers\Providers.Frames.Checkin.pas' {FrameCheckin: TFrame},
  Services.Checkins in 'services\Services.Checkins.pas' {ServiceCheckin: TDataModule};

{$R *.res}

begin
ReportMemoryLeaksOnShutdown := True;
Application.Initialize;
Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;

end.
