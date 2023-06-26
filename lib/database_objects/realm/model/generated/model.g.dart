// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../model.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Model extends _Model with RealmEntity, RealmObjectBase, RealmObject {
  Model(
    ObjectId id,
    double modelSequenceNumber,
    String catalogItem,
    bool fixedPriceIndicator, {
    ModelReference? usage,
    String? pricingType,
    ModelReference? ringSize,
    ModelReference? length,
    ProductTitle? productTitle,
    Iterable<String> departmentCodes = const [],
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'modelSequenceNumber', modelSequenceNumber);
    RealmObjectBase.set(this, 'catalogItem', catalogItem);
    RealmObjectBase.set(this, 'fixedPriceIndicator', fixedPriceIndicator);
    RealmObjectBase.set(this, 'usage', usage);
    RealmObjectBase.set(this, 'pricingType', pricingType);
    RealmObjectBase.set(this, 'ringSize', ringSize);
    RealmObjectBase.set(this, 'length', length);
    RealmObjectBase.set(this, 'productTitle', productTitle);
    RealmObjectBase.set<RealmList<String>>(
        this, 'departmentCodes', RealmList<String>(departmentCodes));
  }

  Model._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  double get modelSequenceNumber =>
      RealmObjectBase.get<double>(this, 'modelSequenceNumber') as double;
  @override
  set modelSequenceNumber(double value) =>
      RealmObjectBase.set(this, 'modelSequenceNumber', value);

  @override
  String get catalogItem =>
      RealmObjectBase.get<String>(this, 'catalogItem') as String;
  @override
  set catalogItem(String value) =>
      RealmObjectBase.set(this, 'catalogItem', value);

  @override
  bool get fixedPriceIndicator =>
      RealmObjectBase.get<bool>(this, 'fixedPriceIndicator') as bool;
  @override
  set fixedPriceIndicator(bool value) =>
      RealmObjectBase.set(this, 'fixedPriceIndicator', value);

  @override
  ModelReference? get usage =>
      RealmObjectBase.get<ModelReference>(this, 'usage') as ModelReference?;
  @override
  set usage(covariant ModelReference? value) =>
      RealmObjectBase.set(this, 'usage', value);

  @override
  String? get pricingType =>
      RealmObjectBase.get<String>(this, 'pricingType') as String?;
  @override
  set pricingType(String? value) =>
      RealmObjectBase.set(this, 'pricingType', value);

  @override
  RealmList<String> get departmentCodes =>
      RealmObjectBase.get<String>(this, 'departmentCodes') as RealmList<String>;
  @override
  set departmentCodes(covariant RealmList<String> value) =>
      throw RealmUnsupportedSetError();

  @override
  ModelReference? get ringSize =>
      RealmObjectBase.get<ModelReference>(this, 'ringSize') as ModelReference?;
  @override
  set ringSize(covariant ModelReference? value) =>
      RealmObjectBase.set(this, 'ringSize', value);

  @override
  ModelReference? get length =>
      RealmObjectBase.get<ModelReference>(this, 'length') as ModelReference?;
  @override
  set length(covariant ModelReference? value) =>
      RealmObjectBase.set(this, 'length', value);

  @override
  ProductTitle? get productTitle =>
      RealmObjectBase.get<ProductTitle>(this, 'productTitle') as ProductTitle?;
  @override
  set productTitle(covariant ProductTitle? value) =>
      RealmObjectBase.set(this, 'productTitle', value);

  @override
  Stream<RealmObjectChanges<Model>> get changes =>
      RealmObjectBase.getChanges<Model>(this);

  @override
  Model freeze() => RealmObjectBase.freezeObject<Model>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Model._);
    return const SchemaObject(ObjectType.realmObject, Model, 'model', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('modelSequenceNumber', RealmPropertyType.double),
      SchemaProperty('catalogItem', RealmPropertyType.string),
      SchemaProperty('fixedPriceIndicator', RealmPropertyType.bool),
      SchemaProperty('usage', RealmPropertyType.object,
          optional: true, linkTarget: 'ModelReference'),
      SchemaProperty('pricingType', RealmPropertyType.string, optional: true),
      SchemaProperty('departmentCodes', RealmPropertyType.string,
          collectionType: RealmCollectionType.list),
      SchemaProperty('ringSize', RealmPropertyType.object,
          optional: true, linkTarget: 'ModelReference'),
      SchemaProperty('length', RealmPropertyType.object,
          optional: true, linkTarget: 'ModelReference'),
      SchemaProperty('productTitle', RealmPropertyType.object,
          optional: true, linkTarget: 'ProductTitle'),
    ]);
  }
}

class ModelReference extends _ModelReference
    with RealmEntity, RealmObjectBase, EmbeddedObject {
  ModelReference(
    String referenceCode, {
    String? zhHK,
    String? zhTW,
    String? enUS,
    String? zhCN,
    String? status,
  }) {
    RealmObjectBase.set(this, 'zh_HK', zhHK);
    RealmObjectBase.set(this, 'zh_TW', zhTW);
    RealmObjectBase.set(this, 'en_US', enUS);
    RealmObjectBase.set(this, 'zh_CN', zhCN);
    RealmObjectBase.set(this, 'referenceCode', referenceCode);
    RealmObjectBase.set(this, 'status', status);
  }

  ModelReference._();

  @override
  String? get zhHK => RealmObjectBase.get<String>(this, 'zh_HK') as String?;
  @override
  set zhHK(String? value) => RealmObjectBase.set(this, 'zh_HK', value);

  @override
  String? get zhTW => RealmObjectBase.get<String>(this, 'zh_TW') as String?;
  @override
  set zhTW(String? value) => RealmObjectBase.set(this, 'zh_TW', value);

  @override
  String? get enUS => RealmObjectBase.get<String>(this, 'en_US') as String?;
  @override
  set enUS(String? value) => RealmObjectBase.set(this, 'en_US', value);

  @override
  String? get zhCN => RealmObjectBase.get<String>(this, 'zh_CN') as String?;
  @override
  set zhCN(String? value) => RealmObjectBase.set(this, 'zh_CN', value);

  @override
  String get referenceCode =>
      RealmObjectBase.get<String>(this, 'referenceCode') as String;
  @override
  set referenceCode(String value) =>
      RealmObjectBase.set(this, 'referenceCode', value);

  @override
  String? get status => RealmObjectBase.get<String>(this, 'status') as String?;
  @override
  set status(String? value) => RealmObjectBase.set(this, 'status', value);

  @override
  Stream<RealmObjectChanges<ModelReference>> get changes =>
      RealmObjectBase.getChanges<ModelReference>(this);

  @override
  ModelReference freeze() => RealmObjectBase.freezeObject<ModelReference>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(ModelReference._);
    return const SchemaObject(
        ObjectType.embeddedObject, ModelReference, 'ModelReference', [
      SchemaProperty('zhHK', RealmPropertyType.string,
          mapTo: 'zh_HK', optional: true),
      SchemaProperty('zhTW', RealmPropertyType.string,
          mapTo: 'zh_TW', optional: true),
      SchemaProperty('enUS', RealmPropertyType.string,
          mapTo: 'en_US', optional: true),
      SchemaProperty('zhCN', RealmPropertyType.string,
          mapTo: 'zh_CN', optional: true),
      SchemaProperty('referenceCode', RealmPropertyType.string),
      SchemaProperty('status', RealmPropertyType.string, optional: true),
    ]);
  }
}

class ProductTitle extends _ProductTitle
    with RealmEntity, RealmObjectBase, EmbeddedObject {
  ProductTitle({
    String? zhHK,
    String? zhTW,
    String? enUS,
    String? zhCN,
  }) {
    RealmObjectBase.set(this, 'zh_HK', zhHK);
    RealmObjectBase.set(this, 'zh_TW', zhTW);
    RealmObjectBase.set(this, 'en_US', enUS);
    RealmObjectBase.set(this, 'zh_CN', zhCN);
  }

  ProductTitle._();

  @override
  String? get zhHK => RealmObjectBase.get<String>(this, 'zh_HK') as String?;
  @override
  set zhHK(String? value) => RealmObjectBase.set(this, 'zh_HK', value);

  @override
  String? get zhTW => RealmObjectBase.get<String>(this, 'zh_TW') as String?;
  @override
  set zhTW(String? value) => RealmObjectBase.set(this, 'zh_TW', value);

  @override
  String? get enUS => RealmObjectBase.get<String>(this, 'en_US') as String?;
  @override
  set enUS(String? value) => RealmObjectBase.set(this, 'en_US', value);

  @override
  String? get zhCN => RealmObjectBase.get<String>(this, 'zh_CN') as String?;
  @override
  set zhCN(String? value) => RealmObjectBase.set(this, 'zh_CN', value);

  @override
  Stream<RealmObjectChanges<ProductTitle>> get changes =>
      RealmObjectBase.getChanges<ProductTitle>(this);

  @override
  ProductTitle freeze() => RealmObjectBase.freezeObject<ProductTitle>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(ProductTitle._);
    return const SchemaObject(
        ObjectType.embeddedObject, ProductTitle, 'ProductTitle', [
      SchemaProperty('zhHK', RealmPropertyType.string,
          mapTo: 'zh_HK', optional: true),
      SchemaProperty('zhTW', RealmPropertyType.string,
          mapTo: 'zh_TW', optional: true),
      SchemaProperty('enUS', RealmPropertyType.string,
          mapTo: 'en_US', optional: true),
      SchemaProperty('zhCN', RealmPropertyType.string,
          mapTo: 'zh_CN', optional: true),
    ]);
  }
}

class Group extends _Group with RealmEntity, RealmObjectBase, EmbeddedObject {
  Group(
    String code,
    String zhHK,
    String enUS,
    String zhCN,
    int id,
  ) {
    RealmObjectBase.set(this, 'code', code);
    RealmObjectBase.set(this, 'zh_HK', zhHK);
    RealmObjectBase.set(this, 'en_US', enUS);
    RealmObjectBase.set(this, 'zh_CN', zhCN);
    RealmObjectBase.set(this, 'id', id);
  }

  Group._();

  @override
  String get code => RealmObjectBase.get<String>(this, 'code') as String;
  @override
  set code(String value) => RealmObjectBase.set(this, 'code', value);

  @override
  String get zhHK => RealmObjectBase.get<String>(this, 'zh_HK') as String;
  @override
  set zhHK(String value) => RealmObjectBase.set(this, 'zh_HK', value);

  @override
  String get enUS => RealmObjectBase.get<String>(this, 'en_US') as String;
  @override
  set enUS(String value) => RealmObjectBase.set(this, 'en_US', value);

  @override
  String get zhCN => RealmObjectBase.get<String>(this, 'zh_CN') as String;
  @override
  set zhCN(String value) => RealmObjectBase.set(this, 'zh_CN', value);

  @override
  int get id => RealmObjectBase.get<int>(this, 'id') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, 'id', value);

  @override
  Stream<RealmObjectChanges<Group>> get changes =>
      RealmObjectBase.getChanges<Group>(this);

  @override
  Group freeze() => RealmObjectBase.freezeObject<Group>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Group._);
    return const SchemaObject(ObjectType.embeddedObject, Group, 'Group', [
      SchemaProperty('code', RealmPropertyType.string),
      SchemaProperty('zhHK', RealmPropertyType.string, mapTo: 'zh_HK'),
      SchemaProperty('enUS', RealmPropertyType.string, mapTo: 'en_US'),
      SchemaProperty('zhCN', RealmPropertyType.string, mapTo: 'zh_CN'),
      SchemaProperty('id', RealmPropertyType.int),
    ]);
  }
}

class WeightRange extends _WeightRange
    with RealmEntity, RealmObjectBase, EmbeddedObject {
  WeightRange(
    double lowerBound,
    double upperBound,
    String weightUnit,
  ) {
    RealmObjectBase.set(this, 'lowerBound', lowerBound);
    RealmObjectBase.set(this, 'upperBound', upperBound);
    RealmObjectBase.set(this, 'weightUnit', weightUnit);
  }

  WeightRange._();

  @override
  double get lowerBound =>
      RealmObjectBase.get<double>(this, 'lowerBound') as double;
  @override
  set lowerBound(double value) =>
      RealmObjectBase.set(this, 'lowerBound', value);

  @override
  double get upperBound =>
      RealmObjectBase.get<double>(this, 'upperBound') as double;
  @override
  set upperBound(double value) =>
      RealmObjectBase.set(this, 'upperBound', value);

  @override
  String get weightUnit =>
      RealmObjectBase.get<String>(this, 'weightUnit') as String;
  @override
  set weightUnit(String value) =>
      RealmObjectBase.set(this, 'weightUnit', value);

  @override
  Stream<RealmObjectChanges<WeightRange>> get changes =>
      RealmObjectBase.getChanges<WeightRange>(this);

  @override
  WeightRange freeze() => RealmObjectBase.freezeObject<WeightRange>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(WeightRange._);
    return const SchemaObject(
        ObjectType.embeddedObject, WeightRange, 'WeightRange', [
      SchemaProperty('lowerBound', RealmPropertyType.double),
      SchemaProperty('upperBound', RealmPropertyType.double),
      SchemaProperty('weightUnit', RealmPropertyType.string),
    ]);
  }
}
