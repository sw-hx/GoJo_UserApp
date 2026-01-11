class PaymentIntentModel {
  final String id;
  final String object;
  final int amount;
  final int amountCapturable;
  final int amountReceived;
  final String currency;
  final String clientSecret;
  final String status;
  final bool livemode;
  final int created;
  final List<String> paymentMethodTypes;
  final AutomaticPaymentMethods? automaticPaymentMethods;
  final PaymentMethodOptions? paymentMethodOptions;

  PaymentIntentModel({
    required this.id,
    required this.object,
    required this.amount,
    required this.amountCapturable,
    required this.amountReceived,
    required this.currency,
    required this.clientSecret,
    required this.status,
    required this.livemode,
    required this.created,
    required this.paymentMethodTypes,
    this.automaticPaymentMethods,
    this.paymentMethodOptions,
  });

  factory PaymentIntentModel.fromJson(Map<String, dynamic> json) {
    return PaymentIntentModel(
      id: json['id'],
      object: json['object'],
      amount: json['amount'],
      amountCapturable: json['amount_capturable'],
      amountReceived: json['amount_received'],
      currency: json['currency'],
      clientSecret: json['client_secret'],
      status: json['status'],
      livemode: json['livemode'],
      created: json['created'],
      paymentMethodTypes:
      List<String>.from(json['payment_method_types'] ?? []),
      automaticPaymentMethods: json['automatic_payment_methods'] != null
          ? AutomaticPaymentMethods.fromJson(
        json['automatic_payment_methods'],
      )
          : null,
      paymentMethodOptions: json['payment_method_options'] != null
          ? PaymentMethodOptions.fromJson(
        json['payment_method_options'],
      )
          : null,
    );
  }
}

class AutomaticPaymentMethods {
  final bool enabled;

  AutomaticPaymentMethods({required this.enabled});

  factory AutomaticPaymentMethods.fromJson(Map<String, dynamic> json) {
    return AutomaticPaymentMethods(
      enabled: json['enabled'],
    );
  }
}

class PaymentMethodOptions {
  final CardOptions? card;

  PaymentMethodOptions({this.card});

  factory PaymentMethodOptions.fromJson(Map<String, dynamic> json) {
    return PaymentMethodOptions(
      card:
      json['card'] != null ? CardOptions.fromJson(json['card']) : null,
    );
  }
}

class CardOptions {
  final String? requestThreeDSecure;

  CardOptions({this.requestThreeDSecure});

  factory CardOptions.fromJson(Map<String, dynamic> json) {
    return CardOptions(
      requestThreeDSecure: json['request_three_d_secure'],
    );
  }
}