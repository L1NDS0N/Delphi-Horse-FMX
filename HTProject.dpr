program HTProject;

uses
  System.StartUpCopy,
  FMX.Forms,
  Views.Hospedes in 'Views\Views.Hospedes.pas' {frmHospedes},
  Providers.Frames.Hospede in 'providers\Providers.Frames.Hospede.pas' {FrameHospede: TFrame},
  Providers.Types in 'providers\Providers.Types.pas',
  Services.Hospedes in 'services\Services.Hospedes.pas' {ServiceHospedes: TDataModule};

{$R *.res}

begin
ReportMemoryLeaksOnShutdown := True;
Application.Initialize;
Application.CreateForm(TfrmHospedes, frmHospedes);
  Application.Run;

end.
