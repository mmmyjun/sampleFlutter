// class TvListResModel {
//   // code, msg, data
//   int code;
//   String msg;
//   List<TvListResDataModel> data=[];
//
//   TvListResModel({required this.code, required this.msg, required this.data});
//
//   factory TvListResModel.fromMap(Map<String, dynamic> map) {
//     List<TvListResDataModel> arr=[];
//     if (map['data'] != null) {
//       for (final item in map['data']) {
//         print('TvListResDataModel.fromMap::::$item');
//         arr.add(TvListResDataModel.fromMap(item));
//       }
//     }
//     return TvListResModel(
//       code: map['code'],
//       msg: map['msg'],
//       data: arr
//     );
//   }
// }

class TvListResDataModel {
  String category;
  String name;
  List<TvListModel> data;

  TvListResDataModel(
      {required this.category, required this.name, required this.data});

  factory TvListResDataModel.fromMap(Map<String, dynamic> map) {
    // print('TvListModel.fromMap:::map::$map');
    List<TvListModel> arr = [];
    if (map['data'] != null) {
      for (final item in map['data']) {
        // print('TvListModel.fromMap:::::$item');
        arr.add(TvListModel.fromMap(item));
      }
    }
    return TvListResDataModel(
      category: map['key'],
      name: map['name'],
      data: arr,
    );
  }
}

class TvListModel {
  int id;
  String name;
  String type;
  String note;
  String last;
  String dt;

  TvListModel(
      {required this.id,
      required this.name,
      required this.type,
      required this.note,
      required this.last,
      required this.dt});

  factory TvListModel.fromMap(Map<String, dynamic> map) {
    return TvListModel(
        id: map['id'],
        name: map['name'],
        type: map['type'],
        note: map['note'],
        last: map['last'],
        dt: map['dt']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'note': note,
    };
  }
}

class TvDetailEpisodesModel {
  String label;
  String url;

  TvDetailEpisodesModel({required this.label, required this.url});

  factory TvDetailEpisodesModel.fromMap(Map<String, dynamic> map) {
    return TvDetailEpisodesModel(label: map['label'], url: map['url']);
  }
}

class TvDetailModel {
  String? pic;
  String? name;
  String? totalNumberOfEpisodes;
  String? subname;
  String? type;
  int? year;
  String? area;
  String? director;
  String? actor;
  String? briefIntroduction;
  List<TvDetailEpisodesModel> dataList;

  TvDetailModel(
      {this.pic,
      this.name,
      this.totalNumberOfEpisodes,
      this.subname,
      this.type,
      this.year,
      this.area,
      this.director,
      this.actor,
      this.briefIntroduction,
      required this.dataList});

  factory TvDetailModel.fromMap(Map<String, dynamic> map) {
    List<TvDetailEpisodesModel> arr = [];
    if (map['dataList'] != null) {
      for (final item in map['dataList']) {
        arr.add(TvDetailEpisodesModel.fromMap(item));
      }
    }
    return TvDetailModel(
        pic: map['pic'],
        name: map['name'],
        totalNumberOfEpisodes: map['note'],
        subname: map['subname'],
        type: map['type'],
        year: map['year'],
        area: map['area'],
        director: map['director'],
        actor: map['actor'],
        briefIntroduction: map['des'],
        dataList: arr);
  }
}
