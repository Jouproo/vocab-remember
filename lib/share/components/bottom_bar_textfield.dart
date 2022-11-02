import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomBarTextField extends StatefulWidget {


  final String ? hint;
  final String ? label;
  final Icon ? icon;
  final double ? horMargin;
  final double ?  verMargin;
  final TextInputType ?  inputType;
  final bool ? isPassword;
  final Function ? onChanged;
  final bool  Function(String) ? validator;
  final String ? errorText;
  final double ?  radius ;
 // final TextEditingController ? controller ;


   BottomBarTextField(
      { this.icon,
        this.horMargin,
        this.verMargin,
        this.inputType,
        this.isPassword = false,
        this.hint,
        this.label,
        this.validator,
        this.errorText,
        this.radius = 10,
        required this.onChanged,
       // required this.controller
      });

  @override
  _BottomBarTextFieldState createState() => _BottomBarTextFieldState();
}

class _BottomBarTextFieldState extends State<BottomBarTextField> {
  bool visibleIcon = false;
  TextEditingController controller = TextEditingController();
  @override
  void dispose() {
    super.dispose();
   // widget.
    controller.clear();
  //  widget.
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: widget.horMargin!, vertical: widget.verMargin!),
      child: TextFormField(

        validator: (value){
          if (value!.isEmpty){
            return widget.errorText ;
          }
          return null;
        },
        controller:controller,
        onChanged: (value) {
          widget.onChanged!(value);
        },
        decoration: InputDecoration(
          border:   OutlineInputBorder( borderRadius: BorderRadius.all(Radius.circular(widget.radius!))),
          hintText: widget.hint,
          labelText:widget.label! ,
          errorText:
              (widget.validator != null && !widget.validator!(controller.text))
                  ? widget.errorText
                  : null,
          prefixIcon: widget.icon,
          suffix:  (widget.isPassword!) ? (visibleIcon) ? GestureDetector(
            onTap: () {
              setState(() {
                visibleIcon = !visibleIcon;
              });
            },
            child: Icon(
              Icons.visibility,
              color: Theme.of(context).primaryColor,
            ),
          )
              : GestureDetector(
            onTap: () {
              setState(() {
                visibleIcon = !visibleIcon;
              });
            },
            child: Icon(
              Icons.visibility_off,
              color: Theme.of(context).primaryColor,
            ),
          ) : null
        ),
        keyboardType: widget.inputType,
        obscureText: (widget.isPassword!) ? (visibleIcon) ? false : true
            : false,

      ),
    );
  }
}
