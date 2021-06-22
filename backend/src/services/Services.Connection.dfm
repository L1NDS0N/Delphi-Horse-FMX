object ServiceConnection: TServiceConnection
  OldCreateOrder = False
  Height = 121
  Width = 88
  object DBConnection: TFDConnection
    ConnectionName = 'HotelT'
    Params.Strings = (
      'Database=HotelT'
      'User_Name=root'
      'Password=root'
      'Server=127.0.0.1'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 32
    Top = 8
  end
  object MySqlDriver: TFDPhysMySQLDriverLink
    VendorLib = 
      'C:\Users\Lindson Fran'#231'a\Desktop\HotelTransilvania\backend\lib\li' +
      'bmySQL.dll'
    Left = 32
    Top = 64
  end
end
