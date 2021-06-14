import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong/latlong.dart';

import 'schema_util.dart';
import 'serializers.dart';

part 'profile_images_record.g.dart';

abstract class ProfileImagesRecord
    implements Built<ProfileImagesRecord, ProfileImagesRecordBuilder> {
  static Serializer<ProfileImagesRecord> get serializer =>
      _$profileImagesRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'user_profile_image')
  String get userProfileImage;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(ProfileImagesRecordBuilder builder) =>
      builder..userProfileImage = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('profileImages');

  static Stream<ProfileImagesRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  ProfileImagesRecord._();
  factory ProfileImagesRecord(
          [void Function(ProfileImagesRecordBuilder) updates]) =
      _$ProfileImagesRecord;
}

Map<String, dynamic> createProfileImagesRecordData({
  String userProfileImage,
}) =>
    serializers.toFirestore(ProfileImagesRecord.serializer,
        ProfileImagesRecord((p) => p..userProfileImage = userProfileImage));

ProfileImagesRecord get dummyProfileImagesRecord {
  final builder = ProfileImagesRecordBuilder()
    ..userProfileImage = dummyImagePath;
  return builder.build();
}

List<ProfileImagesRecord> createDummyProfileImagesRecord({int count}) =>
    List.generate(count, (_) => dummyProfileImagesRecord);
