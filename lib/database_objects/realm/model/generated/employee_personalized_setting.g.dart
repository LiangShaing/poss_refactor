// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../employee_personalized_setting.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class EmployeePersonalizedSetting extends _EmployeePersonalizedSetting
    with RealmEntity, RealmObjectBase, RealmObject {
  EmployeePersonalizedSetting(
    ObjectId id,
    String employeeId, {
    String? employeeName,
    String? departmentCode,
    DateTime? lastLoginDate,
    String? deviceId,
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'employeeId', employeeId);
    RealmObjectBase.set(this, 'employeeName', employeeName);
    RealmObjectBase.set(this, 'departmentCode', departmentCode);
    RealmObjectBase.set(this, 'lastLoginDate', lastLoginDate);
    RealmObjectBase.set(this, 'deviceId', deviceId);
  }

  EmployeePersonalizedSetting._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  String get employeeId =>
      RealmObjectBase.get<String>(this, 'employeeId') as String;
  @override
  set employeeId(String value) =>
      RealmObjectBase.set(this, 'employeeId', value);

  @override
  String? get employeeName =>
      RealmObjectBase.get<String>(this, 'employeeName') as String?;
  @override
  set employeeName(String? value) =>
      RealmObjectBase.set(this, 'employeeName', value);

  @override
  String? get departmentCode =>
      RealmObjectBase.get<String>(this, 'departmentCode') as String?;
  @override
  set departmentCode(String? value) =>
      RealmObjectBase.set(this, 'departmentCode', value);

  @override
  DateTime? get lastLoginDate =>
      RealmObjectBase.get<DateTime>(this, 'lastLoginDate') as DateTime?;
  @override
  set lastLoginDate(DateTime? value) =>
      RealmObjectBase.set(this, 'lastLoginDate', value);

  @override
  String? get deviceId =>
      RealmObjectBase.get<String>(this, 'deviceId') as String?;
  @override
  set deviceId(String? value) => RealmObjectBase.set(this, 'deviceId', value);

  @override
  Stream<RealmObjectChanges<EmployeePersonalizedSetting>> get changes =>
      RealmObjectBase.getChanges<EmployeePersonalizedSetting>(this);

  @override
  EmployeePersonalizedSetting freeze() =>
      RealmObjectBase.freezeObject<EmployeePersonalizedSetting>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(EmployeePersonalizedSetting._);
    return const SchemaObject(ObjectType.realmObject,
        EmployeePersonalizedSetting, 'employeePersonalizedSetting', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('employeeId', RealmPropertyType.string),
      SchemaProperty('employeeName', RealmPropertyType.string, optional: true),
      SchemaProperty('departmentCode', RealmPropertyType.string,
          optional: true),
      SchemaProperty('lastLoginDate', RealmPropertyType.timestamp,
          optional: true),
      SchemaProperty('deviceId', RealmPropertyType.string, optional: true),
    ]);
  }
}
