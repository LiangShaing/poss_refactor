import 'package:realm/realm.dart';

part 'generated/payment_method.g.dart';

@RealmModel()
@MapTo('paymentMethod')
class _PaymentMethod {
  @PrimaryKey()
  @MapTo("_id")
  late ObjectId id;
  late String departmentCode;
  late String paymentMethodCode;
  late String currencyCode;
  late String? externalPaymentMethodNameZHT;
  late String? externalPaymentMethodNameZHS;
  late String? externalPaymentMethodNameENG;
  late String? internalPaymentMethodNameZHT;
  late String? internalPaymentMethodNameZHS;
  late String? internalPaymentMethodNameENG;
  late String paymentCategory;
  late String refundable;
  late String showInSettlement;
  late String asDiscount;
  late String couponRebateReceivable;
  late String needStockTake;
  late String needReferenceReconciliation;
  late String? soB2BInv;
  late String? soB2CInv;
  late String? joB2BInv;
}