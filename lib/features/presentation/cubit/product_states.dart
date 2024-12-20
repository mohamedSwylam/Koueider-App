import 'package:equatable/equatable.dart';
import 'package:task/features/data/models/product_model.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object?> get props => [];
}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {
  final List<ProductModel> oldProducts;
  final bool isFirstFetch;

  const ProductsLoading(this.oldProducts, {this.isFirstFetch = false});

  @override
  List<Object?> get props => [oldProducts, isFirstFetch];
}

class ProductsLoaded extends ProductsState {
  final List<ProductModel> products;
  final bool hasReachedMax;

  const ProductsLoaded(this.products, {this.hasReachedMax = false});

  @override
  List<Object?> get props => [products, hasReachedMax];
}

class ProductsError extends ProductsState {
  final String message;

  const ProductsError(this.message);

  @override
  List<Object?> get props => [message];
}