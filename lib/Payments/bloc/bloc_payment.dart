import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:stripe_payment/stripe_payment.dart';

class PaymentBloc implements Bloc {
  PaymentBloc() {
    StripePayment.setOptions(StripeOptions(
        publishableKey: "pk_test_ZbTnVP36Xm2jew9rbA0Tz47q00vFv9ThSp"));
  }

  @override
  void dispose() {}
}
