// Object-Oriented Programming in Dart: Extend and Implement

// Base class (superclass)
class Animal {
  String name;
  int age;

  Animal(this.name, this.age);

  void eat() {
    print('$name is eating.');
  }

  void sleep() {
    print('$name is sleeping.');
  }

  void makeSound() {
    print('$name makes a sound.');
  }
}

// Extending a class (inheritance)
// Dog inherits from Animal
class Dog extends Animal {
  String breed;

  Dog(String name, int age, this.breed) : super(name, age);

  // Override a method from the parent class
  @override
  void makeSound() {
    print('$name barks: Woof!');
  }

  // Add a new method specific to Dog
  void fetch() {
    print('$name is fetching the ball.');
  }
}

// Interface (abstract class with only abstract methods)
// In Dart, interfaces are implemented using abstract classes
abstract class Flyable {
  void fly();
  void land();
}

// Implementing an interface
// Bird implements Flyable
class Bird implements Flyable {
  String name;

  Bird(this.name);

  @override
  void fly() {
    print('$name is flying high!');
  }

  @override
  void land() {
    print('$name is landing gracefully.');
  }

  void chirp() {
    print('$name chirps: Tweet!');
  }
}

// A class that extends and implements
// Eagle extends Animal and implements Flyable
class Eagle extends Animal implements Flyable {
  Eagle(String name, int age) : super(name, age);

  @override
  void makeSound() {
    print('$name screeches: Scree!');
  }

  @override
  void fly() {
    print('$name soars through the sky!');
  }

  @override
  void land() {
    print('$name perches on a branch.');
  }
}

// Multiple inheritance simulation using mixins
// Mixins allow code reuse without inheritance
mixin Swimmable {
  void swim() {
    print('Swimming in the water.');
  }
}

class Duck extends Animal with Swimmable implements Flyable {
  Duck(String name, int age) : super(name, age);

  @override
  void makeSound() {
    print('$name quacks: Quack!');
  }

  @override
  void fly() {
    print('$name flies low over the pond.');
  }

  @override
  void land() {
    print('$name splashes into the water.');
  }
}

void main() {
  print('=== OOP Examples: Extend and Implement ===\n');

  // Using inheritance (extend)
  print('1. Inheritance (extends):');
  Dog dog = Dog('Buddy', 3, 'Golden Retriever');
  dog.eat();
  dog.makeSound();
  dog.fetch();
  dog.sleep();
  print('');

  // Using interface (implement)
  print('2. Interface Implementation (implements):');
  Bird bird = Bird('Sparrow');
  bird.fly();
  bird.chirp();
  bird.land();
  print('');

  // Using both extend and implement
  print('3. Extending and Implementing:');
  Eagle eagle = Eagle('Bald Eagle', 5);
  eagle.eat();
  eagle.makeSound();
  eagle.fly();
  eagle.land();
  print('');

  // Using mixin (with)
  print('4. Mixin (with) for multiple inheritance:');
  Duck duck = Duck('Donald', 2);
  duck.eat();
  duck.makeSound();
  duck.swim(); // From mixin
  duck.fly(); // From interface
  duck.land();
}
