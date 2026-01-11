import '../../data/models/payment_models/payment_intent_input_model.dart';

abstract class CheckoutRepo{

  Future<void>makePayment({required PaymentIntentInputModel paymentIntentInputModel});

}