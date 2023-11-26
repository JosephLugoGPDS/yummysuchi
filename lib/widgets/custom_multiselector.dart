import 'package:flutter/material.dart';
import 'package:inventario_yummy_sushi/app/constants/app_theme.dart';
import 'package:inventario_yummy_sushi/app/extensions/size_extension.dart';
import 'package:inventario_yummy_sushi/widgets/info_label.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

class CustomMultiSelector extends StatelessWidget {
  const CustomMultiSelector({
    super.key,
    required this.label,
    required this.items,
    required this.onSelectionChanged,
    required this.onConfirm,
  });

  final String label;
  final List<MultiSelectItem<Object?>>? items;
  final void Function(List<Object?>)? onSelectionChanged;
  final void Function(List<Object?>) onConfirm;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.h),
      child: InfoLabel(
        label: label,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 2.h),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: MultiSelectBottomSheetField(
            onSelectionChanged: onSelectionChanged,
            decoration: const BoxDecoration(),
            selectedColor: AppTheme.accentColor,
            title: const Text('Seleccionar',
                style: TextStyle(color: Colors.black)),
            buttonText: const Text('Seleccionar proveedores',
                style: TextStyle(color: Colors.black)),
            buttonIcon: const Icon(Icons.arrow_drop_down_circle),
            items: items ?? [],
            listType: MultiSelectListType.LIST,
            checkColor: AppTheme.accentColor,
            onConfirm: onConfirm,
          ),
        ),
      ),
    );
  }
}
