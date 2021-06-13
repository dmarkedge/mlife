import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong/latlong.dart';

import 'schema_util.dart';
import 'serializers.dart';

part 'test_record.g.dart';

abstract class TestRecord implements Built<TestRecord, TestRecordBuilder> {
  static Serializer<TestRecord> get serializer => _$testRecordSerializer;

  @nullable
  String get test;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(TestRecordBuilder builder) =>
      builder..test = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('test');

  static Stream<TestRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  TestRecord._();
  factory TestRecord([void Function(TestRecordBuilder) updates]) = _$TestRecord;
}

Map<String, dynamic> createTestRecordData({
  String test,
}) =>
    serializers.toFirestore(
        TestRecord.serializer, TestRecord((t) => t..test = test));

TestRecord get dummyTestRecord {
  final builder = TestRecordBuilder()..test = dummyString;
  return builder.build();
}

List<TestRecord> createDummyTestRecord({int count}) =>
    List.generate(count, (_) => dummyTestRecord);
