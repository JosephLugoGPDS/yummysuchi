import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inventario_yummy_sushi/app/constants/app_theme.dart';
import 'package:inventario_yummy_sushi/app/constants/svg_list.dart';
import 'package:inventario_yummy_sushi/app/extensions/size_extension.dart';
import 'package:inventario_yummy_sushi/app/l10n/l10n.dart';
import 'package:inventario_yummy_sushi/blocs/inventories/create/create_inventory_bloc.dart';
import 'package:inventario_yummy_sushi/blocs/inventories/get_inventories_bloc.dart';
import 'package:inventario_yummy_sushi/blocs/inventories/providers_controller_cubit.dart';
import 'package:inventario_yummy_sushi/blocs/inventories/select_assets_cubit.dart';
import 'package:inventario_yummy_sushi/blocs/uuid/get_uuid_bloc.dart';
import 'package:inventario_yummy_sushi/widgets/loader_dialog.dart';
import 'package:inventario_yummy_sushi/widgets/theme_button_gradient.dart';
import 'package:inventario_yummy_sushi/widgets/theme_dialog.dart';
import 'package:inventario_yummy_sushi/widgets/theme_text_form_field.dart';

class CreateInventoryView extends StatelessWidget {
  const CreateInventoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProvidersControllerCubit(),
        ),
      ],
      child: const CreateInventoryScreen(),
    );
  }
}

class CreateInventoryScreen extends StatelessWidget {
  const CreateInventoryScreen({super.key});

  static final TextEditingController descriptionController =
      TextEditingController();
  static final TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: AppTheme.accentColor,
          title: Text(l10n.createInventory),
          elevation: 0,
        ),
        body: BlocListener<CreateInventoryBloc, CreateInventoryState>(
          listener: (context, stateCreateInventoryState) {
            debugPrint('stateCreateInventoryState: $stateCreateInventoryState');
            if (stateCreateInventoryState is CreateInventorySuccess) {
              context.read<GetInventoriesBloc>().add(FetchInventoriesEvent(
                  uuid: (context.read<GetUuidBloc>().state as GetUuidSuccess)
                      .uuid));
              Navigator.pop(context);
              Navigator.of(context).pop(true);
            }
            if (stateCreateInventoryState is CreateInventoryLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const LoaderDialog(),
              );
            }
          },
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20.w, 0, 20.w, MediaQuery.of(context).padding.bottom),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(height: 40.h),
                  ThemeTextFormField(
                    textEditingController: nameController,
                    label: '${l10n.name}*',
                  ),
                  SizedBox(height: 20.h),
                  ThemeTextFormField(
                    textEditingController: descriptionController,
                    label: l10n.description,
                    maxLines: 3,
                  ),
                  SizedBox(height: 20.h),
                  BlocBuilder<ProvidersControllerCubit,
                      List<TextEditingController>>(
                    builder: (BuildContext context,
                        List<TextEditingController> stateProviders) {
                      debugPrint(stateProviders.toString());
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                for (int i = 0; i < stateProviders.length; i++)
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 20.h),
                                    child: ThemeTextFormField(
                                      textEditingController: stateProviders[i],
                                      label: '${l10n.provider} (${i + 1})*',
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              context
                                  .read<ProvidersControllerCubit>()
                                  .addProvider();
                            },
                            child: const CircleAvatar(
                              backgroundColor: AppTheme.accentColor,
                              radius: 12,
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 20.h),
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => ThemeDialog(
                          height: 300.h,
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: SvgList.list.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                            ),
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () async {
                                Navigator.pop(context);
                                await context
                                    .read<SelectAssetsCubit>()
                                    .selectAsset(SvgList.list[index]);
                              },
                              child: SvgPicture.asset(SvgList.list[index],
                                  height: 30.w, width: 30.w),
                            ),
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'Agregar ícono (+)',
                      style: TextStyle(
                        color: AppTheme.accentColor,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  BlocBuilder<GetUuidBloc, GetUuidState>(
                    builder: (context, stateGetUuidState) {
                      if (stateGetUuidState is GetUuidSuccess) {
                        return ThemeButtonGradient(
                          onPressed: () async {
                            for (int i = 0;
                                i <
                                    context
                                        .read<ProvidersControllerCubit>()
                                        .state
                                        .length;
                                i++) {
                              if (context
                                  .read<ProvidersControllerCubit>()
                                  .state[i]
                                  .text
                                  .isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        '${l10n.provider} ${i + 1} ${l10n.required}'),
                                    backgroundColor: AppTheme.accentColor,
                                  ),
                                );
                                return;
                              }
                            }
                            if (nameController.text.isNotEmpty) {
                              FocusScope.of(context).unfocus();
                              context.read<CreateInventoryBloc>().add(
                                    CreateInventory(
                                      uuid: stateGetUuidState.uuid,
                                      name: nameController.text,
                                      description: descriptionController.text,
                                      asset: context
                                          .read<SelectAssetsCubit>()
                                          .state,
                                      providers: context
                                          .read<ProvidersControllerCubit>()
                                          .state
                                          .map((e) => e.text)
                                          .toList(),
                                    ),
                                  );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(l10n.nameRequired),
                                  backgroundColor: AppTheme.accentColor,
                                ),
                              );
                            }
                          },
                          title: 'Guardar',
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
