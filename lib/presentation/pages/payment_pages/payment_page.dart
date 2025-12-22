import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:go_jo_user_application/presentation/pages/payment_pages/paymentSucsess.dart';
import '../../common_components/bottom_nav_bar.dart';
import '../../common_components/custom_returnArrow.dart';
import '../trips.dart';
import '../../cubits/user_book_trip_cubit/user_book_trip_cubit.dart';

/// Coded by [Hala]

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key, required this.tripId}) : super(key: key);
  final int tripId;

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int selectedMethod = 0;
  bool saveCard = false;

  final TextEditingController cardHolderController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cvcController = TextEditingController();
  final TextEditingController expiryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final methods = ["Visa", "PayPal"];
    final icons = [
      "https://logos-world.net/wp-content/uploads/2020/05/Visa-Logo.png",
      "https://logos-world.net/wp-content/uploads/2024/10/PayPal-Logo-New.png"
    ];

    return BlocConsumer<UserBookTripCubit, UserBookTripState>(
      listener: (context, state) {
        if (state is UserBookTripSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const PaymentSuccessPage(),
            ),
          );
        }

        if (state is UserBookTripFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is UserBookTripLoading,
          dismissible: false,
          opacity: 0.4,
          progressIndicator: const CircularProgressIndicator(
            color: Color(0xFF256D85),
          ),
          child: Scaffold(
            body: SafeArea(
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomReturnArrow(
                        targetPage: TripsCardPage(),
                      ),

                      const SizedBox(height: 30),

                      const Text(
                        "Your journey starts here",
                        style: TextStyle(
                          fontSize: 28,
                          color: Color(0xFF11324D),
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 25),

                      const Text(
                        "Choose payment method",
                        style: TextStyle(
                          fontSize: 17,
                          color: Color(0xFF256D85),
                        ),
                      ),

                      const SizedBox(height: 10),

                      Row(
                        children: List.generate(methods.length, (index) {
                          final selected = index == selectedMethod;
                          return GestureDetector(
                            onTap: () =>
                                setState(() => selectedMethod = index),
                            child: Padding(
                              padding: const EdgeInsets.only(right: 25),
                              child: Column(
                                children: [
                                  Image.network(
                                    icons[index],
                                    width: 60,
                                    height: 40,
                                  ),
                                  const SizedBox(height: 5),
                                  Container(
                                    height: 3,
                                    width: 55,
                                    color: selected
                                        ? const Color(0xFF006699)
                                        : Colors.transparent,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),

                      const SizedBox(height: 30),

                      selectedMethod == 0
                          ? buildVisaSection(state)
                          : buildPayPalSection(state),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: const BottomNavBar(),
          ),
        );
      },
    );
  }

  // ================= VISA =================
  Widget buildVisaSection(UserBookTripState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Cardholders name",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFF083F4F),
          ),
        ),
        const SizedBox(height: 8),
        _textField(cardHolderController, "Enter cardholder name"),

        const SizedBox(height: 20),

        const Text(
          "Card number",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFF083F4F),
          ),
        ),
        const SizedBox(height: 8),
        _textField(
          cardNumberController,
          "Enter card number",
          keyboardType: TextInputType.number,
        ),

        const SizedBox(height: 20),

        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "CVC",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF083F4F),
                    ),
                  ),
                  const SizedBox(height: 8),
                  _textField(
                    cvcController,
                    "CVC",
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Expiration Date",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF083F4F),
                    ),
                  ),
                  const SizedBox(height: 8),
                  _textField(
                    expiryController,
                    "MM/YY",
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 15),

        Row(
          children: [
            Checkbox(
              value: saveCard,
              onChanged: (v) => setState(() => saveCard = v!),
            ),
            const Text(
              "Save card for future purchases",
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF083F4F),
              ),
            ),
          ],
        ),

        const SizedBox(height: 30),

        Center(
          child: ElevatedButton(
            onPressed: state is UserBookTripLoading
                ? null
                : () {
              context.read<UserBookTripCubit>().bookTrip(
                tripId: widget.tripId,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF256D85),
              padding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            child: const Text(
              "BOOK NOW!",
              style: TextStyle(
                color: Color(0xFFFFE500),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ================= PAYPAL =================
  Widget buildPayPalSection(UserBookTripState state) {
    return Column(
      children: [
        const SizedBox(height: 30),
        const Text(
          "Pay securely with your PayPal account",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF083F4F),
          ),
        ),
        const SizedBox(height: 20),
        Image.network(
          "https://logos-world.net/wp-content/uploads/2024/10/PayPal-Logo-New.png",
          height: 60,
        ),
        const SizedBox(height: 40),
        ElevatedButton(
          onPressed: state is UserBookTripLoading
              ? null
              : () {
            context.read<UserBookTripCubit>().bookTrip(
              tripId: widget.tripId,
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF256D85),
            padding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: const Text(
            "CONTINUE TO PAYPAL",
            style: TextStyle(
              color: Color(0xFFFFE500),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  // ================= TEXT FIELD =================
  Widget _textField(
      TextEditingController controller,
      String hint, {
        TextInputType? keyboardType,
      }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.grey.shade200,
        contentPadding:
        const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
