// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../customer_session.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class CustomerSession extends _CustomerSession
    with RealmEntity, RealmObjectBase, RealmObject {
  CustomerSession(
    ObjectId id,
    bool checkInIndicator,
    DateTime createdDate,
    String departmentCode,
    String employeeId,
    String employeeName, {
    ShoppingBag? shoppingBag,
    DateTime? lastModifiedDate,
    String? currentProgress,
    String? code,
    DateTime? endedDate,
    String? customerName,
    UIPersistShoppingBag? uiPersistShoppingBag,
    Iterable<BrowsingHistories> browsingHistories = const [],
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'shoppingBag', shoppingBag);
    RealmObjectBase.set(this, 'checkInIndicator', checkInIndicator);
    RealmObjectBase.set(this, 'createdDate', createdDate);
    RealmObjectBase.set(this, 'lastModifiedDate', lastModifiedDate);
    RealmObjectBase.set(this, 'currentProgress', currentProgress);
    RealmObjectBase.set(this, 'code', code);
    RealmObjectBase.set(this, 'departmentCode', departmentCode);
    RealmObjectBase.set(this, 'employeeId', employeeId);
    RealmObjectBase.set(this, 'employeeName', employeeName);
    RealmObjectBase.set(this, 'endedDate', endedDate);
    RealmObjectBase.set(this, 'customerName', customerName);
    RealmObjectBase.set(this, 'uiPersistShoppingBag', uiPersistShoppingBag);
    RealmObjectBase.set<RealmList<BrowsingHistories>>(this, 'browsingHistories',
        RealmList<BrowsingHistories>(browsingHistories));
  }

  CustomerSession._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  ShoppingBag? get shoppingBag =>
      RealmObjectBase.get<ShoppingBag>(this, 'shoppingBag') as ShoppingBag?;
  @override
  set shoppingBag(covariant ShoppingBag? value) =>
      RealmObjectBase.set(this, 'shoppingBag', value);

  @override
  bool get checkInIndicator =>
      RealmObjectBase.get<bool>(this, 'checkInIndicator') as bool;
  @override
  set checkInIndicator(bool value) =>
      RealmObjectBase.set(this, 'checkInIndicator', value);

  @override
  DateTime get createdDate =>
      RealmObjectBase.get<DateTime>(this, 'createdDate') as DateTime;
  @override
  set createdDate(DateTime value) =>
      RealmObjectBase.set(this, 'createdDate', value);

  @override
  DateTime? get lastModifiedDate =>
      RealmObjectBase.get<DateTime>(this, 'lastModifiedDate') as DateTime?;
  @override
  set lastModifiedDate(DateTime? value) =>
      RealmObjectBase.set(this, 'lastModifiedDate', value);

  @override
  String? get currentProgress =>
      RealmObjectBase.get<String>(this, 'currentProgress') as String?;
  @override
  set currentProgress(String? value) =>
      RealmObjectBase.set(this, 'currentProgress', value);

  @override
  String? get code => RealmObjectBase.get<String>(this, 'code') as String?;
  @override
  set code(String? value) => RealmObjectBase.set(this, 'code', value);

  @override
  String get departmentCode =>
      RealmObjectBase.get<String>(this, 'departmentCode') as String;
  @override
  set departmentCode(String value) =>
      RealmObjectBase.set(this, 'departmentCode', value);

  @override
  String get employeeId =>
      RealmObjectBase.get<String>(this, 'employeeId') as String;
  @override
  set employeeId(String value) =>
      RealmObjectBase.set(this, 'employeeId', value);

  @override
  String get employeeName =>
      RealmObjectBase.get<String>(this, 'employeeName') as String;
  @override
  set employeeName(String value) =>
      RealmObjectBase.set(this, 'employeeName', value);

  @override
  DateTime? get endedDate =>
      RealmObjectBase.get<DateTime>(this, 'endedDate') as DateTime?;
  @override
  set endedDate(DateTime? value) =>
      RealmObjectBase.set(this, 'endedDate', value);

  @override
  String? get customerName =>
      RealmObjectBase.get<String>(this, 'customerName') as String?;
  @override
  set customerName(String? value) =>
      RealmObjectBase.set(this, 'customerName', value);

  @override
  RealmList<BrowsingHistories> get browsingHistories =>
      RealmObjectBase.get<BrowsingHistories>(this, 'browsingHistories')
          as RealmList<BrowsingHistories>;
  @override
  set browsingHistories(covariant RealmList<BrowsingHistories> value) =>
      throw RealmUnsupportedSetError();

  @override
  UIPersistShoppingBag? get uiPersistShoppingBag =>
      RealmObjectBase.get<UIPersistShoppingBag>(this, 'uiPersistShoppingBag')
          as UIPersistShoppingBag?;
  @override
  set uiPersistShoppingBag(covariant UIPersistShoppingBag? value) =>
      RealmObjectBase.set(this, 'uiPersistShoppingBag', value);

  @override
  Stream<RealmObjectChanges<CustomerSession>> get changes =>
      RealmObjectBase.getChanges<CustomerSession>(this);

  @override
  CustomerSession freeze() =>
      RealmObjectBase.freezeObject<CustomerSession>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(CustomerSession._);
    return const SchemaObject(
        ObjectType.realmObject, CustomerSession, 'customerSession', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('shoppingBag', RealmPropertyType.object,
          optional: true, linkTarget: 'shoppingBag'),
      SchemaProperty('checkInIndicator', RealmPropertyType.bool),
      SchemaProperty('createdDate', RealmPropertyType.timestamp),
      SchemaProperty('lastModifiedDate', RealmPropertyType.timestamp,
          optional: true),
      SchemaProperty('currentProgress', RealmPropertyType.string,
          optional: true),
      SchemaProperty('code', RealmPropertyType.string, optional: true),
      SchemaProperty('departmentCode', RealmPropertyType.string),
      SchemaProperty('employeeId', RealmPropertyType.string),
      SchemaProperty('employeeName', RealmPropertyType.string),
      SchemaProperty('endedDate', RealmPropertyType.timestamp, optional: true),
      SchemaProperty('customerName', RealmPropertyType.string, optional: true),
      SchemaProperty('browsingHistories', RealmPropertyType.object,
          linkTarget: 'BrowsingHistories',
          collectionType: RealmCollectionType.list),
      SchemaProperty('uiPersistShoppingBag', RealmPropertyType.object,
          optional: true, linkTarget: 'UIPersistShoppingBag'),
    ]);
  }
}

class ShoppingBag extends _ShoppingBag
    with RealmEntity, RealmObjectBase, RealmObject {
  ShoppingBag(
    ObjectId id,
    DateTime createdDate, {
    String? ctId,
    String? settlementTransactionId,
    String? currency,
    DateTime? lastModifiedDate,
    String? signatureBase64Data,
    String? customerId,
    String? departmentCode,
    Iterable<ShoppingBagItem> items = const [],
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'createdDate', createdDate);
    RealmObjectBase.set(this, 'ctId', ctId);
    RealmObjectBase.set(
        this, 'settlementTransactionId', settlementTransactionId);
    RealmObjectBase.set(this, 'currency', currency);
    RealmObjectBase.set(this, 'lastModifiedDate', lastModifiedDate);
    RealmObjectBase.set(this, 'signatureBase64Data', signatureBase64Data);
    RealmObjectBase.set(this, 'customerId', customerId);
    RealmObjectBase.set(this, 'departmentCode', departmentCode);
    RealmObjectBase.set<RealmList<ShoppingBagItem>>(
        this, 'items', RealmList<ShoppingBagItem>(items));
  }

  ShoppingBag._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  DateTime get createdDate =>
      RealmObjectBase.get<DateTime>(this, 'createdDate') as DateTime;
  @override
  set createdDate(DateTime value) =>
      RealmObjectBase.set(this, 'createdDate', value);

  @override
  String? get ctId => RealmObjectBase.get<String>(this, 'ctId') as String?;
  @override
  set ctId(String? value) => RealmObjectBase.set(this, 'ctId', value);

  @override
  String? get settlementTransactionId =>
      RealmObjectBase.get<String>(this, 'settlementTransactionId') as String?;
  @override
  set settlementTransactionId(String? value) =>
      RealmObjectBase.set(this, 'settlementTransactionId', value);

  @override
  String? get currency =>
      RealmObjectBase.get<String>(this, 'currency') as String?;
  @override
  set currency(String? value) => RealmObjectBase.set(this, 'currency', value);

  @override
  DateTime? get lastModifiedDate =>
      RealmObjectBase.get<DateTime>(this, 'lastModifiedDate') as DateTime?;
  @override
  set lastModifiedDate(DateTime? value) =>
      RealmObjectBase.set(this, 'lastModifiedDate', value);

  @override
  String? get signatureBase64Data =>
      RealmObjectBase.get<String>(this, 'signatureBase64Data') as String?;
  @override
  set signatureBase64Data(String? value) =>
      RealmObjectBase.set(this, 'signatureBase64Data', value);

  @override
  String? get customerId =>
      RealmObjectBase.get<String>(this, 'customerId') as String?;
  @override
  set customerId(String? value) =>
      RealmObjectBase.set(this, 'customerId', value);

  @override
  String? get departmentCode =>
      RealmObjectBase.get<String>(this, 'departmentCode') as String?;
  @override
  set departmentCode(String? value) =>
      RealmObjectBase.set(this, 'departmentCode', value);

  @override
  RealmList<ShoppingBagItem> get items =>
      RealmObjectBase.get<ShoppingBagItem>(this, 'items')
          as RealmList<ShoppingBagItem>;
  @override
  set items(covariant RealmList<ShoppingBagItem> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<ShoppingBag>> get changes =>
      RealmObjectBase.getChanges<ShoppingBag>(this);

  @override
  ShoppingBag freeze() => RealmObjectBase.freezeObject<ShoppingBag>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(ShoppingBag._);
    return const SchemaObject(
        ObjectType.realmObject, ShoppingBag, 'shoppingBag', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('createdDate', RealmPropertyType.timestamp),
      SchemaProperty('ctId', RealmPropertyType.string, optional: true),
      SchemaProperty('settlementTransactionId', RealmPropertyType.string,
          optional: true),
      SchemaProperty('currency', RealmPropertyType.string, optional: true),
      SchemaProperty('lastModifiedDate', RealmPropertyType.timestamp,
          optional: true),
      SchemaProperty('signatureBase64Data', RealmPropertyType.string,
          optional: true),
      SchemaProperty('customerId', RealmPropertyType.string, optional: true),
      SchemaProperty('departmentCode', RealmPropertyType.string,
          optional: true),
      SchemaProperty('items', RealmPropertyType.object,
          linkTarget: 'ShoppingBagItem',
          collectionType: RealmCollectionType.list),
    ]);
  }
}

class ShoppingBagItem extends _ShoppingBagItem
    with RealmEntity, RealmObjectBase, EmbeddedObject {
  ShoppingBagItem(
    ObjectId id,
    DateTime createdDate, {
    String? selectedDiscountProjectLineId,
    String? discountName,
    int? ctLineNumber,
    double? modelSequenceNumber,
    String? inventoryId,
    double? inventoryAmount,
    int? quantity,
    String? saleType,
    DateTime? lastModifiedDate,
    double? netAmount,
    double? laborCost,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(
        this, 'selectedDiscountProjectLineId', selectedDiscountProjectLineId);
    RealmObjectBase.set(this, 'discountName', discountName);
    RealmObjectBase.set(this, 'ctLineNumber', ctLineNumber);
    RealmObjectBase.set(this, 'modelSequenceNumber', modelSequenceNumber);
    RealmObjectBase.set(this, 'inventoryId', inventoryId);
    RealmObjectBase.set(this, 'inventoryAmount', inventoryAmount);
    RealmObjectBase.set(this, 'createdDate', createdDate);
    RealmObjectBase.set(this, 'quantity', quantity);
    RealmObjectBase.set(this, 'saleType', saleType);
    RealmObjectBase.set(this, 'lastModifiedDate', lastModifiedDate);
    RealmObjectBase.set(this, 'netAmount', netAmount);
    RealmObjectBase.set(this, 'laborCost', laborCost);
  }

  ShoppingBagItem._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, 'id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, 'id', value);

  @override
  String? get selectedDiscountProjectLineId =>
      RealmObjectBase.get<String>(this, 'selectedDiscountProjectLineId')
          as String?;
  @override
  set selectedDiscountProjectLineId(String? value) =>
      RealmObjectBase.set(this, 'selectedDiscountProjectLineId', value);

  @override
  String? get discountName =>
      RealmObjectBase.get<String>(this, 'discountName') as String?;
  @override
  set discountName(String? value) =>
      RealmObjectBase.set(this, 'discountName', value);

  @override
  int? get ctLineNumber =>
      RealmObjectBase.get<int>(this, 'ctLineNumber') as int?;
  @override
  set ctLineNumber(int? value) =>
      RealmObjectBase.set(this, 'ctLineNumber', value);

  @override
  double? get modelSequenceNumber =>
      RealmObjectBase.get<double>(this, 'modelSequenceNumber') as double?;
  @override
  set modelSequenceNumber(double? value) =>
      RealmObjectBase.set(this, 'modelSequenceNumber', value);

  @override
  String? get inventoryId =>
      RealmObjectBase.get<String>(this, 'inventoryId') as String?;
  @override
  set inventoryId(String? value) =>
      RealmObjectBase.set(this, 'inventoryId', value);

  @override
  double? get inventoryAmount =>
      RealmObjectBase.get<double>(this, 'inventoryAmount') as double?;
  @override
  set inventoryAmount(double? value) =>
      RealmObjectBase.set(this, 'inventoryAmount', value);

  @override
  DateTime get createdDate =>
      RealmObjectBase.get<DateTime>(this, 'createdDate') as DateTime;
  @override
  set createdDate(DateTime value) =>
      RealmObjectBase.set(this, 'createdDate', value);

  @override
  int? get quantity => RealmObjectBase.get<int>(this, 'quantity') as int?;
  @override
  set quantity(int? value) => RealmObjectBase.set(this, 'quantity', value);

  @override
  String? get saleType =>
      RealmObjectBase.get<String>(this, 'saleType') as String?;
  @override
  set saleType(String? value) => RealmObjectBase.set(this, 'saleType', value);

  @override
  DateTime? get lastModifiedDate =>
      RealmObjectBase.get<DateTime>(this, 'lastModifiedDate') as DateTime?;
  @override
  set lastModifiedDate(DateTime? value) =>
      RealmObjectBase.set(this, 'lastModifiedDate', value);

  @override
  double? get netAmount =>
      RealmObjectBase.get<double>(this, 'netAmount') as double?;
  @override
  set netAmount(double? value) => RealmObjectBase.set(this, 'netAmount', value);

  @override
  double? get laborCost =>
      RealmObjectBase.get<double>(this, 'laborCost') as double?;
  @override
  set laborCost(double? value) => RealmObjectBase.set(this, 'laborCost', value);

  @override
  Stream<RealmObjectChanges<ShoppingBagItem>> get changes =>
      RealmObjectBase.getChanges<ShoppingBagItem>(this);

  @override
  ShoppingBagItem freeze() =>
      RealmObjectBase.freezeObject<ShoppingBagItem>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(ShoppingBagItem._);
    return const SchemaObject(
        ObjectType.embeddedObject, ShoppingBagItem, 'ShoppingBagItem', [
      SchemaProperty('id', RealmPropertyType.objectid),
      SchemaProperty('selectedDiscountProjectLineId', RealmPropertyType.string,
          optional: true),
      SchemaProperty('discountName', RealmPropertyType.string, optional: true),
      SchemaProperty('ctLineNumber', RealmPropertyType.int, optional: true),
      SchemaProperty('modelSequenceNumber', RealmPropertyType.double,
          optional: true),
      SchemaProperty('inventoryId', RealmPropertyType.string, optional: true),
      SchemaProperty('inventoryAmount', RealmPropertyType.double,
          optional: true),
      SchemaProperty('createdDate', RealmPropertyType.timestamp),
      SchemaProperty('quantity', RealmPropertyType.int, optional: true),
      SchemaProperty('saleType', RealmPropertyType.string, optional: true),
      SchemaProperty('lastModifiedDate', RealmPropertyType.timestamp,
          optional: true),
      SchemaProperty('netAmount', RealmPropertyType.double, optional: true),
      SchemaProperty('laborCost', RealmPropertyType.double, optional: true),
    ]);
  }
}

class BrowsingHistories extends _BrowsingHistories
    with RealmEntity, RealmObjectBase, EmbeddedObject {
  BrowsingHistories(
    DateTime createdDate, {
    double? modelSequenceNumber,
    String? inventoryId,
    String? saleType,
  }) {
    RealmObjectBase.set(this, 'createdDate', createdDate);
    RealmObjectBase.set(this, 'modelSequenceNumber', modelSequenceNumber);
    RealmObjectBase.set(this, 'inventoryId', inventoryId);
    RealmObjectBase.set(this, 'saleType', saleType);
  }

  BrowsingHistories._();

  @override
  DateTime get createdDate =>
      RealmObjectBase.get<DateTime>(this, 'createdDate') as DateTime;
  @override
  set createdDate(DateTime value) =>
      RealmObjectBase.set(this, 'createdDate', value);

  @override
  double? get modelSequenceNumber =>
      RealmObjectBase.get<double>(this, 'modelSequenceNumber') as double?;
  @override
  set modelSequenceNumber(double? value) =>
      RealmObjectBase.set(this, 'modelSequenceNumber', value);

  @override
  String? get inventoryId =>
      RealmObjectBase.get<String>(this, 'inventoryId') as String?;
  @override
  set inventoryId(String? value) =>
      RealmObjectBase.set(this, 'inventoryId', value);

  @override
  String? get saleType =>
      RealmObjectBase.get<String>(this, 'saleType') as String?;
  @override
  set saleType(String? value) => RealmObjectBase.set(this, 'saleType', value);

  @override
  Stream<RealmObjectChanges<BrowsingHistories>> get changes =>
      RealmObjectBase.getChanges<BrowsingHistories>(this);

  @override
  BrowsingHistories freeze() =>
      RealmObjectBase.freezeObject<BrowsingHistories>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(BrowsingHistories._);
    return const SchemaObject(
        ObjectType.embeddedObject, BrowsingHistories, 'BrowsingHistories', [
      SchemaProperty('createdDate', RealmPropertyType.timestamp),
      SchemaProperty('modelSequenceNumber', RealmPropertyType.double,
          optional: true),
      SchemaProperty('inventoryId', RealmPropertyType.string, optional: true),
      SchemaProperty('saleType', RealmPropertyType.string, optional: true),
    ]);
  }
}

class UIPersistShoppingBag extends _UIPersistShoppingBag
    with RealmEntity, RealmObjectBase, EmbeddedObject {
  UIPersistShoppingBag({
    Iterable<CacheProductItem> cacheProductItems = const [],
  }) {
    RealmObjectBase.set<RealmList<CacheProductItem>>(this, 'cacheProductItems',
        RealmList<CacheProductItem>(cacheProductItems));
  }

  UIPersistShoppingBag._();

  @override
  RealmList<CacheProductItem> get cacheProductItems =>
      RealmObjectBase.get<CacheProductItem>(this, 'cacheProductItems')
          as RealmList<CacheProductItem>;
  @override
  set cacheProductItems(covariant RealmList<CacheProductItem> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<UIPersistShoppingBag>> get changes =>
      RealmObjectBase.getChanges<UIPersistShoppingBag>(this);

  @override
  UIPersistShoppingBag freeze() =>
      RealmObjectBase.freezeObject<UIPersistShoppingBag>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(UIPersistShoppingBag._);
    return const SchemaObject(ObjectType.embeddedObject, UIPersistShoppingBag,
        'UIPersistShoppingBag', [
      SchemaProperty('cacheProductItems', RealmPropertyType.object,
          linkTarget: 'CacheProductItem',
          collectionType: RealmCollectionType.list),
    ]);
  }
}

class CacheProductItem extends _CacheProductItem
    with RealmEntity, RealmObjectBase, EmbeddedObject {
  CacheProductItem(
    ObjectId id,
    DateTime createdDate, {
    double? modelSequenceNumber,
    String? inventoryId,
    String? itemNumber,
    double? netAmount,
    double? inventoryAmount,
    ProductDiscount? selectedProductDiscount,
    int? lineNumber,
    String? saleType,
    String? productName,
    String? catalogItemCode,
    CatalogItemTitle? brand,
    CatalogItemTitle? collection,
    CatalogItemTitle? subCollection,
    bool? fixedPriceIndicator,
    double? goldPrice,
    BookingUnit? bookingUnitInfo,
    Iterable<String> imagesPath = const [],
    Iterable<ProductDiscount> discounts = const [],
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'modelSequenceNumber', modelSequenceNumber);
    RealmObjectBase.set(this, 'inventoryId', inventoryId);
    RealmObjectBase.set(this, 'itemNumber', itemNumber);
    RealmObjectBase.set(this, 'createdDate', createdDate);
    RealmObjectBase.set(this, 'netAmount', netAmount);
    RealmObjectBase.set(this, 'inventoryAmount', inventoryAmount);
    RealmObjectBase.set(
        this, 'selectedProductDiscount', selectedProductDiscount);
    RealmObjectBase.set(this, 'lineNumber', lineNumber);
    RealmObjectBase.set(this, 'saleType', saleType);
    RealmObjectBase.set(this, 'productName', productName);
    RealmObjectBase.set(this, 'catalogItemCode', catalogItemCode);
    RealmObjectBase.set(this, 'brand', brand);
    RealmObjectBase.set(this, 'collection', collection);
    RealmObjectBase.set(this, 'subCollection', subCollection);
    RealmObjectBase.set(this, 'fixedPriceIndicator', fixedPriceIndicator);
    RealmObjectBase.set(this, 'goldPrice', goldPrice);
    RealmObjectBase.set(this, 'bookingUnitInfo', bookingUnitInfo);
    RealmObjectBase.set<RealmList<String>>(
        this, 'imagesPath', RealmList<String>(imagesPath));
    RealmObjectBase.set<RealmList<ProductDiscount>>(
        this, 'discounts', RealmList<ProductDiscount>(discounts));
  }

  CacheProductItem._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, 'id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, 'id', value);

  @override
  double? get modelSequenceNumber =>
      RealmObjectBase.get<double>(this, 'modelSequenceNumber') as double?;
  @override
  set modelSequenceNumber(double? value) =>
      RealmObjectBase.set(this, 'modelSequenceNumber', value);

  @override
  String? get inventoryId =>
      RealmObjectBase.get<String>(this, 'inventoryId') as String?;
  @override
  set inventoryId(String? value) =>
      RealmObjectBase.set(this, 'inventoryId', value);

  @override
  String? get itemNumber =>
      RealmObjectBase.get<String>(this, 'itemNumber') as String?;
  @override
  set itemNumber(String? value) =>
      RealmObjectBase.set(this, 'itemNumber', value);

  @override
  DateTime get createdDate =>
      RealmObjectBase.get<DateTime>(this, 'createdDate') as DateTime;
  @override
  set createdDate(DateTime value) =>
      RealmObjectBase.set(this, 'createdDate', value);

  @override
  RealmList<String> get imagesPath =>
      RealmObjectBase.get<String>(this, 'imagesPath') as RealmList<String>;
  @override
  set imagesPath(covariant RealmList<String> value) =>
      throw RealmUnsupportedSetError();

  @override
  double? get netAmount =>
      RealmObjectBase.get<double>(this, 'netAmount') as double?;
  @override
  set netAmount(double? value) => RealmObjectBase.set(this, 'netAmount', value);

  @override
  double? get inventoryAmount =>
      RealmObjectBase.get<double>(this, 'inventoryAmount') as double?;
  @override
  set inventoryAmount(double? value) =>
      RealmObjectBase.set(this, 'inventoryAmount', value);

  @override
  RealmList<ProductDiscount> get discounts =>
      RealmObjectBase.get<ProductDiscount>(this, 'discounts')
          as RealmList<ProductDiscount>;
  @override
  set discounts(covariant RealmList<ProductDiscount> value) =>
      throw RealmUnsupportedSetError();

  @override
  ProductDiscount? get selectedProductDiscount =>
      RealmObjectBase.get<ProductDiscount>(this, 'selectedProductDiscount')
          as ProductDiscount?;
  @override
  set selectedProductDiscount(covariant ProductDiscount? value) =>
      RealmObjectBase.set(this, 'selectedProductDiscount', value);

  @override
  int? get lineNumber => RealmObjectBase.get<int>(this, 'lineNumber') as int?;
  @override
  set lineNumber(int? value) => RealmObjectBase.set(this, 'lineNumber', value);

  @override
  String? get saleType =>
      RealmObjectBase.get<String>(this, 'saleType') as String?;
  @override
  set saleType(String? value) => RealmObjectBase.set(this, 'saleType', value);

  @override
  String? get productName =>
      RealmObjectBase.get<String>(this, 'productName') as String?;
  @override
  set productName(String? value) =>
      RealmObjectBase.set(this, 'productName', value);

  @override
  String? get catalogItemCode =>
      RealmObjectBase.get<String>(this, 'catalogItemCode') as String?;
  @override
  set catalogItemCode(String? value) =>
      RealmObjectBase.set(this, 'catalogItemCode', value);

  @override
  CatalogItemTitle? get brand =>
      RealmObjectBase.get<CatalogItemTitle>(this, 'brand') as CatalogItemTitle?;
  @override
  set brand(covariant CatalogItemTitle? value) =>
      RealmObjectBase.set(this, 'brand', value);

  @override
  CatalogItemTitle? get collection =>
      RealmObjectBase.get<CatalogItemTitle>(this, 'collection')
          as CatalogItemTitle?;
  @override
  set collection(covariant CatalogItemTitle? value) =>
      RealmObjectBase.set(this, 'collection', value);

  @override
  CatalogItemTitle? get subCollection =>
      RealmObjectBase.get<CatalogItemTitle>(this, 'subCollection')
          as CatalogItemTitle?;
  @override
  set subCollection(covariant CatalogItemTitle? value) =>
      RealmObjectBase.set(this, 'subCollection', value);

  @override
  bool? get fixedPriceIndicator =>
      RealmObjectBase.get<bool>(this, 'fixedPriceIndicator') as bool?;
  @override
  set fixedPriceIndicator(bool? value) =>
      RealmObjectBase.set(this, 'fixedPriceIndicator', value);

  @override
  double? get goldPrice =>
      RealmObjectBase.get<double>(this, 'goldPrice') as double?;
  @override
  set goldPrice(double? value) => RealmObjectBase.set(this, 'goldPrice', value);

  @override
  BookingUnit? get bookingUnitInfo =>
      RealmObjectBase.get<BookingUnit>(this, 'bookingUnitInfo') as BookingUnit?;
  @override
  set bookingUnitInfo(covariant BookingUnit? value) =>
      RealmObjectBase.set(this, 'bookingUnitInfo', value);

  @override
  Stream<RealmObjectChanges<CacheProductItem>> get changes =>
      RealmObjectBase.getChanges<CacheProductItem>(this);

  @override
  CacheProductItem freeze() =>
      RealmObjectBase.freezeObject<CacheProductItem>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(CacheProductItem._);
    return const SchemaObject(
        ObjectType.embeddedObject, CacheProductItem, 'CacheProductItem', [
      SchemaProperty('id', RealmPropertyType.objectid),
      SchemaProperty('modelSequenceNumber', RealmPropertyType.double,
          optional: true),
      SchemaProperty('inventoryId', RealmPropertyType.string, optional: true),
      SchemaProperty('itemNumber', RealmPropertyType.string, optional: true),
      SchemaProperty('createdDate', RealmPropertyType.timestamp),
      SchemaProperty('imagesPath', RealmPropertyType.string,
          collectionType: RealmCollectionType.list),
      SchemaProperty('netAmount', RealmPropertyType.double, optional: true),
      SchemaProperty('inventoryAmount', RealmPropertyType.double,
          optional: true),
      SchemaProperty('discounts', RealmPropertyType.object,
          linkTarget: 'ProductDiscount',
          collectionType: RealmCollectionType.list),
      SchemaProperty('selectedProductDiscount', RealmPropertyType.object,
          optional: true, linkTarget: 'ProductDiscount'),
      SchemaProperty('lineNumber', RealmPropertyType.int, optional: true),
      SchemaProperty('saleType', RealmPropertyType.string, optional: true),
      SchemaProperty('productName', RealmPropertyType.string, optional: true),
      SchemaProperty('catalogItemCode', RealmPropertyType.string,
          optional: true),
      SchemaProperty('brand', RealmPropertyType.object,
          optional: true, linkTarget: 'CatalogItemTitle'),
      SchemaProperty('collection', RealmPropertyType.object,
          optional: true, linkTarget: 'CatalogItemTitle'),
      SchemaProperty('subCollection', RealmPropertyType.object,
          optional: true, linkTarget: 'CatalogItemTitle'),
      SchemaProperty('fixedPriceIndicator', RealmPropertyType.bool,
          optional: true),
      SchemaProperty('goldPrice', RealmPropertyType.double, optional: true),
      SchemaProperty('bookingUnitInfo', RealmPropertyType.object,
          optional: true, linkTarget: 'BookingUnit'),
    ]);
  }
}

class ProductDiscount extends _ProductDiscount
    with RealmEntity, RealmObjectBase, EmbeddedObject {
  ProductDiscount(
    String projectLineId,
    String discountName,
    double agreePrice,
  ) {
    RealmObjectBase.set(this, 'projectLineId', projectLineId);
    RealmObjectBase.set(this, 'discountName', discountName);
    RealmObjectBase.set(this, 'agreePrice', agreePrice);
  }

  ProductDiscount._();

  @override
  String get projectLineId =>
      RealmObjectBase.get<String>(this, 'projectLineId') as String;
  @override
  set projectLineId(String value) =>
      RealmObjectBase.set(this, 'projectLineId', value);

  @override
  String get discountName =>
      RealmObjectBase.get<String>(this, 'discountName') as String;
  @override
  set discountName(String value) =>
      RealmObjectBase.set(this, 'discountName', value);

  @override
  double get agreePrice =>
      RealmObjectBase.get<double>(this, 'agreePrice') as double;
  @override
  set agreePrice(double value) =>
      RealmObjectBase.set(this, 'agreePrice', value);

  @override
  Stream<RealmObjectChanges<ProductDiscount>> get changes =>
      RealmObjectBase.getChanges<ProductDiscount>(this);

  @override
  ProductDiscount freeze() =>
      RealmObjectBase.freezeObject<ProductDiscount>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(ProductDiscount._);
    return const SchemaObject(
        ObjectType.embeddedObject, ProductDiscount, 'ProductDiscount', [
      SchemaProperty('projectLineId', RealmPropertyType.string),
      SchemaProperty('discountName', RealmPropertyType.string),
      SchemaProperty('agreePrice', RealmPropertyType.double),
    ]);
  }
}

class CatalogItemTitle extends _CatalogItemTitle
    with RealmEntity, RealmObjectBase, EmbeddedObject {
  CatalogItemTitle({
    String? code,
    String? name,
  }) {
    RealmObjectBase.set(this, 'code', code);
    RealmObjectBase.set(this, 'name', name);
  }

  CatalogItemTitle._();

  @override
  String? get code => RealmObjectBase.get<String>(this, 'code') as String?;
  @override
  set code(String? value) => RealmObjectBase.set(this, 'code', value);

  @override
  String? get name => RealmObjectBase.get<String>(this, 'name') as String?;
  @override
  set name(String? value) => RealmObjectBase.set(this, 'name', value);

  @override
  Stream<RealmObjectChanges<CatalogItemTitle>> get changes =>
      RealmObjectBase.getChanges<CatalogItemTitle>(this);

  @override
  CatalogItemTitle freeze() =>
      RealmObjectBase.freezeObject<CatalogItemTitle>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(CatalogItemTitle._);
    return const SchemaObject(
        ObjectType.embeddedObject, CatalogItemTitle, 'CatalogItemTitle', [
      SchemaProperty('code', RealmPropertyType.string, optional: true),
      SchemaProperty('name', RealmPropertyType.string, optional: true),
    ]);
  }
}

class BookingUnit extends _BookingUnit
    with RealmEntity, RealmObjectBase, EmbeddedObject {
  BookingUnit({
    BookingUnitsCbu? cbu,
    int? earmarkQuantity,
    double? modelSequenceNumber,
    String? departmentCode,
    String? shape,
    String? diamondBrand,
    String? materialCategory,
    int? qty,
    int? price,
    String? goldType,
    double? caratWeight,
    String? color,
    double? grossWeightGram,
    double? physicalWeightGram,
    double? laborCost,
    String? size,
    String? inventoryState,
    String? clarity,
    String? cutGrade,
    String? polish,
    String? fluorescent,
    String? symmetry,
    String? bomCertificateOrganization,
    String? usageReferenceCode,
    String? sizeAndLength,
  }) {
    RealmObjectBase.set(this, 'cbu', cbu);
    RealmObjectBase.set(this, 'earmarkQuantity', earmarkQuantity);
    RealmObjectBase.set(this, 'modelSequenceNumber', modelSequenceNumber);
    RealmObjectBase.set(this, 'departmentCode', departmentCode);
    RealmObjectBase.set(this, 'shape', shape);
    RealmObjectBase.set(this, 'diamondBrand', diamondBrand);
    RealmObjectBase.set(this, 'materialCategory', materialCategory);
    RealmObjectBase.set(this, 'qty', qty);
    RealmObjectBase.set(this, 'price', price);
    RealmObjectBase.set(this, 'goldType', goldType);
    RealmObjectBase.set(this, 'caratWeight', caratWeight);
    RealmObjectBase.set(this, 'color', color);
    RealmObjectBase.set(this, 'grossWeightGram', grossWeightGram);
    RealmObjectBase.set(this, 'physicalWeightGram', physicalWeightGram);
    RealmObjectBase.set(this, 'laborCost', laborCost);
    RealmObjectBase.set(this, 'size', size);
    RealmObjectBase.set(this, 'inventoryState', inventoryState);
    RealmObjectBase.set(this, 'clarity', clarity);
    RealmObjectBase.set(this, 'cutGrade', cutGrade);
    RealmObjectBase.set(this, 'polish', polish);
    RealmObjectBase.set(this, 'fluorescent', fluorescent);
    RealmObjectBase.set(this, 'symmetry', symmetry);
    RealmObjectBase.set(
        this, 'bomCertificateOrganization', bomCertificateOrganization);
    RealmObjectBase.set(this, 'usageReferenceCode', usageReferenceCode);
    RealmObjectBase.set(this, 'sizeAndLength', sizeAndLength);
  }

  BookingUnit._();

  @override
  BookingUnitsCbu? get cbu =>
      RealmObjectBase.get<BookingUnitsCbu>(this, 'cbu') as BookingUnitsCbu?;
  @override
  set cbu(covariant BookingUnitsCbu? value) =>
      RealmObjectBase.set(this, 'cbu', value);

  @override
  int? get earmarkQuantity =>
      RealmObjectBase.get<int>(this, 'earmarkQuantity') as int?;
  @override
  set earmarkQuantity(int? value) =>
      RealmObjectBase.set(this, 'earmarkQuantity', value);

  @override
  double? get modelSequenceNumber =>
      RealmObjectBase.get<double>(this, 'modelSequenceNumber') as double?;
  @override
  set modelSequenceNumber(double? value) =>
      RealmObjectBase.set(this, 'modelSequenceNumber', value);

  @override
  String? get departmentCode =>
      RealmObjectBase.get<String>(this, 'departmentCode') as String?;
  @override
  set departmentCode(String? value) =>
      RealmObjectBase.set(this, 'departmentCode', value);

  @override
  String? get shape => RealmObjectBase.get<String>(this, 'shape') as String?;
  @override
  set shape(String? value) => RealmObjectBase.set(this, 'shape', value);

  @override
  String? get diamondBrand =>
      RealmObjectBase.get<String>(this, 'diamondBrand') as String?;
  @override
  set diamondBrand(String? value) =>
      RealmObjectBase.set(this, 'diamondBrand', value);

  @override
  String? get materialCategory =>
      RealmObjectBase.get<String>(this, 'materialCategory') as String?;
  @override
  set materialCategory(String? value) =>
      RealmObjectBase.set(this, 'materialCategory', value);

  @override
  int? get qty => RealmObjectBase.get<int>(this, 'qty') as int?;
  @override
  set qty(int? value) => RealmObjectBase.set(this, 'qty', value);

  @override
  int? get price => RealmObjectBase.get<int>(this, 'price') as int?;
  @override
  set price(int? value) => RealmObjectBase.set(this, 'price', value);

  @override
  String? get goldType =>
      RealmObjectBase.get<String>(this, 'goldType') as String?;
  @override
  set goldType(String? value) => RealmObjectBase.set(this, 'goldType', value);

  @override
  double? get caratWeight =>
      RealmObjectBase.get<double>(this, 'caratWeight') as double?;
  @override
  set caratWeight(double? value) =>
      RealmObjectBase.set(this, 'caratWeight', value);

  @override
  String? get color => RealmObjectBase.get<String>(this, 'color') as String?;
  @override
  set color(String? value) => RealmObjectBase.set(this, 'color', value);

  @override
  double? get grossWeightGram =>
      RealmObjectBase.get<double>(this, 'grossWeightGram') as double?;
  @override
  set grossWeightGram(double? value) =>
      RealmObjectBase.set(this, 'grossWeightGram', value);

  @override
  double? get physicalWeightGram =>
      RealmObjectBase.get<double>(this, 'physicalWeightGram') as double?;
  @override
  set physicalWeightGram(double? value) =>
      RealmObjectBase.set(this, 'physicalWeightGram', value);

  @override
  double? get laborCost =>
      RealmObjectBase.get<double>(this, 'laborCost') as double?;
  @override
  set laborCost(double? value) => RealmObjectBase.set(this, 'laborCost', value);

  @override
  String? get size => RealmObjectBase.get<String>(this, 'size') as String?;
  @override
  set size(String? value) => RealmObjectBase.set(this, 'size', value);

  @override
  String? get inventoryState =>
      RealmObjectBase.get<String>(this, 'inventoryState') as String?;
  @override
  set inventoryState(String? value) =>
      RealmObjectBase.set(this, 'inventoryState', value);

  @override
  String? get clarity =>
      RealmObjectBase.get<String>(this, 'clarity') as String?;
  @override
  set clarity(String? value) => RealmObjectBase.set(this, 'clarity', value);

  @override
  String? get cutGrade =>
      RealmObjectBase.get<String>(this, 'cutGrade') as String?;
  @override
  set cutGrade(String? value) => RealmObjectBase.set(this, 'cutGrade', value);

  @override
  String? get polish => RealmObjectBase.get<String>(this, 'polish') as String?;
  @override
  set polish(String? value) => RealmObjectBase.set(this, 'polish', value);

  @override
  String? get fluorescent =>
      RealmObjectBase.get<String>(this, 'fluorescent') as String?;
  @override
  set fluorescent(String? value) =>
      RealmObjectBase.set(this, 'fluorescent', value);

  @override
  String? get symmetry =>
      RealmObjectBase.get<String>(this, 'symmetry') as String?;
  @override
  set symmetry(String? value) => RealmObjectBase.set(this, 'symmetry', value);

  @override
  String? get bomCertificateOrganization =>
      RealmObjectBase.get<String>(this, 'bomCertificateOrganization')
          as String?;
  @override
  set bomCertificateOrganization(String? value) =>
      RealmObjectBase.set(this, 'bomCertificateOrganization', value);

  @override
  String? get usageReferenceCode =>
      RealmObjectBase.get<String>(this, 'usageReferenceCode') as String?;
  @override
  set usageReferenceCode(String? value) =>
      RealmObjectBase.set(this, 'usageReferenceCode', value);

  @override
  String? get sizeAndLength =>
      RealmObjectBase.get<String>(this, 'sizeAndLength') as String?;
  @override
  set sizeAndLength(String? value) =>
      RealmObjectBase.set(this, 'sizeAndLength', value);

  @override
  Stream<RealmObjectChanges<BookingUnit>> get changes =>
      RealmObjectBase.getChanges<BookingUnit>(this);

  @override
  BookingUnit freeze() => RealmObjectBase.freezeObject<BookingUnit>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(BookingUnit._);
    return const SchemaObject(
        ObjectType.embeddedObject, BookingUnit, 'BookingUnit', [
      SchemaProperty('cbu', RealmPropertyType.object,
          optional: true, linkTarget: 'BookingUnitsCbu'),
      SchemaProperty('earmarkQuantity', RealmPropertyType.int, optional: true),
      SchemaProperty('modelSequenceNumber', RealmPropertyType.double,
          optional: true),
      SchemaProperty('departmentCode', RealmPropertyType.string,
          optional: true),
      SchemaProperty('shape', RealmPropertyType.string, optional: true),
      SchemaProperty('diamondBrand', RealmPropertyType.string, optional: true),
      SchemaProperty('materialCategory', RealmPropertyType.string,
          optional: true),
      SchemaProperty('qty', RealmPropertyType.int, optional: true),
      SchemaProperty('price', RealmPropertyType.int, optional: true),
      SchemaProperty('goldType', RealmPropertyType.string, optional: true),
      SchemaProperty('caratWeight', RealmPropertyType.double, optional: true),
      SchemaProperty('color', RealmPropertyType.string, optional: true),
      SchemaProperty('grossWeightGram', RealmPropertyType.double,
          optional: true),
      SchemaProperty('physicalWeightGram', RealmPropertyType.double,
          optional: true),
      SchemaProperty('laborCost', RealmPropertyType.double, optional: true),
      SchemaProperty('size', RealmPropertyType.string, optional: true),
      SchemaProperty('inventoryState', RealmPropertyType.string,
          optional: true),
      SchemaProperty('clarity', RealmPropertyType.string, optional: true),
      SchemaProperty('cutGrade', RealmPropertyType.string, optional: true),
      SchemaProperty('polish', RealmPropertyType.string, optional: true),
      SchemaProperty('fluorescent', RealmPropertyType.string, optional: true),
      SchemaProperty('symmetry', RealmPropertyType.string, optional: true),
      SchemaProperty('bomCertificateOrganization', RealmPropertyType.string,
          optional: true),
      SchemaProperty('usageReferenceCode', RealmPropertyType.string,
          optional: true),
      SchemaProperty('sizeAndLength', RealmPropertyType.string, optional: true),
    ]);
  }
}

class BookingUnitsCbu extends _BookingUnitsCbu
    with RealmEntity, RealmObjectBase, EmbeddedObject {
  BookingUnitsCbu({
    String? inventoryId,
    double? modelSequenceNumber,
  }) {
    RealmObjectBase.set(this, 'inventoryId', inventoryId);
    RealmObjectBase.set(this, 'modelSequenceNumber', modelSequenceNumber);
  }

  BookingUnitsCbu._();

  @override
  String? get inventoryId =>
      RealmObjectBase.get<String>(this, 'inventoryId') as String?;
  @override
  set inventoryId(String? value) =>
      RealmObjectBase.set(this, 'inventoryId', value);

  @override
  double? get modelSequenceNumber =>
      RealmObjectBase.get<double>(this, 'modelSequenceNumber') as double?;
  @override
  set modelSequenceNumber(double? value) =>
      RealmObjectBase.set(this, 'modelSequenceNumber', value);

  @override
  Stream<RealmObjectChanges<BookingUnitsCbu>> get changes =>
      RealmObjectBase.getChanges<BookingUnitsCbu>(this);

  @override
  BookingUnitsCbu freeze() =>
      RealmObjectBase.freezeObject<BookingUnitsCbu>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(BookingUnitsCbu._);
    return const SchemaObject(
        ObjectType.embeddedObject, BookingUnitsCbu, 'BookingUnitsCbu', [
      SchemaProperty('inventoryId', RealmPropertyType.string, optional: true),
      SchemaProperty('modelSequenceNumber', RealmPropertyType.double,
          optional: true),
    ]);
  }
}
