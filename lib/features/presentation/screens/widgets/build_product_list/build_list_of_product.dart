import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/features/presentation/cubit/product_cubit.dart';
import 'package:task/features/presentation/cubit/product_states.dart';
import 'package:task/features/presentation/screens/widgets/build_product_list/build_product_items.dart';

Widget buildListProduct(ScrollController scrollController) {
    return Expanded(
                child: BlocBuilder<ProductsCubit, ProductsState>(
                  builder: (context, state) {
                    if (state is ProductsInitial) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (state is ProductsError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              state.message,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.red),
                            ),
                            SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                context
                                    .read<ProductsCubit>()
                                    .loadProducts(refresh: true);
                              },
                              child: Text('Try Again'),
                            ),
                          ],
                        ),
                      );
                    }
                    if (state is ProductsLoaded) {
                      if (state.products.isEmpty) {
                        return Center(child: Text('No products found'));
                      }

                      return RefreshIndicator(
                        onRefresh: () async {
                          context
                              .read<ProductsCubit>()
                              .loadProducts(refresh: true);
                        },
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: state.products.length +
                              (state.hasReachedMax ? 0 : 1),
                          padding: EdgeInsets.all(16),
                          itemBuilder: (context, index) {
                            if (index >= state.products.length) {
                              return Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }

                            final product = state.products[index];
                            return buildProductItem(product);
                          },
                        ),
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              );
  }

  