// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../inventory.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Inventory extends _Inventory
    with RealmEntity, RealmObjectBase, RealmObject {
  Inventory(
    ObjectId id,
    String inventoryId,
    String currency,
    String custodianDepartmentCode,
    double laborCost,
    double modelSequenceNumber,
    double price, {
    Weight? grossWeight,
    String? itemNumber,
    Weight? physicalWeight,
    double? quantity,
    String? usage,
    String? catalogItem,
    String? generalLedgerInventoryClass,
    String? inventoryStatus,
    String? pendingIndicator,
    Iterable<Bom> bom = const [],
    Iterable<InventoryCertificates> inventoryCertificates = const [],
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'inventoryId', inventoryId);
    RealmObjectBase.set(this, 'currency', currency);
    RealmObjectBase.set(
        this, 'custodianDepartmentCode', custodianDepartmentCode);
    RealmObjectBase.set(this, 'grossWeight', grossWeight);
    RealmObjectBase.set(this, 'itemNumber', itemNumber);
    RealmObjectBase.set(this, 'laborCost', laborCost);
    RealmObjectBase.set(this, 'modelSequenceNumber', modelSequenceNumber);
    RealmObjectBase.set(this, 'physicalWeight', physicalWeight);
    RealmObjectBase.set(this, 'price', price);
    RealmObjectBase.set(this, 'quantity', quantity);
    RealmObjectBase.set(this, 'usage', usage);
    RealmObjectBase.set(this, 'catalogItem', catalogItem);
    RealmObjectBase.set(
        this, 'generalLedgerInventoryClass', generalLedgerInventoryClass);
    RealmObjectBase.set(this, 'inventoryStatus', inventoryStatus);
    RealmObjectBase.set(this, 'pendingIndicator', pendingIndicator);
    RealmObjectBase.set<RealmList<Bom>>(this, 'bom', RealmList<Bom>(bom));
    RealmObjectBase.set<RealmList<InventoryCertificates>>(
        this,
        'inventoryCertificates',
        RealmList<InventoryCertificates>(inventoryCertificates));
  }

  Inventory._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  String get inventoryId =>
      RealmObjectBase.get<String>(this, 'inventoryId') as String;
  @override
  set inventoryId(String value) =>
      RealmObjectBase.set(this, 'inventoryId', value);

  @override
  RealmList<Bom> get bom =>
      RealmObjectBase.get<Bom>(this, 'bom') as RealmList<Bom>;
  @override
  set bom(covariant RealmList<Bom> value) => throw RealmUnsupportedSetError();

  @override
  String get currency =>
      RealmObjectBase.get<String>(this, 'currency') as String;
  @override
  set currency(String value) => RealmObjectBase.set(this, 'currency', value);

  @override
  String get custodianDepartmentCode =>
      RealmObjectBase.get<String>(this, 'custodianDepartmentCode') as String;
  @override
  set custodianDepartmentCode(String value) =>
      RealmObjectBase.set(this, 'custodianDepartmentCode', value);

  @override
  Weight? get grossWeight =>
      RealmObjectBase.get<Weight>(this, 'grossWeight') as Weight?;
  @override
  set grossWeight(covariant Weight? value) =>
      RealmObjectBase.set(this, 'grossWeight', value);

  @override
  String? get itemNumber =>
      RealmObjectBase.get<String>(this, 'itemNumber') as String?;
  @override
  set itemNumber(String? value) =>
      RealmObjectBase.set(this, 'itemNumber', value);

  @override
  double get laborCost =>
      RealmObjectBase.get<double>(this, 'laborCost') as double;
  @override
  set laborCost(double value) => RealmObjectBase.set(this, 'laborCost', value);

  @override
  double get modelSequenceNumber =>
      RealmObjectBase.get<double>(this, 'modelSequenceNumber') as double;
  @override
  set modelSequenceNumber(double value) =>
      RealmObjectBase.set(this, 'modelSequenceNumber', value);

  @override
  Weight? get physicalWeight =>
      RealmObjectBase.get<Weight>(this, 'physicalWeight') as Weight?;
  @override
  set physicalWeight(covariant Weight? value) =>
      RealmObjectBase.set(this, 'physicalWeight', value);

  @override
  double get price => RealmObjectBase.get<double>(this, 'price') as double;
  @override
  set price(double value) => RealmObjectBase.set(this, 'price', value);

  @override
  double? get quantity =>
      RealmObjectBase.get<double>(this, 'quantity') as double?;
  @override
  set quantity(double? value) => RealmObjectBase.set(this, 'quantity', value);

  @override
  String? get usage => RealmObjectBase.get<String>(this, 'usage') as String?;
  @override
  set usage(String? value) => RealmObjectBase.set(this, 'usage', value);

  @override
  String? get catalogItem =>
      RealmObjectBase.get<String>(this, 'catalogItem') as String?;
  @override
  set catalogItem(String? value) =>
      RealmObjectBase.set(this, 'catalogItem', value);

  @override
  String? get generalLedgerInventoryClass =>
      RealmObjectBase.get<String>(this, 'generalLedgerInventoryClass')
          as String?;
  @override
  set generalLedgerInventoryClass(String? value) =>
      RealmObjectBase.set(this, 'generalLedgerInventoryClass', value);

  @override
  String? get inventoryStatus =>
      RealmObjectBase.get<String>(this, 'inventoryStatus') as String?;
  @override
  set inventoryStatus(String? value) =>
      RealmObjectBase.set(this, 'inventoryStatus', value);

  @override
  String? get pendingIndicator =>
      RealmObjectBase.get<String>(this, 'pendingIndicator') as String?;
  @override
  set pendingIndicator(String? value) =>
      RealmObjectBase.set(this, 'pendingIndicator', value);

  @override
  RealmList<InventoryCertificates> get inventoryCertificates =>
      RealmObjectBase.get<InventoryCertificates>(this, 'inventoryCertificates')
          as RealmList<InventoryCertificates>;
  @override
  set inventoryCertificates(covariant RealmList<InventoryCertificates> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<Inventory>> get changes =>
      RealmObjectBase.getChanges<Inventory>(this);

  @override
  Inventory freeze() => RealmObjectBase.freezeObject<Inventory>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Inventory._);
    return const SchemaObject(ObjectType.realmObject, Inventory, 'inventory', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('inventoryId', RealmPropertyType.string),
      SchemaProperty('bom', RealmPropertyType.object,
          linkTarget: 'Bom', collectionType: RealmCollectionType.list),
      SchemaProperty('currency', RealmPropertyType.string),
      SchemaProperty('custodianDepartmentCode', RealmPropertyType.string),
      SchemaProperty('grossWeight', RealmPropertyType.object,
          optional: true, linkTarget: 'Weight'),
      SchemaProperty('itemNumber', RealmPropertyType.string, optional: true),
      SchemaProperty('laborCost', RealmPropertyType.double),
      SchemaProperty('modelSequenceNumber', RealmPropertyType.double),
      SchemaProperty('physicalWeight', RealmPropertyType.object,
          optional: true, linkTarget: 'Weight'),
      SchemaProperty('price', RealmPropertyType.double),
      SchemaProperty('quantity', RealmPropertyType.double, optional: true),
      SchemaProperty('usage', RealmPropertyType.string, optional: true),
      SchemaProperty('catalogItem', RealmPropertyType.string, optional: true),
      SchemaProperty('generalLedgerInventoryClass', RealmPropertyType.string,
          optional: true),
      SchemaProperty('inventoryStatus', RealmPropertyType.string,
          optional: true),
      SchemaProperty('pendingIndicator', RealmPropertyType.string,
          optional: true),
      SchemaProperty('inventoryCertificates', RealmPropertyType.object,
          linkTarget: 'InventoryCertificates',
          collectionType: RealmCollectionType.list),
    ]);
  }
}

class InventoryReference extends _InventoryReference
    with RealmEntity, RealmObjectBase, EmbeddedObject {
  InventoryReference({
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

  InventoryReference._();

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
  Stream<RealmObjectChanges<InventoryReference>> get changes =>
      RealmObjectBase.getChanges<InventoryReference>(this);

  @override
  InventoryReference freeze() =>
      RealmObjectBase.freezeObject<InventoryReference>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(InventoryReference._);
    return const SchemaObject(
        ObjectType.embeddedObject, InventoryReference, 'InventoryReference', [
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

class InventoryCertificates extends _InventoryCertificates
    with RealmEntity, RealmObjectBase, EmbeddedObject {
  InventoryCertificates({
    String? entryUser,
    String? verifyCode,
    String? certificateOrganization,
    String? clarity,
    String? color,
    String? certificateNumber,
    DateTime? entryDate,
    String? inventoryId,
    String? from,
    double? certificateSeq,
  }) {
    RealmObjectBase.set(this, 'entryUser', entryUser);
    RealmObjectBase.set(this, 'verifyCode', verifyCode);
    RealmObjectBase.set(
        this, 'certificateOrganization', certificateOrganization);
    RealmObjectBase.set(this, 'clarity', clarity);
    RealmObjectBase.set(this, 'color', color);
    RealmObjectBase.set(this, 'certificateNumber', certificateNumber);
    RealmObjectBase.set(this, 'entryDate', entryDate);
    RealmObjectBase.set(this, 'inventoryId', inventoryId);
    RealmObjectBase.set(this, 'from', from);
    RealmObjectBase.set(this, 'certificateSeq', certificateSeq);
  }

  InventoryCertificates._();

  @override
  String? get entryUser =>
      RealmObjectBase.get<String>(this, 'entryUser') as String?;
  @override
  set entryUser(String? value) => RealmObjectBase.set(this, 'entryUser', value);

  @override
  String? get verifyCode =>
      RealmObjectBase.get<String>(this, 'verifyCode') as String?;
  @override
  set verifyCode(String? value) =>
      RealmObjectBase.set(this, 'verifyCode', value);

  @override
  String? get certificateOrganization =>
      RealmObjectBase.get<String>(this, 'certificateOrganization') as String?;
  @override
  set certificateOrganization(String? value) =>
      RealmObjectBase.set(this, 'certificateOrganization', value);

  @override
  String? get clarity =>
      RealmObjectBase.get<String>(this, 'clarity') as String?;
  @override
  set clarity(String? value) => RealmObjectBase.set(this, 'clarity', value);

  @override
  String? get color => RealmObjectBase.get<String>(this, 'color') as String?;
  @override
  set color(String? value) => RealmObjectBase.set(this, 'color', value);

  @override
  String? get certificateNumber =>
      RealmObjectBase.get<String>(this, 'certificateNumber') as String?;
  @override
  set certificateNumber(String? value) =>
      RealmObjectBase.set(this, 'certificateNumber', value);

  @override
  DateTime? get entryDate =>
      RealmObjectBase.get<DateTime>(this, 'entryDate') as DateTime?;
  @override
  set entryDate(DateTime? value) =>
      RealmObjectBase.set(this, 'entryDate', value);

  @override
  String? get inventoryId =>
      RealmObjectBase.get<String>(this, 'inventoryId') as String?;
  @override
  set inventoryId(String? value) =>
      RealmObjectBase.set(this, 'inventoryId', value);

  @override
  String? get from => RealmObjectBase.get<String>(this, 'from') as String?;
  @override
  set from(String? value) => RealmObjectBase.set(this, 'from', value);

  @override
  double? get certificateSeq =>
      RealmObjectBase.get<double>(this, 'certificateSeq') as double?;
  @override
  set certificateSeq(double? value) =>
      RealmObjectBase.set(this, 'certificateSeq', value);

  @override
  Stream<RealmObjectChanges<InventoryCertificates>> get changes =>
      RealmObjectBase.getChanges<InventoryCertificates>(this);

  @override
  InventoryCertificates freeze() =>
      RealmObjectBase.freezeObject<InventoryCertificates>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(InventoryCertificates._);
    return const SchemaObject(ObjectType.embeddedObject, InventoryCertificates,
        'InventoryCertificates', [
      SchemaProperty('entryUser', RealmPropertyType.string, optional: true),
      SchemaProperty('verifyCode', RealmPropertyType.string, optional: true),
      SchemaProperty('certificateOrganization', RealmPropertyType.string,
          optional: true),
      SchemaProperty('clarity', RealmPropertyType.string, optional: true),
      SchemaProperty('color', RealmPropertyType.string, optional: true),
      SchemaProperty('certificateNumber', RealmPropertyType.string,
          optional: true),
      SchemaProperty('entryDate', RealmPropertyType.timestamp, optional: true),
      SchemaProperty('inventoryId', RealmPropertyType.string, optional: true),
      SchemaProperty('from', RealmPropertyType.string, optional: true),
      SchemaProperty('certificateSeq', RealmPropertyType.double,
          optional: true),
    ]);
  }
}

class Bom extends _Bom with RealmEntity, RealmObjectBase, EmbeddedObject {
  Bom(
    double cost,
    double caratWeight,
    bool mainMaterialIndicator,
    double muBaseAmount,
    double qty,
    String inventoryId,
    ObjectId id,
    double seq, {
    String? materialClass,
    String? materialCategory,
    InventoryReference? diamondColor,
    InventoryReference? diamondShape,
    InventoryReference? diamondCutGrade,
    String? vvCode,
    String? from,
    InventoryReference? diamondClarity,
    InventoryReference? diamondPolish,
    InventoryReference? diamondFluorescent,
    InventoryReference? diamondSymmetry,
    Iterable<BomCertificate> bomCertificates = const [],
  }) {
    RealmObjectBase.set(this, 'materialClass', materialClass);
    RealmObjectBase.set(this, 'cost', cost);
    RealmObjectBase.set(this, 'caratWeight', caratWeight);
    RealmObjectBase.set(this, 'mainMaterialIndicator', mainMaterialIndicator);
    RealmObjectBase.set(this, 'materialCategory', materialCategory);
    RealmObjectBase.set(this, 'diamondColor', diamondColor);
    RealmObjectBase.set(this, 'diamondShape', diamondShape);
    RealmObjectBase.set(this, 'diamondCutGrade', diamondCutGrade);
    RealmObjectBase.set(this, 'muBaseAmount', muBaseAmount);
    RealmObjectBase.set(this, 'qty', qty);
    RealmObjectBase.set(this, 'vvCode', vvCode);
    RealmObjectBase.set(this, 'inventoryId', inventoryId);
    RealmObjectBase.set(this, 'from', from);
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'seq', seq);
    RealmObjectBase.set(this, 'diamondClarity', diamondClarity);
    RealmObjectBase.set(this, 'diamondPolish', diamondPolish);
    RealmObjectBase.set(this, 'diamondFluorescent', diamondFluorescent);
    RealmObjectBase.set(this, 'diamondSymmetry', diamondSymmetry);
    RealmObjectBase.set<RealmList<BomCertificate>>(
        this, 'bomCertificates', RealmList<BomCertificate>(bomCertificates));
  }

  Bom._();

  @override
  String? get materialClass =>
      RealmObjectBase.get<String>(this, 'materialClass') as String?;
  @override
  set materialClass(String? value) =>
      RealmObjectBase.set(this, 'materialClass', value);

  @override
  double get cost => RealmObjectBase.get<double>(this, 'cost') as double;
  @override
  set cost(double value) => RealmObjectBase.set(this, 'cost', value);

  @override
  double get caratWeight =>
      RealmObjectBase.get<double>(this, 'caratWeight') as double;
  @override
  set caratWeight(double value) =>
      RealmObjectBase.set(this, 'caratWeight', value);

  @override
  bool get mainMaterialIndicator =>
      RealmObjectBase.get<bool>(this, 'mainMaterialIndicator') as bool;
  @override
  set mainMaterialIndicator(bool value) =>
      RealmObjectBase.set(this, 'mainMaterialIndicator', value);

  @override
  String? get materialCategory =>
      RealmObjectBase.get<String>(this, 'materialCategory') as String?;
  @override
  set materialCategory(String? value) =>
      RealmObjectBase.set(this, 'materialCategory', value);

  @override
  InventoryReference? get diamondColor =>
      RealmObjectBase.get<InventoryReference>(this, 'diamondColor')
          as InventoryReference?;
  @override
  set diamondColor(covariant InventoryReference? value) =>
      RealmObjectBase.set(this, 'diamondColor', value);

  @override
  InventoryReference? get diamondShape =>
      RealmObjectBase.get<InventoryReference>(this, 'diamondShape')
          as InventoryReference?;
  @override
  set diamondShape(covariant InventoryReference? value) =>
      RealmObjectBase.set(this, 'diamondShape', value);

  @override
  InventoryReference? get diamondCutGrade =>
      RealmObjectBase.get<InventoryReference>(this, 'diamondCutGrade')
          as InventoryReference?;
  @override
  set diamondCutGrade(covariant InventoryReference? value) =>
      RealmObjectBase.set(this, 'diamondCutGrade', value);

  @override
  double get muBaseAmount =>
      RealmObjectBase.get<double>(this, 'muBaseAmount') as double;
  @override
  set muBaseAmount(double value) =>
      RealmObjectBase.set(this, 'muBaseAmount', value);

  @override
  double get qty => RealmObjectBase.get<double>(this, 'qty') as double;
  @override
  set qty(double value) => RealmObjectBase.set(this, 'qty', value);

  @override
  String? get vvCode => RealmObjectBase.get<String>(this, 'vvCode') as String?;
  @override
  set vvCode(String? value) => RealmObjectBase.set(this, 'vvCode', value);

  @override
  String get inventoryId =>
      RealmObjectBase.get<String>(this, 'inventoryId') as String;
  @override
  set inventoryId(String value) =>
      RealmObjectBase.set(this, 'inventoryId', value);

  @override
  String? get from => RealmObjectBase.get<String>(this, 'from') as String?;
  @override
  set from(String? value) => RealmObjectBase.set(this, 'from', value);

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  double get seq => RealmObjectBase.get<double>(this, 'seq') as double;
  @override
  set seq(double value) => RealmObjectBase.set(this, 'seq', value);

  @override
  InventoryReference? get diamondClarity =>
      RealmObjectBase.get<InventoryReference>(this, 'diamondClarity')
          as InventoryReference?;
  @override
  set diamondClarity(covariant InventoryReference? value) =>
      RealmObjectBase.set(this, 'diamondClarity', value);

  @override
  InventoryReference? get diamondPolish =>
      RealmObjectBase.get<InventoryReference>(this, 'diamondPolish')
          as InventoryReference?;
  @override
  set diamondPolish(covariant InventoryReference? value) =>
      RealmObjectBase.set(this, 'diamondPolish', value);

  @override
  InventoryReference? get diamondFluorescent =>
      RealmObjectBase.get<InventoryReference>(this, 'diamondFluorescent')
          as InventoryReference?;
  @override
  set diamondFluorescent(covariant InventoryReference? value) =>
      RealmObjectBase.set(this, 'diamondFluorescent', value);

  @override
  InventoryReference? get diamondSymmetry =>
      RealmObjectBase.get<InventoryReference>(this, 'diamondSymmetry')
          as InventoryReference?;
  @override
  set diamondSymmetry(covariant InventoryReference? value) =>
      RealmObjectBase.set(this, 'diamondSymmetry', value);

  @override
  RealmList<BomCertificate> get bomCertificates =>
      RealmObjectBase.get<BomCertificate>(this, 'bomCertificates')
          as RealmList<BomCertificate>;
  @override
  set bomCertificates(covariant RealmList<BomCertificate> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<Bom>> get changes =>
      RealmObjectBase.getChanges<Bom>(this);

  @override
  Bom freeze() => RealmObjectBase.freezeObject<Bom>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Bom._);
    return const SchemaObject(ObjectType.embeddedObject, Bom, 'Bom', [
      SchemaProperty('materialClass', RealmPropertyType.string, optional: true),
      SchemaProperty('cost', RealmPropertyType.double),
      SchemaProperty('caratWeight', RealmPropertyType.double),
      SchemaProperty('mainMaterialIndicator', RealmPropertyType.bool),
      SchemaProperty('materialCategory', RealmPropertyType.string,
          optional: true),
      SchemaProperty('diamondColor', RealmPropertyType.object,
          optional: true, linkTarget: 'InventoryReference'),
      SchemaProperty('diamondShape', RealmPropertyType.object,
          optional: true, linkTarget: 'InventoryReference'),
      SchemaProperty('diamondCutGrade', RealmPropertyType.object,
          optional: true, linkTarget: 'InventoryReference'),
      SchemaProperty('muBaseAmount', RealmPropertyType.double),
      SchemaProperty('qty', RealmPropertyType.double),
      SchemaProperty('vvCode', RealmPropertyType.string, optional: true),
      SchemaProperty('inventoryId', RealmPropertyType.string),
      SchemaProperty('from', RealmPropertyType.string, optional: true),
      SchemaProperty('id', RealmPropertyType.objectid, mapTo: '_id'),
      SchemaProperty('seq', RealmPropertyType.double),
      SchemaProperty('diamondClarity', RealmPropertyType.object,
          optional: true, linkTarget: 'InventoryReference'),
      SchemaProperty('diamondPolish', RealmPropertyType.object,
          optional: true, linkTarget: 'InventoryReference'),
      SchemaProperty('diamondFluorescent', RealmPropertyType.object,
          optional: true, linkTarget: 'InventoryReference'),
      SchemaProperty('diamondSymmetry', RealmPropertyType.object,
          optional: true, linkTarget: 'InventoryReference'),
      SchemaProperty('bomCertificates', RealmPropertyType.object,
          linkTarget: 'BomCertificate',
          collectionType: RealmCollectionType.list),
    ]);
  }
}

class BomCertificate extends _BomCertificate
    with RealmEntity, RealmObjectBase, EmbeddedObject {
  BomCertificate({
    bool? cnPhysicalCertificateIndicator,
    bool? physicalIndicator,
    String? certificateOrganization,
    String? certificateNumber,
    String? inventoryId,
    String? from,
    String? createUser,
  }) {
    RealmObjectBase.set(
        this, 'cnPhysicalCertificateIndicator', cnPhysicalCertificateIndicator);
    RealmObjectBase.set(this, 'physicalIndicator', physicalIndicator);
    RealmObjectBase.set(
        this, 'certificateOrganization', certificateOrganization);
    RealmObjectBase.set(this, 'certificateNumber', certificateNumber);
    RealmObjectBase.set(this, 'inventoryId', inventoryId);
    RealmObjectBase.set(this, 'from', from);
    RealmObjectBase.set(this, 'createUser', createUser);
  }

  BomCertificate._();

  @override
  bool? get cnPhysicalCertificateIndicator =>
      RealmObjectBase.get<bool>(this, 'cnPhysicalCertificateIndicator')
          as bool?;
  @override
  set cnPhysicalCertificateIndicator(bool? value) =>
      RealmObjectBase.set(this, 'cnPhysicalCertificateIndicator', value);

  @override
  bool? get physicalIndicator =>
      RealmObjectBase.get<bool>(this, 'physicalIndicator') as bool?;
  @override
  set physicalIndicator(bool? value) =>
      RealmObjectBase.set(this, 'physicalIndicator', value);

  @override
  String? get certificateOrganization =>
      RealmObjectBase.get<String>(this, 'certificateOrganization') as String?;
  @override
  set certificateOrganization(String? value) =>
      RealmObjectBase.set(this, 'certificateOrganization', value);

  @override
  String? get certificateNumber =>
      RealmObjectBase.get<String>(this, 'certificateNumber') as String?;
  @override
  set certificateNumber(String? value) =>
      RealmObjectBase.set(this, 'certificateNumber', value);

  @override
  String? get inventoryId =>
      RealmObjectBase.get<String>(this, 'inventoryId') as String?;
  @override
  set inventoryId(String? value) =>
      RealmObjectBase.set(this, 'inventoryId', value);

  @override
  String? get from => RealmObjectBase.get<String>(this, 'from') as String?;
  @override
  set from(String? value) => RealmObjectBase.set(this, 'from', value);

  @override
  String? get createUser =>
      RealmObjectBase.get<String>(this, 'createUser') as String?;
  @override
  set createUser(String? value) =>
      RealmObjectBase.set(this, 'createUser', value);

  @override
  Stream<RealmObjectChanges<BomCertificate>> get changes =>
      RealmObjectBase.getChanges<BomCertificate>(this);

  @override
  BomCertificate freeze() => RealmObjectBase.freezeObject<BomCertificate>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(BomCertificate._);
    return const SchemaObject(
        ObjectType.embeddedObject, BomCertificate, 'BomCertificate', [
      SchemaProperty('cnPhysicalCertificateIndicator', RealmPropertyType.bool,
          optional: true),
      SchemaProperty('physicalIndicator', RealmPropertyType.bool,
          optional: true),
      SchemaProperty('certificateOrganization', RealmPropertyType.string,
          optional: true),
      SchemaProperty('certificateNumber', RealmPropertyType.string,
          optional: true),
      SchemaProperty('inventoryId', RealmPropertyType.string, optional: true),
      SchemaProperty('from', RealmPropertyType.string, optional: true),
      SchemaProperty('createUser', RealmPropertyType.string, optional: true),
    ]);
  }
}

class Weight extends _Weight with RealmEntity, RealmObjectBase, EmbeddedObject {
  Weight(
    double gram,
    double raw,
  ) {
    RealmObjectBase.set(this, 'gram', gram);
    RealmObjectBase.set(this, 'raw', raw);
  }

  Weight._();

  @override
  double get gram => RealmObjectBase.get<double>(this, 'gram') as double;
  @override
  set gram(double value) => RealmObjectBase.set(this, 'gram', value);

  @override
  double get raw => RealmObjectBase.get<double>(this, 'raw') as double;
  @override
  set raw(double value) => RealmObjectBase.set(this, 'raw', value);

  @override
  Stream<RealmObjectChanges<Weight>> get changes =>
      RealmObjectBase.getChanges<Weight>(this);

  @override
  Weight freeze() => RealmObjectBase.freezeObject<Weight>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Weight._);
    return const SchemaObject(ObjectType.embeddedObject, Weight, 'Weight', [
      SchemaProperty('gram', RealmPropertyType.double),
      SchemaProperty('raw', RealmPropertyType.double),
    ]);
  }
}

class InventoryModel extends _InventoryModel
    with RealmEntity, RealmObjectBase, EmbeddedObject {
  InventoryModel(
    String inventoryClass,
    String usage,
    String generalLedgerInventoryClass,
    String costUnit,
    String productType,
    String weightCode,
    String jwInd,
    DateTime createDate,
    String productClass,
    String modelNumber,
    String withMuBaseIndicator,
    DateTime lastModifiedDate,
    String styleCatgInd,
    String modelDescription,
    String catalogItemNumber,
    String finish,
    double modelSequenceNumber,
    String goldType,
    String styleCatalogNumber, {
    String? t22,
    String? cut,
    String? color,
    String? rawMaterialSize,
    String? materialBrand,
    String? settingWidth,
    String? modelPictNbr,
    String? setting,
    String? t18,
    String? vvCode,
    String? parntModelSeqNbr,
    String? t17,
    String? t19,
    String? sieveSize,
    String? t44,
    String? t48,
    String? materialCategory,
    String? modelSize,
    String? clarity,
    String? materialClass,
    String? statCde,
    String? shape,
  }) {
    RealmObjectBase.set(this, 't22', t22);
    RealmObjectBase.set(this, 'cut', cut);
    RealmObjectBase.set(this, 'inventoryClass', inventoryClass);
    RealmObjectBase.set(this, 'color', color);
    RealmObjectBase.set(this, 'usage', usage);
    RealmObjectBase.set(this, 'rawMaterialSize', rawMaterialSize);
    RealmObjectBase.set(this, 'materialBrand', materialBrand);
    RealmObjectBase.set(this, 'settingWidth', settingWidth);
    RealmObjectBase.set(this, 'modelPictNbr', modelPictNbr);
    RealmObjectBase.set(this, 'setting', setting);
    RealmObjectBase.set(
        this, 'generalLedgerInventoryClass', generalLedgerInventoryClass);
    RealmObjectBase.set(this, 't18', t18);
    RealmObjectBase.set(this, 'vvCode', vvCode);
    RealmObjectBase.set(this, 'parntModelSeqNbr', parntModelSeqNbr);
    RealmObjectBase.set(this, 'costUnit', costUnit);
    RealmObjectBase.set(this, 't17', t17);
    RealmObjectBase.set(this, 't19', t19);
    RealmObjectBase.set(this, 'productType', productType);
    RealmObjectBase.set(this, 'weightCode', weightCode);
    RealmObjectBase.set(this, 'sieveSize', sieveSize);
    RealmObjectBase.set(this, 'jwInd', jwInd);
    RealmObjectBase.set(this, 'createDate', createDate);
    RealmObjectBase.set(this, 't44', t44);
    RealmObjectBase.set(this, 'productClass', productClass);
    RealmObjectBase.set(this, 't48', t48);
    RealmObjectBase.set(this, 'modelNumber', modelNumber);
    RealmObjectBase.set(this, 'withMuBaseIndicator', withMuBaseIndicator);
    RealmObjectBase.set(this, 'lastModifiedDate', lastModifiedDate);
    RealmObjectBase.set(this, 'styleCatgInd', styleCatgInd);
    RealmObjectBase.set(this, 'materialCategory', materialCategory);
    RealmObjectBase.set(this, 'modelSize', modelSize);
    RealmObjectBase.set(this, 'modelDescription', modelDescription);
    RealmObjectBase.set(this, 'clarity', clarity);
    RealmObjectBase.set(this, 'catalogItemNumber', catalogItemNumber);
    RealmObjectBase.set(this, 'materialClass', materialClass);
    RealmObjectBase.set(this, 'finish', finish);
    RealmObjectBase.set(this, 'modelSequenceNumber', modelSequenceNumber);
    RealmObjectBase.set(this, 'statCde', statCde);
    RealmObjectBase.set(this, 'shape', shape);
    RealmObjectBase.set(this, 'goldType', goldType);
    RealmObjectBase.set(this, 'styleCatalogNumber', styleCatalogNumber);
  }

  InventoryModel._();

  @override
  String? get t22 => RealmObjectBase.get<String>(this, 't22') as String?;
  @override
  set t22(String? value) => RealmObjectBase.set(this, 't22', value);

  @override
  String? get cut => RealmObjectBase.get<String>(this, 'cut') as String?;
  @override
  set cut(String? value) => RealmObjectBase.set(this, 'cut', value);

  @override
  String get inventoryClass =>
      RealmObjectBase.get<String>(this, 'inventoryClass') as String;
  @override
  set inventoryClass(String value) =>
      RealmObjectBase.set(this, 'inventoryClass', value);

  @override
  String? get color => RealmObjectBase.get<String>(this, 'color') as String?;
  @override
  set color(String? value) => RealmObjectBase.set(this, 'color', value);

  @override
  String get usage => RealmObjectBase.get<String>(this, 'usage') as String;
  @override
  set usage(String value) => RealmObjectBase.set(this, 'usage', value);

  @override
  String? get rawMaterialSize =>
      RealmObjectBase.get<String>(this, 'rawMaterialSize') as String?;
  @override
  set rawMaterialSize(String? value) =>
      RealmObjectBase.set(this, 'rawMaterialSize', value);

  @override
  String? get materialBrand =>
      RealmObjectBase.get<String>(this, 'materialBrand') as String?;
  @override
  set materialBrand(String? value) =>
      RealmObjectBase.set(this, 'materialBrand', value);

  @override
  String? get settingWidth =>
      RealmObjectBase.get<String>(this, 'settingWidth') as String?;
  @override
  set settingWidth(String? value) =>
      RealmObjectBase.set(this, 'settingWidth', value);

  @override
  String? get modelPictNbr =>
      RealmObjectBase.get<String>(this, 'modelPictNbr') as String?;
  @override
  set modelPictNbr(String? value) =>
      RealmObjectBase.set(this, 'modelPictNbr', value);

  @override
  String? get setting =>
      RealmObjectBase.get<String>(this, 'setting') as String?;
  @override
  set setting(String? value) => RealmObjectBase.set(this, 'setting', value);

  @override
  String get generalLedgerInventoryClass =>
      RealmObjectBase.get<String>(this, 'generalLedgerInventoryClass')
          as String;
  @override
  set generalLedgerInventoryClass(String value) =>
      RealmObjectBase.set(this, 'generalLedgerInventoryClass', value);

  @override
  String? get t18 => RealmObjectBase.get<String>(this, 't18') as String?;
  @override
  set t18(String? value) => RealmObjectBase.set(this, 't18', value);

  @override
  String? get vvCode => RealmObjectBase.get<String>(this, 'vvCode') as String?;
  @override
  set vvCode(String? value) => RealmObjectBase.set(this, 'vvCode', value);

  @override
  String? get parntModelSeqNbr =>
      RealmObjectBase.get<String>(this, 'parntModelSeqNbr') as String?;
  @override
  set parntModelSeqNbr(String? value) =>
      RealmObjectBase.set(this, 'parntModelSeqNbr', value);

  @override
  String get costUnit =>
      RealmObjectBase.get<String>(this, 'costUnit') as String;
  @override
  set costUnit(String value) => RealmObjectBase.set(this, 'costUnit', value);

  @override
  String? get t17 => RealmObjectBase.get<String>(this, 't17') as String?;
  @override
  set t17(String? value) => RealmObjectBase.set(this, 't17', value);

  @override
  String? get t19 => RealmObjectBase.get<String>(this, 't19') as String?;
  @override
  set t19(String? value) => RealmObjectBase.set(this, 't19', value);

  @override
  String get productType =>
      RealmObjectBase.get<String>(this, 'productType') as String;
  @override
  set productType(String value) =>
      RealmObjectBase.set(this, 'productType', value);

  @override
  String get weightCode =>
      RealmObjectBase.get<String>(this, 'weightCode') as String;
  @override
  set weightCode(String value) =>
      RealmObjectBase.set(this, 'weightCode', value);

  @override
  String? get sieveSize =>
      RealmObjectBase.get<String>(this, 'sieveSize') as String?;
  @override
  set sieveSize(String? value) => RealmObjectBase.set(this, 'sieveSize', value);

  @override
  String get jwInd => RealmObjectBase.get<String>(this, 'jwInd') as String;
  @override
  set jwInd(String value) => RealmObjectBase.set(this, 'jwInd', value);

  @override
  DateTime get createDate =>
      RealmObjectBase.get<DateTime>(this, 'createDate') as DateTime;
  @override
  set createDate(DateTime value) =>
      RealmObjectBase.set(this, 'createDate', value);

  @override
  String? get t44 => RealmObjectBase.get<String>(this, 't44') as String?;
  @override
  set t44(String? value) => RealmObjectBase.set(this, 't44', value);

  @override
  String get productClass =>
      RealmObjectBase.get<String>(this, 'productClass') as String;
  @override
  set productClass(String value) =>
      RealmObjectBase.set(this, 'productClass', value);

  @override
  String? get t48 => RealmObjectBase.get<String>(this, 't48') as String?;
  @override
  set t48(String? value) => RealmObjectBase.set(this, 't48', value);

  @override
  String get modelNumber =>
      RealmObjectBase.get<String>(this, 'modelNumber') as String;
  @override
  set modelNumber(String value) =>
      RealmObjectBase.set(this, 'modelNumber', value);

  @override
  String get withMuBaseIndicator =>
      RealmObjectBase.get<String>(this, 'withMuBaseIndicator') as String;
  @override
  set withMuBaseIndicator(String value) =>
      RealmObjectBase.set(this, 'withMuBaseIndicator', value);

  @override
  DateTime get lastModifiedDate =>
      RealmObjectBase.get<DateTime>(this, 'lastModifiedDate') as DateTime;
  @override
  set lastModifiedDate(DateTime value) =>
      RealmObjectBase.set(this, 'lastModifiedDate', value);

  @override
  String get styleCatgInd =>
      RealmObjectBase.get<String>(this, 'styleCatgInd') as String;
  @override
  set styleCatgInd(String value) =>
      RealmObjectBase.set(this, 'styleCatgInd', value);

  @override
  String? get materialCategory =>
      RealmObjectBase.get<String>(this, 'materialCategory') as String?;
  @override
  set materialCategory(String? value) =>
      RealmObjectBase.set(this, 'materialCategory', value);

  @override
  String? get modelSize =>
      RealmObjectBase.get<String>(this, 'modelSize') as String?;
  @override
  set modelSize(String? value) => RealmObjectBase.set(this, 'modelSize', value);

  @override
  String get modelDescription =>
      RealmObjectBase.get<String>(this, 'modelDescription') as String;
  @override
  set modelDescription(String value) =>
      RealmObjectBase.set(this, 'modelDescription', value);

  @override
  String? get clarity =>
      RealmObjectBase.get<String>(this, 'clarity') as String?;
  @override
  set clarity(String? value) => RealmObjectBase.set(this, 'clarity', value);

  @override
  String get catalogItemNumber =>
      RealmObjectBase.get<String>(this, 'catalogItemNumber') as String;
  @override
  set catalogItemNumber(String value) =>
      RealmObjectBase.set(this, 'catalogItemNumber', value);

  @override
  String? get materialClass =>
      RealmObjectBase.get<String>(this, 'materialClass') as String?;
  @override
  set materialClass(String? value) =>
      RealmObjectBase.set(this, 'materialClass', value);

  @override
  String get finish => RealmObjectBase.get<String>(this, 'finish') as String;
  @override
  set finish(String value) => RealmObjectBase.set(this, 'finish', value);

  @override
  double get modelSequenceNumber =>
      RealmObjectBase.get<double>(this, 'modelSequenceNumber') as double;
  @override
  set modelSequenceNumber(double value) =>
      RealmObjectBase.set(this, 'modelSequenceNumber', value);

  @override
  String? get statCde =>
      RealmObjectBase.get<String>(this, 'statCde') as String?;
  @override
  set statCde(String? value) => RealmObjectBase.set(this, 'statCde', value);

  @override
  String? get shape => RealmObjectBase.get<String>(this, 'shape') as String?;
  @override
  set shape(String? value) => RealmObjectBase.set(this, 'shape', value);

  @override
  String get goldType =>
      RealmObjectBase.get<String>(this, 'goldType') as String;
  @override
  set goldType(String value) => RealmObjectBase.set(this, 'goldType', value);

  @override
  String get styleCatalogNumber =>
      RealmObjectBase.get<String>(this, 'styleCatalogNumber') as String;
  @override
  set styleCatalogNumber(String value) =>
      RealmObjectBase.set(this, 'styleCatalogNumber', value);

  @override
  Stream<RealmObjectChanges<InventoryModel>> get changes =>
      RealmObjectBase.getChanges<InventoryModel>(this);

  @override
  InventoryModel freeze() => RealmObjectBase.freezeObject<InventoryModel>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(InventoryModel._);
    return const SchemaObject(
        ObjectType.embeddedObject, InventoryModel, 'InventoryModel', [
      SchemaProperty('t22', RealmPropertyType.string, optional: true),
      SchemaProperty('cut', RealmPropertyType.string, optional: true),
      SchemaProperty('inventoryClass', RealmPropertyType.string),
      SchemaProperty('color', RealmPropertyType.string, optional: true),
      SchemaProperty('usage', RealmPropertyType.string),
      SchemaProperty('rawMaterialSize', RealmPropertyType.string,
          optional: true),
      SchemaProperty('materialBrand', RealmPropertyType.string, optional: true),
      SchemaProperty('settingWidth', RealmPropertyType.string, optional: true),
      SchemaProperty('modelPictNbr', RealmPropertyType.string, optional: true),
      SchemaProperty('setting', RealmPropertyType.string, optional: true),
      SchemaProperty('generalLedgerInventoryClass', RealmPropertyType.string),
      SchemaProperty('t18', RealmPropertyType.string, optional: true),
      SchemaProperty('vvCode', RealmPropertyType.string, optional: true),
      SchemaProperty('parntModelSeqNbr', RealmPropertyType.string,
          optional: true),
      SchemaProperty('costUnit', RealmPropertyType.string),
      SchemaProperty('t17', RealmPropertyType.string, optional: true),
      SchemaProperty('t19', RealmPropertyType.string, optional: true),
      SchemaProperty('productType', RealmPropertyType.string),
      SchemaProperty('weightCode', RealmPropertyType.string),
      SchemaProperty('sieveSize', RealmPropertyType.string, optional: true),
      SchemaProperty('jwInd', RealmPropertyType.string),
      SchemaProperty('createDate', RealmPropertyType.timestamp),
      SchemaProperty('t44', RealmPropertyType.string, optional: true),
      SchemaProperty('productClass', RealmPropertyType.string),
      SchemaProperty('t48', RealmPropertyType.string, optional: true),
      SchemaProperty('modelNumber', RealmPropertyType.string),
      SchemaProperty('withMuBaseIndicator', RealmPropertyType.string),
      SchemaProperty('lastModifiedDate', RealmPropertyType.timestamp),
      SchemaProperty('styleCatgInd', RealmPropertyType.string),
      SchemaProperty('materialCategory', RealmPropertyType.string,
          optional: true),
      SchemaProperty('modelSize', RealmPropertyType.string, optional: true),
      SchemaProperty('modelDescription', RealmPropertyType.string),
      SchemaProperty('clarity', RealmPropertyType.string, optional: true),
      SchemaProperty('catalogItemNumber', RealmPropertyType.string),
      SchemaProperty('materialClass', RealmPropertyType.string, optional: true),
      SchemaProperty('finish', RealmPropertyType.string),
      SchemaProperty('modelSequenceNumber', RealmPropertyType.double),
      SchemaProperty('statCde', RealmPropertyType.string, optional: true),
      SchemaProperty('shape', RealmPropertyType.string, optional: true),
      SchemaProperty('goldType', RealmPropertyType.string),
      SchemaProperty('styleCatalogNumber', RealmPropertyType.string),
    ]);
  }
}
