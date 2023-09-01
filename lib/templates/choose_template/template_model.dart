

class Template{
  String? id;
  String? name;
  String? description;
  String? type;
  String? thumbnail;
  String? personName;
  String? coverImage;
  String? introImage;
  String? introText;
  String? shortMessage;

  String? createdAt;
  String? updatedAt;


  Template(

  {
   this.id,
    this.name,
    this.description,
    this.type,
    this.thumbnail,
    this.personName,
   this.coverImage,
    this.introImage,
    this.introText,
    this.shortMessage,
    this.createdAt,
    this.updatedAt
});
  Template.fromJson(Map<String, dynamic> json) {
    id = json['_id'] != null ? (json['_id']) : null;
    name = json['name'] != null ? (json['name']) : null;
    description = json['description'] != null ? json['description']: null;
    type = json['type'] != null ? (json['type']) : null;
   personName = json['details']['name'] != null ? (json['details']['name']) : ' ';
    coverImage = json['details']['coverImage'] != null ? (json['details']['coverImage']) : ' ';
    introText = json['details']['introText'] != null ? (json['details']['introText']) : null;
    introImage = json['details']['introImage'];
    shortMessage = json['details']['shortMessage'];
    createdAt= json['is_private'];
    updatedAt= json['_id'];
    thumbnail = json['thumbnail'];


  }
}