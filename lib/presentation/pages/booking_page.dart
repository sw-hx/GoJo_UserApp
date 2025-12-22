import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_jo_user_application/presentation/pages/payment_pages/payment_page.dart';
import 'package:go_jo_user_application/presentation/pages/trips.dart';

import '../../domain/repos/trip_repo.dart';
import '../../services/git_it_service.dart';
import '../../services/open_map_service.dart';
import '../common_components/custom_TitleText.dart';
import '../common_components/custom_divider.dart';
import '../common_components/custom_returnArrow.dart';
import '../common_components/bottom_nav_bar.dart';
import '../components/components_place_infoPage/map.dart';
import '../cubits/user_book_trip_cubit/user_book_trip_cubit.dart';

/// coded by [suhaib]
class BookingPage extends StatelessWidget {
  final int tripId;
  final String companyName;
  final int rating;
  final String launchDate;
  final String returnDate;
  final String fromLocation;
  final String toLocation;
  final String contactNumber;
  final String details;
  final List<String> features;
  final List<String> galleryImages;
  final double price;
  final bool showBookNow;
  final String? location;

  const BookingPage({
    super.key,
    required this.tripId,
    required this.companyName,
    required this.rating,
    required this.launchDate,
    required this.returnDate,
    required this.fromLocation,
    required this.toLocation,
    required this.contactNumber,
    required this.details,
    required this.features,
    required this.galleryImages,
    required this.price,
    required this.showBookNow ,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF113545);
    const Color yellowColor = Color(0xFFFFE100);

    final TextStyle mainText = TextStyle(
      color: primaryColor,
      fontFamily: 'Jaldi',
      fontWeight: FontWeight.w400,
      fontSize: 16.sp,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomReturnArrow(targetPage: TripsCardPage()),
              SizedBox(height: 30.h),

              Text(
                companyName,
                style: mainText.copyWith(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.h),

              Row(
                children: List.generate(
                  5,
                      (index) =>
                      Icon(
                        index < rating ? Icons.star : Icons.star_border,
                        color: index < rating ? yellowColor : Colors.grey,
                        size: 28.r,
                      ),
                ),
              ),

              SizedBox(height: 10.h),

              Text('Launch',
                  style: mainText.copyWith(
                      fontSize: 20.sp, fontWeight: FontWeight.bold)),
              Text(launchDate, style: mainText.copyWith(fontSize: 20.sp)),
              SizedBox(height: 10.h),
              Text('Return',
                  style: mainText.copyWith(
                      fontSize: 20.sp, fontWeight: FontWeight.bold)),
              Text(returnDate, style: mainText.copyWith(fontSize: 20.sp)),

              SizedBox(height: 10.h),
              customDivider(),

          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerRight,
                    child: Text(
                      fromLocation,
                      style: mainText.copyWith(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 12.w),

                Icon(
                  Icons.arrow_right_alt_rounded,
                  color: primaryColor,
                  size: 80.r,
                ),

                SizedBox(width: 12.w),

                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      toLocation,
                      style: mainText.copyWith(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),


          SizedBox(height: 10.h),
              customDivider(),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Contact',
                      style: mainText.copyWith(
                          fontSize: 18.sp, fontWeight: FontWeight.bold)),
                  SizedBox(width: 8.w),
                  Icon(Icons.phone, color: primaryColor, size: 24.r),
                  SizedBox(width: 12.w),
                  Text(contactNumber,
                      style: mainText.copyWith(fontSize: 18.sp)),
                ],
              ),

              SizedBox(height: 10.h),
              customDivider(),

              Text('Details',
                  style: mainText.copyWith(
                      fontSize: 24.sp, fontWeight: FontWeight.bold)),
              SizedBox(height: 10.h),
              Text(details,
                  style: mainText.copyWith(
                      fontSize: 18.sp, height: 1.4)),

              SizedBox(height: 10.h),
              customDivider(),

              Text('Included Features',
                  style: mainText.copyWith(
                      fontSize: 22.sp, fontWeight: FontWeight.bold)),
              SizedBox(height: 12.h),
              Wrap(
                spacing: 10.w,
                runSpacing: 10.h,
                children: features
                    .map((f) =>
                    _featuresCard(f, yellowColor, primaryColor))
                    .toList(),
              ),

              SizedBox(height: 10.h),
              customDivider(),

              Text('Gallery',
                  style: mainText.copyWith(
                      fontSize: 22.sp, fontWeight: FontWeight.bold)),
              SizedBox(height: 12.h),
              SizedBox(
                height: 200.h,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children:
                  galleryImages.map((e) => _imageCard(e)).toList(),
                ),
              ),

              SizedBox(height: 10.h),
              customDivider(),
              customTitleText(title: 'Map', size: 22),
              SizedBox(height: 12.h),
              GestureDetector(
                  onTap: ()async{
                    await OpenMapService.openMapFromUrl(location!);
                  },
                  child: Center(child: MapSection())
              ),
              SizedBox(height: 10.h),
              customDivider(),

              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text('$price JD',
                            style: mainText.copyWith(
                                fontSize: 30.sp,
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 8.h),
                        Text('per person',
                            style: mainText.copyWith(fontSize: 18.sp)),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    customDivider(),
                    SizedBox(height: 12.h),
                    if (showBookNow)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  BlocProvider(
                                    create: (context) => UserBookTripCubit(
                                      tripRepo: getIt<TripRepo>(),
                                    ),
                                    child: PaymentPage(
                                      tripId: tripId,
                                    ),
                                  ),
                            ),
                          );
                        },
                        child: Text(
                          'BOOK NOW!',
                          style: mainText.copyWith(
                              color: yellowColor, fontSize: 24.sp),
                        ),
                      )
                    else
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 12.h),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                              color: Colors.green, width: 2.w),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.check_circle,
                                color: Colors.green, size: 24.r),
                            SizedBox(width: 10.w),
                            Text(
                              'Booked Successfully',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }

  Widget _featuresCard(String text, Color bg, Color textColor) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4.r,
            offset: Offset(0, 3.h),
          ),
        ],
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontFamily: 'Jaldi',
          fontSize: 16.sp,
        ),
      ),
    );
  }

  Widget _imageCard(String url) {
    return Padding(
      padding: EdgeInsets.only(right: 12.w),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Image.network(
          url,
          width: 180.w,
          height: 500.h,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
