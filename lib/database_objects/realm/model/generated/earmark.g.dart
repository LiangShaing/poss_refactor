// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../earmark.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Earmark extends _Earmark with RealmEntity, RealmObjectBase, RealmObject {
  Earmark(
    ObjectId id, {
    String? circleUnit,
    String? departmentCode,
    String? inventoryId,
    DateTime? lastModifiedDate,
    double? modelSequenceNumber,
    String? purposeCode,
    double? quantity,
    String? tag,
    String? catalogItem,
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'circleUnit', circleUnit);
    RealmObjectBase.set(this, 'departmentCode', departmentCode);
    RealmObjectBase.set(this, 'inventoryId', inventoryId);
    RealmObjectBase.set(this, 'last_modified_date', lastModifiedDate);
    RealmObjectBase.set(this, 'modelSequenceNumber', modelSequenceNumber);
    RealmObjectBase.set(this, 'purposeCode', purposeCode);
    RealmObjectBase.set(this, 'quantity', quantity);
    RealmObjectBase.set(this, 'tag', tag);
    RealmObjectBase.set(this, 'catalogItem', catalogItem);
  }

  Earmark._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  String? get circleUnit =>
      RealmObjectBase.get<String>(this, 'circleUnit') as String?;
  @override
  set circleUnit(String? value) =>
      RealmObjectBase.set(this, 'circleUnit', value);

  @override
  String? get departmentCode =>
      RealmObjectBase.get<String>(this, 'departmentCode') as String?;
  @override
  set departmentCode(String? value) =>
      RealmObjectBase.set(this, 'departmentCode', value);

  @override
  String? get inventoryId =>
      RealmObjectBase.get<String>(this, 'inventoryId') as String?;
  @override
  set inventoryId(String? value) =>
      RealmObjectBase.set(this, 'inventoryId', value);

  @override
  DateTime? get lastModifiedDate =>
      RealmObjectBase.get<DateTime>(this, 'last_modified_date') as DateTime?;
  @override
  set lastModifiedDate(DateTime? value) =>
      RealmObjectBase.set(this, 'last_modified_date', value);

  @override
  double? get modelSequenceNumber =>
      RealmObjectBase.get<double>(this, 'modelSequenceNumber') as double?;
  @override
  set modelSequenceNumber(double? value) =>
      RealmObjectBase.set(this, 'modelSequenceNumber', value);

  @override
  String? get purposeCode =>
      RealmObjectBase.get<String>(this, 'purposeCode') as String?;
  @override
  set purposeCode(String? value) =>
      RealmObjectBase.set(this, 'purposeCode', value);

  @override
  double? get quantity =>
      RealmObjectBase.get<double>(this, 'quantity') as double?;
  @override
  set quantity(double? value) => RealmObjectBase.set(this, 'quantity', value);

  @override
  String? get tag => RealmObjectBase.get<String>(this, 'tag') as String?;
  @override
  set tag(String? value) => RealmObjectBase.set(this, 'tag', value);

  @override
  String? get catalogItem =>
      RealmObjectBase.get<String>(this, 'catalogItem') as String?;
  @override
  set catalogItem(String? value) =>
      RealmObjectBase.set(this, 'catalogItem', value);

  @override
  Stream<RealmObjectChanges<Earmark>> get changes =>
      RealmObjectBase.getChanges<Earmark>(this);

  @override
  Earmark freeze() => RealmObjectBase.freezeObject<Earmark>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Earmark._);
    return const SchemaObject(ObjectType.realmObject, Earmark, 'earmark', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('circleUnit', RealmPropertyType.string, optional: true),
      SchemaProperty('departmentCode', RealmPropertyType.string,
          optional: true),
      SchemaProperty('inventoryId', RealmPropertyType.string, optional: true),
      SchemaProperty('lastModifiedDate', RealmPropertyType.timestamp,
          mapTo: 'last_modified_date', optional: true),
      SchemaProperty('modelSequenceNumber', RealmPropertyType.double,
          optional: true),
      SchemaProperty('purposeCode', RealmPropertyType.string, optional: true),
      SchemaProperty('quantity', RealmPropertyType.double, optional: true),
      SchemaProperty('tag', RealmPropertyType.string, optional: true),
      SchemaProperty('catalogItem', RealmPropertyType.string, optional: true),
    ]);
  }
}
