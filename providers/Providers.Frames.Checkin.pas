unit Providers.Frames.Checkin;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Graphics,
  FMX.Controls,
  FMX.Forms,
  FMX.Dialogs,
  FMX.StdCtrls,
  FMX.Objects,
  FMX.Controls.Presentation,
  Providers.Types;

type
  TFrameCheckin = class(TFrame)
    retContent: TRectangle;
    lblEntrada: TLabel;
    lblHospede: TLabel;
    crlDelete: TCircle;
    imgDelete: TPath;
    lineSeparator: TLine;
    crlEdit: TCircle;
    imgEdit: TPath;
    lblSaida: TLabel;
    chkPossuiCarro: TCheckBox;
    procedure crlEditClick(Sender: TObject);
    procedure crlDeleteClick(Sender: TObject);
    procedure crlDeleteTap(Sender: TObject; const Point: TPointF);
    procedure crlEditTap(Sender: TObject; const Point: TPointF);
    procedure retContentClick(Sender: TObject);
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

procedure TFrameCheckin.crlDeleteClick(Sender: TObject);
begin
  {$IFDEF MSWINDOWS}
  if Assigned(FOnDelete) then
    FOnDelete(Self, FId);
  {$ENDIF}
end;

procedure TFrameCheckin.crlDeleteTap(Sender: TObject; const Point: TPointF);
begin
  {$IFNDEF MSWINDOWS}
  if Assigned(FOnDelete) then
    FOnDelete(Self, FId);
  {$ENDIF}
end;

procedure TFrameCheckin.crlEditClick(Sender: TObject);
begin
  {$IFDEF MSWINDOWS}
  if Assigned(FOnUpdate) then
    FOnUpdate(Self, FId);
  {$ENDIF}
end;

procedure TFrameCheckin.crlEditTap(Sender: TObject; const Point: TPointF);
begin
  {$IFNDEF MSWINDOWS}
  if Assigned(FOnUpdate) then
    FOnUpdate(Self, FId);
  {$ENDIF}
end;

procedure TFrameCheckin.retContentClick(Sender: TObject);
begin
  {$IFDEF MSWINDOWS}
  if Assigned(FOnUpdate) then
    FOnUpdate(Self, FId);
  {$ENDIF}
end;

end.
