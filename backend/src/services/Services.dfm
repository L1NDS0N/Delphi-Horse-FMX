object ServiceConnection: TServiceConnection
  OldCreateOrder = False
  Height = 117
  Width = 74
  object Connection: TFDConnection
    Params.Strings = (
      'Database=hotelt'
      'Server=localhost'
      'User_Name=root'
      'Password=root'
      'DriverID=MySQL')
    Connected = True
    LoginPrompt = False
    Left = 24
    Top = 8
  end
  object MysqlDriver: TFDPhysMySQLDriverLink
    VendorLib = 
      'C:\Users\Lindson Fran'#231'a\Desktop\HotelTransilvania\backend\lib\li' +
      'bmySQL.dll'
    Left = 24
    Top = 64
  end
end
