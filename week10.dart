import 'dart:async';


abstract class Maintainable {
  Future<void> serviceEngine();
}



mixin GPSNavigable {
  Future<void> navigateTo(String destination) async {
    print('GPS: Searching location...');
    await Future.delayed(Duration(seconds: 1)); // 1-second delay
    print('GPS Navigation: Routing optimal path to "$destination"...\n');
  }
}


abstract class Tricycle implements Maintainable {
  // Encapsulation: Private color property
  String _color;
  bool isEngineRunning = false;


  Tricycle(this._color);

  
  String get color => _color;
  set color(String newColor) {
    if (newColor == 'silver' || newColor == 'black' || newColor == 'white') {
      _color = newColor;
    } else {
      print('Invalid color choice! Choose silver, black, or white.');
    }
  }

  
  Future<void> kickstartEngine() async {
    print('Starting $_color tricycle engine...');
    await Future.delayed(Duration(seconds: 1)); // 1-second delay
    isEngineRunning = true;
    print('The $_color tricycle engine is running: Vroom vroom!\n');
  }

  Future<void> honk() async {
    await Future.delayed(Duration(seconds: 1)); // 1-second delay
    print('The $_color tricycle honks: Beep beep!\n');
  }
}


class PassengerTricycle extends Tricycle {
  int passengerCapacity;

  PassengerTricycle(String color, this.passengerCapacity) : super(color);

  
  @override
  Future<void> honk() async {
    print('Preparing to honk...');
    await Future.delayed(Duration(seconds: 1)); // 1-second delay
    print('Passenger Tricycle ($_color): "BEEP BEEP! Commuters board now!"\n');
  }

  
  @override
  Future<void> serviceEngine() async {
    print('Servicing Passenger Tricycle...');
    await Future.delayed(Duration(seconds: 1)); // 1-second delay
    print('Service Complete: Checked passenger safety & brakes.\n');
  }

  Future<void> loadPassengers(int count) async {
    print('Loading passengers...');
    await Future.delayed(Duration(seconds: 1)); // 1-second delay
    if (count <= passengerCapacity) {
      print('Loaded $count passenger(s) into the sidecar.\n');
    } else {
      print('Overload! Capacity limit is $passengerCapacity passengers.\n');
    }
  }
}


class CargoTricycle extends Tricycle with GPSNavigable {
  double maxCargoKg;

  CargoTricycle(String color, this.maxCargoKg) : super(color);

  
  @override
  Future<void> kickstartEngine() async {
    print('Cargo Tricycle ($_color): Kickstarting heavy duty engine...');
    await Future.delayed(Duration(seconds: 1)); // 1-second delay
    isEngineRunning = true;
    print('Engine roaring! Ready for heavy load.\n');
  }

  
  @override
  Future<void> serviceEngine() async {
    print('Servicing Cargo Tricycle...');
    await Future.delayed(Duration(seconds: 1)); // 1-second delay
    print('Service Complete: Inspected heavy-duty suspension & tires.\n');
  }

  Future<void> loadCargo(double weight) async {
    print('Loading cargo...');
    await Future.delayed(Duration(seconds: 1)); // 1-second delay
    print('Loaded ${weight}kg of cargo (Max capacity: ${maxCargoKg}kg).\n');
  }
}


Future<void> main() async {


  List<Tricycle> fleet = [
    PassengerTricycle('silver', 4),
    CargoTricycle('black', 250.0),
  ];

  for (var tricycle in fleet) {
    print('====================================');
    print('Tricycle Color: ${tricycle.color}');
    print('====================================\n');
    
    
    await tricycle.kickstartEngine();
    await tricycle.honk();
    await tricycle.serviceEngine();

    if (tricycle is PassengerTricycle) {
      await tricycle.loadPassengers(3);
    } else if (tricycle is CargoTricycle) {
      await tricycle.loadCargo(150.0);
      await tricycle.navigateTo('Central Market');
    }
  }

  print('=== DEMO COMPLETED ===');
}
