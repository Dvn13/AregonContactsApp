import 'package:contacts_app/Helpers/constants/color.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Toastr {
  static void show(String text, int state) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: state == 1
            ? ConstColor.darkgreen
            : state == 4
                ? ConstColor.grey
                : state == 5
                    ? ConstColor.red
                    : ConstColor.black,
        textColor: ConstColor.white,
        fontSize: 16.0);
  }
}
