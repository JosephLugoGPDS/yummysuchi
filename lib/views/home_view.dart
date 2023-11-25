import 'package:inventario_yummy_sushi/app/constants/app_theme.dart';
import 'package:inventario_yummy_sushi/app/extensions/size_extension.dart';
import 'package:inventario_yummy_sushi/app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:inventario_yummy_sushi/app/routes/app_router.dart';
import 'package:inventario_yummy_sushi/blocs/inventories/get_inventories_bloc.dart';
import 'package:inventario_yummy_sushi/gen/assets.gen.dart';
import 'package:inventario_yummy_sushi/model/inventory.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/flutter_svg.dart';

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
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            title: Text(l10n.app, style: const TextStyle(color: Colors.white)),
            floating: true,
            backgroundColor: AppTheme.accentColor,
            elevation: 0,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(AppRoutes.createInventoryScreen);
                },
                icon: const Icon(Icons.add, color: Colors.white),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 20.h,
            ),
          ),
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
                      return Card(
                        margin: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 5.h),
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                inventory.name,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${inventory.products?.length ?? 0}',
                                style: const TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                          leading: Padding(
                            padding: EdgeInsets.fromLTRB(5.w, 12.h, 5.w, 12.h),
                            child: SvgPicture.asset(
                              inventory.asset,
                              colorFilter: const ColorFilter.mode(
                                  AppTheme.accentColor, BlendMode.srcIn),
                            ),
                          ),
                          trailing: const Icon(Icons.more_vert,
                              color: AppTheme.accentColor),
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
        ],
      ),
    );
  }
}
