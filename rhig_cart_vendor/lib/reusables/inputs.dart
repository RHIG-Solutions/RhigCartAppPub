import 'package:flutter/material.dart';
import 'package:rhig_cart_vendor/models/vendor_model.dart';
import 'package:rhig_cart_vendor/styles.dart';
import 'package:rhig_cart_vendor/reusables/input_formats.dart';

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
      this.errorText = '',
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
    return Column(
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
          decoration: InputDecoration(
            filled: true,
            fillColor: kInputBackground,
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
                        color: kRHIGLightGrey,
                      )
                    : null,
          ),
        ),
      ],
    );
  }
}

class CheckBoxField extends StatefulWidget {
  final String label;
  final Vendor myVendor;
  const CheckBoxField({Key? key, required this.label, required this.myVendor})
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
            activeColor: kRHIGDarkGreen,
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
