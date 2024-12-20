import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task/core/helper/spacing.dart';
import 'package:task/core/theming/colors.dart';
import 'package:task/features/presentation/cubit/product_cubit.dart';
import 'package:task/features/presentation/screens/widgets/build_catigores.dart';
import 'package:task/features/presentation/screens/widgets/build_header.dart';
import 'package:task/features/presentation/screens/widgets/build_product_list/build_list_of_product.dart';
import 'package:task/features/presentation/screens/widgets/build_title.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final _scrollController = ScrollController();
  // Add offset for FAB position
  Offset _fabPosition = Offset(20, 20);
  
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<ProductsCubit>().loadProducts();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<ProductsCubit>().loadProducts();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll - 200);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManger.lightGray,
      body: SafeArea(
        child: Stack(
          children: [
            Scaffold(
              backgroundColor: ColorsManger.lightGray,
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 20.0.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildHeader(),
                    buildTitle(),
                    verticalSpace(22.h),
                    buildCategories(),
                    verticalSpace(22.h),
                    buildListProduct(_scrollController),
                  ],
                ),
              ),
             bottomNavigationBar: BottomNavigationBar(
            selectedItemColor:
                ColorsManger.darkGray, // Change the selected label color
            unselectedItemColor: ColorsManger.darkGray,
            showUnselectedLabels: true,
            items: [
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/svgs/Home.svg', // Replace with your SVG file path
                    width: 30.w,
                    height: 30.h,
                  ),
                  label: 'الرئيسية'),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/svgs/Heart.svg', // Replace with your SVG file path
                    width: 30.w,
                    height: 30.h,
                  ),
                  label: 'المفضلة'),
              BottomNavigationBarItem(
                  icon: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      SvgPicture.asset(
                        'assets/svgs/Cart.svg', // Replace with your SVG file path
                        width: 26.h,
                        height: 26.h,
                      ),
                      Positioned(
                        right: 0,
                        top: 10.h,
                        child: Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: ColorsManger.green,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          constraints: BoxConstraints(
                            minWidth: 16,
                            minHeight: 16,
                          ),
                          child: Text(
                            '1',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                  label: 'عربة التسوق'),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/svgs/User.svg', // Replace with your SVG file path
                    width: 17.w,
                    height: 30.h,
                  ),
                  label: 'حسابي'),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/svgs/Menu.svg', // Replace with your SVG file path
                    width: 20.w,
                    height: 20.h,
                  ),
                  label: 'المزيد'),
            ],
          ),
            ),
            // Add draggable FAB
            Positioned(
              left: _fabPosition.dx,
              top: _fabPosition.dy,
              child: Draggable(
                feedback: _buildFAB(),
                childWhenDragging: Container(),
                onDragEnd: (details) {
                  setState(() {
                    // Ensure the FAB stays within screen bounds
                    double newX = details.offset.dx;
                    double newY = details.offset.dy;
                    
                    // Get screen dimensions
                    final screenWidth = MediaQuery.of(context).size.width;
                    final screenHeight = MediaQuery.of(context).size.height;
                    
                    // Adjust position to keep FAB fully visible
                    newX = newX.clamp(0, screenWidth - 56); // 56 is FAB width
                    newY = newY.clamp(0, screenHeight - 56); // 56 is FAB height
                    
                    _fabPosition = Offset(newX, newY);
                  });
                },
                child: _buildFAB(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAB() {
    return FloatingActionButton(
      onPressed: () {
        context.read<ProductsCubit>().showSortOptions(context);
      },
      backgroundColor: ColorsManger.orange,
      shape: CircleBorder(),
      child: Center(
        child: SvgPicture.asset(
          'assets/svgs/Button.svg',
          width: 20.w,
          height: 20.h,
        ),
      ),
    );
  }
}
