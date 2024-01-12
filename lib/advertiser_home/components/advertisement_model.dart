class AdvertisementModel {
  final String? area;
  final String? contactArea;
  final String? streetName;
  final String? houseNumber;
  final String? websiteLink;
  final int? floor;
  final int? rooms;
  final int? bathrooms;
  final int? residents;
  final String? title;
  final String? otherDetails;
  final int? price;
  final String? phoneNumber;
  late final String? imageUrl;
  final bool? isAvailable;

  AdvertisementModel({
    this.area,
    this.contactArea,
    this.streetName,
    this.houseNumber,
    this.websiteLink,
    this.floor,
    this.rooms,
    this.bathrooms,
    this.residents,
    this.title,
    this.otherDetails,
    this.price,
    this.phoneNumber,
    this.imageUrl,
    this.isAvailable,
  });
}

// ignore: camel_case_types
class AdvertisementModel_01 {
  final String area;
  final String contactArea;
  final String streetName;
  final String houseNumber;
  final String websiteLink;

  AdvertisementModel_01({
    required this.area,
    required this.contactArea,
    required this.streetName,
    required this.houseNumber,
    required this.websiteLink,
  });
}

// ignore: camel_case_types
class AdvertisementModel_02 {
  final AdvertisementModel_01 advertisementModel_01;
  final int floor;
  final int rooms;
  final int bathrooms;
  final int residents;

  AdvertisementModel_02({
    required this.advertisementModel_01,
    required this.floor,
    required this.rooms,
    required this.bathrooms,
    required this.residents,
  });
}

class AdvertisementModel_03 {
  final AdvertisementModel_02 advertisementModel_02;
  final String title;
  final String otherDetails;
  final int price;
  final String phoneNumber;

  AdvertisementModel_03({
    required this.advertisementModel_02,
    required this.title,
    required this.otherDetails,
    required this.price,
    required this.phoneNumber,
  });
}

// ignore: camel_case_types
class AdvertisementModel_04 {
  final AdvertisementModel_02 advertisementModel_03;
  late final String imageUrl;
  final bool isAvailable;

  AdvertisementModel_04({
    required this.advertisementModel_03,
    required this.imageUrl,
    required this.isAvailable,
  });
}
