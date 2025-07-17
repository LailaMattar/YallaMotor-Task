import '../../domain/entities/car_entity.dart';

class CarModel extends CarEntity {
  const CarModel({
    required super.id,
    required super.title,
    required super.price,
    required super.currency,
    required super.year,
    required super.location,
    required super.fuel,
    required super.body,
    required super.image,
    required super.isFavorite,
    required super.mileage,
    required super.color,
    required super.transmission,
    required super.pictures,
    required super.description,
    required super.whatsappNumber,
    required super.sellerName,
    required super.doors,
    required super.seats,
    required super.engineCC,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    // Parse pictures array, fallback to slideshow_picture if pictures is empty
    List<String> picturesList = [];
    if (json['pictures'] != null && json['pictures'] is List) {
      picturesList = List<String>.from(json['pictures']);
    }
    
    // If no pictures available, use slideshow_picture as fallback
    if (picturesList.isEmpty && json['slideshow_picture'] != null) {
      picturesList = [json['slideshow_picture']];
    }

    // Keep the raw HTML description for rendering with flutter_widget_from_html
    String description = json['description'] ?? '';

    // Parse doors - convert to string, handle null/0 values
    String doors = '';
    if (json['doors'] != null) {
      doors = json['doors'].toString();
      if (doors == '0' || doors == 'null') {
        doors = 'N/A';
      }
    } else {
      doors = 'N/A';
    }

    // Parse seats - convert to string, handle null/0 values
    String seats = '';
    if (json['seats'] != null) {
      seats = json['seats'].toString();
      if (seats == '0' || seats == 'null') {
        seats = 'N/A';
      }
    } else {
      seats = 'N/A';
    }

    // Parse engine CC - convert to string, handle null/0 values
    String engineCC = '';
    if (json['engine_cc'] != null) {
      engineCC = json['engine_cc'].toString();
      if (engineCC == '0' || engineCC == 'null') {
        engineCC = 'N/A';
      } else {
        engineCC = '${engineCC}cc';
      }
    } else {
      engineCC = 'N/A';
    }

    return CarModel(
      id: json['id'].toString(),
      title: json['title'] ?? 'Unknown Car',
      price: json['price'].toString(),
      currency: 'AED', // Default currency
      year: json['year'].toString(),
      location: json['city'] ?? 'UAE',
      fuel: json['fuel_type'] ?? 'Petrol',
      body: json['body_style'] ?? 'Unknown',
      image: json['slideshow_picture'] ?? '',
      isFavorite: false, // Default to false since API doesn't have this
      mileage: json['km_driven'].toString(),
      color: json['exterior_color'] ?? 'Unknown',
      transmission: json['transmission_type'] ?? 'Automatic',
      pictures: picturesList,
      description: description,
      whatsappNumber: json['whatsapp_number'] ?? '',
      sellerName: json['seller_name'] ?? 'Unknown Seller',
      doors: doors,
      seats: seats,
      engineCC: engineCC,
    );
  }

  // Helper method to strip HTML tags from description - keeping for potential future use
  static String _stripHtmlTags(String htmlString) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlString.replaceAll(exp, '').replaceAll('&nbsp;', ' ').trim();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'currency': currency,
      'year': year,
      'location': location,
      'fuel': fuel,
      'body': body,
      'image': image,
      'isFavorite': isFavorite,
      'mileage': mileage,
      'color': color,
      'transmission': transmission,
      'pictures': pictures,
      'description': description,
      'whatsapp_number': whatsappNumber,
      'seller_name': sellerName,
      'doors': doors,
      'seats': seats,
      'engine_cc': engineCC,
    };
  }

  factory CarModel.fromEntity(CarEntity entity) {
    return CarModel(
      id: entity.id,
      title: entity.title,
      price: entity.price,
      currency: entity.currency,
      year: entity.year,
      location: entity.location,
      fuel: entity.fuel,
      body: entity.body,
      image: entity.image,
      isFavorite: entity.isFavorite,
      mileage: entity.mileage,
      color: entity.color,
      transmission: entity.transmission,
      pictures: entity.pictures,
      description: entity.description,
      whatsappNumber: entity.whatsappNumber,
      sellerName: entity.sellerName,
      doors: entity.doors,
      seats: entity.seats,
      engineCC: entity.engineCC,
    );
  }
} 