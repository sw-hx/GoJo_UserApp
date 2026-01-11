import 'package:bloc/bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:go_jo_user_application/data/models/payment_models/payment_intent_input_model.dart';
import 'package:meta/meta.dart';
import '../../../../domain/repos/checkout_repo.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit({required this.checkoutRepo}) : super(CheckoutInitial());
  final CheckoutRepo checkoutRepo;

  Future<void> makePayment({
    required PaymentIntentInputModel paymentIntentInputModel,
  }) async {
    emit(CheckoutLoading());
    try {
      await checkoutRepo.makePayment(
        paymentIntentInputModel: paymentIntentInputModel,
      );
      emit(CheckoutSuccess());
    } on StripeException catch (e) {
      if (e.error.code == FailureCode.Canceled) {
        emit(CheckoutCancelled(message: 'Payment Cancelled'));
      } else {
        emit(CheckoutFailure(message: 'Payment Failed'));
      }
    } catch (_) {
      emit(CheckoutFailure(message: 'Unexpected error occurred'));
    }
  }
}
