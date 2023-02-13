// PAGE NOTES:
// - Known flutter issue when assigning values to texteditingcontrollers, field
// formats are not applied until the user makes a change to the field.
import 'package:flutter/material.dart';
import 'package:rhig_cart_vendor/models/edit_vendor_model.dart';
import 'package:rhig_cart_vendor/theme_controller_model.dart';
import 'package:rhig_cart_vendor/reusables/input_formats.dart';
import 'package:rhig_cart_vendor/constants.dart';

//Build Standard input field
class InputField extends StatefulWidget {
  final FocusNode node;
  final FocusNode nextNode;
  final TextEditingController controller;
  final String label;
  final String hint;
  final bool isLast;
  final bool isPassword;
  final bool isNumber;
  final bool isCellNumber;
  final String errorText;
  final bool isRequired;
  final bool hasIcon;
  final IconData icon;

  const InputField(
      {Key? key,
      required this.node,
      required this.nextNode,
      required this.controller,
      required this.label,
      required this.hint,
      this.isLast = false,
      this.isPassword = false,
      this.isNumber = false,
      this.isCellNumber = false,
      required this.errorText,
      this.isRequired = true,
      this.hasIcon = false,
      this.icon = Icons.abc})
      : super(key: key);

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  //Set to false if by default passwords should show
  bool _passwordObscured = true;
  @override
  Widget build(BuildContext context) {
    String errorText = widget.errorText;
    return Theme(
      data: ThemeData(
        colorScheme:
            ColorScheme.fromSwatch(accentColor: Color(myPrefs.dColourMain1)),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Color(myPrefs.dColourMain1),
          selectionHandleColor: Color(myPrefs.dColourMain1),
          selectionColor: myPrefs.dColourSelection,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.label, style: kLabelStyle),
          TextField(
            focusNode: widget.node,
            controller: widget.controller,
            keyboardType: widget.isNumber ? TextInputType.number : null,
            inputFormatters: widget.isCellNumber ? [CellFormatter()] : null,
            textInputAction:
                widget.isLast ? TextInputAction.done : TextInputAction.next,
            obscureText: widget.isPassword ? _passwordObscured : false,
            obscuringCharacter: '*',
            onSubmitted: (value) {
              //The following line activates the keyboard for the next field when pressing the
              //next button in the current field
              widget.isLast
                  ? null
                  : FocusScope.of(context).requestFocus(widget.nextNode);
            },
            cursorColor: Color(myPrefs.dColourMain1),
            decoration: InputDecoration(
              filled: true,
              fillColor: kColourInputBackground,
              border: InputBorder.none,
              hintText: (widget.hint),
              hintStyle: kHintStyle,
              contentPadding: const EdgeInsets.only(left: 15),
              errorText: errorText.isNotEmpty ? errorText : null,
              suffixIcon: widget.isPassword
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          _passwordObscured = !_passwordObscured;
                        });
                      },
                      icon: Icon(
                        _passwordObscured
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                      ),
                    )
                  : widget.hasIcon
                      ? Icon(
                          widget.icon,
                          color: kColourRHIGLightGrey,
                        )
                      : null,
              errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius:
                      BorderRadius.all(Radius.circular(kInputRadius))),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius:
                      BorderRadius.all(Radius.circular(kInputRadius))),
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius:
                      BorderRadius.all(Radius.circular(kInputRadius))),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(myPrefs.dColourMain1)),
                  borderRadius:
                      BorderRadius.all(Radius.circular(kInputRadius))),
            ),
          ),
        ],
      ),
    );
  }
}

//Build OTP input field
class OTPField extends StatefulWidget {
  final FocusNode node;
  final FocusNode nextNode;
  final FocusNode lastNode;
  final TextEditingController controller;
  final bool isLast;
  final String errorText;
  final double width;

  const OTPField({
    Key? key,
    required this.node,
    required this.nextNode,
    required this.lastNode,
    required this.controller,
    required this.isLast,
    this.errorText = '',
    required this.width,
  }) : super(key: key);

  @override
  State<OTPField> createState() => _OTPFieldState();
}

class _OTPFieldState extends State<OTPField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: TextField(
        textAlign: TextAlign.center,
        focusNode: widget.node,
        controller: widget.controller,
        keyboardType: TextInputType.number,
        inputFormatters: [OTPFormatter()],
        textInputAction:
            widget.isLast ? TextInputAction.done : TextInputAction.next,
        onSubmitted: (value) {
          //The following line activates the keyboard for the next field when pressing the
          //next button in the current field
          widget.isLast
              ? null
              : FocusScope.of(context).requestFocus(widget.nextNode);
        },
        onChanged: (value) {
          //The following lines focus on the next field when a digit is entered
          widget.controller.text.isNotEmpty
              ? widget.isLast
                  ? FocusScope.of(context).unfocus()
                  : FocusScope.of(context).requestFocus(widget.nextNode)
              : FocusScope.of(context).requestFocus(widget.lastNode);
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: kColourInputBackground,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(top: 5),
          errorText: widget.errorText.isNotEmpty ? widget.errorText : null,
          errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.all(Radius.circular(kInputRadius))),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.all(Radius.circular(kInputRadius))),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.all(Radius.circular(kInputRadius))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(myPrefs.dColourMain1)),
              borderRadius: BorderRadius.all(Radius.circular(kInputRadius))),
        ),
      ),
    );
  }
}

//Build checkbox field
class CheckBoxField extends StatefulWidget {
  final String label;
  final EditVendor myVendor;
  final PreferenceController myPrefs;
  const CheckBoxField(
      {Key? key,
      required this.label,
      required this.myVendor,
      required this.myPrefs})
      : super(key: key);

  @override
  State<CheckBoxField> createState() => _CheckBoxFieldState();
}

class _CheckBoxFieldState extends State<CheckBoxField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            value: widget.myVendor.newsletter,
            activeColor: Color(widget.myPrefs.dColourMain1),
            onChanged: (bool? value) {
              setState(() {
                widget.myVendor.newsletter = value!;
              });
            }),
        Flexible(
          child: Text(
            widget.label,
            style: kLabelStyle,
          ),
        ),
      ],
    );
  }
}
