class NewsListModel {
  int status;
  String message;
  List<NewsList> newsList;

  NewsListModel({this.status, this.message, this.newsList});

  NewsListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['news_list'] != null) {
      newsList = new List<NewsList>();
      json['news_list'].forEach((v) {
        newsList.add(new NewsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.newsList != null) {
      data['news_list'] = this.newsList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NewsList {
  String title;
  String date;

  NewsList({this.title, this.date});

  NewsList.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['date'] = this.date;
    return data;
  }
}