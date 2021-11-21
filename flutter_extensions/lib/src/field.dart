import 'package:flutter/material.dart';

extension InputDecorationFlutterExtensions on InputDecoration {
  InputDecoration completeWith({
    Widget? icon,
    String? labelText,
    TextStyle? labelStyle,
    String? helperText,
    TextStyle? helperStyle,
    int? helperMaxLines,
    String? hintText,
    TextStyle? hintStyle,
    int? hintMaxLines,
    String? errorText,
    TextStyle? errorStyle,
    int? errorMaxLines,
    FloatingLabelBehavior? floatingLabelBehavior,
    bool? isDense,
    EdgeInsetsGeometry? contentPadding,
    Widget? prefixIcon,
    Widget? prefix,
    String? prefixText,
    TextStyle? prefixStyle,
    Widget? suffixIcon,
    Widget? suffix,
    String? suffixText,
    TextStyle? suffixStyle,
    Widget? counter,
    String? counterText,
    TextStyle? counterStyle,
    bool? filled,
    Color? fillColor,
    Color? focusColor,
    Color? hoverColor,
    InputBorder? errorBorder,
    InputBorder? focusedBorder,
    InputBorder? focusedErrorBorder,
    InputBorder? disabledBorder,
    InputBorder? enabledBorder,
    InputBorder? border,
    String? semanticCounterText,
    bool? alignLabelWithHint,
  }) {
    return InputDecoration(
      icon: this.icon ?? icon,
      labelText: this.labelText ?? labelText,
      labelStyle: this.labelStyle ?? labelStyle,
      helperText: this.helperText ?? helperText,
      helperStyle: this.helperStyle ?? helperStyle,
      helperMaxLines: this.helperMaxLines ?? helperMaxLines,
      hintText: this.hintText ?? hintText,
      hintStyle: this.hintStyle ?? hintStyle,
      hintMaxLines: this.hintMaxLines ?? hintMaxLines,
      errorText: this.errorText ?? errorText,
      errorStyle: this.errorStyle ?? errorStyle,
      errorMaxLines: this.errorMaxLines ?? errorMaxLines,
      floatingLabelBehavior: this.floatingLabelBehavior ?? floatingLabelBehavior,
      isDense: this.isDense ?? isDense,
      contentPadding: this.contentPadding ?? contentPadding,
      prefixIcon: this.prefixIcon ?? prefixIcon,
      prefix: this.prefix ?? prefix,
      prefixText: this.prefixText ?? prefixText,
      prefixStyle: this.prefixStyle ?? prefixStyle,
      suffixIcon: this.suffixIcon ?? suffixIcon,
      suffix: this.suffix ?? suffix,
      suffixText: this.suffixText ?? suffixText,
      suffixStyle: this.suffixStyle ?? suffixStyle,
      counter: this.counter ?? counter,
      counterText: this.counterText ?? counterText,
      counterStyle: this.counterStyle ?? counterStyle,
      filled: this.filled ?? filled,
      fillColor: this.fillColor ?? fillColor,
      focusColor: this.focusColor ?? focusColor,
      hoverColor: this.hoverColor ?? hoverColor,
      errorBorder: this.errorBorder ?? errorBorder,
      focusedBorder: this.focusedBorder ?? focusedBorder,
      focusedErrorBorder: this.focusedErrorBorder ?? focusedErrorBorder,
      disabledBorder: this.disabledBorder ?? disabledBorder,
      enabledBorder: this.enabledBorder ?? enabledBorder,
      border: this.border ?? border,
      enabled: enabled,
      semanticCounterText: this.semanticCounterText ?? semanticCounterText,
      alignLabelWithHint: this.alignLabelWithHint ?? alignLabelWithHint,
    );
  }
}

extension DataRowFlutterExtensions on DataRow {
  DataRow copyWith({
    LocalKey? key,
    bool? selected,
    ValueChanged<bool?>? onSelectChanged,
    MaterialStateProperty<Color?>? color,
    List<DataCell>? cells,
  }) {
    return DataRow(
      key: key ?? this.key,
      selected: selected ?? this.selected,
      onSelectChanged: onSelectChanged ?? this.onSelectChanged,
      color: color ?? this.color,
      cells: cells ?? this.cells,
    );
  }

  DataRow completeWith({
    LocalKey? key,
    ValueChanged<bool?>? onSelectChanged,
    MaterialStateProperty<Color?>? color,
  }) {
    return DataRow(
      key: this.key ?? key,
      selected: selected,
      onSelectChanged: this.onSelectChanged ?? onSelectChanged,
      color: this.color ?? color,
      cells: cells,
    );
  }
}

extension DataCellFlutterExtensions on DataCell {
  DataCell copyWith({
    bool? placeholder,
    bool? showEditIcon,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    GestureTapDownCallback? onTapDown,
    VoidCallback? onDoubleTap,
    VoidCallback? onTapCancel,
  }) {
    return DataCell(
      child,
      placeholder: placeholder ?? this.placeholder,
      showEditIcon: showEditIcon ?? this.showEditIcon,
      onTap: onTap ?? this.onTap,
      onLongPress: onLongPress ?? this.onLongPress,
      onTapDown: onTapDown ?? this.onTapDown,
      onDoubleTap: onDoubleTap ?? this.onDoubleTap,
      onTapCancel: onTapCancel ?? this.onTapCancel,
    );
  }

  DataCell completeWith({
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    GestureTapDownCallback? onTapDown,
    VoidCallback? onDoubleTap,
    VoidCallback? onTapCancel,
  }) {
    return DataCell(
      child,
      placeholder: placeholder,
      showEditIcon: showEditIcon,
      onTap: this.onTap ?? onTap,
      onLongPress: this.onLongPress ?? onLongPress,
      onTapDown: this.onTapDown ?? onTapDown,
      onDoubleTap: this.onDoubleTap ?? onDoubleTap,
      onTapCancel: this.onTapCancel ?? onTapCancel,
    );
  }
}
