import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventario_yummy_sushi/app/constants/app_theme.dart';
import 'package:inventario_yummy_sushi/app/extensions/size_extension.dart';
import 'package:inventario_yummy_sushi/app/routes/app_router.dart';
import 'package:inventario_yummy_sushi/blocs/history/get_histories_bloc.dart';
import 'package:inventario_yummy_sushi/blocs/inventories/get_current_inventory.dart';
import 'package:inventario_yummy_sushi/gen/assets.gen.dart';
import 'package:inventario_yummy_sushi/model/history.dart';

class HistoryListView extends StatelessWidget {
  const HistoryListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    debugPrint('build HomeScreen');
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            foregroundColor: Colors.white,
            title: Text(
                'Historial: ${context.read<GetCurrentInventory>().state}',
                style: const TextStyle(color: Colors.white)),
            floating: true,
            backgroundColor: AppTheme.accentColor,
            elevation: 0,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(AppRoutes.createProductsScreen);
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
          BlocBuilder<GetHistoriesBloc, GetHistoriesState>(
            builder: (context, stateGetHistoriesState) {
              debugPrint('stateGetHistoriesState: $stateGetHistoriesState');
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
                      return Card(
                        margin: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 5.h),
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  history.isUp
                                      ? const Icon(Icons.arrow_upward_outlined,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                              Column(
                                children: [
                                  const Text(
                                    'Anterior',
                                    style: TextStyle(
                                        color: AppTheme.grayTextColor),
                                  ),
                                  Text(
                                    '${history.before}',
                                    style: const TextStyle(
                                      color: AppTheme.grayTextColor,
                                    ),
                                  ),
                                  const Text(
                                    'Nuevo',
                                    style: TextStyle(
                                      color: AppTheme.grayTextColor,
                                    ),
                                  ),
                                  Text(
                                    '${history.after}',
                                    style: TextStyle(
                                        color: history.isUp
                                            ? AppTheme.greenColor
                                            : AppTheme.redColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
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
    );
  }
}
