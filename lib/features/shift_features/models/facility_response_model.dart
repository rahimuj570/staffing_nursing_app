// {
//         "id": 4,
//         "name": "Jarrod Stewart",
//         "image": null,
//         "address": "Ipsum do eiusmod expedita error",
//         "city": "Atque tempor magna a vel est perferendis sapiente",
//         "state": "Ipsa eiusmod sapiente quaerat dolores atque sit qui nulla occaecat",
//         "latitude": "74.000000",
//         "longitude": "64.000000"
//       },

class FacilityResponseModel {
  int? id;
  String? name;
  String? image;
  String? address;
  String? city;
  String? state;
  String? latitude;
  String? longitude;

  FacilityResponseModel({
    this.image,
    this.id,
    this.name,
    this.address,
    this.city,
    this.state,
    this.latitude,
    this.longitude,
  });

  FacilityResponseModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    id = json['id'];
    name = json['name'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}
