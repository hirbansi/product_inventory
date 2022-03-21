import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:incdnc/screens/camera_and_gallary.dart';

ElevatedButton elevatedButton(
    {String? buttonName, Function()? onPressbtn, Color? color}) {
  return ElevatedButton(
    style: ButtonStyle(
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
        backgroundColor: MaterialStateProperty.all(color)),
    onPressed: onPressbtn,
    child: Text(
      buttonName!,
      style: GoogleFonts.marmelad(
        fontWeight: FontWeight.w400,
        color: Colors.black,
        fontSize: 18,
      ),
    ),
  );
}

Widget? textFormField(
    {String? Function(dynamic val)? validator,
    String? labelText,
    String? value,
    bool? enabled,
    Widget? icon,
    TextEditingController? controller,
    double? fontSize,
    Widget? suffixIcon}) {
  return TextFormField(
    decoration: InputDecoration(
        labelText: labelText,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(),
        prefixIcon: icon),
    validator: validator,
    enabled: enabled,
    initialValue: value,
    controller: controller,
    style: TextStyle(fontSize: fontSize),
  );
}

datePickerFunc(
  BuildContext context,
  TextEditingController controller,
) async {
  DateTime selectedDate = DateTime.now();
  final selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now());
  if (selected != null && selected != selectedDate) {
    selectedDate = selected;
    print(selectedDate);
    controller.text = selectedDate.toString();
  }
}

text({String? string, double? fontsize, FontWeight? fontweight, Color? color,}) {
  return Text(
    string!,
    style: TextStyle(
      fontSize: fontsize ?? null,
      fontWeight: fontweight ?? null,
      color: color ?? null,
    ),
    maxLines: 2,
  );
}
 handleButtons(BuildContext context, var type) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => CameraAndGallary(type)));
}

/* Image From Gallery */

