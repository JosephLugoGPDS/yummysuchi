import 'package:intl/intl.dart';
import 'package:inventario_yummy_sushi/app/constants/app_theme.dart';
import 'package:inventario_yummy_sushi/app/extensions/size_extension.dart';
import 'package:inventario_yummy_sushi/app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:inventario_yummy_sushi/app/routes/app_router.dart';
import 'package:inventario_yummy_sushi/blocs/history/get_histories_bloc.dart';
import 'package:inventario_yummy_sushi/blocs/inventories/get_current_inventory.dart';
import 'package:inventario_yummy_sushi/blocs/inventories/get_inventories_bloc.dart';
import 'package:inventario_yummy_sushi/blocs/pdf/generated_pdf_cubit.dart';
import 'package:inventario_yummy_sushi/blocs/products/get_products_cubit.dart';
import 'package:inventario_yummy_sushi/blocs/products/get_selection_providers_cubit.dart';
import 'package:inventario_yummy_sushi/blocs/uuid/get_uuid_bloc.dart';
import 'package:inventario_yummy_sushi/gen/assets.gen.dart';
import 'package:inventario_yummy_sushi/model/inventory.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:inventario_yummy_sushi/widgets/custom_speed_dial.dart';
import 'package:inventario_yummy_sushi/widgets/theme_button_gradient.dart';

// class HomeView extends StatelessWidget {
//   const HomeView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => di.sl<GetInventoriesBloc>()
//         ..add(FetchInventoriesEvent(
//             uuid: (context.read<GetUuidBloc>().state as GetUuidSuccess).uuid)),
//       child: const HomeScreen(),
//     );
//   }
// }

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    debugPrint('build HomeScreen');
    final AppLocalizations l10n = context.l10n;
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(
                top: 25.h + MediaQuery.of(context).padding.top,
                bottom: 0,
                left: 25.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.app,
                    style: TextStyle(
                      color: AppTheme.primaryColor,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          BlocBuilder<GetInventoriesBloc, GetInventoriesState>(
              builder: (context, stateGetInventoriesState) {
            if (stateGetInventoriesState is GetInventoriesLoaded) {
              return SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(top: 0, left: 25.w, bottom: 15.h),
                  child: Text(
                    '${stateGetInventoriesState.inventories.length} ${stateGetInventoriesState.inventories.length == 1 ? 'Inventario' : 'Inventarios'}',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w200),
                  ),
                ),
              );
            }
            return SliverToBoxAdapter(child: SizedBox(height: 30.h));
          }),
          BlocBuilder<GetInventoriesBloc, GetInventoriesState>(
            builder: (context, stateGetInventoriesState) {
              debugPrint('stateGetInventoriesState: $stateGetInventoriesState');
              if (stateGetInventoriesState is GetInventoriesLoaded) {
                final List<Inventory> inventories =
                    stateGetInventoriesState.inventories;
                if (inventories.isEmpty) {
                  return SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(top: 60.h),
                      child: Assets.splashPng.image(),
                    ),
                  );
                }
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      final Inventory inventory = inventories[index];
                      return GestureDetector(
                        onTap: () {
                          context
                              .read<GetProductsCubit>()
                              .loadProducts(inventory.products ?? []);
                          context
                              .read<GetSelectionProvidersCubit>()
                              .loadProviders(inventory.providers);
                          context
                              .read<GetCurrentInventory>()
                              .loadInventory(inventory.name);
                          Navigator.of(context).pushNamed(
                            AppRoutes.productsScreen,
                          );
                        },
                        child: Container(
                          clipBehavior: Clip.none,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.w),
                            ),
                          ),
                          margin: EdgeInsets.symmetric(
                              horizontal: 27.w, vertical: 5.h),
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 10.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 6.h, 15.w, 6.h),
                                child: SvgPicture.asset(
                                  inventory.asset,
                                  height: 20.w,
                                  width: 20.w,
                                  colorFilter: const ColorFilter.mode(
                                      AppTheme.accentColor, BlendMode.srcIn),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      inventory.name,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      inventory.description ?? '',
                                      maxLines: 2,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w200,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          '${inventory.products?.length ?? 0} ${inventory.products?.length == 1 ? ' Producto' : ' Productos'}',
                                          style: TextStyle(
                                              fontSize: 10.sp,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    childCount: inventories.length,
                  ),
                );
              }
              if (stateGetInventoriesState is GetInventoriesLoading) {
                return const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                );
              } else {
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(top: 60.h),
                    child: Assets.splashPng.image(),
                  ),
                );
              }
            },
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(
                top: 15.h,
                bottom: 15.h,
              ),
              child: ThemeButtonGradient(
                title: 'Crear un nuevo inventario',
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(AppRoutes.createInventoryScreen);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
