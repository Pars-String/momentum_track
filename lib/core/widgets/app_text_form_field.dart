import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:momentum_track/core/utils/extensions/context_extension.dart';

class AppTextFormField extends StatefulWidget {
  final String? label;
  final GlobalKey<FormState>? formKey;
  final String? hint;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final String? Function(String? value)? validator;
  final String? validatorText;
  final bool? autoFocus;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onTapSuffixIcon;
  final Function(String value)? onChange;
  final Function(String value)? onFieldSubmitted;
  final FocusNode? nextFocusNode;
  final Function()? onEditingComplete;
  final int? maxLength;
  final Function(FocusNode? focusNode)? onTap;
  final FocusNode? focusNode;
  final bool readOnly;
  final int? customLines;
  final int? maxLines;
  final int? minLines;

  const AppTextFormField({
    super.key,
    this.keyboardType,
    this.textInputAction,
    this.controller,
    this.maxLength,
    this.formKey,
    this.label,
    this.hint,
    this.validatorText,
    this.validator,
    this.autoFocus = false,
    this.prefixIcon,
    this.suffixIcon,
    this.onTapSuffixIcon,
    this.onChange,
    this.onEditingComplete,
    this.nextFocusNode,
    this.onFieldSubmitted,
    this.onTap,
    this.focusNode,
    this.readOnly = false,
    this.customLines,
    this.maxLines,
    this.minLines,
  });

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  // bool _hasFocus = false;

  // @override
  // void initState() {
  //   super.initState();
  //   widget.focusNode?.addListener(_handleFocusChange);
  // }

  // @override
  // void dispose() {
  //   widget.focusNode?.removeListener(_handleFocusChange);
  //   super.dispose();
  // }

  // void _handleFocusChange() {
  //   setState(() {
  //     _hasFocus = widget.focusNode?.hasFocus ?? false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    if (widget.label != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label!,
            style: TextStyle(
              // color: _hasFocus ? Colors.white : Colors.green,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Gap(6),
          if (widget.validatorText == null)
            _customTextFormField(context)
          else
            Form(key: widget.formKey, child: _customTextFormField(context)),
        ],
      );
    } else {
      if (widget.validatorText == null) {
        return _customTextFormField(context);
      } else {
        return Form(key: widget.formKey, child: _customTextFormField(context));
      }
    }
  }

  TextFormField _customTextFormField(BuildContext ctx) {
    return TextFormField(
      focusNode: widget.focusNode,
      onTap: widget.onTap == null
          ? null
          : () => widget.onTap!(widget.focusNode),
      onFieldSubmitted:
          widget.onFieldSubmitted ??
          (s) {
            FocusScope.of(ctx).requestFocus(widget.nextFocusNode);
          },
      style: TextStyle(
        // color: AppColors.white,
        fontSize: 18,
        fontWeight: FontWeight.w400,
      ),

      maxLength: widget.maxLength,
      readOnly: widget.readOnly,
      onEditingComplete: widget.onEditingComplete,
      controller: widget.controller,
      onChanged: widget.onChange,
      textInputAction: widget.textInputAction,
      keyboardType: widget.keyboardType,
      obscureText: widget.keyboardType == TextInputType.visiblePassword,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      validator: widget.validatorText == null
          ? widget.validator
          : (value) {
              if (value!.isEmpty) {
                return widget.validatorText;
              }
              return null;
            },
      autofocus: widget.autoFocus!,
      // cursorColor: AppColors.mediumGray,
      mouseCursor: MouseCursor.defer,
      decoration: InputDecoration(
        hoverColor: Theme.of(
          context,
        ).colorScheme.outlineVariant.withOpacity(.05),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 10,
        ),
        hintStyle: TextStyle(
          // color: AppColors.gray,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        // errorStyle: AppTextStyle.getRegularXsStyle(
        //   color:
        //       _hasFocus
        //           ? AppColors.accentWarning700
        //           : AppColors.accentWarning900,
        // ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: context.colorScheme.error),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        hintText: widget.hint,
        prefixIcon: widget.prefixIcon == null
            ? null
            : Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Icon(widget.prefixIcon),
              ),
        // prefixIconColor: AppColors.mediumGray,
        prefixIconConstraints: const BoxConstraints(
          minHeight: 24,
          minWidth: 24,
        ),
        suffixIcon: widget.suffixIcon == null
            ? null
            : Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: InkWell(
                  onTap: widget.onTapSuffixIcon,
                  child: Icon(widget.suffixIcon),
                ),
              ),
        counterText: '',
        // fillColor: AppColors.deepBlueGray,
        filled: true,
      ),
    );
  }
}
