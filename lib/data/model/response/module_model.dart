class ModuleModel {
  int id;
  String moduleName;
  String moduleType;
  String thumbnail;
  String icon;
  int themeId;
  String description;
  int storesCount;
  String createdAt;
  String updatedAt;
  List<ModuleZoneData> zones;

  ModuleModel(
      {this.id,
        this.moduleName,
        this.moduleType,
        this.thumbnail,
        this.storesCount,
        this.icon,
        this.themeId,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.zones,
      });

  ModuleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    moduleName = json['module_name'];
    moduleType = json['module_type'];
    thumbnail = json['thumbnail'];
    icon = json['icon'];
    themeId = json['theme_id'];
    description = json['description'];
    storesCount = json['stores_count'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['zones'] != null) {
      zones = <ModuleZoneData>[];
      json['zones'].forEach((v) => zones.add(new ModuleZoneData.fromJson(v)));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['module_name'] = this.moduleName;
    data['module_type'] = this.moduleType;
    data['thumbnail'] = this.thumbnail;
    data['icon'] = this.icon;
    data['theme_id'] = this.themeId;
    data['description'] = this.description;
    data['stores_count'] = this.storesCount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.zones != null) {
      data['zones'] = this.zones.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class ModuleZoneData {
  int id;
  String name;
  int status;
  String createdAt;
  String updatedAt;
  bool cashOnDelivery;
  bool digitalPayment;

  ModuleZoneData({this.id, this.name, this.status, this.createdAt, this.updatedAt, this.cashOnDelivery, this.digitalPayment});

  ModuleZoneData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    cashOnDelivery = json['cash_on_delivery'];
    digitalPayment = json['digital_payment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['cash_on_delivery'] = this.cashOnDelivery;
    data['digital_payment'] = this.digitalPayment;
    return data;
  }
}
