class Library {
  final String id;
  final String name;
  final String address;
  final String phone;
  final String mail;
  final String manager;
  final List<WorkingTime> workingTime;
  final String hasWifi;
  final String hasWarmDrinks;
  final String hasComputers;

  const Library({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.mail,
    required this.manager,
    required this.workingTime,
    required this.hasWifi,
    required this.hasWarmDrinks,
    required this.hasComputers,
  });

  factory Library.fromJson(Map<String, dynamic> json) {
    return Library(
      id: json['id'],
      name: json['Naziv'],
      address: json['Adresa'],
      phone: json['Kontakt_telefon'],
      mail: json['Kontakt_mail'],
      manager: json['Voditelj'],
      workingTime: (json['radno_vrijeme'] as List<dynamic>)
          .map((element) =>
              WorkingTime.fromJson(element as Map<String, dynamic>))
          .toList(),
      hasWifi: json['Nudi_wifi'],
      hasWarmDrinks: json['Nudi_tople_napitke'],
      hasComputers: json['Nudi_racunalo'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'Naziv': name,
        'Adresa': address,
        'Kontakt_telefon': phone,
        'Kontakt_mail': mail,
        'Voditelj': manager,
        'radno_vrijeme': workingTime.map((time) => time.toJson()).toList(),
        'Nudi_wifi': hasWifi,
        'Nudi_tople_napitke': hasWarmDrinks,
        'Nudi_racunalo': hasComputers,
      };
}

class WorkingTime {
  final String days;
  final String hours;

  const WorkingTime({
    required this.days,
    required this.hours,
  });

  factory WorkingTime.fromJson(Map<String, dynamic> json) {
    return WorkingTime(
      days: json['dani'],
      hours: json['sati'],
    );
  }

  Map<String, dynamic> toJson() => {
        'dani': days,
        'sati': hours,
      };

  @override
  String toString() => "$days: $hours";
}
