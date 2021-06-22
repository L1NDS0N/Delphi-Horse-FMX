unit Views.Hospedes;

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
  Services.Hospedes;

type
  TfrmHospedes = class(TForm)
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
    procedure FormShow(Sender: TObject);
    procedure Circle1Click(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    private
      FService: TServiceHospedes;
      procedure Salvar;
      procedure Listar;
      procedure Incluir;
      procedure OnDelete(const ASender: TFrame; const AId: string);
      procedure OnUpdate(const ASender: TFrame; const AId: string);
    public
      { Public declarations }
  end;

var
  frmHospedes: TfrmHospedes;

implementation

uses
  Providers.Frames.Hospede;

{$R *.fmx}

procedure TfrmHospedes.btnCancelarClick(Sender: TObject);
  begin
    tclCadastro.Previous();
  end;

procedure TfrmHospedes.btnSalvarClick(Sender: TObject);
  begin
    Salvar;
  end;

procedure TfrmHospedes.Circle1Click(Sender: TObject);
  begin
    Incluir;
  end;

procedure TfrmHospedes.FormCreate(Sender: TObject);
  begin
    FService := TServiceHospedes.Create(Self);
  end;

procedure TfrmHospedes.FormDestroy(Sender: TObject);
  begin
    FService.Free;
  end;

procedure TfrmHospedes.FormShow(Sender: TObject);
  begin
    tclCadastro.ActiveTab := tabBuscar;
    Listar;
  end;

procedure TfrmHospedes.Incluir;
  begin
    edtNome.Text := EmptyStr;
    edtDocumento.Text := EmptyStr;
    edtTelefone.Text := EmptyStr;
    tclCadastro.Next();
  end;

procedure TfrmHospedes.Listar;
  var
    LFrame: TFrameHospede;
    I: Integer;
  begin
    vsbPesquisa.BeginUpdate;
    try
      try
        for I := Pred(vsbPesquisa.Content.ControlsCount) downto 0 do
          vsbPesquisa.Content.Controls[I].DisposeOf;
        FService.Listar;
        FService.mtPesquisaHospedes.First;
        while not FService.mtPesquisaHospedes.Eof do
          begin
            LFrame := TFrameHospede.Create(vsbPesquisa);
            LFrame.Parent := vsbPesquisa;
            LFrame.Align := TAlignLayout.Top;
            LFrame.Position.X := vsbPesquisa.Content.ControlsCount * LFrame.Height;

            LFrame.Id := FService.mtPesquisaHospedesid.AsString;
            LFrame.Name := LFrame.ClassName + FService.mtPesquisaHospedesid.AsString;
            LFrame.lblNome.Text := FService.mtPesquisaHospedesnome.AsString;
            LFrame.lblDocumento.Text := FService.mtPesquisaHospedesdocumento.AsString;
            LFrame.lblTelefone.Text := FService.mtPesquisaHospedestelefone.AsString;

            LFrame.OnDelete := Self.OnDelete;
            LFrame.OnUpdate := Self.OnUpdate;
            FService.mtPesquisaHospedes.Next;
          end;
      except
        on E: Exception do
          ShowMessage(E.Message);
      end;
    finally
      vsbPesquisa.EndUpdate;
    end;

  end;

procedure TfrmHospedes.OnDelete(const ASender: TFrame; const AId: string);
  begin
    try
      TDialogService.MessageDialog('Tem certeza que deseja deletar?', TMsgDlgType.mtConfirmation, FMX.Dialogs.mbYesNo,
        TMsgDlgBtn.mbNo, 0,
          procedure(const AResult: TModalResult)
          begin
            if AResult <> mrYes then
              abort;
          end);
      FService.Delete(AId);
      ASender.DisposeOf;
    except
      on E: Exception do
        ShowMessage(E.Message);
    end;
  end;

procedure TfrmHospedes.OnUpdate(const ASender: TFrame; const AId: string);
  begin
    try
      FService.GetById(AId);
      edtNome.Text := FService.mtCadastroHospedesnome.AsString;
      edtDocumento.Text := FService.mtCadastroHospedesdocumento.AsString;
      edtTelefone.Text := FService.mtCadastroHospedestelefone.AsString;
      tclCadastro.Next();
    except
      on E: Exception do
        ShowMessage(E.Message);
    end;
  end;

procedure TfrmHospedes.Salvar;
  begin
    try
      if (FService.mtCadastroHospedesid.AsInteger > 0) then
        FService.mtCadastroHospedes.Edit
      else
        FService.mtCadastroHospedes.Append;

      FService.mtCadastroHospedesnome.AsString := edtNome.Text;
      FService.mtCadastroHospedesdocumento.AsString := edtDocumento.Text;
      FService.mtCadastroHospedestelefone.AsString := edtTelefone.Text;
      FService.mtCadastroHospedes.Post;
      FService.Salvar;
      Listar;
      tclCadastro.Previous();
    except
      on E: Exception do
        ShowMessage(E.Message);
    end;
  end;

end.
