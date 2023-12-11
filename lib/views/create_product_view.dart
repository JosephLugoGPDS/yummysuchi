import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventario_yummy_sushi/app/constants/app_theme.dart';
import 'package:inventario_yummy_sushi/app/extensions/size_extension.dart';
import 'package:inventario_yummy_sushi/app/l10n/l10n.dart';
import 'package:inventario_yummy_sushi/blocs/inventories/get_current_inventory.dart';
import 'package:inventario_yummy_sushi/blocs/inventories/get_inventories_bloc.dart';
import 'package:inventario_yummy_sushi/blocs/products/create/create_product_bloc.dart';
import 'package:inventario_yummy_sushi/blocs/products/get_selection_providers_cubit.dart';
import 'package:inventario_yummy_sushi/blocs/products/products_controller_cubit.dart';
import 'package:inventario_yummy_sushi/blocs/uuid/get_uuid_bloc.dart';
import 'package:inventario_yummy_sushi/widgets/custom_multiselector.dart';
import 'package:inventario_yummy_sushi/widgets/custom_return.dart';
import 'package:inventario_yummy_sushi/widgets/loader_dialog.dart';
import 'package:inventario_yummy_sushi/widgets/theme_button_gradient.dart';
import 'package:inventario_yummy_sushi/widgets/theme_text_form_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

class CreateProductView extends StatelessWidget {
  const CreateProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProvidersProductControllerCubit(),
        ),
      ],
      child: const CreateProductScreen(),
    );
  }
}

class CreateProductScreen extends StatelessWidget {
  const CreateProductScreen({super.key});

  static final TextEditingController stockController = TextEditingController();
  static final TextEditingController stockMinController =
      TextEditingController(text: '0');
  static final TextEditingController stockMaxController =
      TextEditingController(text: '100');
  static final TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final providers = context.read<GetSelectionProvidersCubit>().providerList;
    final providersToSelect = providers
        .map((provider) => MultiSelectItem<String>(provider, provider))
        .toList();
    final AppLocalizations l10n = context.l10n;
    return Scaffold(
        body: BlocListener<CreateProductBloc, CreateProductState>(
      listener: (context, stateCreateProductState) {
        debugPrint('stateCreateProductState: $stateCreateProductState');
        if (stateCreateProductState is CreateProductSuccess) {
          context.read<GetInventoriesBloc>().add(FetchInventoriesEvent(
              uuid:
                  (context.read<GetUuidBloc>().state as GetUuidSuccess).uuid));
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.of(context).pop(true);
        }
        if (stateCreateProductState is CreateProductLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const LoaderDialog(),
          );
        }
        if (stateCreateProductState is CreateProductFailure) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(stateCreateProductState.error),
            ),
          );
        }
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            20.w, 0, 20.w, MediaQuery.of(context).padding.bottom),
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        40.w,
                        25.h + MediaQuery.of(context).padding.top,
                        20.w,
                        MediaQuery.of(context).padding.bottom),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 200.w,
                              child: Text(
                                context.read<GetCurrentInventory>().state,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.accentColor,
                                ),
                              ),
                            ),
                            Text(
                              l10n.app,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w200),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40.h),
                  ThemeTextFormField(
                    textEditingController: nameController,
                    label: l10n.name,
                  ),
                  SizedBox(height: 20.h),
                  ThemeTextFormField(
                    textEditingController: stockController,
                    keyboardType: TextInputType.number,
                    label: l10n.stock,
                  ),
                  SizedBox(height: 20.h),
                  ThemeTextFormField(
                    textEditingController: stockMaxController,
                    keyboardType: TextInputType.number,
                    label: l10n.stockMax,
                  ),
                  SizedBox(height: 20.h),
                  ThemeTextFormField(
                    textEditingController: stockMinController,
                    keyboardType: TextInputType.number,
                    label: l10n.stockMin,
                  ),
                  SizedBox(height: 5.h),
                  CustomMultiSelector(
                    label: 'Proveedores',
                    onSelectionChanged: (list) {},
                    items: providersToSelect,
                    onConfirm: (list) => context
                        .read<GetSelectionProvidersCubit>()
                        .selectProvider(list.map((e) => e.toString()).toList()),
                  ),
                  SizedBox(height: 20.h),
                  ThemeButtonGradient(
                      title: 'Guardar',
                      onPressed: () {
                        if (nameController.text.isNotEmpty &&
                            stockController.text.isNotEmpty &&
                            stockMinController.text.isNotEmpty &&
                            stockMaxController.text.isNotEmpty) {
                          if (int.parse(stockController.text) >
                                  int.parse(stockMaxController.text) ||
                              int.parse(stockController.text) <
                                  int.parse(stockMinController.text)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'El stock no puede ser mayor al stock máximo, ni menor al stock mínimo'),
                              ),
                            );
                            return;
                          }
                          context.read<CreateProductBloc>().add(
                                CreateNewProductEvent(
                                  productName: nameController.text,
                                  stock: int.parse(stockController.text),
                                  stockMin: int.parse(stockMinController.text),
                                  stockMax: int.parse(stockMaxController.text),
                                  uuid: context.read<GetUuidBloc>().state
                                          is GetUuidSuccess
                                      ? (context.read<GetUuidBloc>().state
                                              as GetUuidSuccess)
                                          .uuid
                                      : '',
                                  inventory:
                                      context.read<GetCurrentInventory>().state,
                                  providers: context
                                      .read<GetSelectionProvidersCubit>()
                                      .state,
                                ),
                              );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Todos los campos son obligatorios'),
                            ),
                          );
                        }
                      }),
                ],
              ),
            ),
            const CustomReturn(),
          ],
        ),
      ),
    ));
  }
}
