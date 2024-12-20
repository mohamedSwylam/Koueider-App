import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:task/core/helper/spacing.dart';
import 'package:task/core/theming/colors.dart';
import 'package:task/core/theming/style.dart';
import 'package:task/features/data/models/product_model.dart';
import 'package:task/features/presentation/screens/widgets/custom_button.dart';

Widget buildProductItem( ProductModel product) {
return  Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: Card(
                                margin: EdgeInsets.only(bottom: 16),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl: product.mainImg.src,
                                          progressIndicatorBuilder:
                                              (context, url, downloadProgress) {
                                            return Shimmer.fromColors(
                                              baseColor: ColorsManger.blue,
                                              highlightColor: Colors.white,
                                              child: Container(
                                                width: 110.w,
                                                height: 120.h,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                  color: Colors.white,
                                                ),
                                              ),
                                            );
                                          },
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            width: 160.w,
                                            height: 160.h,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6.0),
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 8.h,
                                          right: 8.w,
                                          child: GestureDetector(
                                            onTap: () {},
                                            child: Container(
                                              height: 22.h,
                                              width: 22.w,
                                              decoration: BoxDecoration(
                                                color: ColorsManger.white,
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Icon(
                                                Icons.favorite_border,
                                                size: 16.sp,
                                                color: ColorsManger.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    horizontalSpace(13),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            product.arName,
                                            style: TextStyles.font16BlackBold,
                                          ),
                                          verticalSpace(8),
                                          Text(
                                            '250 جم',
                                            style: TextStyles.font16GrayMedium,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.groups,
                                                color: ColorsManger.darkGray,
                                              ),
                                              horizontalSpace(5),
                                              Text(
                                                '8-7 أفراد',
                                                style:
                                                    TextStyles.font16GrayMedium,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'EGP ${product.price}',
                                                style:
                                                    TextStyles.font21BlueBold,
                                              ),
                                              horizontalSpace(5),
                                              Container(
                                                height: 17.h,
                                                width: 61.w,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                  color: ColorsManger.green
                                                      // ignore: deprecated_member_use
                                                      .withOpacity(.15),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                        'assets/svgs/Icon.svg'),
                                                    horizontalSpace(3.5),
                                                    Text(
                                                      '50 نقطه',
                                                      style: TextStyles
                                                          .font10GreenBold,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          verticalSpace(11),
                                          CustomButton(
                                            width: 129,
                                            height: 30,
                                            color: ColorsManger.blue,
                                            text: 'أختار الوزن',
                                            onPressed: () {},
                                            icon: Icons.add,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );

  }
