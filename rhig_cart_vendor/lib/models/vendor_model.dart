import 'address_model.dart';

class Vendor {
  String firstName = '';
  String lastName = '';
  String cell = '';
  String email = '';
  Address address = Address();
  String password = '';
  bool newsletter = true;
  // Base64 Profile image, if any
  String profileImage = '';

  String getInitials() {
    String initials;
    initials = firstName[0] + lastName[0];
    return initials;
  }

//TODO Sort out JSON and all it entails
//  Dated code below, just starting to figure things out
//   Map<String, dynamic> toJson() => {
//         'firstname': firstName,
//         'lastname': lastName,
//         'cell': cell,
//         'email': email,
//         'street': address.street,
//         'suburb': address.suburb,
//         'city': address.city,
//         'postalcode': address.postalCode,
//         'password': password,
//         'newsletter': newsletter,
//       };

}
