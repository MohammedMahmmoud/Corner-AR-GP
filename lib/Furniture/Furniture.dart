class Furniture{
  static const collectionName = "Furniture";
  late String categoryID;
  late String modelName;
  late String modelUrl;
  late String id;
  late String imageUrl;

  Furniture({this.modelName='' ,this.modelUrl='', this.id='', this.imageUrl='', this.categoryID = ''});

  void setModelName(String modelName){
    this.modelName = modelName;
  }
  String getModelName(){
    return modelName;
  }
  void setModelUrl(String modelUrl){
    this.modelUrl = modelUrl;
  }
  String getModelUrl(){
    return modelUrl;
  }
  void setImageUrl(String imageUrl){
    this.imageUrl = imageUrl;
  }
  String getImageUrl(){
    return imageUrl;
  }
  void setId(String id){
    this.id = id;
  }
  String getId(){
    return id;
  }
  void setCategory(String category){
    this.categoryID = category;
  }
  String getCategory(){
    return categoryID;
  }

  Furniture.fromJson(Map<String, Object?> json)
      : this(
    modelUrl: json['modelUrl']! as String,
    modelName: json['modelName']! as String,
    imageUrl: json['imageUrl']! as String,
    id: json['id']! as String,
    categoryID: json['categoryID']! as String,
  );

  //to write in db
  Map<String, Object?> toJson() {
    return {
      'modelName': modelName,
      'modelUrl': modelUrl,
      'imageUrl': imageUrl,
      'id': id,
      'categoryID': categoryID
    };
  }
}