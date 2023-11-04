class AppwriteConstants {
  // static const String databaseId = "653a534a16767924a8c0";
  // static const String projectId = "653a503e84c8981f9cae";
  // static const String endPoint = "http://172.20.10.4:80/v1";
  // static const String usersID = "653ce5f60eb2f48d588d";
  // static const String tweetsCollectionID = "653e6dcee1f7373f0fa1";
  // static const String imagesBucket = "653e9ba478858f570216";

  static const String databaseId = "653fde8ac221f9f2b000";
  static const String projectId = "653a3f319fa5b52fe3d5";
  static const String endPoint = "https://cloud.appwrite.io/v1";
  static const String usersID = "653fded8e204bb9ed20c";
  static const String tweetsCollectionID = "653fe01721d2c1ac14db";
  static const String imagesBucket = "653fe02c9b9b61ad9340";

  static String imageURL(String imageId) =>
      // "172.20.158.24/storage/buckets/$imagesBucket/files/$imageId/view?project=$projectId&mode=admin";
      "$endPoint/storage/buckets/$imagesBucket/files/$imageId/view?project=$projectId&mode=admin";
}

//172.20.10.4 hotspot
//172.20.156.148 hos24
