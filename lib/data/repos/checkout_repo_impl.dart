import '../../domain/repos/checkout_repo.dart';
import '../../services/stripe_service.dart';
import '../models/payment_models/payment_intent_input_model.dart';

class CheckoutRepoImpl implements CheckoutRepo{
  final StripeService stripeService;

  CheckoutRepoImpl({required this.stripeService});

  @override
  Future<void> makePayment({required PaymentIntentInputModel paymentIntentInputModel}) async{

     await stripeService.makePayment(paymentIntentInputModel: paymentIntentInputModel);

  }
}