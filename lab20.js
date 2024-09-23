print("\n")
print("------------------------")
print("\n")

db.patients.insertMany([
    { 
        "name": "John", 
        "ssn": "846591037", 
        "age": 10, 
        "address": {
            "street": "6345 Marina Rd",
            "city": "Los Angeles",
            "state": "CA",
            "zipcode": "74859"
        }
    },
    { 
        "name": "Alice", 
        "ssn": "123456789", 
        "age": 20, 
        "address": {
            "street": "123 Main St",
            "city": "New York",
            "state": "NY",
            "zipcode": "10001"
        }
    },
    { 
        "name": "Bob", 
        "ssn": "987654321", 
        "age": 30, 
        "address": {
            "street": "456 Elm St",
            "city": "Chicago",
            "state": "IL",
            "zipcode": "60601"
        }
    }
]);

print("Displaying all documents")
cursor = db.patients.find();
while (cursor.hasNext()){
     doc = cursor.next();
     print(doc);
}
print("\n")

db.patients.replaceOne(
    {age: 30},
    {
        prescriptions : [
            {  rxid:  "RX743009", tradename : "Hydrochlorothiazide"   },
            {  rxid : "RX656003", tradename : "LEVAQUIN", formula : "levofloxacin"  }
       ]      
    }
);


print("Displaying all documents")
cursor = db.patients.find();
while (cursor.hasNext()){
     doc = cursor.next();
     print(doc);
}
print("\n")

print("Printing number 5:")
const five = db.patients.findOne({age: 20})
print(five)
print("\n")

print("Printing number 6:")
const six = db.patients.find(
    {age: {$lt: 25}}
)
print(six)
print("\n")

db.patients.drop();

print("Printing number 9: \n")
cursor = db.customers.find()
zipCounts = []
while (cursor.hasNext()) {
    zip = cursor.next().address.zip
    if (zip.startsWith('9')) {
        zipCounts[zip] = (zipCounts[zip] || 0) + 1; 
    }
}
for (zip in zipCounts) {
    if (zipCounts[zip] >= 2) {
        print(`Zip code: ${zip}, Customer count: ${zipCounts[zip]}`);
    }
}
print("\n")

print("Printing number 10: \n") 
let totalQuantity = 0;
let numOrders = 0;
db.orders.find().forEach(order => {
    numOrders++;
    let orderQuantity = 0;
    order.items.forEach(item => {
        orderQuantity += item.qty;
    });
    totalQuantity += orderQuantity;
});
const averageQuantity = totalQuantity / numOrders;
print("Average quantity per order: " + averageQuantity);
