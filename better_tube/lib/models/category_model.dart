class Category {

  final String name;
  final List<String> channels;
  int numberOfVideos;

  Category({this.name, this.channels}) {
    numberOfVideos = channels.length;
  }

}