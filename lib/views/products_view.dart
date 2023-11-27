import 'package:inventario_yummy_sushi/app/constants/app_theme.dart';
import 'package:inventario_yummy_sushi/app/extensions/size_extension.dart';
import 'package:inventario_yummy_sushi/app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:inventario_yummy_sushi/app/routes/app_router.dart';
import 'package:inventario_yummy_sushi/blocs/inventories/get_current_inventory.dart';
import 'package:inventario_yummy_sushi/blocs/inventories/get_inventories_bloc.dart';
import 'package:inventario_yummy_sushi/blocs/products/get_products_cubit.dart';
import 'package:inventario_yummy_sushi/blocs/products/update/update_product_bloc.dart';
import 'package:inventario_yummy_sushi/blocs/uuid/get_uuid_bloc.dart';
import 'package:inventario_yummy_sushi/gen/assets.gen.dart';
import 'package:inventario_yummy_sushi/model/inventory.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventario_yummy_sushi/widgets/loader_dialog.dart';
import 'package:inventario_yummy_sushi/widgets/theme_dialog.dart';

import '../widgets/theme_text_form_field.dart';

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

class ProductsView extends StatelessWidget {
  const ProductsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    debugPrint('build HomeScreen');
    final AppLocalizations l10n = context.l10n;
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          BlocListener<UpdateProductBloc, UpdateProductState>(
            listener: (context, state) {
              if (state is UpdateProductFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error),
                    backgroundColor: AppTheme.accentColor,
                  ),
                );
              }
              if (state is UpdateProductLoading) {
                showDialog(
                    context: context,
                    builder: (_) => const Center(
                          child: LoaderDialog(),
                        ));
              }
              if (state is UpdateProductInitial) {
                Navigator.of(context).pop();
              }
              if (state is UpdateProductSuccess) {
                context.read<GetInventoriesBloc>().add(FetchInventoriesEvent(
                    uuid: (context.read<GetUuidBloc>().state as GetUuidSuccess)
                        .uuid));
                Navigator.pop(context);
                Navigator.pop(context);
              }
            },
            child: SliverAppBar(
              foregroundColor: Colors.white,
              title:
                  Text(l10n.app, style: const TextStyle(color: Colors.white)),
              floating: true,
              backgroundColor: AppTheme.secondColor,
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
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 20.h,
            ),
          ),
          BlocBuilder<GetProductsCubit, List<Product>>(
            builder: (context, stateGetGetProductsCubit) {
              debugPrint('stateGetGetProductsCubit: $stateGetGetProductsCubit');
              if (stateGetGetProductsCubit.isNotEmpty) {
                final List<Product> products = stateGetGetProductsCubit;

                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      final Product product = products[index];
                      return GestureDetector(
                        onTap: () {
                          final TextEditingController stockController =
                              TextEditingController(
                                  text: product.stock.toString());

                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext _) {
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                child: ThemeDialog(
                                  showIconClose: false,
                                  contentPadding: EdgeInsets.fromLTRB(
                                      10.w, 10.h, 10.w, 10.h),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15.w),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          height: 60.h,
                                        ),
                                        Text(
                                          product.name,
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        ThemeTextFormField(
                                          textEditingController:
                                              stockController,
                                          label: l10n.name,
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            if (stockController
                                                .text.isNotEmpty) {
                                              Navigator.of(context).pop();
                                              context
                                                  .read<UpdateProductBloc>()
                                                  .add(UpdateNewProductEvent(
                                                      uuid: (context
                                                                  .read<
                                                                      GetUuidBloc>()
                                                                  .state
                                                              as GetUuidSuccess)
                                                          .uuid,
                                                      inventory: context
                                                          .read<
                                                              GetCurrentInventory>()
                                                          .state,
                                                      product: product,
                                                      stock: int.parse(
                                                          stockController
                                                              .text)));
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content:
                                                      Text(l10n.nameRequired),
                                                  backgroundColor:
                                                      AppTheme.accentColor,
                                                ),
                                              );
                                            }
                                          },
                                          child: Text('Guardar',
                                              style: TextStyle(
                                                  color: AppTheme.accentColor,
                                                  fontSize: 14.sp)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Card(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 5.h),
                          child: ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: 'max: ',
                                        style: const TextStyle(
                                            color: AppTheme.grayTextColor),
                                        children: [
                                          TextSpan(
                                            text: '${product.stockMax}',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: 'min: ',
                                        style: const TextStyle(
                                            color: AppTheme.grayTextColor),
                                        children: [
                                          TextSpan(
                                            text: '${product.stockMin}',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
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
                                        product.name,
                                        maxLines: 2,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      for (String provider in product.providers)
                                        Text(
                                          provider,
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
                                    Text(
                                      '${product.stock}',
                                      style: TextStyle(
                                          color: product.stock <
                                                      product.stockMin ||
                                                  product.stock >
                                                      product.stockMax
                                              ? Colors.red
                                              : AppTheme.secondColor,
                                          fontSize: 20.sp),
                                    ),
                                    const Text(
                                      'und.',
                                      style: TextStyle(
                                          color: AppTheme.grayTextColor),
                                    ),
                                    const Text(
                                      'Stock',
                                      style: TextStyle(
                                          color: AppTheme.grayTextColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: products.length,
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
