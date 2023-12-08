import 'package:flutter/material.dart';

abstract class DataUtil {
  static Map<String, dynamic> iconMap = {
    'Alimentos': {
      'iconPrimary': {'iconData': Icons.fastfood, 'code': 0xe57a},
      'iconSecondary': {'iconData': Icons.restaurant, 'code': 0xe56c},
    },
    'Cocina': {
      'iconPrimary': {'iconData': Icons.kitchen, 'code': 0xeb47},
      'iconSecondary': {'iconData': Icons.local_dining, 'code': 0xef54},
    },
    'Insumos': {
      'iconPrimary': {'iconData': Icons.inventory, 'code': 0xe896},
      'iconSecondary': {
        'iconData': Icons.production_quantity_limits,
        'code': 0xf1df
      },
    },
    'Limpieza': {
      'iconPrimary': {'iconData': Icons.cleaning_services, 'code': 0xf0ff},
      'iconSecondary': {'iconData': Icons.soap, 'code': 0xf1b2},
    },
    'Juguetes': {
      'iconPrimary': {'iconData': Icons.toys, 'code': 0xe332},
      'iconSecondary': {'iconData': Icons.sports_esports, 'code': 0xea28},
    },
    'Regalos': {
      'iconPrimary': {'iconData': Icons.card_giftcard, 'code': 0xe8f6},
      'iconSecondary': {'iconData': Icons.card_giftcard, 'code': 0xe8f6},
    },
    'Mascotas': {
      'iconPrimary': {'iconData': Icons.pets, 'code': 0xe91d},
      'iconSecondary': {'iconData': Icons.pets, 'code': 0xe91d},
    },
    'Moda': {
      'iconPrimary': {'iconData': Icons.style, 'code': 0xe41d},
      'iconSecondary': {'iconData': Icons.shopping_bag, 'code': 0xf1cc},
    },
    'Jardín': {
      'iconPrimary': {'iconData': Icons.eco, 'code': 0xea35},
      'iconSecondary': {'iconData': Icons.flare, 'code': 0xe3e4},
    },
    'Manualidades': {
      'iconPrimary': {'iconData': Icons.brush, 'code': 0xe3a8},
      'iconSecondary': {'iconData': Icons.palette, 'code': 0xe40a},
    },
    'Bebés': {
      'iconPrimary': {'iconData': Icons.child_care, 'code': 0xeb41},
      'iconSecondary': {
        'iconData': Icons.baby_changing_station,
        'code': 0xf19b
      },
    },
    'Deportes': {
      'iconPrimary': {'iconData': Icons.sports_soccer, 'code': 0xea2f},
      'iconSecondary': {'iconData': Icons.sports_basketball, 'code': 0xea26},
    },
    'Vestuarios': {
      'iconPrimary': {'iconData': Icons.dry_cleaning, 'code': 0xea70},
      'iconSecondary': {'iconData': Icons.dry_cleaning, 'code': 0xea70},
    },
    'Otros': {
      'iconPrimary': {'iconData': Icons.miscellaneous_services, 'code': 0xf10c},
      'iconSecondary': {'iconData': Icons.more_horiz, 'code': 0xe5d3},
    },
  };
}
