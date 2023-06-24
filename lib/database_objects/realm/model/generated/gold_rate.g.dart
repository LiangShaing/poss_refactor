// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../gold_rate.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class GoldRate extends _GoldRate
    with RealmEntity, RealmObjectBase, RealmObject {
  GoldRate(
    ObjectId id,
    String ccy,
    DateTime effectiveDate,
    String from,
    String goldRateTypeCode,
    bool includeLaborCostIndicator,
    bool isBarIndicator,
    bool isGoldIndicator,
    DateTime lastModifyDate,
    String lastModifyUser,
    double rate,
    String rateId,
    String zhCN,
  ) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'ccy', ccy);
    RealmObjectBase.set(this, 'effectiveDate', effectiveDate);
    RealmObjectBase.set(this, 'from', from);
    RealmObjectBase.set(this, 'goldRateTypeCode', goldRateTypeCode);
    RealmObjectBase.set(
        this, 'includeLaborCostIndicator', includeLaborCostIndicator);
    RealmObjectBase.set(this, 'isBarIndicator', isBarIndicator);
    RealmObjectBase.set(this, 'isGoldIndicator', isGoldIndicator);
    RealmObjectBase.set(this, 'lastModifyDate', lastModifyDate);
    RealmObjectBase.set(this, 'lastModifyUser', lastModifyUser);
    RealmObjectBase.set(this, 'rate', rate);
    RealmObjectBase.set(this, 'rateId', rateId);
    RealmObjectBase.set(this, 'zh_CN', zhCN);
  }

  GoldRate._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  String get ccy => RealmObjectBase.get<String>(this, 'ccy') as String;
  @override
  set ccy(String value) => RealmObjectBase.set(this, 'ccy', value);

  @override
  DateTime get effectiveDate =>
      RealmObjectBase.get<DateTime>(this, 'effectiveDate') as DateTime;
  @override
  set effectiveDate(DateTime value) =>
      RealmObjectBase.set(this, 'effectiveDate', value);

  @override
  String get from => RealmObjectBase.get<String>(this, 'from') as String;
  @override
  set from(String value) => RealmObjectBase.set(this, 'from', value);

  @override
  String get goldRateTypeCode =>
      RealmObjectBase.get<String>(this, 'goldRateTypeCode') as String;
  @override
  set goldRateTypeCode(String value) =>
      RealmObjectBase.set(this, 'goldRateTypeCode', value);

  @override
  bool get includeLaborCostIndicator =>
      RealmObjectBase.get<bool>(this, 'includeLaborCostIndicator') as bool;
  @override
  set includeLaborCostIndicator(bool value) =>
      RealmObjectBase.set(this, 'includeLaborCostIndicator', value);

  @override
  bool get isBarIndicator =>
      RealmObjectBase.get<bool>(this, 'isBarIndicator') as bool;
  @override
  set isBarIndicator(bool value) =>
      RealmObjectBase.set(this, 'isBarIndicator', value);

  @override
  bool get isGoldIndicator =>
      RealmObjectBase.get<bool>(this, 'isGoldIndicator') as bool;
  @override
  set isGoldIndicator(bool value) =>
      RealmObjectBase.set(this, 'isGoldIndicator', value);

  @override
  DateTime get lastModifyDate =>
      RealmObjectBase.get<DateTime>(this, 'lastModifyDate') as DateTime;
  @override
  set lastModifyDate(DateTime value) =>
      RealmObjectBase.set(this, 'lastModifyDate', value);

  @override
  String get lastModifyUser =>
      RealmObjectBase.get<String>(this, 'lastModifyUser') as String;
  @override
  set lastModifyUser(String value) =>
      RealmObjectBase.set(this, 'lastModifyUser', value);

  @override
  double get rate => RealmObjectBase.get<double>(this, 'rate') as double;
  @override
  set rate(double value) => RealmObjectBase.set(this, 'rate', value);

  @override
  String get rateId => RealmObjectBase.get<String>(this, 'rateId') as String;
  @override
  set rateId(String value) => RealmObjectBase.set(this, 'rateId', value);

  @override
  String get zhCN => RealmObjectBase.get<String>(this, 'zh_CN') as String;
  @override
  set zhCN(String value) => RealmObjectBase.set(this, 'zh_CN', value);

  @override
  Stream<RealmObjectChanges<GoldRate>> get changes =>
      RealmObjectBase.getChanges<GoldRate>(this);

  @override
  GoldRate freeze() => RealmObjectBase.freezeObject<GoldRate>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(GoldRate._);
    return const SchemaObject(ObjectType.realmObject, GoldRate, 'goldRate', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('ccy', RealmPropertyType.string),
      SchemaProperty('effectiveDate', RealmPropertyType.timestamp),
      SchemaProperty('from', RealmPropertyType.string),
      SchemaProperty('goldRateTypeCode', RealmPropertyType.string),
      SchemaProperty('includeLaborCostIndicator', RealmPropertyType.bool),
      SchemaProperty('isBarIndicator', RealmPropertyType.bool),
      SchemaProperty('isGoldIndicator', RealmPropertyType.bool),
      SchemaProperty('lastModifyDate', RealmPropertyType.timestamp),
      SchemaProperty('lastModifyUser', RealmPropertyType.string),
      SchemaProperty('rate', RealmPropertyType.double),
      SchemaProperty('rateId', RealmPropertyType.string),
      SchemaProperty('zhCN', RealmPropertyType.string, mapTo: 'zh_CN'),
    ]);
  }
}
