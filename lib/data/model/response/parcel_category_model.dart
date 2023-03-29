class ParcelCategoryModel {
  int id;
  String image;
  String name;
  String description;
  String createdAt;
  String updatedAt;
  double parcelPerKmShippingCharge;
  double parcelMinimumShippingCharge;

  ParcelCategoryModel({
        this.id,
        this.image,
        this.name,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.parcelPerKmShippingCharge,
        this.parcelMinimumShippingCharge});

  ParcelCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    parcelPerKmShippingCharge = json['parcel_per_km_shipping_charge'] != null ? json['parcel_per_km_shipping_charge'].toDouble() : 0;
    parcelMinimumShippingCharge = json['parcel_minimum_shipping_charge'] != null ? json['parcel_minimum_shipping_charge'].toDouble() : 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['name'] = this.name;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['parcel_per_km_shipping_charge'] = this.parcelPerKmShippingCharge;
    data['parcel_minimum_shipping_charge'] = this.parcelMinimumShippingCharge;
    return data;
  }
}
