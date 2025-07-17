import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/car_entity.dart';
import '../providers/car_provider.dart';
import '../widgets/car_card.dart';
import 'car_details.dart';

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
      color: const Color(0xFF2986F6),
      backgroundColor: Colors.white,
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Use responsive breakpoint with ScreenUtil
          bool isTabletOrDesktop = constraints.maxWidth > 600.w;
          
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
      color: const Color(0xFF2986F6),
      backgroundColor: Colors.white,
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
                  color: Colors.grey,
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
                    color: Colors.grey[600],
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
      color: const Color(0xFF2986F6),
      backgroundColor: Colors.white,
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
                  color: Colors.red,
                ),
                SizedBox(height: 16.h),
                Text(
                  'Failed to load cars',
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: Colors.red,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Pull down to refresh or tap retry',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 16.h),
                ElevatedButton(
                  onPressed: () => context.read<CarProvider>().loadCurrentTabData(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2986F6),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    'Retry',
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
          'Cars',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.sp,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        bottom: TabBar(
          controller: _tabController,
          labelColor: const Color(0xFF2986F6),
          unselectedLabelColor: Colors.grey,
          indicatorColor: const Color(0xFF2986F6),
          labelStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.normal),
          tabs: const [
            Tab(text: 'Used Cars'),
            Tab(text: 'Featured Cars'),
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
                  _buildEmptyState('No used cars available', 'Pull down to refresh'),
                  // Featured Cars Tab - No Data
                  _buildEmptyState('No featured cars available', 'Pull down to refresh'),
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
                  _buildEmptyState('Welcome to Cars App', 'Pull down to load cars'),
                  // Featured Cars Tab - Initial
                  _buildEmptyState('Welcome to Featured Cars', 'Pull down to load featured cars'),
                ],
              );
          }
        },
      ),
    );
  }
}
