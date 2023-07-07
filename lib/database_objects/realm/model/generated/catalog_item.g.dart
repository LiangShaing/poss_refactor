// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../catalog_item.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class CatalogItem extends _CatalogItem
    with RealmEntity, RealmObjectBase, RealmObject {
  CatalogItem(
    ObjectId id,
    String catalogItem, {
    ProductSampleInfoObject? brand,
    Reference? goldType,
    String? pricingType,
    Reference? usage,
    Collection? subCollection,
    Collection? collection,
    Reference? declaredMaterial,
    Reference? materialCategory,
    Iterable<String> departmentCodes = const [],
    Iterable<ProductTagType> earringsType = const [],
    Iterable<PhysicalWeight> standardSpecificationPhysicalWeight = const [],
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'catalogItem', catalogItem);
    RealmObjectBase.set(this, 'brand', brand);
    RealmObjectBase.set(this, 'goldType', goldType);
    RealmObjectBase.set(this, 'pricingType', pricingType);
    RealmObjectBase.set(this, 'usage', usage);
    RealmObjectBase.set(this, 'subCollection', subCollection);
    RealmObjectBase.set(this, 'collection', collection);
    RealmObjectBase.set(this, 'declaredMaterial', declaredMaterial);
    RealmObjectBase.set(this, 'materialCategory', materialCategory);
    RealmObjectBase.set<RealmList<String>>(
        this, 'departmentCodes', RealmList<String>(departmentCodes));
    RealmObjectBase.set<RealmList<ProductTagType>>(
        this, 'earringsType', RealmList<ProductTagType>(earringsType));
    RealmObjectBase.set<RealmList<PhysicalWeight>>(
        this,
        'standardSpecificationPhysicalWeight',
        RealmList<PhysicalWeight>(standardSpecificationPhysicalWeight));
  }

  CatalogItem._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  String get catalogItem =>
      RealmObjectBase.get<String>(this, 'catalogItem') as String;
  @override
  set catalogItem(String value) =>
      RealmObjectBase.set(this, 'catalogItem', value);

  @override
  ProductSampleInfoObject? get brand =>
      RealmObjectBase.get<ProductSampleInfoObject>(this, 'brand')
          as ProductSampleInfoObject?;
  @override
  set brand(covariant ProductSampleInfoObject? value) =>
      RealmObjectBase.set(this, 'brand', value);

  @override
  Reference? get goldType =>
      RealmObjectBase.get<Reference>(this, 'goldType') as Reference?;
  @override
  set goldType(covariant Reference? value) =>
      RealmObjectBase.set(this, 'goldType', value);

  @override
  String? get pricingType =>
      RealmObjectBase.get<String>(this, 'pricingType') as String?;
  @override
  set pricingType(String? value) =>
      RealmObjectBase.set(this, 'pricingType', value);

  @override
  Reference? get usage =>
      RealmObjectBase.get<Reference>(this, 'usage') as Reference?;
  @override
  set usage(covariant Reference? value) =>
      RealmObjectBase.set(this, 'usage', value);

  @override
  Collection? get subCollection =>
      RealmObjectBase.get<Collection>(this, 'subCollection') as Collection?;
  @override
  set subCollection(covariant Collection? value) =>
      RealmObjectBase.set(this, 'subCollection', value);

  @override
  Collection? get collection =>
      RealmObjectBase.get<Collection>(this, 'collection') as Collection?;
  @override
  set collection(covariant Collection? value) =>
      RealmObjectBase.set(this, 'collection', value);

  @override
  Reference? get declaredMaterial =>
      RealmObjectBase.get<Reference>(this, 'declaredMaterial') as Reference?;
  @override
  set declaredMaterial(covariant Reference? value) =>
      RealmObjectBase.set(this, 'declaredMaterial', value);

  @override
  RealmList<String> get departmentCodes =>
      RealmObjectBase.get<String>(this, 'departmentCodes') as RealmList<String>;
  @override
  set departmentCodes(covariant RealmList<String> value) =>
      throw RealmUnsupportedSetError();

  @override
  Reference? get materialCategory =>
      RealmObjectBase.get<Reference>(this, 'materialCategory') as Reference?;
  @override
  set materialCategory(covariant Reference? value) =>
      RealmObjectBase.set(this, 'materialCategory', value);

  @override
  RealmList<ProductTagType> get earringsType =>
      RealmObjectBase.get<ProductTagType>(this, 'earringsType')
          as RealmList<ProductTagType>;
  @override
  set earringsType(covariant RealmList<ProductTagType> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmList<PhysicalWeight> get standardSpecificationPhysicalWeight =>
      RealmObjectBase.get<PhysicalWeight>(
              this, 'standardSpecificationPhysicalWeight')
          as RealmList<PhysicalWeight>;
  @override
  set standardSpecificationPhysicalWeight(
          covariant RealmList<PhysicalWeight> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<CatalogItem>> get changes =>
      RealmObjectBase.getChanges<CatalogItem>(this);

  @override
  CatalogItem freeze() => RealmObjectBase.freezeObject<CatalogItem>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(CatalogItem._);
    return const SchemaObject(
        ObjectType.realmObject, CatalogItem, 'catalogItem', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('catalogItem', RealmPropertyType.string),
      SchemaProperty('brand', RealmPropertyType.object,
          optional: true, linkTarget: 'ProductSampleInfoObject'),
      SchemaProperty('goldType', RealmPropertyType.object,
          optional: true, linkTarget: 'Reference'),
      SchemaProperty('pricingType', RealmPropertyType.string, optional: true),
      SchemaProperty('usage', RealmPropertyType.object,
          optional: true, linkTarget: 'Reference'),
      SchemaProperty('subCollection', RealmPropertyType.object,
          optional: true, linkTarget: 'Collection'),
      SchemaProperty('collection', RealmPropertyType.object,
          optional: true, linkTarget: 'Collection'),
      SchemaProperty('declaredMaterial', RealmPropertyType.object,
          optional: true, linkTarget: 'Reference'),
      SchemaProperty('departmentCodes', RealmPropertyType.string,
          collectionType: RealmCollectionType.list),
      SchemaProperty('materialCategory', RealmPropertyType.object,
          optional: true, linkTarget: 'Reference'),
      SchemaProperty('earringsType', RealmPropertyType.object,
          linkTarget: 'ProductTagType',
          collectionType: RealmCollectionType.list),
      SchemaProperty(
          'standardSpecificationPhysicalWeight', RealmPropertyType.object,
          linkTarget: 'PhysicalWeight',
          collectionType: RealmCollectionType.list),
    ]);
  }
}

class Reference extends _Reference
    with RealmEntity, RealmObjectBase, EmbeddedObject {
  Reference({
    String? zhHK,
    String? zhTW,
    String? enUS,
    String? zhCN,
    String? referenceCode,
    String? status,
  }) {
    RealmObjectBase.set(this, 'zh_HK', zhHK);
    RealmObjectBase.set(this, 'zh_TW', zhTW);
    RealmObjectBase.set(this, 'en_US', enUS);
    RealmObjectBase.set(this, 'zh_CN', zhCN);
    RealmObjectBase.set(this, 'referenceCode', referenceCode);
    RealmObjectBase.set(this, 'status', status);
  }

  Reference._();

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
  String? get referenceCode =>
      RealmObjectBase.get<String>(this, 'referenceCode') as String?;
  @override
  set referenceCode(String? value) =>
      RealmObjectBase.set(this, 'referenceCode', value);

  @override
  String? get status => RealmObjectBase.get<String>(this, 'status') as String?;
  @override
  set status(String? value) => RealmObjectBase.set(this, 'status', value);

  @override
  Stream<RealmObjectChanges<Reference>> get changes =>
      RealmObjectBase.getChanges<Reference>(this);

  @override
  Reference freeze() => RealmObjectBase.freezeObject<Reference>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Reference._);
    return const SchemaObject(
        ObjectType.embeddedObject, Reference, 'Reference', [
      SchemaProperty('zhHK', RealmPropertyType.string,
          mapTo: 'zh_HK', optional: true),
      SchemaProperty('zhTW', RealmPropertyType.string,
          mapTo: 'zh_TW', optional: true),
      SchemaProperty('enUS', RealmPropertyType.string,
          mapTo: 'en_US', optional: true),
      SchemaProperty('zhCN', RealmPropertyType.string,
          mapTo: 'zh_CN', optional: true),
      SchemaProperty('referenceCode', RealmPropertyType.string, optional: true),
      SchemaProperty('status', RealmPropertyType.string, optional: true),
    ]);
  }
}

class Material extends _Material
    with RealmEntity, RealmObjectBase, EmbeddedObject {
  Material(
    String zhHK,
    String zhTW,
    String enUS,
    String zhCN,
    String materialCode,
    String status, {
    String? materialDescription,
    String? productType,
  }) {
    RealmObjectBase.set(this, 'zh_HK', zhHK);
    RealmObjectBase.set(this, 'zh_TW', zhTW);
    RealmObjectBase.set(this, 'en_US', enUS);
    RealmObjectBase.set(this, 'zh_CN', zhCN);
    RealmObjectBase.set(this, 'materialCode', materialCode);
    RealmObjectBase.set(this, 'materialDescription', materialDescription);
    RealmObjectBase.set(this, 'productType', productType);
    RealmObjectBase.set(this, 'status', status);
  }

  Material._();

  @override
  String get zhHK => RealmObjectBase.get<String>(this, 'zh_HK') as String;
  @override
  set zhHK(String value) => RealmObjectBase.set(this, 'zh_HK', value);

  @override
  String get zhTW => RealmObjectBase.get<String>(this, 'zh_TW') as String;
  @override
  set zhTW(String value) => RealmObjectBase.set(this, 'zh_TW', value);

  @override
  String get enUS => RealmObjectBase.get<String>(this, 'en_US') as String;
  @override
  set enUS(String value) => RealmObjectBase.set(this, 'en_US', value);

  @override
  String get zhCN => RealmObjectBase.get<String>(this, 'zh_CN') as String;
  @override
  set zhCN(String value) => RealmObjectBase.set(this, 'zh_CN', value);

  @override
  String get materialCode =>
      RealmObjectBase.get<String>(this, 'materialCode') as String;
  @override
  set materialCode(String value) =>
      RealmObjectBase.set(this, 'materialCode', value);

  @override
  String? get materialDescription =>
      RealmObjectBase.get<String>(this, 'materialDescription') as String?;
  @override
  set materialDescription(String? value) =>
      RealmObjectBase.set(this, 'materialDescription', value);

  @override
  String? get productType =>
      RealmObjectBase.get<String>(this, 'productType') as String?;
  @override
  set productType(String? value) =>
      RealmObjectBase.set(this, 'productType', value);

  @override
  String get status => RealmObjectBase.get<String>(this, 'status') as String;
  @override
  set status(String value) => RealmObjectBase.set(this, 'status', value);

  @override
  Stream<RealmObjectChanges<Material>> get changes =>
      RealmObjectBase.getChanges<Material>(this);

  @override
  Material freeze() => RealmObjectBase.freezeObject<Material>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Material._);
    return const SchemaObject(ObjectType.embeddedObject, Material, 'Material', [
      SchemaProperty('zhHK', RealmPropertyType.string, mapTo: 'zh_HK'),
      SchemaProperty('zhTW', RealmPropertyType.string, mapTo: 'zh_TW'),
      SchemaProperty('enUS', RealmPropertyType.string, mapTo: 'en_US'),
      SchemaProperty('zhCN', RealmPropertyType.string, mapTo: 'zh_CN'),
      SchemaProperty('materialCode', RealmPropertyType.string),
      SchemaProperty('materialDescription', RealmPropertyType.string,
          optional: true),
      SchemaProperty('productType', RealmPropertyType.string, optional: true),
      SchemaProperty('status', RealmPropertyType.string),
    ]);
  }
}

class ProductTagType extends _ProductTagType
    with RealmEntity, RealmObjectBase, EmbeddedObject {
  ProductTagType({
    String? zhHK,
    String? zhTW,
    String? enUS,
    String? zhCN,
    String? referenceCode,
    String? status,
  }) {
    RealmObjectBase.set(this, 'zh_HK', zhHK);
    RealmObjectBase.set(this, 'zh_TW', zhTW);
    RealmObjectBase.set(this, 'en_US', enUS);
    RealmObjectBase.set(this, 'zh_CN', zhCN);
    RealmObjectBase.set(this, 'referenceCode', referenceCode);
    RealmObjectBase.set(this, 'status', status);
  }

  ProductTagType._();

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
  String? get referenceCode =>
      RealmObjectBase.get<String>(this, 'referenceCode') as String?;
  @override
  set referenceCode(String? value) =>
      RealmObjectBase.set(this, 'referenceCode', value);

  @override
  String? get status => RealmObjectBase.get<String>(this, 'status') as String?;
  @override
  set status(String? value) => RealmObjectBase.set(this, 'status', value);

  @override
  Stream<RealmObjectChanges<ProductTagType>> get changes =>
      RealmObjectBase.getChanges<ProductTagType>(this);

  @override
  ProductTagType freeze() => RealmObjectBase.freezeObject<ProductTagType>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(ProductTagType._);
    return const SchemaObject(
        ObjectType.embeddedObject, ProductTagType, 'ProductTagType', [
      SchemaProperty('zhHK', RealmPropertyType.string,
          mapTo: 'zh_HK', optional: true),
      SchemaProperty('zhTW', RealmPropertyType.string,
          mapTo: 'zh_TW', optional: true),
      SchemaProperty('enUS', RealmPropertyType.string,
          mapTo: 'en_US', optional: true),
      SchemaProperty('zhCN', RealmPropertyType.string,
          mapTo: 'zh_CN', optional: true),
      SchemaProperty('referenceCode', RealmPropertyType.string, optional: true),
      SchemaProperty('status', RealmPropertyType.string, optional: true),
    ]);
  }
}

class ProductDescription extends _ProductDescription
    with RealmEntity, RealmObjectBase, EmbeddedObject {
  ProductDescription(
    ObjectId fdmProductDescriptionId,
    String zhHK,
    String enUS,
    String zhCN,
    int productId,
  ) {
    RealmObjectBase.set(
        this, 'FDM_productDescription_id', fdmProductDescriptionId);
    RealmObjectBase.set(this, 'zh_HK', zhHK);
    RealmObjectBase.set(this, 'en_US', enUS);
    RealmObjectBase.set(this, 'zh_CN', zhCN);
    RealmObjectBase.set(this, 'productId', productId);
  }

  ProductDescription._();

  @override
  ObjectId get fdmProductDescriptionId =>
      RealmObjectBase.get<ObjectId>(this, 'FDM_productDescription_id')
          as ObjectId;
  @override
  set fdmProductDescriptionId(ObjectId value) =>
      RealmObjectBase.set(this, 'FDM_productDescription_id', value);

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
  int get productId => RealmObjectBase.get<int>(this, 'productId') as int;
  @override
  set productId(int value) => RealmObjectBase.set(this, 'productId', value);

  @override
  Stream<RealmObjectChanges<ProductDescription>> get changes =>
      RealmObjectBase.getChanges<ProductDescription>(this);

  @override
  ProductDescription freeze() =>
      RealmObjectBase.freezeObject<ProductDescription>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(ProductDescription._);
    return const SchemaObject(
        ObjectType.embeddedObject, ProductDescription, 'ProductDescription', [
      SchemaProperty('fdmProductDescriptionId', RealmPropertyType.objectid,
          mapTo: 'FDM_productDescription_id'),
      SchemaProperty('zhHK', RealmPropertyType.string, mapTo: 'zh_HK'),
      SchemaProperty('enUS', RealmPropertyType.string, mapTo: 'en_US'),
      SchemaProperty('zhCN', RealmPropertyType.string, mapTo: 'zh_CN'),
      SchemaProperty('productId', RealmPropertyType.int),
    ]);
  }
}

class StyleCategoryDetail extends _StyleCategoryDetail
    with RealmEntity, RealmObjectBase, EmbeddedObject {
  StyleCategoryDetail(
    bool allowIndicator,
    String usage,
    String styleCategoryNumber, {
    String? minModelSize,
    String? engraveType,
    String? zhHK,
    String? zhCN,
    String? maxModelSize,
    ObjectId? fdmCategoryDetailsId,
    String? remarkType,
  }) {
    RealmObjectBase.set(this, 'MIN_MODEL_SIZE', minModelSize);
    RealmObjectBase.set(this, 'ENGRAVE_TYPE', engraveType);
    RealmObjectBase.set(this, 'zh_HK', zhHK);
    RealmObjectBase.set(this, 'allowIndicator', allowIndicator);
    RealmObjectBase.set(this, 'usage', usage);
    RealmObjectBase.set(this, 'styleCategoryNumber', styleCategoryNumber);
    RealmObjectBase.set(this, 'zh_CN', zhCN);
    RealmObjectBase.set(this, 'MAX_MODEL_SIZE', maxModelSize);
    RealmObjectBase.set(
        this, 'FDM_styleCategoryDetails_id', fdmCategoryDetailsId);
    RealmObjectBase.set(this, 'remarkType', remarkType);
  }

  StyleCategoryDetail._();

  @override
  String? get minModelSize =>
      RealmObjectBase.get<String>(this, 'MIN_MODEL_SIZE') as String?;
  @override
  set minModelSize(String? value) =>
      RealmObjectBase.set(this, 'MIN_MODEL_SIZE', value);

  @override
  String? get engraveType =>
      RealmObjectBase.get<String>(this, 'ENGRAVE_TYPE') as String?;
  @override
  set engraveType(String? value) =>
      RealmObjectBase.set(this, 'ENGRAVE_TYPE', value);

  @override
  String? get zhHK => RealmObjectBase.get<String>(this, 'zh_HK') as String?;
  @override
  set zhHK(String? value) => RealmObjectBase.set(this, 'zh_HK', value);

  @override
  bool get allowIndicator =>
      RealmObjectBase.get<bool>(this, 'allowIndicator') as bool;
  @override
  set allowIndicator(bool value) =>
      RealmObjectBase.set(this, 'allowIndicator', value);

  @override
  String get usage => RealmObjectBase.get<String>(this, 'usage') as String;
  @override
  set usage(String value) => RealmObjectBase.set(this, 'usage', value);

  @override
  String get styleCategoryNumber =>
      RealmObjectBase.get<String>(this, 'styleCategoryNumber') as String;
  @override
  set styleCategoryNumber(String value) =>
      RealmObjectBase.set(this, 'styleCategoryNumber', value);

  @override
  String? get zhCN => RealmObjectBase.get<String>(this, 'zh_CN') as String?;
  @override
  set zhCN(String? value) => RealmObjectBase.set(this, 'zh_CN', value);

  @override
  String? get maxModelSize =>
      RealmObjectBase.get<String>(this, 'MAX_MODEL_SIZE') as String?;
  @override
  set maxModelSize(String? value) =>
      RealmObjectBase.set(this, 'MAX_MODEL_SIZE', value);

  @override
  ObjectId? get fdmCategoryDetailsId =>
      RealmObjectBase.get<ObjectId>(this, 'FDM_styleCategoryDetails_id')
          as ObjectId?;
  @override
  set fdmCategoryDetailsId(ObjectId? value) =>
      RealmObjectBase.set(this, 'FDM_styleCategoryDetails_id', value);

  @override
  String? get remarkType =>
      RealmObjectBase.get<String>(this, 'remarkType') as String?;
  @override
  set remarkType(String? value) =>
      RealmObjectBase.set(this, 'remarkType', value);

  @override
  Stream<RealmObjectChanges<StyleCategoryDetail>> get changes =>
      RealmObjectBase.getChanges<StyleCategoryDetail>(this);

  @override
  StyleCategoryDetail freeze() =>
      RealmObjectBase.freezeObject<StyleCategoryDetail>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(StyleCategoryDetail._);
    return const SchemaObject(
        ObjectType.embeddedObject, StyleCategoryDetail, 'StyleCategoryDetail', [
      SchemaProperty('minModelSize', RealmPropertyType.string,
          mapTo: 'MIN_MODEL_SIZE', optional: true),
      SchemaProperty('engraveType', RealmPropertyType.string,
          mapTo: 'ENGRAVE_TYPE', optional: true),
      SchemaProperty('zhHK', RealmPropertyType.string,
          mapTo: 'zh_HK', optional: true),
      SchemaProperty('allowIndicator', RealmPropertyType.bool),
      SchemaProperty('usage', RealmPropertyType.string),
      SchemaProperty('styleCategoryNumber', RealmPropertyType.string),
      SchemaProperty('zhCN', RealmPropertyType.string,
          mapTo: 'zh_CN', optional: true),
      SchemaProperty('maxModelSize', RealmPropertyType.string,
          mapTo: 'MAX_MODEL_SIZE', optional: true),
      SchemaProperty('fdmCategoryDetailsId', RealmPropertyType.objectid,
          mapTo: 'FDM_styleCategoryDetails_id', optional: true),
      SchemaProperty('remarkType', RealmPropertyType.string, optional: true),
    ]);
  }
}

class QcAccept extends _QcAccept
    with RealmEntity, RealmObjectBase, EmbeddedObject {
  QcAccept(
    int productId,
    DateTime entryDate,
    double upperBound,
    double lowerBound,
    int seq,
    ObjectId fdmQcAcceptId,
    String weightUnit, {
    String? remark,
    String? entryUserId,
  }) {
    RealmObjectBase.set(this, 'productId', productId);
    RealmObjectBase.set(this, 'entryDate', entryDate);
    RealmObjectBase.set(this, 'upperBound', upperBound);
    RealmObjectBase.set(this, 'lowerBound', lowerBound);
    RealmObjectBase.set(this, 'remark', remark);
    RealmObjectBase.set(this, 'entryUserId', entryUserId);
    RealmObjectBase.set(this, 'seq', seq);
    RealmObjectBase.set(this, 'FDM_qcAccept_id', fdmQcAcceptId);
    RealmObjectBase.set(this, 'weightUnit', weightUnit);
  }

  QcAccept._();

  @override
  int get productId => RealmObjectBase.get<int>(this, 'productId') as int;
  @override
  set productId(int value) => RealmObjectBase.set(this, 'productId', value);

  @override
  DateTime get entryDate =>
      RealmObjectBase.get<DateTime>(this, 'entryDate') as DateTime;
  @override
  set entryDate(DateTime value) =>
      RealmObjectBase.set(this, 'entryDate', value);

  @override
  double get upperBound =>
      RealmObjectBase.get<double>(this, 'upperBound') as double;
  @override
  set upperBound(double value) =>
      RealmObjectBase.set(this, 'upperBound', value);

  @override
  double get lowerBound =>
      RealmObjectBase.get<double>(this, 'lowerBound') as double;
  @override
  set lowerBound(double value) =>
      RealmObjectBase.set(this, 'lowerBound', value);

  @override
  String? get remark => RealmObjectBase.get<String>(this, 'remark') as String?;
  @override
  set remark(String? value) => RealmObjectBase.set(this, 'remark', value);

  @override
  String? get entryUserId =>
      RealmObjectBase.get<String>(this, 'entryUserId') as String?;
  @override
  set entryUserId(String? value) =>
      RealmObjectBase.set(this, 'entryUserId', value);

  @override
  int get seq => RealmObjectBase.get<int>(this, 'seq') as int;
  @override
  set seq(int value) => RealmObjectBase.set(this, 'seq', value);

  @override
  ObjectId get fdmQcAcceptId =>
      RealmObjectBase.get<ObjectId>(this, 'FDM_qcAccept_id') as ObjectId;
  @override
  set fdmQcAcceptId(ObjectId value) =>
      RealmObjectBase.set(this, 'FDM_qcAccept_id', value);

  @override
  String get weightUnit =>
      RealmObjectBase.get<String>(this, 'weightUnit') as String;
  @override
  set weightUnit(String value) =>
      RealmObjectBase.set(this, 'weightUnit', value);

  @override
  Stream<RealmObjectChanges<QcAccept>> get changes =>
      RealmObjectBase.getChanges<QcAccept>(this);

  @override
  QcAccept freeze() => RealmObjectBase.freezeObject<QcAccept>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(QcAccept._);
    return const SchemaObject(ObjectType.embeddedObject, QcAccept, 'QcAccept', [
      SchemaProperty('productId', RealmPropertyType.int),
      SchemaProperty('entryDate', RealmPropertyType.timestamp),
      SchemaProperty('upperBound', RealmPropertyType.double),
      SchemaProperty('lowerBound', RealmPropertyType.double),
      SchemaProperty('remark', RealmPropertyType.string, optional: true),
      SchemaProperty('entryUserId', RealmPropertyType.string, optional: true),
      SchemaProperty('seq', RealmPropertyType.int),
      SchemaProperty('fdmQcAcceptId', RealmPropertyType.objectid,
          mapTo: 'FDM_qcAccept_id'),
      SchemaProperty('weightUnit', RealmPropertyType.string),
    ]);
  }
}

class MarketingKeyword extends _MarketingKeyword
    with RealmEntity, RealmObjectBase, EmbeddedObject {
  MarketingKeyword(
    int productId,
    ObjectId fdmProductMarketingKeywordId,
    int id,
    String status,
    ObjectId mdmMarketingKeywordId,
    String zhHK,
    String enUS,
    String zhCN,
  ) {
    RealmObjectBase.set(this, 'productId', productId);
    RealmObjectBase.set(
        this, 'FDM_productMarketingKeyword_id', fdmProductMarketingKeywordId);
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'status', status);
    RealmObjectBase.set(this, 'MDM_marketingKeyword_id', mdmMarketingKeywordId);
    RealmObjectBase.set(this, 'zh_HK', zhHK);
    RealmObjectBase.set(this, 'en_US', enUS);
    RealmObjectBase.set(this, 'zh_CN', zhCN);
  }

  MarketingKeyword._();

  @override
  int get productId => RealmObjectBase.get<int>(this, 'productId') as int;
  @override
  set productId(int value) => RealmObjectBase.set(this, 'productId', value);

  @override
  ObjectId get fdmProductMarketingKeywordId =>
      RealmObjectBase.get<ObjectId>(this, 'FDM_productMarketingKeyword_id')
          as ObjectId;
  @override
  set fdmProductMarketingKeywordId(ObjectId value) =>
      RealmObjectBase.set(this, 'FDM_productMarketingKeyword_id', value);

  @override
  int get id => RealmObjectBase.get<int>(this, 'id') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get status => RealmObjectBase.get<String>(this, 'status') as String;
  @override
  set status(String value) => RealmObjectBase.set(this, 'status', value);

  @override
  ObjectId get mdmMarketingKeywordId =>
      RealmObjectBase.get<ObjectId>(this, 'MDM_marketingKeyword_id')
          as ObjectId;
  @override
  set mdmMarketingKeywordId(ObjectId value) =>
      RealmObjectBase.set(this, 'MDM_marketingKeyword_id', value);

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
  Stream<RealmObjectChanges<MarketingKeyword>> get changes =>
      RealmObjectBase.getChanges<MarketingKeyword>(this);

  @override
  MarketingKeyword freeze() =>
      RealmObjectBase.freezeObject<MarketingKeyword>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(MarketingKeyword._);
    return const SchemaObject(
        ObjectType.embeddedObject, MarketingKeyword, 'MarketingKeyword', [
      SchemaProperty('productId', RealmPropertyType.int),
      SchemaProperty('fdmProductMarketingKeywordId', RealmPropertyType.objectid,
          mapTo: 'FDM_productMarketingKeyword_id'),
      SchemaProperty('id', RealmPropertyType.int),
      SchemaProperty('status', RealmPropertyType.string),
      SchemaProperty('mdmMarketingKeywordId', RealmPropertyType.objectid,
          mapTo: 'MDM_marketingKeyword_id'),
      SchemaProperty('zhHK', RealmPropertyType.string, mapTo: 'zh_HK'),
      SchemaProperty('enUS', RealmPropertyType.string, mapTo: 'en_US'),
      SchemaProperty('zhCN', RealmPropertyType.string, mapTo: 'zh_CN'),
    ]);
  }
}

class Collection extends _Collection
    with RealmEntity, RealmObjectBase, EmbeddedObject {
  Collection(
    String code,
    String enUS,
    String status,
    String zhCN,
    String zhHK,
  ) {
    RealmObjectBase.set(this, 'code', code);
    RealmObjectBase.set(this, 'en_US', enUS);
    RealmObjectBase.set(this, 'status', status);
    RealmObjectBase.set(this, 'zh_CN', zhCN);
    RealmObjectBase.set(this, 'zh_HK', zhHK);
  }

  Collection._();

  @override
  String get code => RealmObjectBase.get<String>(this, 'code') as String;
  @override
  set code(String value) => RealmObjectBase.set(this, 'code', value);

  @override
  String get enUS => RealmObjectBase.get<String>(this, 'en_US') as String;
  @override
  set enUS(String value) => RealmObjectBase.set(this, 'en_US', value);

  @override
  String get status => RealmObjectBase.get<String>(this, 'status') as String;
  @override
  set status(String value) => RealmObjectBase.set(this, 'status', value);

  @override
  String get zhCN => RealmObjectBase.get<String>(this, 'zh_CN') as String;
  @override
  set zhCN(String value) => RealmObjectBase.set(this, 'zh_CN', value);

  @override
  String get zhHK => RealmObjectBase.get<String>(this, 'zh_HK') as String;
  @override
  set zhHK(String value) => RealmObjectBase.set(this, 'zh_HK', value);

  @override
  Stream<RealmObjectChanges<Collection>> get changes =>
      RealmObjectBase.getChanges<Collection>(this);

  @override
  Collection freeze() => RealmObjectBase.freezeObject<Collection>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Collection._);
    return const SchemaObject(
        ObjectType.embeddedObject, Collection, 'Collection', [
      SchemaProperty('code', RealmPropertyType.string),
      SchemaProperty('enUS', RealmPropertyType.string, mapTo: 'en_US'),
      SchemaProperty('status', RealmPropertyType.string),
      SchemaProperty('zhCN', RealmPropertyType.string, mapTo: 'zh_CN'),
      SchemaProperty('zhHK', RealmPropertyType.string, mapTo: 'zh_HK'),
    ]);
  }
}

class ProductSampleInfoObject extends _ProductSampleInfoObject
    with RealmEntity, RealmObjectBase, EmbeddedObject {
  ProductSampleInfoObject(
    String code,
    String enUS,
    String status,
    String zhCN,
    String zhHK,
  ) {
    RealmObjectBase.set(this, 'code', code);
    RealmObjectBase.set(this, 'en_US', enUS);
    RealmObjectBase.set(this, 'status', status);
    RealmObjectBase.set(this, 'zh_CN', zhCN);
    RealmObjectBase.set(this, 'zh_HK', zhHK);
  }

  ProductSampleInfoObject._();

  @override
  String get code => RealmObjectBase.get<String>(this, 'code') as String;
  @override
  set code(String value) => RealmObjectBase.set(this, 'code', value);

  @override
  String get enUS => RealmObjectBase.get<String>(this, 'en_US') as String;
  @override
  set enUS(String value) => RealmObjectBase.set(this, 'en_US', value);

  @override
  String get status => RealmObjectBase.get<String>(this, 'status') as String;
  @override
  set status(String value) => RealmObjectBase.set(this, 'status', value);

  @override
  String get zhCN => RealmObjectBase.get<String>(this, 'zh_CN') as String;
  @override
  set zhCN(String value) => RealmObjectBase.set(this, 'zh_CN', value);

  @override
  String get zhHK => RealmObjectBase.get<String>(this, 'zh_HK') as String;
  @override
  set zhHK(String value) => RealmObjectBase.set(this, 'zh_HK', value);

  @override
  Stream<RealmObjectChanges<ProductSampleInfoObject>> get changes =>
      RealmObjectBase.getChanges<ProductSampleInfoObject>(this);

  @override
  ProductSampleInfoObject freeze() =>
      RealmObjectBase.freezeObject<ProductSampleInfoObject>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(ProductSampleInfoObject._);
    return const SchemaObject(ObjectType.embeddedObject,
        ProductSampleInfoObject, 'ProductSampleInfoObject', [
      SchemaProperty('code', RealmPropertyType.string),
      SchemaProperty('enUS', RealmPropertyType.string, mapTo: 'en_US'),
      SchemaProperty('status', RealmPropertyType.string),
      SchemaProperty('zhCN', RealmPropertyType.string, mapTo: 'zh_CN'),
      SchemaProperty('zhHK', RealmPropertyType.string, mapTo: 'zh_HK'),
    ]);
  }
}

class PhysicalWeight extends _PhysicalWeight
    with RealmEntity, RealmObjectBase, EmbeddedObject {
  PhysicalWeight({
    String? lastModifyUser,
    String? sizeReferenceCode,
    ObjectId? fdmStandardSpecificationPhysicalWeightId,
    double? productId,
    double? upperBound,
    double? lowerBound,
    DateTime? lastModifyDate,
    String? weightUnit,
  }) {
    RealmObjectBase.set(this, 'lastModifyUser', lastModifyUser);
    RealmObjectBase.set(this, 'sizeReferenceCode', sizeReferenceCode);
    RealmObjectBase.set(this, 'FDM_standardSpecificationPhysicalWeight_id',
        fdmStandardSpecificationPhysicalWeightId);
    RealmObjectBase.set(this, 'productId', productId);
    RealmObjectBase.set(this, 'upperBound', upperBound);
    RealmObjectBase.set(this, 'lowerBound', lowerBound);
    RealmObjectBase.set(this, 'lastModifyDate', lastModifyDate);
    RealmObjectBase.set(this, 'weightUnit', weightUnit);
  }

  PhysicalWeight._();

  @override
  String? get lastModifyUser =>
      RealmObjectBase.get<String>(this, 'lastModifyUser') as String?;
  @override
  set lastModifyUser(String? value) =>
      RealmObjectBase.set(this, 'lastModifyUser', value);

  @override
  String? get sizeReferenceCode =>
      RealmObjectBase.get<String>(this, 'sizeReferenceCode') as String?;
  @override
  set sizeReferenceCode(String? value) =>
      RealmObjectBase.set(this, 'sizeReferenceCode', value);

  @override
  ObjectId? get fdmStandardSpecificationPhysicalWeightId =>
      RealmObjectBase.get<ObjectId>(
          this, 'FDM_standardSpecificationPhysicalWeight_id') as ObjectId?;
  @override
  set fdmStandardSpecificationPhysicalWeightId(ObjectId? value) =>
      RealmObjectBase.set(
          this, 'FDM_standardSpecificationPhysicalWeight_id', value);

  @override
  double? get productId =>
      RealmObjectBase.get<double>(this, 'productId') as double?;
  @override
  set productId(double? value) => RealmObjectBase.set(this, 'productId', value);

  @override
  double? get upperBound =>
      RealmObjectBase.get<double>(this, 'upperBound') as double?;
  @override
  set upperBound(double? value) =>
      RealmObjectBase.set(this, 'upperBound', value);

  @override
  double? get lowerBound =>
      RealmObjectBase.get<double>(this, 'lowerBound') as double?;
  @override
  set lowerBound(double? value) =>
      RealmObjectBase.set(this, 'lowerBound', value);

  @override
  DateTime? get lastModifyDate =>
      RealmObjectBase.get<DateTime>(this, 'lastModifyDate') as DateTime?;
  @override
  set lastModifyDate(DateTime? value) =>
      RealmObjectBase.set(this, 'lastModifyDate', value);

  @override
  String? get weightUnit =>
      RealmObjectBase.get<String>(this, 'weightUnit') as String?;
  @override
  set weightUnit(String? value) =>
      RealmObjectBase.set(this, 'weightUnit', value);

  @override
  Stream<RealmObjectChanges<PhysicalWeight>> get changes =>
      RealmObjectBase.getChanges<PhysicalWeight>(this);

  @override
  PhysicalWeight freeze() => RealmObjectBase.freezeObject<PhysicalWeight>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(PhysicalWeight._);
    return const SchemaObject(
        ObjectType.embeddedObject, PhysicalWeight, 'PhysicalWeight', [
      SchemaProperty('lastModifyUser', RealmPropertyType.string,
          optional: true),
      SchemaProperty('sizeReferenceCode', RealmPropertyType.string,
          optional: true),
      SchemaProperty('fdmStandardSpecificationPhysicalWeightId',
          RealmPropertyType.objectid,
          mapTo: 'FDM_standardSpecificationPhysicalWeight_id', optional: true),
      SchemaProperty('productId', RealmPropertyType.double, optional: true),
      SchemaProperty('upperBound', RealmPropertyType.double, optional: true),
      SchemaProperty('lowerBound', RealmPropertyType.double, optional: true),
      SchemaProperty('lastModifyDate', RealmPropertyType.timestamp,
          optional: true),
      SchemaProperty('weightUnit', RealmPropertyType.string, optional: true),
    ]);
  }
}
