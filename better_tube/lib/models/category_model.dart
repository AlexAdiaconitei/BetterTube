class Category {

  final String name;
  final List<String> channels;
  final String color;
  int numberOfVideos;

  Category({this.name, this.channels, this.color}) {
    numberOfVideos = channels.length;
  }

}