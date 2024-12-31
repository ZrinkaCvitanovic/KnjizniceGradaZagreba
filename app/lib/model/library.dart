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
      name: json['name'],
      address: json['address'],
      phone: json['phone'],
      mail: json['email'],
      manager: json['manager'],
      workingTime: (json['workingHours'] as List<dynamic>)
          .map((element) => WorkingTime.fromJson(element as Map<String, dynamic>))
          .toList(),
      hasWifi: json['hasWifi'],
      hasWarmDrinks: json['hasWarmDrinks'],
      hasComputers: json['hasComputers'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'address': address,
        'phone': phone,
        'email': mail,
        'manager': manager,
        'workingHours': workingTime.map((time) => time.toJson()).toList(),
        'hasWifi': hasWifi,
        'hasWarmDrinks': hasWarmDrinks,
        'hasComputers': hasComputers,
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
      days: json['days'],
      hours: json['hours'],
    );
  }

  Map<String, dynamic> toJson() => {
        'days': days,
        'hours': hours,
      };

  @override
  String toString() => "$days: $hours";
}
