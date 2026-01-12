// OOP Benefits: Real-World Example - E-Commerce System
// This file demonstrates why OOP is beneficial in real-life applications

// import 'dart:collection';

// ==========================================
// PROCEDURAL APPROACH (HARD TO MAINTAIN)
// ==========================================
// Everything is in one place - functions and data mixed together
// This becomes messy as the application grows

// Global variables (data scattered everywhere)
List<String> productNames = [];
List<double> productPrices = [];
List<int> productStocks = [];
List<String> customerNames = [];
List<String> customerEmails = [];
List<double> customerBalances = [];
List<String> orderIds = [];
List<String> orderCustomers = [];
List<String> orderProducts = [];
List<double> orderTotals = [];

// Functions that operate on global data
void addProduct(String name, double price, int stock) {
  productNames.add(name);
  productPrices.add(price);
  productStocks.add(stock);
}

void addCustomer(String name, String email, double balance) {
  customerNames.add(name);
  customerEmails.add(email);
  customerBalances.add(balance);
}

void createOrder(String customerEmail, String productName, int quantity) {
  // Find customer index
  int customerIndex = customerEmails.indexOf(customerEmail);
  if (customerIndex == -1) {
    print('Customer not found!');
    return;
  }

  // Find product index
  int productIndex = productNames.indexOf(productName);
  if (productIndex == -1) {
    print('Product not found!');
    return;
  }

  // Check stock
  if (productStocks[productIndex] < quantity) {
    print('Insufficient stock!');
    return;
  }

  // Check customer balance
  double total = productPrices[productIndex] * quantity;
  if (customerBalances[customerIndex] < total) {
    print('Insufficient balance!');
    return;
  }

  // Process order (update global data)
  productStocks[productIndex] -= quantity;
  customerBalances[customerIndex] -= total;

  String orderId = 'ORD${orderIds.length + 1}';
  orderIds.add(orderId);
  orderCustomers.add(customerEmail);
  orderProducts.add(productName);
  orderTotals.add(total);

  print('Order $orderId created successfully!');
}

void displayInventory() {
  print('\n=== INVENTORY ===');
  for (int i = 0; i < productNames.length; i++) {
    print(
      '${productNames[i]}: \$${productPrices[i]} (${productStocks[i]} in stock)',
    );
  }
}

void displayCustomers() {
  print('\n=== CUSTOMERS ===');
  for (int i = 0; i < customerNames.length; i++) {
    print(
      '${customerNames[i]} (${customerEmails[i]}): \$${customerBalances[i]}',
    );
  }
}

// ==========================================
// OOP APPROACH (ORGANIZED AND MAINTAINABLE)
// ==========================================
// Data and behavior are encapsulated in classes
// Easy to extend, modify, and maintain

// Abstract class example: defines a blueprint for purchasable items
abstract class Purchasable {
  String get name;
  double get price;
  int get stock;
  bool isAvailable(int quantity);
  double getTotalPrice(int quantity);
  void reduceStock(int quantity);
}

class Product extends Purchasable {
  String name;
  double price;
  int stock;

  Product(this.name, this.price, this.stock);

  bool isAvailable(int quantity) => stock >= quantity;

  void reduceStock(int quantity) {
    if (isAvailable(quantity)) {
      stock -= quantity;
    }
  }

  double getTotalPrice(int quantity) => price * quantity;

  @override
  String toString() => '$name: \$${price} (${stock} in stock)';
}

class Customer {
  String name;
  String email;
  double balance;

  Customer(this.name, this.email, this.balance);

  bool canAfford(double amount) => balance >= amount;

  void deductBalance(double amount) {
    if (canAfford(amount)) {
      balance -= amount;
    }
  }

  @override
  String toString() => '$name ($email): \$${balance}';
}

class Order {
  static int _orderCounter = 1;
  String orderId;
  Customer customer;
  Product product;
  int quantity;
  double totalAmount;
  DateTime orderDate;

  Order(this.customer, this.product, this.quantity)
    : orderId = 'ORD${_orderCounter++}',
      totalAmount = product.getTotalPrice(quantity),
      orderDate = DateTime.now();

  bool canProcess() {
    return product.isAvailable(quantity) && customer.canAfford(totalAmount);
  }

  void process() {
    if (canProcess()) {
      product.reduceStock(quantity);
      customer.deductBalance(totalAmount);
      print('Order $orderId processed successfully!');
    } else {
      print('Cannot process order $orderId');
    }
  }

  @override
  String toString() {
    return 'Order $orderId: ${customer.name} ordered $quantity x ${product.name} for \$${totalAmount}';
  }
}

class Inventory {
  List<Product> products = [];

  void addProduct(Product product) {
    products.add(product);
  }

  Product? findProduct(String name) {
    return products.where((p) => p.name == name).firstOrNull;
  }

  void display() {
    print('\n=== OOP INVENTORY ===');
    for (var product in products) {
      print(product);
    }
  }
}

class CustomerDatabase {
  List<Customer> customers = [];

  void addCustomer(Customer customer) {
    customers.add(customer);
  }

  Customer? findCustomer(String email) {
    return customers.where((c) => c.email == email).firstOrNull;
  }

  void display() {
    print('\n=== OOP CUSTOMERS ===');
    for (var customer in customers) {
      print(customer);
    }
  }
}

class OrderSystem {
  Inventory inventory;
  CustomerDatabase customerDb;
  List<Order> orders = [];

  OrderSystem(this.inventory, this.customerDb);

  Order? createOrder(String customerEmail, String productName, int quantity) {
    Customer? customer = customerDb.findCustomer(customerEmail);
    Product? product = inventory.findProduct(productName);

    if (customer == null) {
      print('Customer not found!');
      return null;
    }

    if (product == null) {
      print('Product not found!');
      return null;
    }

    Order order = Order(customer, product, quantity);
    orders.add(order);
    return order;
  }

  void processOrder(Order order) {
    order.process();
  }

  void displayOrders() {
    print('\n=== ORDERS ===');
    for (var order in orders) {
      print(order);
    }
  }
}

// ==========================================
// BENEFITS DEMONSTRATION
// ==========================================

void demonstrateProceduralApproach() {
  print('=== PROCEDURAL APPROACH ===');
  print('Problems:');
  print('- Global variables everywhere');
  print('- Functions tightly coupled to data');
  print('- Hard to modify or extend');
  print('- Error-prone (index mismatches)');
  print('- No data validation');
  print('');

  // Setup data
  addProduct('Laptop', 999.99, 10);
  addProduct('Mouse', 25.99, 50);
  addCustomer('John Doe', 'john@email.com', 1500.00);
  addCustomer('Jane Smith', 'jane@email.com', 800.00);

  // Try to create orders
  createOrder('john@email.com', 'Laptop', 1);
  createOrder('jane@email.com', 'Mouse', 2);
  createOrder(
    'john@email.com',
    'Mouse',
    100,
  ); // Should fail - insufficient stock

  displayInventory();
  displayCustomers();
}

void demonstrateOOPApproach() {
  print('\n=== OBJECT-ORIENTED APPROACH ===');
  print('Benefits:');
  print('- Data and behavior encapsulated together');
  print('- Easy to extend and modify');
  print('- Built-in validation and error handling');
  print('- Clear relationships between objects');
  print('- Reusable components');
  print('');

  // Setup OOP system
  Inventory inventory = Inventory();
  CustomerDatabase customerDb = CustomerDatabase();
  OrderSystem orderSystem = OrderSystem(inventory, customerDb);

  // Add products and customers
  inventory.addProduct(Product('Laptop', 999.99, 10));
  inventory.addProduct(Product('Mouse', 25.99, 50));
  customerDb.addCustomer(Customer('John Doe', 'john@email.com', 1500.00));
  customerDb.addCustomer(Customer('Jane Smith', 'jane@email.com', 800.00));

  // Create and process orders
  Order? order1 = orderSystem.createOrder('john@email.com', 'Laptop', 1);
  Order? order2 = orderSystem.createOrder('jane@email.com', 'Mouse', 2);
  Order? order3 = orderSystem.createOrder(
    'john@email.com',
    'Mouse',
    100,
  ); // Should fail

  if (order1 != null) orderSystem.processOrder(order1);
  if (order2 != null) orderSystem.processOrder(order2);
  if (order3 != null) orderSystem.processOrder(order3);

  inventory.display();
  customerDb.display();
  orderSystem.displayOrders();
}

void main() {
  print('WHY USE OOP? REAL-WORLD BENEFITS DEMONSTRATION\n');

  demonstrateProceduralApproach();
  demonstrateOOPApproach();

  print('\n=== KEY BENEFITS OF OOP ===');
  print('1. MODULARITY: Code is organized into logical units (classes)');
  print('2. REUSABILITY: Classes can be reused in different contexts');
  print(
    '3. MAINTAINABILITY: Easy to modify and extend without breaking other parts',
  );
  print('4. SCALABILITY: Can handle growing complexity better');
  print(
    '5. DATA PROTECTION: Encapsulation prevents accidental data corruption',
  );
  print('6. ABSTRACTION: Hide complex implementation details');
  print('7. POLYMORPHISM: Write flexible, generic code');
  print('8. REAL-WORLD MODELING: Objects represent real entities naturally');

  print('\n=== WHEN TO USE OOP ===');
  print('- Large applications with complex data relationships');
  print('- Team development (clear separation of concerns)');
  print('- Applications that need to evolve over time');
  print('- Systems requiring high maintainability');
  print('- When modeling real-world entities and their interactions');
}
