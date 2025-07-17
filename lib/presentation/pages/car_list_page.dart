import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../core/app_colors.dart';
import '../../core/app_strings.dart';
import '../../domain/entities/car_entity.dart';
import '../providers/car_provider.dart';
import '../widgets/car_card.dart';

class CarListPage extends StatefulWidget {
  const CarListPage({super.key});

  @override
  State<CarListPage> createState() => _CarListPageState();
}

class _CarListPageState extends State<CarListPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Load initial data for used cars tab
      context.read<CarProvider>().loadCars();
    });

    // Listen to tab changes
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        final provider = context.read<CarProvider>();
        if (_tabController.index == 0) {
          provider.changeTab(CarTabType.usedCars);
        } else {
          provider.changeTab(CarTabType.featuredCars);
        }
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    await context.read<CarProvider>().loadCurrentTabData();
  }

  Widget _buildCarList(List<CarEntity> cars, CarProvider carProvider) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      color: AppColors.refreshIndicator,
      backgroundColor: AppColors.background,
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Use responsive breakpoint for tablets and desktop
          bool isTabletOrDesktop = constraints.maxWidth > 600;
          
          if (isTabletOrDesktop) {
            // Grid layout for tablets and desktop
            return Padding(
              padding: EdgeInsets.all(16.w),
              child: GridView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 16.h,
                  childAspectRatio: 0.75,
                ),
                itemCount: cars.length,
                itemBuilder: (context, index) {
                  final car = cars[index];
                  return CarCard(
                    image: car.image,
                    title: car.title,
                    price: '${car.currency} ${car.price}',
                    year: car.year,
                    location: car.location,
                    fuel: car.fuel,
                    body: car.body,
                    isFavorite: car.isFavorite,
                    onFavoriteToggle: () => carProvider.toggleCarFavorite(car.id),
                    car: car,
                  );
                },
              ),
            );
          } else {
            // List layout for mobile devices
            return Padding(
              padding: EdgeInsets.all(16.w),
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: cars.length,
                itemBuilder: (context, index) {
                  final car = cars[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: CarCard(
                      image: car.image,
                      title: car.title,
                      price: '${car.currency} ${car.price}',
                      year: car.year,
                      location: car.location,
                      fuel: car.fuel,
                      body: car.body,
                      isFavorite: car.isFavorite,
                      onFavoriteToggle: () => carProvider.toggleCarFavorite(car.id),
                      car: car,
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildEmptyState(String message, String subtitle) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      color: AppColors.refreshIndicator,
      backgroundColor: AppColors.background,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.directions_car_outlined,
                  size: 64.w,
                  color: AppColors.placeholderIcon,
                ),
                SizedBox(height: 16.h),
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.textMedium,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      color: AppColors.refreshIndicator,
      backgroundColor: AppColors.background,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 64.w,
                  color: AppColors.error,
                ),
                SizedBox(height: 16.h),
                Text(
                  AppStrings.failedToLoadCars,
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: AppColors.error,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  AppStrings.pullDownToRefreshOrRetry,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.textMedium,
                  ),
                ),
                SizedBox(height: 16.h),
                ElevatedButton(
                  onPressed: () => context.read<CarProvider>().loadCurrentTabData(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonPrimary,
                    foregroundColor: AppColors.buttonPrimaryText,
                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    AppStrings.retry,
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.cars,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
                  bottom: TabBar(
            controller: _tabController,
            labelColor: AppColors.tabSelected,
            unselectedLabelColor: AppColors.tabUnselected,
            indicatorColor: AppColors.tabIndicator,
          labelStyle: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.normal),
          tabs: const [
            Tab(text: AppStrings.usedCars),
            Tab(text: AppStrings.featuredCars),
          ],
        ),
      ),
      body: Consumer<CarProvider>(
        builder: (context, carProvider, child) {
          print('carProvider.state: ${carProvider.state}');
          
          switch (carProvider.state) {
            case LoadingState.loading:
              return const Center(child: CircularProgressIndicator());
            
            case LoadingState.doneWithData:
              return TabBarView(
                controller: _tabController,
                children: [
                  // Used Cars Tab
                  _buildCarList(carProvider.usedCars, carProvider),
                  // Featured Cars Tab
                  _buildCarList(carProvider.featuredCars, carProvider),
                ],
              );
            
            case LoadingState.doneWithNoData:
              return TabBarView(
                controller: _tabController,
                children: [
                  // Used Cars Tab - No Data
                  _buildEmptyState(AppStrings.noUsedCarsAvailable, AppStrings.pullDownToRefresh),
                  // Featured Cars Tab - No Data
                  _buildEmptyState(AppStrings.noFeaturedCarsAvailable, AppStrings.pullDownToRefresh),
                ],
              );
            
            case LoadingState.hasError:
              return TabBarView(
                controller: _tabController,
                children: [
                  // Used Cars Tab - Error
                  _buildErrorState(),
                  // Featured Cars Tab - Error
                  _buildErrorState(),
                ],
              );
            
            case LoadingState.idle:
            default:
              return TabBarView(
                controller: _tabController,
                children: [
                  // Used Cars Tab - Initial
                  _buildEmptyState(AppStrings.welcomeToCarsApp, AppStrings.pullDownToLoadCars),
                  // Featured Cars Tab - Initial
                  _buildEmptyState(AppStrings.welcomeToFeaturedCars, AppStrings.pullDownToLoadFeaturedCars),
                ],
              );
          }
        },
      ),
    );
  }
}
