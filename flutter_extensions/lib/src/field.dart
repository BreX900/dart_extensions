import 'package:flutter/material.dart';

extension InputDecorationExt on InputDecoration {
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
      enabled: this.enabled,
      semanticCounterText: this.semanticCounterText ?? semanticCounterText,
      alignLabelWithHint: this.alignLabelWithHint ?? alignLabelWithHint,
    );
  }
}

extension DataRowExt on DataRow {
  DataRow copyWith({
    LocalKey? key,
    bool? selected,
    ValueChanged<bool?>? onSelectChanged,
    List<DataCell>? cells,
  }) {
    return DataRow(
      key: key ?? this.key,
      selected: selected ?? this.selected,
      onSelectChanged: onSelectChanged ?? this.onSelectChanged,
      cells: cells ?? this.cells,
    );
  }

  DataRow completeWith({
    LocalKey? key,
    ValueChanged<bool?>? onSelectChanged,
  }) {
    return DataRow(
      key: this.key ?? key,
      selected: this.selected,
      onSelectChanged: this.onSelectChanged ?? onSelectChanged,
      cells: this.cells,
    );
  }
}

extension DataCellExt on DataCell {
  DataCell copyWith({bool? placeholder, bool? showEditIcon, VoidCallback? onTap}) {
    return DataCell(
      child,
      placeholder: placeholder ?? this.placeholder,
      showEditIcon: showEditIcon ?? this.showEditIcon,
      onTap: onTap ?? this.onTap,
    );
  }

  DataCell completeWith({VoidCallback? onTap}) {
    return DataCell(
      child,
      placeholder: this.placeholder,
      showEditIcon: this.showEditIcon,
      onTap: this.onTap ?? onTap,
    );
  }
}
