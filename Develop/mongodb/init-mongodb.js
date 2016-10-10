conn = new Mongo("192.168.1.105");
db = conn.getDB("admin");

db.createUser(
    {
        user: "admin",
        pwd: "123456",
        roles: [{
            role: "userAdminAnyDatabase", db: "admin" 
        }]
    }
);

db = db.getSiblingDB('private');

db.createUser(
    {
        user: "fifman",
        pwd: "123456",
        roles: [{
            role: "readWrite", db: "test" 
        },{
            role: "read", db: "admin" 
        },{
            role: "readWrite", db: "private" 
        }]
    }
);

db2.accounts.bank.ccb.insert({ _id: 1, card_no: 4895920340414134, expire_year: 2020, expire_month: 9, owner_name: "FENG YI CHENG", security_code: 519, type: "visa" })
