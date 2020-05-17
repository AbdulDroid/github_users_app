
class UserUrlList {
  final List<String> userUrls;

  UserUrlList({
    this.userUrls,
  });

  factory UserUrlList.fromJson(List<dynamic> parsedJson) {
    List<String> uUrls = parsedJson.map((i) => i['url'].toString()).toList();

    return UserUrlList(
      userUrls: uUrls,
    );
  }
}
