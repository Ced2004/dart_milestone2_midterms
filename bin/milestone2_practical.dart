abstract class Maintainable {
  void performMaintenance();
}

mixin GPSLocatable {
  Future<void> trackLocation(String vehicleId) async {
    print('   [GPS SYSTEM]: Connecting to satellite network for $vehicleId...');
    await Future.delayed(Duration(seconds: 2));
    print('   [GPS SUCCESS]: Coordinates synced live for $vehicleId!');
  }
}

abstract class Vehicle implements Maintainable {
  String vehicleId;
  String routeName;
  int passengerCapacity;
  double baseFare;

  double _totalCollectedFare = 0.0;

  Vehicle({
    required this.vehicleId,
    required this.routeName,
    required this.passengerCapacity,
    required this.baseFare,
  });

  double get totalCollectedFare => _totalCollectedFare;

  double calculateFare(int distanceInKm);

  Future<String> processTripPaymentAsync(int distanceInKm, int passengerCount) async {
    print('   [PAYMENT SYSTEM]: Processing payment for $passengerCount passenger(s) on $vehicleId...');
    
    await Future.delayed(Duration(seconds: 2));

    double farePerHead = calculateFare(distanceInKm);
    double totalTripFare = farePerHead * passengerCount;

    _totalCollectedFare += totalTripFare;

    return 'Payment Success! Amount Paid: P${totalTripFare.toStringAsFixed(2)} ($passengerCount passengers x P${farePerHead.toStringAsFixed(2)})';
  }

  void displayInfo() {
    print('ID: $vehicleId | Route: $routeName | Capacity: $passengerCapacity passengers');
  }
}

class TraditionalJeepney extends Vehicle with GPSLocatable {
  TraditionalJeepney({
    required String vehicleId,
    required String routeName,
    required int passengerCapacity,
  }) : super(
          vehicleId: vehicleId,
          routeName: routeName,
          passengerCapacity: passengerCapacity,
          baseFare: 13.00,
        );

  @override
  double calculateFare(int distanceInKm) {
    if (distanceInKm <= 4) return baseFare;
    return baseFare + ((distanceInKm - 4) * 1.75);
  }

  @override
  void performMaintenance() {
    print('   [MAINTENANCE]: Engine oil change and brake pad check completed for $vehicleId.');
  }
}

class ModernElectricJeepney extends Vehicle {
  bool hasAircon;

  ModernElectricJeepney({
    required String vehicleId,
    required String routeName,
    required int passengerCapacity,
    this.hasAircon = true,
  }) : super(
          vehicleId: vehicleId,
          routeName: routeName,
          passengerCapacity: passengerCapacity,
          baseFare: 15.00,
        );

  @override
  double calculateFare(int distanceInKm) {
    double fare = distanceInKm <= 4 ? baseFare : baseFare + ((distanceInKm - 4) * 2.00);
    return hasAircon ? fare + 2.00 : fare;
  }

  @override
  void displayInfo() {
    super.displayInfo();
    print('   Details: Modern E-Jeepney | Airconditioned: $hasAircon');
  }

  @override
  void performMaintenance() {
    print('   [MAINTENANCE]: Lithium battery cell diagnostic and AC service done for $vehicleId.');
  }
}

void main() async {
  print('================================================================');
  print('       NTC PC16 MILESTONE 2: DART LOGIC PRACTICAL EXAM          ');
  print('================================================================\n');

  TraditionalJeepney traditionalJeep = TraditionalJeepney(
    vehicleId: 'TJ-101',
    routeName: 'Quiapo - Espana',
    passengerCapacity: 18,
  );

  ModernElectricJeepney modernJeep = ModernElectricJeepney(
    vehicleId: 'EJ-202',
    routeName: 'Cubao - Divisoria',
    passengerCapacity: 24,
    hasAircon: true,
  );

  List<Vehicle> transitFleet = [traditionalJeep, modernJeep];

  List<dynamic> tripRequests = [
    {'distance': 6, 'passengers': 3},
    {'distance': -2, 'passengers': 4},
    {'distance': 8, 'passengers': 5},
  ];

  print('--- 1. PROCESSING ASYNCHRONOUS FLEET TRANSACTIONS ---');
  
  for (var vehicle in transitFleet) {
    vehicle.displayInfo();

    for (var trip in tripRequests) {
      try {
        int distance = int.parse(trip['distance'].toString());
        int passengers = int.parse(trip['passengers'].toString());

        if (distance <= 0 || passengers <= 0) {
          throw FormatException('Invalid trip parameters: Distance ($distance km) and Passengers ($passengers) must be positive.');
        }

        String receipt = await vehicle.processTripPaymentAsync(distance, passengers);
        print('   -> [SUCCESS]: $receipt');

      } catch (e) {
        print('   -> [ERROR CAUGHT]: $e');
      }
    }

    if (vehicle is GPSLocatable) {
      await (vehicle as GPSLocatable).trackLocation(vehicle.vehicleId);
    }

    vehicle.performMaintenance();
    print('   Total Revenue Earned: P${vehicle.totalCollectedFare.toStringAsFixed(2)}');
    print('----------------------------------------------------------------\n');
  }

  print('================================================================');
  print('         MILESTONE 2 PRACTICAL EXAM EXECUTION COMPLETE          ');
  print('================================================================');
}
