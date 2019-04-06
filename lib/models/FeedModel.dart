class FeedModel {
  int id;
  String imageUrl;
  String section;
  String summary;
  String title;

  FeedModel(this.id, this.imageUrl, this.section, this.summary, this.title);

  FeedModel.fromJson(Map<String, dynamic> parsedJson){
    id = parsedJson['id'];
    imageUrl = parsedJson['imageUrl'];
    section = parsedJson['section'];
    summary = parsedJson['summary'];
    title = parsedJson['title'];
  }
}
