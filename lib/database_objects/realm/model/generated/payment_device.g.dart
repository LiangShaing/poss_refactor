// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../payment_device.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class PaymentDevice extends _PaymentDevice
    with RealmEntity, RealmObjectBase, RealmObject {
  PaymentDevice(
    ObjectId id,
    String departmentCode,
    String paymentDeviceId,
    String paymentGatewayId,
    String deviceName, {
    String? terminalId,
    String? deviceType,
    String? remarks,
    String? authenticationCashNo,
    String? authenticationPOSNo,
    String? authenticationMerchantNo,
    String? authenticationSign,
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'departmentCode', departmentCode);
    RealmObjectBase.set(this, 'paymentDeviceId', paymentDeviceId);
    RealmObjectBase.set(this, 'paymentGatewayId', paymentGatewayId);
    RealmObjectBase.set(this, 'terminalId', terminalId);
    RealmObjectBase.set(this, 'deviceType', deviceType);
    RealmObjectBase.set(this, 'deviceName', deviceName);
    RealmObjectBase.set(this, 'remarks', remarks);
    RealmObjectBase.set(this, 'authenticationCashNo', authenticationCashNo);
    RealmObjectBase.set(this, 'authenticationPOSNo', authenticationPOSNo);
    RealmObjectBase.set(
        this, 'authenticationMerchantNo', authenticationMerchantNo);
    RealmObjectBase.set(this, 'authenticationSign', authenticationSign);
  }

  PaymentDevice._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  String get departmentCode =>
      RealmObjectBase.get<String>(this, 'departmentCode') as String;
  @override
  set departmentCode(String value) =>
      RealmObjectBase.set(this, 'departmentCode', value);

  @override
  String get paymentDeviceId =>
      RealmObjectBase.get<String>(this, 'paymentDeviceId') as String;
  @override
  set paymentDeviceId(String value) =>
      RealmObjectBase.set(this, 'paymentDeviceId', value);

  @override
  String get paymentGatewayId =>
      RealmObjectBase.get<String>(this, 'paymentGatewayId') as String;
  @override
  set paymentGatewayId(String value) =>
      RealmObjectBase.set(this, 'paymentGatewayId', value);

  @override
  String? get terminalId =>
      RealmObjectBase.get<String>(this, 'terminalId') as String?;
  @override
  set terminalId(String? value) =>
      RealmObjectBase.set(this, 'terminalId', value);

  @override
  String? get deviceType =>
      RealmObjectBase.get<String>(this, 'deviceType') as String?;
  @override
  set deviceType(String? value) =>
      RealmObjectBase.set(this, 'deviceType', value);

  @override
  String get deviceName =>
      RealmObjectBase.get<String>(this, 'deviceName') as String;
  @override
  set deviceName(String value) =>
      RealmObjectBase.set(this, 'deviceName', value);

  @override
  String? get remarks =>
      RealmObjectBase.get<String>(this, 'remarks') as String?;
  @override
  set remarks(String? value) => RealmObjectBase.set(this, 'remarks', value);

  @override
  String? get authenticationCashNo =>
      RealmObjectBase.get<String>(this, 'authenticationCashNo') as String?;
  @override
  set authenticationCashNo(String? value) =>
      RealmObjectBase.set(this, 'authenticationCashNo', value);

  @override
  String? get authenticationPOSNo =>
      RealmObjectBase.get<String>(this, 'authenticationPOSNo') as String?;
  @override
  set authenticationPOSNo(String? value) =>
      RealmObjectBase.set(this, 'authenticationPOSNo', value);

  @override
  String? get authenticationMerchantNo =>
      RealmObjectBase.get<String>(this, 'authenticationMerchantNo') as String?;
  @override
  set authenticationMerchantNo(String? value) =>
      RealmObjectBase.set(this, 'authenticationMerchantNo', value);

  @override
  String? get authenticationSign =>
      RealmObjectBase.get<String>(this, 'authenticationSign') as String?;
  @override
  set authenticationSign(String? value) =>
      RealmObjectBase.set(this, 'authenticationSign', value);

  @override
  Stream<RealmObjectChanges<PaymentDevice>> get changes =>
      RealmObjectBase.getChanges<PaymentDevice>(this);

  @override
  PaymentDevice freeze() => RealmObjectBase.freezeObject<PaymentDevice>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(PaymentDevice._);
    return const SchemaObject(
        ObjectType.realmObject, PaymentDevice, 'paymentDevice', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('departmentCode', RealmPropertyType.string),
      SchemaProperty('paymentDeviceId', RealmPropertyType.string),
      SchemaProperty('paymentGatewayId', RealmPropertyType.string),
      SchemaProperty('terminalId', RealmPropertyType.string, optional: true),
      SchemaProperty('deviceType', RealmPropertyType.string, optional: true),
      SchemaProperty('deviceName', RealmPropertyType.string),
      SchemaProperty('remarks', RealmPropertyType.string, optional: true),
      SchemaProperty('authenticationCashNo', RealmPropertyType.string,
          optional: true),
      SchemaProperty('authenticationPOSNo', RealmPropertyType.string,
          optional: true),
      SchemaProperty('authenticationMerchantNo', RealmPropertyType.string,
          optional: true),
      SchemaProperty('authenticationSign', RealmPropertyType.string,
          optional: true),
    ]);
  }
}
