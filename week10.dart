// --- ABSTRACT CLASS / INTERFACE ---
// Contract defining maintenance operations
abstract class Maintainable {
  void serviceEngine();
}

// --- MIXIN ---
// Feature that can be added to any vehicle class
mixin GPSNavigable {
  void navigateTo(String destination) {
    print('GPS Navigation: Routing optimal path to "$destination"...');
  }
}

// --- BASE CLASS (From Week 9) ---
abstract class Tricycle implements Maintainable {
  // Encapsulation: Private color property
  String _color;
  bool isEngineRunning = false;

  // Constructor
  Tricycle(this._color);

  // Getter & Setter
  String get color => _color;
  set color(String newColor) {
    if (newColor == 'silver' || newColor == 'black' || newColor == 'white') {
      _color = newColor;
    } else {
      print('Invalid color choice! Choose silver, black, or white.');
    }
  }

  // Base methods
  void kickstartEngine() {
    isEngineRunning = true;
    print('The $_color tricycle engine is started: Vroom vroom!');
  }

  void honk() {
    print('The $_color tricycle honks: Beep beep!');
  }
}

// --- DERIVED CLASS 1 (Inheritance & Polymorphism) ---
class PassengerTricycle extends Tricycle {
  int passengerCapacity;

  PassengerTricycle(String color, this.passengerCapacity) : super(color);

  // Polymorphism: Overriding honk method
  @override
  void honk() {
    print('Passenger Tricycle ($_color): "BEEP BEEP! Commuters board now!"');
  }

  // Implementation of Abstract Class method
  @override
  void serviceEngine() {
    print('Servicing Passenger Tricycle: Checking passenger safety & brakes.');
  }

  void loadPassengers(int count) {
    if (count <= passengerCapacity) {
      print('Loaded $count passenger(s) into the sidecar.');
    } else {
      print('Overload! Capacity limit is $passengerCapacity passengers.');
    }
  }
}

// --- DERIVED CLASS 2 (Inheritance, Polymorphism & Mixin) ---
class CargoTricycle extends Tricycle with GPSNavigable {
  double maxCargoKg;

  CargoTricycle(String color, this.maxCargoKg) : super(color);

  // Polymorphism: Overriding kickstartEngine method
  @override
  void kickstartEngine() {
    isEngineRunning = true;
    print('Cargo Tricycle ($_color): Heavy duty kickstart initiated. Engine roaring!');
  }

  // Implementation of Abstract Class method
  @override
  void serviceEngine() {
    print('Servicing Cargo Tricycle: Inspecting heavy-duty suspension & tires.');
  }

  void loadCargo(double weight) {
    print('Loaded ${weight}kg of cargo (Max capacity: ${maxCargoKg}kg).');
  }
}

// --- MAIN FUNCTION ---
void main() {
  print('=== WEEK 10: ENHANCED TRICYCLE OOP DEMO ===\n');

  // Polymorphism in action: List of base class pointers storing derived instances
  List<Tricycle> fleet = [
    PassengerTricycle('silver', 4),
    CargoTricycle('black', 250.0),
  ];

  for (var tricycle in fleet) {
    print('--- Tricycle Details ---');
    print('Color: ${tricycle.color}');
    
    // Calls polymorphic methods
    tricycle.kickstartEngine();
    tricycle.honk();
    tricycle.serviceEngine();

    // Type checking for unique derived class behaviors
    if (tricycle is PassengerTricycle) {
      tricycle.loadPassengers(3);
    } else if (tricycle is CargoTricycle) {
      tricycle.loadCargo(150.0);
      // Calling mixin method
      tricycle.navigateTo('Central Market');
    }

    print('');
  }
}
