// Advanced Object-Oriented Programming Concepts in Dart
// This file demonstrates encapsulation, polymorphism, abstraction, and other OOP principles

// ==========================================
// 1. ENCAPSULATION
// ==========================================
// Encapsulation hides internal data and provides controlled access through getters/setters
class BankAccount {
  // Private fields (indicated by underscore prefix)
  String _accountNumber;
  double _balance;
  String _accountHolder;

  // Constructor
  BankAccount(this._accountHolder, this._accountNumber, this._balance);

  // Public getter for account holder (read-only)
  String get accountHolder => _accountHolder;

  // Public getter for account number (read-only)
  String get accountNumber => _accountNumber;

  // Public getter for balance (read-only)
  double get balance => _balance;

  // Public setter for balance with validation
  set balance(double amount) {
    if (amount >= 0) {
      _balance = amount;
    } else {
      print('Error: Balance cannot be negative!');
    }
  }

  // Public methods to interact with the encapsulated data
  void deposit(double amount) {
    if (amount > 0) {
      _balance += amount;
      print('Deposited \$${amount}. New balance: \$${_balance}');
    }
  }

  void withdraw(double amount) {
    if (amount > 0 && amount <= _balance) {
      _balance -= amount;
      print('Withdrew \$${amount}. New balance: \$${_balance}');
    } else {
      print('Error: Insufficient funds or invalid amount!');
    }
  }
}

// ==========================================
// 2. ABSTRACTION
// ==========================================
// Abstract classes define a blueprint with some implementation and some abstract methods
abstract class Shape {
  // Abstract property (must be implemented by subclasses)
  String get name;

  // Concrete property
  String color;

  Shape(this.color);

  // Abstract method (no implementation, must be overridden)
  double calculateArea();

  // Concrete method (has implementation, can be inherited or overridden)
  void displayInfo() {
    print('This is a $color $name');
  }

  // Another concrete method
  void paint(String newColor) {
    color = newColor;
    print('$name is now painted $color');
  }
}

// Concrete implementation of Shape
class Circle extends Shape {
  double radius;

  Circle(this.radius, String color) : super(color);

  @override
  String get name => 'Circle';

  @override
  double calculateArea() {
    return 3.14159 * radius * radius;
  }

  // Additional method specific to Circle
  double calculateCircumference() {
    return 2 * 3.14159 * radius;
  }
}

// Another concrete implementation
class Rectangle extends Shape {
  double width;
  double height;

  Rectangle(this.width, this.height, String color) : super(color);

  @override
  String get name => 'Rectangle';

  @override
  double calculateArea() {
    return width * height;
  }

  // Additional method specific to Rectangle
  bool isSquare() {
    return width == height;
  }
}

// ==========================================
// 3. POLYMORPHISM
// ==========================================
// Polymorphism allows objects of different classes to be treated as objects of a common superclass
class PaymentProcessor {
  // Method that accepts any Shape (polymorphic parameter)
  void processPayment(Shape shape, double pricePerUnit) {
    double area = shape.calculateArea();
    double totalCost = area * pricePerUnit;
    print('Processing payment for ${shape.name}:');
    print('Area: ${area.toStringAsFixed(2)} square units');
    print('Price per unit: \$${pricePerUnit}');
    print('Total cost: \$${totalCost.toStringAsFixed(2)}\n');
  }
}

// ==========================================
// 4. STATIC MEMBERS
// ==========================================
// Static members belong to the class itself, not instances
class MathUtils {
  // Static constant
  static const double PI = 3.14159;

  // Static variable
  static int operationCount = 0;

  // Static method
  static double calculateCircleArea(double radius) {
    operationCount++;
    return PI * radius * radius;
  }

  // Static method
  static double calculateRectangleArea(double width, double height) {
    operationCount++;
    return width * height;
  }

  // Static method to get operation count
  static void printOperationCount() {
    print('Total operations performed: $operationCount');
  }
}

// ==========================================
// 5. COMPOSITION (HAS-A RELATIONSHIP)
// ==========================================
// Composition creates complex objects by combining simpler ones
class Engine {
  String type;
  int horsepower;

  Engine(this.type, this.horsepower);

  void start() {
    print('Engine ($type, ${horsepower}HP) started');
  }

  void stop() {
    print('Engine stopped');
  }
}

class Car {
  String model;
  int year;
  Engine engine; // Composition: Car HAS-A Engine

  Car(this.model, this.year, String engineType, int horsepower)
    : engine = Engine(engineType, horsepower);

  void startCar() {
    print('Starting $year $model...');
    engine.start();
    print('Car is ready to drive!\n');
  }

  void stopCar() {
    print('Stopping $model...');
    engine.stop();
    print('Car stopped.\n');
  }
}

// ==========================================
// 6. FACTORY CONSTRUCTORS
// ==========================================
// Factory constructors can return instances of subclasses or cached instances
abstract class Animal {
  String name;

  Animal(this.name);

  factory Animal.create(String type, String name) {
    switch (type.toLowerCase()) {
      case 'dog':
        return Dog(name);
      case 'cat':
        return Cat(name);
      default:
        return GenericAnimal(name);
    }
  }

  void makeSound();
}

class Dog implements Animal {
  @override
  String name;

  Dog(this.name);

  @override
  void makeSound() {
    print('$name says: Woof!');
  }
}

class Cat implements Animal {
  @override
  String name;

  Cat(this.name);

  @override
  void makeSound() {
    print('$name says: Meow!');
  }
}

class GenericAnimal implements Animal {
  @override
  String name;

  GenericAnimal(this.name);

  @override
  void makeSound() {
    print('$name makes a generic animal sound.');
  }
}

// ==========================================
// MAIN FUNCTION TO DEMONSTRATE ALL CONCEPTS
// ==========================================
void main() {
  print('=== ADVANCED OOP CONCEPTS DEMONSTRATION ===\n');

  // 1. ENCAPSULATION
  print('1. ENCAPSULATION:');
  BankAccount account = BankAccount('John Doe', '123456789', 1000.0);
  print('Account holder: ${account.accountHolder}');
  print('Account number: ${account.accountNumber}');
  print('Initial balance: \$${account.balance}');
  account.deposit(500);
  account.withdraw(200);
  account.balance = -100; // This should fail due to validation
  print('');

  // 2. ABSTRACTION
  print('2. ABSTRACTION:');
  Circle circle = Circle(5.0, 'red');
  Rectangle rectangle = Rectangle(4.0, 6.0, 'blue');

  circle.displayInfo();
  print('Area: ${circle.calculateArea()}');
  print('Circumference: ${circle.calculateCircumference()}');

  rectangle.displayInfo();
  print('Area: ${rectangle.calculateArea()}');
  print('Is square? ${rectangle.isSquare()}');

  circle.paint('green');
  print('');

  // 3. POLYMORPHISM
  print('3. POLYMORPHISM:');
  PaymentProcessor processor = PaymentProcessor();
  processor.processPayment(circle, 2.5); // Circle treated as Shape
  processor.processPayment(rectangle, 1.8); // Rectangle treated as Shape
  print('');

  // 4. STATIC MEMBERS
  print('4. STATIC MEMBERS:');
  double circleArea = MathUtils.calculateCircleArea(3.0);
  double rectArea = MathUtils.calculateRectangleArea(4.0, 5.0);
  print('Circle area: $circleArea');
  print('Rectangle area: $rectArea');
  MathUtils.printOperationCount();
  print('');

  // 5. COMPOSITION
  print('5. COMPOSITION:');
  Car myCar = Car('Toyota Camry', 2023, 'V6', 300);
  myCar.startCar();
  myCar.stopCar();
  print('');

  // 6. FACTORY CONSTRUCTORS
  print('6. FACTORY CONSTRUCTORS:');
  Animal dog = Animal.create('dog', 'Buddy');
  Animal cat = Animal.create('cat', 'Whiskers');
  Animal unknown = Animal.create('bird', 'Tweety');

  dog.makeSound();
  cat.makeSound();
  unknown.makeSound();

  print('\n=== END OF DEMONSTRATION ===');
}
