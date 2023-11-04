import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as model;
import 'package:dsa_proj/constants/appwrite_constants.dart';
import 'package:dsa_proj/core/core.dart';
import 'package:dsa_proj/core/providers.dart';
import 'package:dsa_proj/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

final userAPIProvider = Provider((ref) {
  return UserAPI(
    db: ref.watch(appwriteDatabasesProvider),
  );
});

abstract class IUserAPI {
  FutureEitherVoid saveUserData(UserModel userModel);
  Future<model.Document> getUserData(String uid);
}

class UserAPI implements IUserAPI {
  final Databases _db;
  UserAPI({required Databases db}) : _db = db;

  @override
  FutureEitherVoid saveUserData(UserModel userModel) async {
    try {
      await _db.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.usersID,
        documentId: userModel.uid,
        data: userModel.toMap(),
      );

      return right(null);
    } on AppwriteException catch (e, st) {
      return left(
        Failure(e.message ?? "Some error occured", st),
      );
    } catch (e, st) {
      return left(
        Failure(e.toString(), st),
      );
    }
  }

  @override
  Future<model.Document> getUserData(String uid) async {
    // final doclist = (_db.listDocuments(
    //     databaseId: AppwriteConstants.databaseId,
    //     collectionId: AppwriteConstants.usersID));
    // print(doclist);
    // print(await _db.getDocument(
    //     databaseId: AppwriteConstants.databaseId,
    //     collectionId: AppwriteConstants.usersID,
    //     documentId: uid));
    return await _db.getDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.usersID,
        documentId: uid);
  }
}
