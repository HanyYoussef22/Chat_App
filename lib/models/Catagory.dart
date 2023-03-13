class Category {
  static String movesNameId = 'movies';
  static String musicNameId = 'music';
  static String sportNameId = 'sports';

  String id;
  late String name;
  late String image;

  Category(this.id, this.name, this.image);

  Category.fromId(this.id) {
    name = id;
    image = 'assets/$id.jpeg';
  }

  static List<Category> getCategory() {
    return [
      Category.fromId(sportNameId),
      Category.fromId(musicNameId),
      Category.fromId(movesNameId)
    ];
  }
}
