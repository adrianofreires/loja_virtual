class PostModel {
  int id;
  String date;
  String featuredMedia;
  String title;
  String link_url;
  String categoryUrl;
  List categories = [];

  PostModel({this.id, this.title, this.date, this.featuredMedia, this.link_url, this.categoryUrl, this.categories});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      title: json['title']['rendered'],
      date: json['date'],
      link_url: json['link'],
      featuredMedia: json['fimg_url'],
      categoryUrl: json['_links']['wp:term'][0]['href'],
      categories: json['categories_names'],
    );
  }
}
