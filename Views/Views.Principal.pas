unit Views.Principal;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Layouts,
  FMX.Controls.Presentation,
  FMX.MultiView,
  FMX.TabControl,
  System.ImageList,
  FMX.ImgList,
  FMX.StdCtrls,
  FMX.Ani,
  FMX.Objects,
  FMX.Edit,
  FMX.DialogService,
  Services.Hospedes,
  Services.Checkins,
  FMX.Colors,
  FMX.ListBox,
  FMX.DateTimeCtrls,
  FMX.ComboEdit,
  FMX.EditBox,
  FMX.ComboTrackBar;

type
  TfrmPrincipal = class(TForm)
    Layout1: TLayout;
    tclAbas: TTabControl;
    tabHospedes: TTabItem;
    tabCheckins: TTabItem;
    tclCadastro: TTabControl;
    tabCadastro: TTabItem;
    tabBuscar: TTabItem;
    pnlFooter: TPanel;
    retFooter: TRectangle;
    Circle2: TCircle;
    Circle1: TCircle;
    imgAdd: TPath;
    ColorAnimation1: TColorAnimation;
    retHeader: TRectangle;
    Label1: TLabel;
    vsbPesquisa: TVertScrollBox;
    pnlMain: TPanel;
    pnlMainCadastro: TPanel;
    edtTelefone: TEdit;
    lineEmail: TLine;
    edtNome: TEdit;
    lineNome: TLine;
    edtDocumento: TEdit;
    lineSobrenome: TLine;
    lblTelefone: TLabel;
    lblDocumento: TLabel;
    Nome: TLabel;
    retCancelar: TRectangle;
    btnCancelar: TSpeedButton;
    retSalvar: TRectangle;
    btnSalvar: TSpeedButton;
    pnlFooterCadastro: TPanel;
    Rectangle1: TRectangle;
    Label2: TLabel;
    retBody: TRectangle;
    tclCadastroCheckin: TTabControl;
    tabBuscarCheckin: TTabItem;
    tabCadastroCheckin: TTabItem;
    Rectangle2: TRectangle;
    vsbCheckin: TVertScrollBox;
    Panel1: TPanel;
    Rectangle3: TRectangle;
    Circle3: TCircle;
    Circle4: TCircle;
    Path1: TPath;
    ColorAnimation2: TColorAnimation;
    Rectangle4: TRectangle;
    Label3: TLabel;
    Rectangle5: TRectangle;
    Label4: TLabel;
    Panel2: TPanel;
    Panel3: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Panel4: TPanel;
    Rectangle6: TRectangle;
    SpeedButton1: TSpeedButton;
    Rectangle7: TRectangle;
    SpeedButton2: TSpeedButton;
    cbHospede: TComboEdit;
    Line2: TLine;
    Panel5: TPanel;
    Switch1: TSwitch;
    Label8: TLabel;
    Panel7: TPanel;
    dtEntrada: TDateEdit;
    dtSaida: TDateEdit;
    StyleBook1: TStyleBook;
    Line1: TLine;
    Line3: TLine;
    cbIdHospede: TComboEdit;
    pnlDatas: TPanel;
    pnlLblDatas: TPanel;
    procedure FormShow(Sender: TObject);
    procedure Circle1Click(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Circle4Click(Sender: TObject);
    procedure tabCheckinsClick(Sender: TObject);
    procedure tabCheckinsTap(Sender: TObject; const Point: TPointF);
    procedure tabHospedesTap(Sender: TObject; const Point: TPointF);
    procedure SpeedButton1Click(Sender: TObject);
    procedure cbHospedeChangeTracking(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    private
      FServiceHospede: TServiceHospedes;
      FServiceCheckin: TServiceCheckin;
      procedure SalvarHospedes;
      procedure ListarHospedes;
      procedure IncluirHospedes;
      procedure OnDeleteHospede(const ASender: TFrame; const AId: string);
      procedure OnUpdateHospede(const ASender: TFrame; const AId: string);

      procedure SalvarCheckin;
      procedure IncluirCheckins;
      procedure ListarCheckins;
      procedure OnDeleteCheckin(const ASender: TFrame; const AId: string);
      procedure OnUpdateCheckin(const ASender: TFrame; const AId: string);
    public
      { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  Providers.Frames.Hospede,
  Providers.Frames.Checkin;

{$R *.fmx}

procedure TfrmPrincipal.btnCancelarClick(Sender: TObject);
begin
  tclCadastro.Previous();
  FServiceHospede.mtCadastroHospedes.Cancel;
end;

procedure TfrmPrincipal.btnSalvarClick(Sender: TObject);
begin
  SalvarHospedes;
end;

procedure TfrmPrincipal.cbHospedeChangeTracking(Sender: TObject);
begin
  cbIdHospede.ItemIndex := cbHospede.ItemIndex;
end;

procedure TfrmPrincipal.Circle1Click(Sender: TObject);
begin
  IncluirHospedes;
end;

procedure TfrmPrincipal.Circle4Click(Sender: TObject);
begin
  IncluirCheckins;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  FServiceHospede := TServiceHospedes.Create(Self);
  FServiceCheckin := TServiceCheckin.Create(Self);
end;

procedure TfrmPrincipal.FormDestroy(Sender: TObject);
begin
  FServiceHospede.Free;
  FServiceCheckin.Free;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  tclAbas.ActiveTab := tabHospedes;
  tclCadastro.ActiveTab := tabBuscar;
  tclCadastroCheckin.ActiveTab := tabBuscarCheckin;
  ListarHospedes;
end;

procedure TfrmPrincipal.IncluirCheckins;
begin
  try
    ListarCheckins;

    dtEntrada.Date := Now;
    dtSaida.Date := IncMonth(Now);
    Switch1.IsChecked := False;

    cbIdHospede.Text := EmptyStr;
    cbIdHospede.Items.Clear;
    cbIdHospede.BeginUpdate;

    cbHospede.Enabled := True;
    cbHospede.Text := EmptyStr;

    cbHospede.Items.Clear;
    cbHospede.BeginUpdate;

    FServiceHospede.mtPesquisaHospedes.First;
    while not FServiceHospede.mtPesquisaHospedes.Eof do
    begin
      cbHospede.Items.Add(FServiceHospede.mtPesquisaHospedesnome.AsString);
      cbIdHospede.Items.Add(FServiceHospede.mtPesquisaHospedesid.AsString);
      FServiceHospede.mtPesquisaHospedes.Next;
    end;

    FServiceHospede.mtPesquisaHospedes.First;
    while not FServiceHospede.mtPesquisaHospedes.Eof do
    begin

      FServiceCheckin.mtPesquisaCheckin.First;
      while not FServiceCheckin.mtPesquisaCheckin.Eof do
      begin
        if (FServiceHospede.mtPesquisaHospedesid.AsInteger = FServiceCheckin.mtPesquisaCheckinhospede.AsInteger) then
        begin
          cbHospede.Items.Delete(cbHospede.Items.IndexOf(FServiceCheckin.mtPesquisaCheckinlkphospede.AsString));
          cbIdHospede.Items.Delete(cbIdHospede.Items.IndexOf(FServiceCheckin.mtPesquisaCheckinhospede.AsString));

        end;

        FServiceCheckin.mtPesquisaCheckin.Next;
      end;

      FServiceHospede.mtPesquisaHospedes.Next;
    end;
  finally
    if cbHospede.Items.Text = EmptyStr then
    begin
      cbHospede.Text := 'Todos os hóspedes estão com as reservas agendadas';
      cbHospede.Enabled := False;
    end;

    cbIdHospede.EndUpdate;
    cbHospede.EndUpdate;
    cbHospede.SetFocus;
  end;

  FServiceCheckin.mtCadastroCheckin.Append;
  tclCadastroCheckin.Next;
end;

procedure TfrmPrincipal.IncluirHospedes;
begin
  edtNome.Text := EmptyStr;
  edtDocumento.Text := EmptyStr;
  edtTelefone.Text := EmptyStr;
  FServiceHospede.mtCadastroHospedes.Append;
  tclCadastro.Next();
end;

procedure TfrmPrincipal.ListarCheckins;
var
  LFrame: TFrameCheckin;
  I: Integer;
begin
  vsbCheckin.BeginUpdate;
  try
    try
      for I := Pred(vsbCheckin.Content.ControlsCount) downto 0 do
        vsbCheckin.Content.Controls[I].DisposeOf;
      FServiceCheckin.Listar;
      FServiceCheckin.mtPesquisaCheckin.First;
      while not FServiceCheckin.mtPesquisaCheckin.Eof do
      begin
        LFrame := TFrameCheckin.Create(vsbCheckin);
        LFrame.Parent := vsbCheckin;
        LFrame.Align := TAlignLayout.Top;
        LFrame.Position.X := vsbCheckin.Content.ControlsCount * LFrame.Height;

        LFrame.Id := FServiceCheckin.mtPesquisaCheckinid.AsString;
        LFrame.Name := LFrame.ClassName + FServiceCheckin.mtPesquisaCheckinhospede.AsString;
        LFrame.lblHospede.Text := FServiceCheckin.mtPesquisaCheckinlkphospede.AsString;
        LFrame.lblEntrada.Text := 'Entrada: ' + FServiceCheckin.mtPesquisaCheckindataentrada.AsString;
        LFrame.lblSaida.Text := 'Saída: ' + FServiceCheckin.mtPesquisaCheckindatasaida.AsString;
        LFrame.chkPossuiCarro.IsChecked := FServiceCheckin.mtPesquisaCheckinadicionalveiculo.AsBoolean;

        LFrame.OnDelete := Self.OnDeleteCheckin;
        LFrame.OnUpdate := Self.OnUpdateCheckin;
        FServiceCheckin.mtPesquisaCheckin.Next;
      end;
    except
      on E: Exception do
        ShowMessage(E.Message);
    end;
  finally
    vsbCheckin.EndUpdate;
  end;

end;

procedure TfrmPrincipal.ListarHospedes;
var
  LFrame: TFrameHospede;
  I: Integer;
begin
  vsbPesquisa.BeginUpdate;
  try
    try
      for I := Pred(vsbPesquisa.Content.ControlsCount) downto 0 do
        vsbPesquisa.Content.Controls[I].DisposeOf;
      FServiceHospede.Listar;
      FServiceHospede.mtPesquisaHospedes.First;
      while not FServiceHospede.mtPesquisaHospedes.Eof do
      begin
        LFrame := TFrameHospede.Create(vsbPesquisa);
        LFrame.Parent := vsbPesquisa;
        LFrame.Align := TAlignLayout.Top;
        LFrame.Position.X := vsbPesquisa.Content.ControlsCount * LFrame.Height;

        LFrame.Id := FServiceHospede.mtPesquisaHospedesid.AsString;
        LFrame.Name := LFrame.ClassName + FServiceHospede.mtPesquisaHospedesid.AsString;
        LFrame.lblNome.Text := FServiceHospede.mtPesquisaHospedesnome.AsString;
        LFrame.lblDocumento.Text := FServiceHospede.mtPesquisaHospedesdocumento.AsString;
        LFrame.lblTelefone.Text := FServiceHospede.mtPesquisaHospedestelefone.AsString;

        LFrame.OnDelete := Self.OnDeleteHospede;
        LFrame.OnUpdate := Self.OnUpdateHospede;
        FServiceHospede.mtPesquisaHospedes.Next;
      end;
    except
      on E: Exception do
        ShowMessage(E.Message);
    end;
  finally
    vsbPesquisa.EndUpdate;
  end;

end;

procedure TfrmPrincipal.OnDeleteHospede(const ASender: TFrame; const AId: string);
begin
  try
    TDialogService.MessageDialog('Tem certeza que deseja deletar?', TMsgDlgType.mtConfirmation, FMX.Dialogs.mbYesNo,
      TMsgDlgBtn.mbNo, 0,
        procedure(const AResult: TModalResult)
      begin
        if AResult <> mrYes then
          Abort;
      end);
    FServiceHospede.Delete(AId);
    ASender.DisposeOf;
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;

procedure TfrmPrincipal.OnDeleteCheckin(const ASender: TFrame; const AId: string);
begin
  try
    TDialogService.MessageDialog('Tem certeza que deseja deletar?', TMsgDlgType.mtConfirmation, FMX.Dialogs.mbYesNo,
      TMsgDlgBtn.mbNo, 0,
      procedure(const AResult: TModalResult)
      begin
        if AResult <> mrYes then
          Abort;
      end);
    FServiceCheckin.Delete(AId);
    ASender.DisposeOf;
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;

procedure TfrmPrincipal.OnUpdateHospede(const ASender: TFrame; const AId: string);
begin
  try
    FServiceHospede.GetById(AId);
    edtNome.Text := FServiceHospede.mtCadastroHospedesnome.AsString;
    edtDocumento.Text := FServiceHospede.mtCadastroHospedesdocumento.AsString;
    edtTelefone.Text := FServiceHospede.mtCadastroHospedestelefone.AsString;
    tclCadastro.Next();
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;

procedure TfrmPrincipal.OnUpdateCheckin(const ASender: TFrame; const AId: string);
begin
  try
    FServiceCheckin.GetById(AId);
    cbHospede.Items.Clear;
    cbHospede.Enabled := False;
    cbIdHospede.Text := FServiceCheckin.mtCadastroCheckinhospede.AsString;
    cbHospede.Text := FServiceCheckin.mtCadastroCheckinlkpHospede.AsString;
    dtEntrada.DateTime := FServiceCheckin.mtCadastroCheckindataentrada.AsDateTime;
    dtSaida.DateTime := FServiceCheckin.mtCadastroCheckindatasaida.AsDateTime;
    Switch1.IsChecked := FServiceCheckin.mtCadastroCheckinadicionalveiculo.AsBoolean;
    tclCadastroCheckin.Next();
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;

procedure TfrmPrincipal.SalvarCheckin;
begin
  try
    if (FServiceCheckin.mtCadastroCheckinid.AsInteger > 0) then
      FServiceCheckin.mtCadastroCheckin.Edit
    else
      FServiceCheckin.mtCadastroCheckin.Append;

    FServiceCheckin.mtCadastroCheckinhospede.AsInteger := StrToInt(cbIdHospede.Text);
    FServiceCheckin.mtCadastroCheckindataentrada.AsDateTime := dtEntrada.DateTime;
    FServiceCheckin.mtCadastroCheckindatasaida.AsDateTime := dtSaida.DateTime;
    FServiceCheckin.mtCadastroCheckinadicionalveiculo.AsBoolean := Switch1.IsChecked;
    FServiceCheckin.mtCadastroCheckin.Post;

    FServiceCheckin.Salvar;
    ListarCheckins;
    tclCadastroCheckin.Previous();
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;

procedure TfrmPrincipal.SalvarHospedes;
begin
  try
    if (FServiceHospede.mtCadastroHospedesid.AsInteger > 0) then
      FServiceHospede.mtCadastroHospedes.Edit
    else
      FServiceHospede.mtCadastroHospedes.Append;

    FServiceHospede.mtCadastroHospedesnome.AsString := edtNome.Text;
    FServiceHospede.mtCadastroHospedesdocumento.AsString := edtDocumento.Text;
    FServiceHospede.mtCadastroHospedestelefone.AsString := edtTelefone.Text;
    FServiceHospede.mtCadastroHospedes.Post;
    FServiceHospede.Salvar;
    ListarHospedes;
    tclCadastro.Previous();
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;

procedure TfrmPrincipal.SpeedButton1Click(Sender: TObject);
begin
  tclCadastroCheckin.Previous;
  FServiceCheckin.mtCadastroCheckin.Cancel;
end;

procedure TfrmPrincipal.SpeedButton2Click(Sender: TObject);
begin
  SalvarCheckin;
end;

procedure TfrmPrincipal.tabCheckinsClick(Sender: TObject);
begin
  ListarCheckins;
end;

procedure TfrmPrincipal.tabCheckinsTap(Sender: TObject; const Point: TPointF);
begin
  ListarCheckins;
end;

procedure TfrmPrincipal.tabHospedesTap(Sender: TObject; const Point: TPointF);
begin
  ListarHospedes;
end;

end.
