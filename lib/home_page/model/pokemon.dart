class Pokemon {
  final String name;
  final String dataUrl;

  Pokemon({required this.name, required this.dataUrl});

  Pokemon.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        dataUrl = json['url'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'url': dataUrl,
      };
}
