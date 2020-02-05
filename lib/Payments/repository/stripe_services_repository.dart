import 'package:ecomerceapp/Payments/repository/stripe_services_api.dart';

class StripeServicesRepository {
  final stripe_services_api = StripeServicesAPI();

  Future<void> createStripeCustomer({String email, String userId}) =>
      stripe_services_api.createStripeCustomer(email: email, userId: userId);

  Future<void> addCard(
          {int cardNumber, int month, int year, int cvc, String stripeId}) =>
      stripe_services_api.addCard(
          stripeId: stripeId,
          year: year,
          month: month,
          cvc: cvc,
          cardNumber: cardNumber);

  Future<void> charge(
          {int amount,
          String currency,
          String sourceToken,
          String descripcion,
          String customerID}) =>
      stripe_services_api.charge(
          sourceToken: sourceToken,
          customerID: customerID,
          currency: currency,
          descripcion: descripcion,
          amount: amount);
}
