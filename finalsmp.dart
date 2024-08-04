import 'dart:io';

// Function to save all data to a file
void saveData(List<Product> productlist, List<Customer> customerlist, List<Purchaseproduct> purchaselist) {
  final file = File('data.txt');
  final sink = file.openWrite();

  // Write products
  sink.writeln('Products');
  for (var p in productlist) {
    sink.writeln('${p.pid}|${p.pname}|${p.price}');
  }

  // Write customers
  sink.writeln('Customers');
  for (var c in customerlist) {
    sink.writeln('${c.cid}|${c.cname}|${c.cemail}');
  }

  // Write purchases
  sink.writeln('Purchases');
  for (var p in purchaselist) {
    sink.writeln('${p.customerid}|${p.productid}|${p.price}');
  }

  sink.close();
}

// Function to load all data from a file
void loadData(List<Product> productlist, List<Customer> customerlist, List<Purchaseproduct> purchaselist) {
  final file = File('data.txt');
  if (!file.existsSync()) return;

  final lines = file.readAsLinesSync();
  String? section;

  for (var line in lines) {
    if (line == 'Products') {
      section = 'products';
    } else if (line == 'Customers') {
      section = 'customers';
    } else if (line == 'Purchases') {
      section = 'purchases';
    } else {
      final parts = line.split('|');
      if (section == 'products') {
        productlist.add(Product(pid: parts[0], pname: parts[1], price: double.tryParse(parts[2]) ?? 0.0));
      } else if (section == 'customers') {
        customerlist.add(Customer(cid: parts[0], cname: parts[1], cemail: parts[2]));
      } else if (section == 'purchases') {
        purchaselist.add(Purchaseproduct(customerid: parts[0], productid: parts[1], price: double.tryParse(parts[2]) ?? 0.0));
      }
    }
  }
}

// Your existing functions, modified slightly if necessary
void addproducts(List<Product> productlist) {
  print("How many products do you want to add?");
  stdout.write("Answer: ");
  int n = int.parse(stdin.readLineSync()!);
  for (var i = 0; i < n; i++) {
    print("Product ${i + 1}:");
    stdout.write("Enter Product ID: ");
    String pid = stdin.readLineSync()!;
    stdout.write("Enter Product Name: ");
    String pname = stdin.readLineSync()!;
    stdout.write("Enter Product Price: ");
    double price = double.parse(stdin.readLineSync()!);
    productlist.add(Product(pid: pid, pname: pname, price: price));
    print("Product Successfully Added\n");
    print("ProductID: ${pid}, ProductName: ${pname}, ProductPrice: ${price}");
  }
  print("\nAll Products added successfully\n");
  displayproducts(productlist);
}

void Updateproducts(List<Product> productlist) {
  displayproducts(productlist);
  print("\nHow many products do you want to update?");
  stdout.write("Answer: ");
  int nu = int.parse(stdin.readLineSync()!);

  for (int i = 0; i < nu; i++) {
    print("\nUpdate Product ${i + 1}:");
    stdout.write("Enter Product ID to Update: ");
    String pid = stdin.readLineSync()!;
    var pindex = productlist.indexWhere((Product product) => product.pid == pid);
    
    if (pindex == -1) {
      print('Product not found. Skipping this update.');
      continue;
    }
    
    stdout.write("Enter New Product Name: ");
    String pname = stdin.readLineSync()!;
    stdout.write("Enter New Product Price: ");
    double price = double.parse(stdin.readLineSync()!);

    productlist[pindex] = Product(pid: pid, pname: pname, price: price);
    print("Product ${i + 1} Successfully Updated");
    print("ProductID: ${pid}, ProductName: ${pname}, ProductPrice: ${price}");
  }

  print("\nAll products have been updated.");
  displayproducts(productlist);
}

void deleteproducts(List<Product> productlist) {
  print("How many products do you want to delete?");
  stdout.write("Answer: ");
  int numberOfDeletions = int.parse(stdin.readLineSync()!);

  for (int i = 0; i < numberOfDeletions; i++) {
    displayproducts(productlist);
    print("\nDelete Product ${i + 1}:");
    stdout.write("Enter Product ID to Delete: ");
    String pid = stdin.readLineSync()!;
    var pindex = productlist.indexWhere((Product product) => product.pid == pid);

    if (pindex == -1) {
      print('Product not found. Skipping this deletion.');
      continue;
    }

    productlist.removeAt(pindex);
    print("Product ${i + 1} Successfully Deleted");
  }

  print("\nAll specified products have been deleted.");
  displayproducts(productlist);
}

void displayproducts(List<Product> productlist) {
  if (productlist.isEmpty) {
    print('No products to display.');
    return;
  }

  print('All Products:');
  for (var product in productlist) {
    print("ID: ${product.pid}, Name: ${product.pname}, Price: ${product.price}");
  }
}

void addcustomers(List<Customer> customerlist) {
  print("How many customers do you want to add?");
  stdout.write("Answer: ");
  int ca = int.parse(stdin.readLineSync()!);
  for (var i = 0; i < ca; i++) {
    print("Customer ${i + 1}:");
    stdout.write("Enter Customer ID: ");
    String cid = stdin.readLineSync()!;
    stdout.write("Enter Customer Name: ");
    String cname = stdin.readLineSync()!;
    stdout.write("Enter Customer Email: ");
    String cemail = stdin.readLineSync()!;
    customerlist.add(Customer(cid: cid, cname: cname, cemail: cemail));
    print("Customer Successfully Added\n");
    print("CustomerID: ${cid}, CustomerName: ${cname}, CustomerEmail: ${cemail}");
  }
  print("\nAll Customers added successfully\n");
  viewcustomers(customerlist);
}

void Updatecustomers(List<Customer> customerlist) {
  viewcustomers(customerlist);
  print("\nHow many customers do you want to update?");
  stdout.write("Answer: ");
  int cu = int.parse(stdin.readLineSync()!);
  for (int i = 0; i < cu; i++) {
    print("\nUpdate Customer ${i + 1}:");
    stdout.write("Enter Customer ID to Update: ");
    String cid = stdin.readLineSync()!;
    var cindex = customerlist.indexWhere((Customer customer) => customer.cid == cid);
    
    if (cindex == -1) {
      print('Customer not found. Skipping this update.');
      continue;
    }
    
    stdout.write("Enter New Customer Name: ");
    String cname = stdin.readLineSync()!;
    stdout.write("Enter New Customer Email: ");
    String cemail = stdin.readLineSync()!;
    customerlist[cindex] = Customer(cid: cid, cname: cname, cemail: cemail);
    print("Customer ${i + 1} Successfully Updated");
    print("CustomerID: ${cid}, CustomerName: ${cname}, CustomerEmail: ${cemail}");
  } 
  print("\nAll customers have been updated.");
  viewcustomers(customerlist);  
}

void deletecustomers(List<Customer> customerlist) {
  print("How many customers do you want to delete?");
  stdout.write("Answer: ");
  int cd = int.parse(stdin.readLineSync()!);
  for (int i = 0; i < cd; i++) {
    viewcustomers(customerlist);
    print("\nDelete Customer ${i + 1}:");
    stdout.write("Enter Customer ID to Delete: ");
    String cid = stdin.readLineSync()!;
    var cindex = customerlist.indexWhere((Customer customer) => customer.cid == cid);
    if (cindex == -1) {
      print('Customer not found. Skipping this deletion.');
      continue;
    } 
    customerlist.removeAt(cindex);
    print("Customer ${i + 1} Successfully Deleted");
  }
  print("\nAll specified customers have been deleted.");
  viewcustomers(customerlist);
}

void viewcustomers(List<Customer> customerlist) {
  if(customerlist.isEmpty) {
    print('No customers to display.');
    return;
  }

  print('All Customers:');
  for (var customer in customerlist) {
    print("ID: ${customer.cid}, Name: ${customer.cname}, Email: ${customer.cemail}");
  }
}

bool isValidCustomer(List<Customer> customerlist, String customerid) {
  for (Customer customer in customerlist) {
    if (customer.cid == customerid) {
      return true;
    }
  }
  return false;
}

bool isValidProduct(List<Product> productlist, String productid) {
  for (Product product in productlist) {
    if (product.pid == productid) {
      return true;
    }
  }
  return false;
}

void addpurchases(List<Purchaseproduct> purchaselist, List<Customer> customerlist, List<Product> productlist) {
  print("How many purchases do you want to add?");
  stdout.write("Answer: ");
  int nap = int.parse(stdin.readLineSync()!);
  for (int i = 0; i < nap; i++) {
    print("\nPurchase ${i + 1}:");
    stdout.write("Enter Customer ID: ");
    String customerid = stdin.readLineSync()!;
    stdout.write("Enter Product ID: ");
    String productid = stdin.readLineSync()!;
    if (!isValidCustomer(customerlist, customerid) || !isValidProduct(productlist, productid)) {
      print("Invalid customer or product ID. Skipping purchase.");
      continue;
    }

    stdout.write("Enter Purchase Price: ");
    double price = double.parse(stdin.readLineSync()!);
    purchaselist.add(Purchaseproduct(customerid: customerid, productid: productid, price: price));
    print("Purchase Successfully Added\n");
  }
  print("\nAll Purchases added successfully\n");
  viewpurchases(purchaselist);
}

void Updatepurchases(List<Purchaseproduct> purchaselist) {
  viewpurchases(purchaselist);
  print("\nHow many purchases do you want to update?");
  stdout.write("Answer: ");
  int nup = int.parse(stdin.readLineSync()!);
  for (int i = 0; i < nup; i++) {
    print("Update Purchase ${i + 1}:");
    print("Enter Product ID and Customer ID to Update");
    stdout.write("Product ID: ");
    String proid = stdin.readLineSync()!;
    stdout.write("Customer ID: ");
    String cusid = stdin.readLineSync()!;
    var purindex = purchaselist.indexWhere((Purchaseproduct purchase) => purchase.productid == proid && purchase.customerid == cusid);
    if (purindex == -1) {
      print('Purchase not found. Skipping this update.');
      continue;
    } 
    stdout.write("Enter New Purchase Price: ");
    double price = double.parse(stdin.readLineSync()!);
    purchaselist[purindex] = Purchaseproduct(customerid: cusid, productid: proid, price: price);
    print("Purchase ${i + 1} Successfully Updated");
    print("CustomerID: ${cusid}, ProductID: ${proid}, PurchasePrice: ${price}");
  }
  print("\nAll purchases have been updated.");
  viewpurchases(purchaselist);
}

void deletepurchases(List<Purchaseproduct> purchaselist) {
  print("How many purchases do you want to delete?");
  stdout.write("Answer: ");
  int ndp = int.parse(stdin.readLineSync()!);
  for (int i = 0; i < ndp; i++) {
    print("Enter Product ID and Customer ID to Delete");
    stdout.write("Product ID: ");
    String proid = stdin.readLineSync()!;
    stdout.write("Customer ID: ");
    String cusid = stdin.readLineSync()!;
    var purindex = purchaselist.indexWhere((Purchaseproduct purchase) => purchase.productid == proid && purchase.customerid == cusid);
    if (purindex == -1) {
      print('Purchase not found. Skipping this deletion.');
      continue;
    } 
    purchaselist.removeAt(purindex);
    print("Purchase Successfully Deleted");
  }
  print("\nAll specified purchases have been deleted");
  viewpurchases(purchaselist);
}

void viewpurchases(List<Purchaseproduct> purchaselist) {
  if (purchaselist.isEmpty) {
    print('No purchases to display.');
    return;
  }   
  print('All Purchases:');  
  for (var purchase in purchaselist) {
    print("CustomerID: ${purchase.customerid}, ProductID: ${purchase.productid}, PurchasePrice: ${purchase.price}");
  }
}

void main() {

  String validUsername = "admin";
  String validPassword = "1234";

  print("=== Login ===");
  stdout.write("Enter username: ");
  String username = stdin.readLineSync()!;
  stdout.write("Enter password: ");
  String password = stdin.readLineSync()!;

  if (username == validUsername && password == validPassword) {
    print("\nLogin successful! Welcome, $username.\n");
  List<Product> productlist = [];
  List<Customer> customerlist = [];
  List<Purchaseproduct> purchaselist = [];

  loadData(productlist, customerlist, purchaselist);

  bool isRunning = true;

  while (isRunning) {
    print("\nWelcome to the Super Market");
    print("1. (Products) \t Add products / Update Products / Delete Products");
    print("2. (Customers) \t Add customers / Update customers / Delete customers");
    print("3. (Purchases) \t Add purchases / Update purchases / Delete purchases");
    print("4. View products");
    print("5. View customers");
    print("6. View purchases");  
    print("7. Exit");
    stdout.write("Enter your choice: "); 
    int choice = int.parse(stdin.readLineSync()!);
    switch (choice) {
      case 1:
        bool stayin = true;
        while (stayin) {
          print("\n(Products)\na. Add products \nb. Update Products \nc. Delete Products");
          stdout.write("Enter your choice: ");
          String choice1 = stdin.readLineSync()!;
          if (choice1 == "a") {
            addproducts(productlist);
          } else if (choice1 == "b") {
            Updateproducts(productlist);
          } else if (choice1 == "c") {
            deleteproducts(productlist);
          } else {
            print("Invalid choice");
          }
          stdout.write("Do you want to continue product menu ? (y/n): ");
          String choicee1 = stdin.readLineSync()!;
          if (choicee1 == "n") {
            stayin = false;
          }
        }
        break;

      case 2:
        bool stayin1 = true;
        while (stayin1) {
          print("\n(Customers)\na. Add customer \nb. Update customer \nc. Delete customer");
          stdout.write("Enter your choice: ");
          String choice2 = stdin.readLineSync()!;
          if (choice2 == "a") {
            addcustomers(customerlist);
          } else if (choice2 == "b") {
            Updatecustomers(customerlist);
          } else if (choice2 == "c") {
            deletecustomers(customerlist);
          } else {
            print("Invalid choice");
          }
          stdout.write("Do you want to continue customer menu ? (y/n): ");
          String choicee2 = stdin.readLineSync()!;
          if (choicee2 == "n") {
            stayin1 = false;
          }
        }
        break;

      case 3:
        bool stayin2 = true;
        while (stayin2) {
          print("\n(Purchases)\na. Add purchase \nb. Update purchase \nc. Delete purchase");
          stdout.write("Enter your choice: ");
          String choice3 = stdin.readLineSync()!;
          if (choice3 == "a") {
            addpurchases(purchaselist, customerlist, productlist);
          } else if (choice3 == "b") {
            Updatepurchases(purchaselist);
          } else if (choice3 == "c") {
            deletepurchases(purchaselist);
          } else {
            print("Invalid choice");
          } 
          stdout.write("Do you want to continue purchase menu ? (y/n): ");
          String choicee3 = stdin.readLineSync()!;
          if (choicee3 == "n") {  
            stayin2 = false;
          }
        } 
        break;

      case 4:
        displayproducts(productlist);
        break;
      case 5:
        viewcustomers(customerlist);
        break;
      case 6:
        viewpurchases(purchaselist);
        break;
      case 7:
        isRunning = false;
        break;
      default:
        print('Invalid choice, please try again.');
    }
  }

  saveData(productlist, customerlist, purchaselist);
}
else {
    print("\nInvalid username or password. Exiting.");
  }
}

class Product {
  String pid;
  String? pname;
  double? price;
  Product({required this.pid, this.pname, this.price});
}

class Customer {
  String cid;
  String? cname;
  String? cemail;
  Customer({required this.cid, this.cname, this.cemail});
}

class Purchaseproduct {
  String customerid;
  String productid;
  double? price;
  Purchaseproduct({required this.customerid, required this.productid, this.price});
}
