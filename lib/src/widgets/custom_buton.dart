import 'package:flutter/material.dart';


class ButtonWidget extends StatelessWidget {
  final String? butonText;
  final Color? butonColor;
  final Color? butonTextColor;
  final double? radius;
  final double? yukseklik;
  final Widget? butonIcon;
  final VoidCallback? onPressed;
  final FocusNode? focusNode;
  final Color? disableColor;
  final Size? ebat;
  final double? fontsize;

  const ButtonWidget({
    Key? key,
    @required this.butonText,
    this.butonColor= Colors.red,
    this.butonTextColor= Colors.white,
    this.radius= 10,
    this.yukseklik=32,
    this.fontsize,
    this.butonIcon,
    this.focusNode,
    this.disableColor=Colors.brown,
    this.onPressed,
    this.ebat,
  })  : assert(butonText != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return ElevatedButton.icon(
        icon: butonIcon!,
        label: Text(butonText!),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          alignment: Alignment.centerLeft,
          enabledMouseCursor: MouseCursor.defer,
          padding: EdgeInsets.symmetric(horizontal: 30),
          fixedSize: ebat,
          textStyle: TextStyle(
              //fontStyle: FontStyle.italic,
              fontSize: fontsize),
          shape: new RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(radius!))),
        ));
  }
}
