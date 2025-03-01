class Citizen {
  final String email;
  final String firstName;
  final String lastName;
  final String contact;
  final String location;
  final String emergencyDetails;

  Citizen({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.contact,
    required this.location,
    required this.emergencyDetails,
  });
}

class NGO {
  final String email;
  final String ngoName;
  final String contactPerson;
  final String registrationNumber;
  final String address;
  final String city;
  final String state;
  final String country;
  final String contact;
  final String website;
  final String missionStatement;

  NGO(
      {required this.email,
      required this.ngoName,
      required this.contactPerson,
      required this.registrationNumber,
      required this.address,
      required this.city,
      required this.state,
      required this.country,
      required this.contact,
      required this.website,
      required this.missionStatement});
}
