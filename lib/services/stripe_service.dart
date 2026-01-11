import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:go_jo_user_application/core/constants.dart';

import '../data/models/payment_models/payment_intent_input_model.dart';
import '../data/models/payment_models/payment_intent_model.dart';
import 'api_service.dart';

class StripeService{
  final ApiService apiService=ApiService();


  Future<PaymentIntentModel> createPaymentIntent(
      PaymentIntentInputModel paymentIntentInputModel) async {

    final body = {
      'amount': paymentIntentInputModel.amount,
      'currency': paymentIntentInputModel.currency,
      'payment_method_types[]': 'card',
    };

    final response = await apiService.post(
      body: body,
      url: 'https://api.stripe.com/v1/payment_intents',
      token: stripeSecretKey,
      contentType: Headers.formUrlEncodedContentType,
    );

    return PaymentIntentModel.fromJson(response.data);
  }


  Future<void> initPaymentSheet({
    required PaymentIntentModel paymentIntentModel,
  }) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntentModel.clientSecret,
        merchantDisplayName: 'GOJO',

        style: ThemeMode.light,

        appearance: const PaymentSheetAppearance(
          colors: PaymentSheetAppearanceColors(
            primary: Color(0xFF113545),
            background: Color(0xFFFDFEFE),
            componentBackground: Color(0xFFF1F4F6),
            primaryText: Color(0xFF0F172A),
            secondaryText: Color(0xFF475569),
            componentText: Color(0xFF0F172A),
            placeholderText: Color(0xFF94A3B8),
            icon: Color(0xFF113545),
          ),
          shapes: PaymentSheetShape(
            borderRadius: 22,
            borderWidth: 1,
          ),
          primaryButton: PaymentSheetPrimaryButtonAppearance(
            colors: PaymentSheetPrimaryButtonTheme(
              light: PaymentSheetPrimaryButtonThemeColors(
                background: Color(0xFF113545),
                text: Colors.white,
                border: Color(0xFF113545),
              ),
            ),
            shapes: PaymentSheetPrimaryButtonShape(
              blurRadius: 0,
              borderWidth: 0,
            ),
          ),
        ),

      ),
    );
  }


  Future<void> presentPaymentSheet()async{

   await Stripe.instance.presentPaymentSheet();

  }

  Future<void> makePayment({required PaymentIntentInputModel paymentIntentInputModel}) async{

    PaymentIntentModel paymentIntentModel=await createPaymentIntent(paymentIntentInputModel);

    await initPaymentSheet(paymentIntentModel: paymentIntentModel);

    await presentPaymentSheet();
  }
}