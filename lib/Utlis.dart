
import 'package:permission_handler/permission_handler.dart';

Future<bool> requestPermission(permission) async{
  if(await permission.isGranted) {
    return true;
  }else{
    var result =await permission.request();
    if(result == PermissionStatus.granted){
      return true;
    }
  }
  return false;
}