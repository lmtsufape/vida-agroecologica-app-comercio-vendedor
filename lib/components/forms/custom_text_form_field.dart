import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    Key? key,
    this.onChanged,
    this.label,
    this.maskFormatter,
    this.controller,
    this.keyboardType,
    this.hintText,
    this.hintStyle,
    this.isPassword,
    this.icon,
    this.isBordered,
    this.validatorError,
    this.erroStyle,
    this.enabled,
    this.autoValidate,
  }) : super(key: key);

  final Function(String)? onChanged;
  final String? label;
  final MaskTextInputFormatter? maskFormatter;
  final String? hintText;
  final TextStyle? hintStyle;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool? isPassword;
  final IconData? icon;
  final bool? isBordered;
  final dynamic validatorError;
  final dynamic erroStyle;
  final bool? enabled;
  final dynamic autoValidate;

  @override
  State<CustomTextFormField> createState() =>
      _CustomTextFormFieldState();
}

class _CustomTextFormFieldState
    extends State<CustomTextFormField> {
  bool _obscureText = false;

  @override
  void initState() {
    if (widget.isPassword != null) {
      _obscureText = widget.isPassword!;
    }
    super.initState();
  }

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return TextFormField(
      autovalidateMode: widget.autoValidate,
      enabled: widget.enabled,
      onChanged: widget.onChanged,
      inputFormatters: widget.maskFormatter == null
          ? null
          : [widget.maskFormatter!],
      validator: widget.validatorError,
      obscureText: _obscureText,
      controller: widget.controller,
      decoration: InputDecoration(
        errorStyle: widget.erroStyle,
        prefixIcon:
            widget.icon == null ? null : Icon(widget.icon),
        labelText: widget.label,
        filled: true,
        fillColor: Colors.white,
        hintText: widget.hintText,
        hintStyle: widget.hintStyle ??
            TextStyle(fontSize: size.height * 0.02),
        suffixIcon: widget.isPassword == true
            ? InkWell(
                onTap: () => _toggleVisibility(),
                child: Icon(
                  _obscureText
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
              )
            : null,
      ),
    );
  }
}

class CustomTextFormFieldCurrency extends StatefulWidget {
  const CustomTextFormFieldCurrency({
    Key? key,
    this.onChanged,
    this.label,
    this.currencyFormatter,
    this.controller,
    this.keyboardType,
    this.hintText,
    this.hintStyle,
    this.isPassword,
    this.icon,
    this.isBordered,
    this.validatorError,
    this.erroStyle,
    this.enabled,
    this.autoValidate,
  }) : super(key: key);

  final Function(String)? onChanged;
  final String? label;
  final List<TextInputFormatter>? currencyFormatter;
  final String? hintText;
  final TextStyle? hintStyle;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool? isPassword;
  final IconData? icon;
  final bool? isBordered;
  final dynamic validatorError;
  final dynamic erroStyle;
  final bool? enabled;
  final dynamic autoValidate;

  @override
  State<CustomTextFormFieldCurrency> createState() =>
      _CustomTextFormFieldCurrencyState();
}

class _CustomTextFormFieldCurrencyState
    extends State<CustomTextFormFieldCurrency> {
  bool _obscureText = false;

  @override
  void initState() {
    if (widget.isPassword != null) {
      _obscureText = widget.isPassword!;
    }
    super.initState();
  }

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      child: TextFormField(
        autovalidateMode: widget.autoValidate,
        enabled: widget.enabled,
        onChanged: widget.onChanged,
        inputFormatters: widget.currencyFormatter,
        obscureText: _obscureText,
        controller: widget.controller,
        validator: widget.validatorError,
        decoration: InputDecoration(
          errorStyle: widget.erroStyle,
          prefixIcon: widget.icon == null
              ? null
              : Icon(widget.icon),
          labelText: widget.label,
          filled: true,
          fillColor: Colors.white,
          hintText: widget.hintText,
          hintStyle: widget.hintStyle ??
              TextStyle(fontSize: size.height * 0.02),
          suffixIcon: widget.isPassword == true
              ? InkWell(
                  onTap: () => _toggleVisibility(),
                  child: Icon(
                    _obscureText
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}

class CustomTextFormFieldTime extends StatefulWidget {
  const CustomTextFormFieldTime({
    Key? key,
    this.onChanged,
    this.label,
    this.timeFormatter,
    this.controller,
    this.keyboardType,
    this.isPassword,
    this.icon,
    this.isBordered,
    this.erroStyle,
    this.validatorError,
    this.style,
  }) : super(key: key);

  final Function(String)? onChanged;
  final String? label;
  final List<TextInputFormatter>? timeFormatter;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool? isPassword;
  final IconData? icon;
  final bool? isBordered;
  final dynamic validatorError;
  final dynamic erroStyle;
  final TextStyle? style;

  @override
  State<CustomTextFormFieldTime> createState() =>
      _CustomTextFormFieldTimeState();
}

class _CustomTextFormFieldTimeState
    extends State<CustomTextFormFieldTime> {
  bool _obscureText = false;

  @override
  void initState() {
    if (widget.isPassword != null) {
      _obscureText = widget.isPassword!;
    }
    super.initState();
  }

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      child: TextFormField(
        autovalidateMode:
            AutovalidateMode.onUserInteraction,
        validator: widget.validatorError,
        onChanged: widget.onChanged,
        inputFormatters: widget.timeFormatter ?? [],
        obscureText: _obscureText,
        controller: widget.controller,
        style: widget.style,
        decoration: InputDecoration(
          errorStyle: widget.erroStyle,
          prefixIcon: widget.icon == null
              ? null
              : Icon(widget.icon),
          labelText: widget.label,
          filled: true,
          fillColor: Colors.white,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          suffixIcon: widget.isPassword == true
              ? InkWell(
                  onTap: () => _toggleVisibility(),
                  child: Icon(
                    _obscureText
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
