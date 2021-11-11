class Comic {
  final int comicNumber;
  final String img;
  final String title;

  Comic({
    required this.comicNumber,
    required this.img,
    required this.title,
  });

  factory Comic.fromJson(Map<String, dynamic> json) {
    return Comic(
      comicNumber: json['num'],
      img: json['img'],
      title: json['safe_title'],
    );
  }
}
