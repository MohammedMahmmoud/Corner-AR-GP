class Furniture{
  late String modelName;
  late String modelUrl;
  late String id;
  late String imageUrl;

  Furniture({String modelName=' ',String modelUrl=' ',String id=' ',String imageUrl=' '}){
    this.id = id;
    this.imageUrl = imageUrl;
    this.modelName = modelName;
    this.modelUrl = modelUrl;
  }

  void setModelName(String modelName){
    this.modelName = modelName;
  }
  String getModelName(){
    return this.modelName;
  }
  void setModelUrl(String modelUrl){
    this.modelUrl = modelUrl;
  }
  String getModelUrl(){
    return this.modelUrl;
  }
  void setImageUrl(String imageUrl){
    this.imageUrl = imageUrl;
  }
  String getImageUrl(){
    return this.imageUrl;
  }

  Furniture.fromJson(Map<String, Object?> json)
      : this(
    modelUrl: json['modelUrl']! as String,
    modelName: json['modelName']! as String,
    imageUrl: json['imageUrl']! as String,
    id: json['id']! as String,
  );

  //to write in db
  Map<String, Object?> toJson() {
    return {
      'modelName': modelName,
      'modelUrl': modelUrl,
      'imageUrl': imageUrl,
      'id': id,
    };
  }
}