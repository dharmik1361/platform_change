import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';


class Utils{
  call(String? phone){
    launchUrl(Uri.parse('tel:$phone'));
  }

  Future<String> pickImage() async{
    XFile? pickedImage =await ImagePicker().pickImage(source: ImageSource.camera);
    return pickedImage?.path??'';
  }
}