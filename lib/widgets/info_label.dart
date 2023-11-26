import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:inventario_yummy_sushi/app/constants/app_theme.dart';

class InfoLabel extends StatelessWidget {
  /// Creates an info label.
  InfoLabel({
    super.key,
    this.child,
    required String label,
    TextStyle? labelStyle,
    this.isHeader = true,
  }) : label = TextSpan(text: label, style: labelStyle);

  /// Creates an info label.
  const InfoLabel.rich({
    super.key,
    this.child,
    required this.label,
    this.isHeader = true,
  });

  final InlineSpan label;

  /// The widget to apply the label.
  final Widget? child;

  /// Whether to render [header] above [child] or on the side of it.
  final bool isHeader;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<InlineSpan>('label', label));
  }

  @override
  Widget build(BuildContext context) {
    final labelWidget = Text.rich(
      label,
      style: const TextStyle(color: AppTheme.grayTextColor),
    );
    return Flex(
      direction: isHeader ? Axis.vertical : Axis.horizontal,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment:
          isHeader ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        if (isHeader)
          Padding(
            padding: const EdgeInsetsDirectional.only(bottom: 4.0),
            child: labelWidget,
          ),
        if (child != null) Flexible(child: child!),
        if (!isHeader)
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 4.0),
            child: labelWidget,
          ),
      ],
    );
  }
}
