import 'package:flutter/material.dart';
import 'package:go_jo_user_application/pages/payment_pages/payment_page.dart';
import 'package:go_jo_user_application/pages/trips.dart';
import '../common_components/custom_divider.dart';
import '../common_components/custom_returnArrow.dart';
import '../common_components/bottom_nav_bar.dart';

/// coded by [suhaib]
class BookingPage extends StatelessWidget {
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

  const BookingPage({
    super.key,
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
  });

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF113545);
    const Color yellowColor = Color(0xFFFFE100);

    const TextStyle mainText = TextStyle(
      color: primaryColor,
      fontFamily: 'Jaldi',
      fontWeight: FontWeight.w400,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CustomReturnArrow(targetPage: TripsCardPage(),),
                ],
              ),
              const SizedBox(height: 30),

              Text(
                companyName,
                style: mainText.copyWith(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: List.generate(
                  5,
                      (index) => Icon(
                    index < rating ? Icons.star : Icons.star_border,
                    color: index < rating ? yellowColor : Colors.grey,
                    size: 28,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Text(
                'Launch',
                style: mainText.copyWith(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                launchDate,
                style: mainText.copyWith(fontSize: 20),
              ),
              const SizedBox(height: 10),
              Text(
                'Return',
                style: mainText.copyWith(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                returnDate,
                style: mainText.copyWith(fontSize: 20),
              ),

              const SizedBox(height: 10),
              customDivider(),

              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      fromLocation,
                      style: mainText.copyWith(
                          fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width:30),

                    const Icon(
                      Icons.arrow_right_alt_rounded,
                      color: primaryColor,
                      size: 100,
                    ),
                    const SizedBox(width: 30),

                    Text(
                      toLocation,
                      style: mainText.copyWith(
                          fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),
              customDivider(),
              const SizedBox(height: 10),

               Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Contact',
                      style: mainText.copyWith(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Icon(
                      Icons.phone,
                      color: primaryColor,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      contactNumber,
                      style: mainText.copyWith(fontSize: 20),
                    ),
                  ],
                ),

              const SizedBox(height: 10),
              customDivider(),

              Text(
                'Details',
                style: mainText.copyWith(
                    fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                details,
                style: mainText.copyWith(fontSize: 18, height: 1.4),
              ),

              const SizedBox(height: 10),
              customDivider(),

              Text(
                'Included Features',
                style: mainText.copyWith(
                    fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: features
                    .map((feature) => features_card(feature, yellowColor, primaryColor))
                    .toList(),
              ),

              const SizedBox(height: 10),
              customDivider(),

              Text(
                'Gallery',
                style: mainText.copyWith(
                    fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  children: galleryImages.map((url) => image_card(url)).toList(),
                ),
              ),

              const SizedBox(height: 10),
              customDivider(),

      Center(
          child: Column(
            children: [
            Text(
            'Company location on Map',
            style: mainText.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 40),
          InkWell(
            onTap: () {
            },
            child: Image.asset(
              'assets/images/map_image.png',
              width: 160,
              height: 100,
              fit: BoxFit.contain,
            ),
          ),
          ],
          ),
    ),


    const SizedBox(height: 10),
              customDivider(),
              const SizedBox(height: 10),

              // ---------- Price & Button ----------
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          '$price JD',
                          style: mainText.copyWith(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'per person',
                          style: mainText.copyWith(fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        shadowColor: Colors.black38,
                        elevation: 6,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PaymentPage(),
                          ),
                        );

                      },
                      child: Text(
                        'BOOK NOW!',
                        style: mainText.copyWith(
                          color: yellowColor,
                          fontSize: 28,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }

  Widget features_card(String text, Color bg, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontFamily: 'Jaldi',
          fontSize: 18,
        ),
      ),
    );
  }

  Widget image_card(String url) {
    return Padding(
        padding: const EdgeInsets.only(right: 12),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              url,
              width: 180,
              height: 500,
              fit: BoxFit.cover,
            ),
            ),
        );
    }
}
