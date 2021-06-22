unit Providers.Frames.Hospede;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Controls.Presentation, Providers.Types;

type
  TFrameHospede = class(TFrame)
    retContent: TRectangle;
    lblDocumento: TLabel;
    lblNome: TLabel;
    crlDelete: TCircle;
    imgDelete: TPath;
    lineSeparator: TLine;
    crlEdit: TCircle;
    imgEdit: TPath;
    lblTelefone: TLabel;
    procedure crlDeleteClick(Sender: TObject);
    procedure crlDeleteTap(Sender: TObject; const Point: TPointF);
    procedure crlEditTap(Sender: TObject; const Point: TPointF);
    procedure crlEditClick(Sender: TObject);
    procedure retContentDblClick(Sender: TObject);
    private
      FId: string;
      FOnDelete: TEventCallBack;
      FOnUpdate: TEventCallBack;
    public
      property Id: string read FId write FId;
      property OnDelete: TEventCallBack read FOnDelete write FOnDelete;
      property OnUpdate: TEventCallBack read FOnUpdate write FOnUpdate;
  end;

implementation

{$R *.fmx}

{ TFrameHospede }

procedure TFrameHospede.crlDeleteClick(Sender: TObject);
  begin
  {$IFDEF MSWINDOWS}
  if Assigned(FOnDelete) then
    FOnDelete(Self, FId);
  {$ENDIF}
  end;

procedure TFrameHospede.crlDeleteTap(Sender: TObject; const Point: TPointF);
  begin
  {$IFNDEF MSWINDOWS}
  if Assigned(FOnDelete) then
    FOnDelete(Self, FId);
  {$ENDIF}
  end;

procedure TFrameHospede.crlEditClick(Sender: TObject);
  begin
  {$IFDEF MSWINDOWS}
  if Assigned(FOnUpdate) then
    FOnUpdate(Self, FId);
  {$ENDIF}
  end;

procedure TFrameHospede.crlEditTap(Sender: TObject; const Point: TPointF);
  begin
  {$IFNDEF MSWINDOWS}
  if Assigned(FOnUpdate) then
    FOnUpdate(Self, FId);
  {$ENDIF}
  end;

procedure TFrameHospede.retContentDblClick(Sender: TObject);
  begin
  {$IFDEF MSWINDOWS}
  if Assigned(FOnUpdate) then
    FOnUpdate(Self, FId);
  {$ENDIF}
  end;

end.
