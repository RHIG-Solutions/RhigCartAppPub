import 'package:rhig_cart_vendor/models/address_model.dart';

import 'input_properties.dart';

class EditAddress {
  InputProperties street = InputProperties();
  InputProperties suburb = InputProperties();
  InputProperties city = InputProperties();
  InputProperties postalCode = InputProperties();

  Address assignValues() {
    Address myAddress = Address();
    myAddress.street = street.getValue();
    myAddress.suburb = suburb.getValue();
    myAddress.city = city.getValue();
    myAddress.postalCode = postalCode.getValue();
    return myAddress;
  }
}
