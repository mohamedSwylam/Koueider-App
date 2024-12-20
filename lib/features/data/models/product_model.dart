import 'package:flutter/material.dart';

class ProductModel {
  final int id;
  final String status;
  final String name;
  final String arName;
  final String categoryName;
  final String categorySlug;
  final String categoryNameAr;
  final String slug;
  final String sku;
  final String salePrice;
  final String price;
  final MainImage mainImg;
  final String type;
  final String availability;
  final List<ProductVariant> variants;  // Added for variant support
  final bool isFavorite;  // Added for favorite support

  ProductModel({
    required this.id,
    required this.status,
    required this.name,
    required this.arName,
    required this.categoryName,
    required this.categorySlug,
    required this.categoryNameAr,
    required this.slug,
    required this.sku,
    required this.salePrice,
    required this.price,
    required this.mainImg,
    required this.type,
    required this.availability,
    this.variants = const [],  // Default empty list
    this.isFavorite = false,  // Default not favorite
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    // Generate variants based on the product type and price
    List<ProductVariant> variants = [
      ProductVariant(
        weight: '250',
        price: json['price'] ?? '0',
        servingSize: '8-7 أفراد',
        backgroundColor: const Color(0xFFFFF0F0),
      ),
      ProductVariant(
        weight: '250',
        price: json['price'] ?? '0',
        servingSize: '8-7 أفراد',
        backgroundColor: const Color(0xFFF0F0FF),
      ),
    ];

    return ProductModel(
      id: json['id'] ?? 0,
      status: json['status'] ?? '',
      name: json['name'] ?? '',
      arName: json['ar_name'] ?? '',
      categoryName: json['category_name'] ?? '',
      categorySlug: json['category_slug'] ?? '',
      categoryNameAr: json['category_name_ar'] ?? '',
      slug: json['slug'] ?? '',
      sku: json['sku'] ?? '',
      salePrice: json['sale_price'] ?? '',
      price: json['price'] ?? '0',
      mainImg: MainImage.fromJson(json['main_img'] ?? {}),
      type: json['type'] ?? '',
      availability: json['availability'] ?? '',
      variants: variants,
      isFavorite: json['is_favorite'] ?? false,
    );
  }
}

class MainImage {
  final String src;
  final String alt;
  final String caption;
  final String title;

  MainImage({
    required this.src,
    required this.alt,
    required this.caption,
    required this.title,
  });

  factory MainImage.fromJson(Map<String, dynamic> json) {
    return MainImage(
      src: json['src'] ?? '',
      alt: json['alt'] ?? '',
      caption: json['caption'] ?? '',
      title: json['title'] ?? '',
    );
  }
}

class ProductVariant {
  final String weight;
  final String price;
  final String servingSize;
  final Color backgroundColor;

  ProductVariant({
    required this.weight,
    required this.price,
    required this.servingSize,
    required this.backgroundColor,
  });
}

// Example API response handling
class ProductResponse {
  final List<ProductModel> products;
  final bool hasMore;
  final int totalCount;

  ProductResponse({
    required this.products,
    required this.hasMore,
    required this.totalCount,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> data = json['data'] ?? [];
    return ProductResponse(
      products: data.map((product) => ProductModel.fromJson(product)).toList(),
      hasMore: json['has_more'] ?? false,
      totalCount: json['total_count'] ?? 0,
    );
  }
}