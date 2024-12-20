import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/features/data/models/product_model.dart';
import 'package:task/features/data/repositories/product_repositoy.dart';
import 'package:task/features/presentation/cubit/product_states.dart';

enum ProductSortType {
  mostPopular,
  priceLowToHigh,
  priceHighToLow,
  newest
}

class ProductsCubit extends Cubit<ProductsState> {
  final ProductRepository repository;
  
  ProductsCubit(this.repository) : super(ProductsInitial());
  
  int _currentPage = 1;
  bool _hasReachedMax = false;
  ProductSortType _currentSort = ProductSortType.mostPopular;
  
  Future<void> loadProducts({bool refresh = false}) async {
    if (refresh) {
      _currentPage = 1;
      _hasReachedMax = false;
    }
    
    if (state is ProductsLoading) return;
    if (_hasReachedMax && !refresh) return;
    
    try {
      final currentState = state;
      List<ProductModel> existingProducts = [];
      
      if (currentState is ProductsLoaded && !refresh) {
        existingProducts = currentState.products;
      }
      
      emit(ProductsLoading(existingProducts, isFirstFetch: _currentPage == 1));
      
      final newProducts = await repository.getProducts(
        page: _currentPage,
        category: 'assorted-bakeries',
        sortBy: _getSortCriteria(),
        sortOrder: _getSortArrangement(),
      );
      
      _hasReachedMax = newProducts.length < 3;
      
      if (_currentPage == 1) {
        emit(ProductsLoaded(newProducts));
      } else {
        emit(ProductsLoaded([...existingProducts, ...newProducts]));
      }
      
      _currentPage++;
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }
  
  void updateSort(ProductSortType sortType) {
    _currentSort = sortType;
    loadProducts(refresh: true);
  }
  
  String? _getSortCriteria() {
    switch (_currentSort) {
      case ProductSortType.priceLowToHigh:
      case ProductSortType.priceHighToLow:
        return 'price';
      case ProductSortType.newest:
        return 'date';
      default:
        return null;
    }
  }
  
  String? _getSortArrangement() {
    switch (_currentSort) {
      case ProductSortType.priceLowToHigh:
        return 'ASC';
      case ProductSortType.priceHighToLow:
        return 'DESC';
      case ProductSortType.newest:
        return 'DESC';
      default:
        return null;
    }
  }
  void showSortOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('الاكثر مبيعا'),
              leading: Radio<ProductSortType>(
                value: ProductSortType.mostPopular,
                groupValue: ProductSortType.mostPopular,
                onChanged: (value) {
                  context.read<ProductsCubit>().updateSort(value!);
                  Navigator.pop(context);
                },
              ),
            ),
            ListTile(
              title: Text('السعر من الاقل للاكثر'),
              leading: Radio<ProductSortType>(
                value: ProductSortType.priceLowToHigh,
                groupValue: ProductSortType.mostPopular,
                onChanged: (value) {
                  context.read<ProductsCubit>().updateSort(value!);
                  Navigator.pop(context);
                },
              ),
            ),
            ListTile(
              title: Text('السعر من الاكثر للاقل'),
              leading: Radio<ProductSortType>(
                value: ProductSortType.priceHighToLow,
                groupValue: ProductSortType.mostPopular,
                onChanged: (value) {
                  context.read<ProductsCubit>().updateSort(value!);
                  Navigator.pop(context);
                },
              ),
            ),
            ListTile(
              title: Text('الاحدث'),
              leading: Radio<ProductSortType>(
                value: ProductSortType.newest,
                groupValue: ProductSortType.mostPopular,
                onChanged: (value) {
                  context.read<ProductsCubit>().updateSort(value!);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}