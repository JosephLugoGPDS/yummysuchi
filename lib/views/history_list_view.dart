import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventario_yummy_sushi/app/constants/app_theme.dart';
import 'package:inventario_yummy_sushi/app/extensions/size_extension.dart';
import 'package:inventario_yummy_sushi/app/l10n/l10n.dart';
import 'package:inventario_yummy_sushi/app/routes/app_router.dart';
import 'package:inventario_yummy_sushi/blocs/history/get_histories_bloc.dart';
import 'package:inventario_yummy_sushi/blocs/inventories/get_current_inventory.dart';
import 'package:inventario_yummy_sushi/gen/assets.gen.dart';
import 'package:inventario_yummy_sushi/model/history.dart';
import 'package:inventario_yummy_sushi/widgets/custom_return.dart';

class HistoryListView extends StatelessWidget {
  const HistoryListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    debugPrint('build HistoryScreen');
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 20.w),
        child: Stack(
          children: [
            CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
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
                        IconButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(AppRoutes.createProductsScreen);
                          },
                          icon: const Icon(
                            Icons.add_shopping_cart,
                            color: AppTheme.accentColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // SliverAppBar(
                //   foregroundColor: Colors.white,
                //   title: Text(
                //       'Historial: ${context.read<GetCurrentInventory>().state}',
                //       style: const TextStyle(color: Colors.white)),
                //   floating: true,
                //   backgroundColor: AppTheme.accentColor,
                //   elevation: 0,
                //   actions: [
                //     IconButton(
                //       onPressed: () {
                //         Navigator.of(context)
                //             .pushNamed(AppRoutes.createProductsScreen);
                //       },
                //       icon: const Icon(Icons.add, color: Colors.white),
                //     ),
                //   ],
                // ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 20.h,
                  ),
                ),
                BlocBuilder<GetHistoriesBloc, GetHistoriesState>(
                  builder: (context, stateGetHistoriesState) {
                    debugPrint(
                        'stateGetHistoriesState: $stateGetHistoriesState');
                    if (stateGetHistoriesState is GetHistoriesError) {
                      return SliverToBoxAdapter(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 60.h),
                                child: Assets.splashPng.image(),
                              ),
                              Text(
                                'Error al cargar el historial',
                                style: TextStyle(
                                    color: AppTheme.grayTextColor,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    if (stateGetHistoriesState is GetHistoriesLoading) {
                      return SliverToBoxAdapter(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 60.h),
                                child: Assets.splashPng.image(),
                              ),
                              const CircularProgressIndicator(),
                            ],
                          ),
                        ),
                      );
                    }
                    if (stateGetHistoriesState is GetHistoriesLoaded) {
                      if (stateGetHistoriesState.histories.isEmpty) {
                        return SliverToBoxAdapter(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 60.h),
                                  child: Assets.splashPng.image(),
                                ),
                                Text(
                                  'No hay historial',
                                  style: TextStyle(
                                      color: AppTheme.grayTextColor,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      final List<History> histories =
                          stateGetHistoriesState.histories;

                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            final History history = histories[index];
                            return Container(
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.w),
                                ),
                              ),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 5.h),
                              child: ListTile(
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        history.isUp
                                            ? const Icon(
                                                Icons.arrow_upward_outlined,
                                                color: AppTheme.greenColor)
                                            : const Icon(
                                                Icons.arrow_downward_outlined,
                                                color: AppTheme.redColor,
                                              ),
                                      ],
                                    ),
                                    SizedBox(width: 15.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            history.name,
                                            maxLines: 2,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            history.date,
                                            maxLines: 1,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: AppTheme.grayTextColor,
                                                fontSize: 10.sp),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      '${history.isUp ? '(+)  ' : '(-)  '}${history.isUp ? (history.after - history.before) : (history.before - history.after)}',
                                      style: TextStyle(
                                          color: history.isUp
                                              ? AppTheme.greenColor
                                              : AppTheme.redColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          childCount: histories.length,
                        ),
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
            const CustomReturn(),
          ],
        ),
      ),
    );
  }
}
