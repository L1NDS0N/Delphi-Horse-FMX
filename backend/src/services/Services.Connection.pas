unit Services.Connection;

interface

uses
  System.SysUtils,
  System.Classes,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.ConsoleUI.Wait,
  FireDAC.Phys.MySQLDef,
  FireDAC.Phys.MySQL,
  Data.DB,
  FireDAC.Comp.Client;

type
  TServiceConnection = class(TDataModule)
    DBConnection: TFDConnection;
    MySqlDriver: TFDPhysMySQLDriverLink;
    private
      { Private declarations }
    public

  end;

var
  ServiceConnection: TServiceConnection;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}
{$R *.dfm}

end.
