// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../payment_method.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class PaymentMethod extends _PaymentMethod
    with RealmEntity, RealmObjectBase, RealmObject {
  PaymentMethod(
    ObjectId id,
    String departmentCode,
    String paymentMethodCode,
    String currencyCode,
    String paymentCategory,
    String refundable,
    String showInSettlement,
    String asDiscount,
    String couponRebateReceivable,
    String needStockTake,
    String needReferenceReconciliation, {
    String? externalPaymentMethodNameZHT,
    String? externalPaymentMethodNameZHS,
    String? externalPaymentMethodNameENG,
    String? internalPaymentMethodNameZHT,
    String? internalPaymentMethodNameZHS,
    String? internalPaymentMethodNameENG,
    String? soB2BInv,
    String? soB2CInv,
    String? joB2BInv,
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'departmentCode', departmentCode);
    RealmObjectBase.set(this, 'paymentMethodCode', paymentMethodCode);
    RealmObjectBase.set(this, 'currencyCode', currencyCode);
    RealmObjectBase.set(
        this, 'externalPaymentMethodNameZHT', externalPaymentMethodNameZHT);
    RealmObjectBase.set(
        this, 'externalPaymentMethodNameZHS', externalPaymentMethodNameZHS);
    RealmObjectBase.set(
        this, 'externalPaymentMethodNameENG', externalPaymentMethodNameENG);
    RealmObjectBase.set(
        this, 'internalPaymentMethodNameZHT', internalPaymentMethodNameZHT);
    RealmObjectBase.set(
        this, 'internalPaymentMethodNameZHS', internalPaymentMethodNameZHS);
    RealmObjectBase.set(
        this, 'internalPaymentMethodNameENG', internalPaymentMethodNameENG);
    RealmObjectBase.set(this, 'paymentCategory', paymentCategory);
    RealmObjectBase.set(this, 'refundable', refundable);
    RealmObjectBase.set(this, 'showInSettlement', showInSettlement);
    RealmObjectBase.set(this, 'asDiscount', asDiscount);
    RealmObjectBase.set(this, 'couponRebateReceivable', couponRebateReceivable);
    RealmObjectBase.set(this, 'needStockTake', needStockTake);
    RealmObjectBase.set(
        this, 'needReferenceReconciliation', needReferenceReconciliation);
    RealmObjectBase.set(this, 'soB2BInv', soB2BInv);
    RealmObjectBase.set(this, 'soB2CInv', soB2CInv);
    RealmObjectBase.set(this, 'joB2BInv', joB2BInv);
  }

  PaymentMethod._();

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
  String get paymentMethodCode =>
      RealmObjectBase.get<String>(this, 'paymentMethodCode') as String;
  @override
  set paymentMethodCode(String value) =>
      RealmObjectBase.set(this, 'paymentMethodCode', value);

  @override
  String get currencyCode =>
      RealmObjectBase.get<String>(this, 'currencyCode') as String;
  @override
  set currencyCode(String value) =>
      RealmObjectBase.set(this, 'currencyCode', value);

  @override
  String? get externalPaymentMethodNameZHT =>
      RealmObjectBase.get<String>(this, 'externalPaymentMethodNameZHT')
          as String?;
  @override
  set externalPaymentMethodNameZHT(String? value) =>
      RealmObjectBase.set(this, 'externalPaymentMethodNameZHT', value);

  @override
  String? get externalPaymentMethodNameZHS =>
      RealmObjectBase.get<String>(this, 'externalPaymentMethodNameZHS')
          as String?;
  @override
  set externalPaymentMethodNameZHS(String? value) =>
      RealmObjectBase.set(this, 'externalPaymentMethodNameZHS', value);

  @override
  String? get externalPaymentMethodNameENG =>
      RealmObjectBase.get<String>(this, 'externalPaymentMethodNameENG')
          as String?;
  @override
  set externalPaymentMethodNameENG(String? value) =>
      RealmObjectBase.set(this, 'externalPaymentMethodNameENG', value);

  @override
  String? get internalPaymentMethodNameZHT =>
      RealmObjectBase.get<String>(this, 'internalPaymentMethodNameZHT')
          as String?;
  @override
  set internalPaymentMethodNameZHT(String? value) =>
      RealmObjectBase.set(this, 'internalPaymentMethodNameZHT', value);

  @override
  String? get internalPaymentMethodNameZHS =>
      RealmObjectBase.get<String>(this, 'internalPaymentMethodNameZHS')
          as String?;
  @override
  set internalPaymentMethodNameZHS(String? value) =>
      RealmObjectBase.set(this, 'internalPaymentMethodNameZHS', value);

  @override
  String? get internalPaymentMethodNameENG =>
      RealmObjectBase.get<String>(this, 'internalPaymentMethodNameENG')
          as String?;
  @override
  set internalPaymentMethodNameENG(String? value) =>
      RealmObjectBase.set(this, 'internalPaymentMethodNameENG', value);

  @override
  String get paymentCategory =>
      RealmObjectBase.get<String>(this, 'paymentCategory') as String;
  @override
  set paymentCategory(String value) =>
      RealmObjectBase.set(this, 'paymentCategory', value);

  @override
  String get refundable =>
      RealmObjectBase.get<String>(this, 'refundable') as String;
  @override
  set refundable(String value) =>
      RealmObjectBase.set(this, 'refundable', value);

  @override
  String get showInSettlement =>
      RealmObjectBase.get<String>(this, 'showInSettlement') as String;
  @override
  set showInSettlement(String value) =>
      RealmObjectBase.set(this, 'showInSettlement', value);

  @override
  String get asDiscount =>
      RealmObjectBase.get<String>(this, 'asDiscount') as String;
  @override
  set asDiscount(String value) =>
      RealmObjectBase.set(this, 'asDiscount', value);

  @override
  String get couponRebateReceivable =>
      RealmObjectBase.get<String>(this, 'couponRebateReceivable') as String;
  @override
  set couponRebateReceivable(String value) =>
      RealmObjectBase.set(this, 'couponRebateReceivable', value);

  @override
  String get needStockTake =>
      RealmObjectBase.get<String>(this, 'needStockTake') as String;
  @override
  set needStockTake(String value) =>
      RealmObjectBase.set(this, 'needStockTake', value);

  @override
  String get needReferenceReconciliation =>
      RealmObjectBase.get<String>(this, 'needReferenceReconciliation')
          as String;
  @override
  set needReferenceReconciliation(String value) =>
      RealmObjectBase.set(this, 'needReferenceReconciliation', value);

  @override
  String? get soB2BInv =>
      RealmObjectBase.get<String>(this, 'soB2BInv') as String?;
  @override
  set soB2BInv(String? value) => RealmObjectBase.set(this, 'soB2BInv', value);

  @override
  String? get soB2CInv =>
      RealmObjectBase.get<String>(this, 'soB2CInv') as String?;
  @override
  set soB2CInv(String? value) => RealmObjectBase.set(this, 'soB2CInv', value);

  @override
  String? get joB2BInv =>
      RealmObjectBase.get<String>(this, 'joB2BInv') as String?;
  @override
  set joB2BInv(String? value) => RealmObjectBase.set(this, 'joB2BInv', value);

  @override
  Stream<RealmObjectChanges<PaymentMethod>> get changes =>
      RealmObjectBase.getChanges<PaymentMethod>(this);

  @override
  PaymentMethod freeze() => RealmObjectBase.freezeObject<PaymentMethod>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(PaymentMethod._);
    return const SchemaObject(
        ObjectType.realmObject, PaymentMethod, 'paymentMethod', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('departmentCode', RealmPropertyType.string),
      SchemaProperty('paymentMethodCode', RealmPropertyType.string),
      SchemaProperty('currencyCode', RealmPropertyType.string),
      SchemaProperty('externalPaymentMethodNameZHT', RealmPropertyType.string,
          optional: true),
      SchemaProperty('externalPaymentMethodNameZHS', RealmPropertyType.string,
          optional: true),
      SchemaProperty('externalPaymentMethodNameENG', RealmPropertyType.string,
          optional: true),
      SchemaProperty('internalPaymentMethodNameZHT', RealmPropertyType.string,
          optional: true),
      SchemaProperty('internalPaymentMethodNameZHS', RealmPropertyType.string,
          optional: true),
      SchemaProperty('internalPaymentMethodNameENG', RealmPropertyType.string,
          optional: true),
      SchemaProperty('paymentCategory', RealmPropertyType.string),
      SchemaProperty('refundable', RealmPropertyType.string),
      SchemaProperty('showInSettlement', RealmPropertyType.string),
      SchemaProperty('asDiscount', RealmPropertyType.string),
      SchemaProperty('couponRebateReceivable', RealmPropertyType.string),
      SchemaProperty('needStockTake', RealmPropertyType.string),
      SchemaProperty('needReferenceReconciliation', RealmPropertyType.string),
      SchemaProperty('soB2BInv', RealmPropertyType.string, optional: true),
      SchemaProperty('soB2CInv', RealmPropertyType.string, optional: true),
      SchemaProperty('joB2BInv', RealmPropertyType.string, optional: true),
    ]);
  }
}
