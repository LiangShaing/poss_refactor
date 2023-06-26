import 'package:realm/realm.dart';

part 'generated/payment_device.g.dart';

@RealmModel()
@MapTo('paymentDevice')
class _PaymentDevice {

  @PrimaryKey()
  @MapTo("_id")
  late ObjectId id;
  late String departmentCode;
  late String paymentDeviceId;
  late String paymentGatewayId;
  late String? terminalId;
  late String? deviceType;
  late String deviceName;
  late String? remarks;
  late String? authenticationCashNo;
  late String? authenticationPOSNo;
  late String? authenticationMerchantNo;
  late String? authenticationSign;

}