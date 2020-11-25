

class SportsModel{
  final String id;
  final String name;
  final String format;
  final String image1;
  final String image2;
  final String description;

  SportsModel({
    this.id,
    this.description,
    this.format,
    this.image1,
    this.name,
    this.image2
  });

  factory SportsModel.fromJson(Map<String, dynamic>json){
    return SportsModel(
      id: json['idSport'],
      name: json['strSport'],
      description: json['strSportDescription'],
      image1: json['strSportThumb'],
      image2: json['strSportThumbGreen'],
      format: json['strFormat']
    );
  }

}