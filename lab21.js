db.pharmacy.drop()
db.drug.drop()
let pharm = [
    {
        _id: 1,
        name: "HealthCare Pharmacy",
        address: "123 Main Street, Cityville",
        phone: "555-1234",
        drugCosts:[
            {drugName: 'lisinopril', cost: 6.9},
            {drugName: 'acetaminophen', cost: 3.76},
            {drugName: 'amoxicillin', cost: 12.05},
        ]
    },
    {
        _id: 2,
        name: "MediWell Pharmacy",
        address: "456 Oak Avenue, Townsville",
        phone: "555-5678",
        drugCosts:[
            {drugName: 'lisinopril', cost: 7.5},
            {drugName: 'acetaminophen', cost: 3.2},
            {drugName: 'amoxicillin', cost: 12.05},
        ]
    },
    {
        _id: 3,
        name: "City Drugs",
        address: "789 Elm Lane, Metro City",
        phone: "555-9876",
        drugCosts:[
            {drugName: 'lisinopril', cost: 7.8},
            {drugName: 'acetaminophen', cost: 3},
            {drugName: 'amoxicillin', cost: 11},
        ]
    },
]
let meds = [{ _id: 1, name: 'lisinopril' },
{_id: 2, name:'acetaminophen'},
{_id: 3, name: 'amoxicillin'}
]
db.pharmacy.insertMany(pharm)
db.drug.insertMany(meds)


