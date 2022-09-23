class Address {
  String street = '';
  String suburb = '';
  String city = '';
  String postalCode = '';

  Address({String user = ''}) {
    if (user != '') {
      //TODO Get address information from server and remove dummy creation
      street = '1 Test Street';
      suburb = 'Suburbia';
      city = 'Heresville';
      postalCode = '1234';
    }
  }
}
