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
    );
  }
} 