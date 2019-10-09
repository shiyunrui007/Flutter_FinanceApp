class BannerModel {
  int status;
  String message;
  List<BannerList> bannerList;

  BannerModel({this.status, this.message, this.bannerList});

  BannerModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['banner_list'] != null) {
      bannerList = new List<BannerList>();
      json['banner_list'].forEach((v) {
        bannerList.add(new BannerList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.bannerList != null) {
      data['banner_list'] = this.bannerList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BannerList {
  String title;
  String imgPath;

  BannerList({this.title, this.imgPath});

  BannerList.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    imgPath = json['img_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['img_path'] = this.imgPath;
    return data;
  }
}