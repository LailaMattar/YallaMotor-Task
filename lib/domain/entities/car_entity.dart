import 'package:equatable/equatable.dart';

class CarEntity extends Equatable {
  final String id;
  final String title;
  final String price;
  final String currency;
  final String year;
  final String location;
  final String fuel;
  final String body;
  final String image;
  final bool isFavorite;
  final String mileage;
  final String color;
  final String transmission;
  final List<String> pictures;
  final String description;
  final String whatsappNumber;
  final String sellerName;
  final String doors;
  final String seats;
  final String engineCC;

  const CarEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.currency,
    required this.year,
    required this.location,
    required this.fuel,
    required this.body,
    required this.image,
    required this.isFavorite,
    required this.mileage,
    required this.color,
    required this.transmission,
    required this.pictures,
    required this.description,
    required this.whatsappNumber,
    required this.sellerName,
    required this.doors,
    required this.seats,
    required this.engineCC,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        price,
        currency,
        year,
        location,
        fuel,
        body,
        image,
        isFavorite,
        mileage,
        color,
        transmission,
        pictures,
        description,
        whatsappNumber,
        sellerName,
        doors,
        seats,
        engineCC,
      ];

  CarEntity copyWith({
    String? id,
    String? title,
    String? price,
    String? currency,
    String? year,
    String? location,
    String? fuel,
    String? body,
    String? image,
    bool? isFavorite,
    String? mileage,
    String? color,
    String? transmission,
    List<String>? pictures,
    String? description,
    String? whatsappNumber,
    String? sellerName,
    String? doors,
    String? seats,
    String? engineCC,
  }) {
    return CarEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      year: year ?? this.year,
      location: location ?? this.location,
      fuel: fuel ?? this.fuel,
      body: body ?? this.body,
      image: image ?? this.image,
      isFavorite: isFavorite ?? this.isFavorite,
      mileage: mileage ?? this.mileage,
      color: color ?? this.color,
      transmission: transmission ?? this.transmission,
      pictures: pictures ?? this.pictures,
      description: description ?? this.description,
      whatsappNumber: whatsappNumber ?? this.whatsappNumber,
      sellerName: sellerName ?? this.sellerName,
      doors: doors ?? this.doors,
      seats: seats ?? this.seats,
      engineCC: engineCC ?? this.engineCC,
    );
  }
} 