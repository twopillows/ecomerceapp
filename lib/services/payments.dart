import 'package:stripe_payment/stripe_payment.dart';

class PaymentService {
  PaymentService() {
    StripePayment.setOptions(StripeOptions(
        publishableKey: "pk_test_ZbTnVP36Xm2jew9rbA0Tz47q00vFv9ThSp"));
  }
}
