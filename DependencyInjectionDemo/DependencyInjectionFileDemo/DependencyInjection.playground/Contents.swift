import UIKit

//MARK: Class , Protocol prepare for description DI

protocol Database {
    func GetData() -> String
}

class DatabaseThingie: Database {
    
    init() { }
    
    func GetData() -> String {
        print("Get Data done")
        return "Data"
    }
}

//MARK: What's Dependency
//new instance is 'Dependency'
var myDatabase : DatabaseThingie = DatabaseThingie()

//MARK: Dependency Non-Injection
//you can look case by delete comment for look sample Dependency Non-Injection
/*
class ExampleShopWeapon {

    private var myDatabase : DatabaseThingie
    var dataTest: String = ""
 
    init() {
        //new Instance
        myDatabase = DatabaseThingie()
    }

    func doStuff() {
 dataTest = myDatabase.GetData()
    }
}
 */

//MARK:  Dependency Injection
class ExampleShopWeapon {
    
    private var myDatabase : Database
    var dataTest: String = ""
    
    init(databaseInjectClass: Database) {
        //new Instance
        myDatabase = databaseInjectClass
    }
    
    func doStuff() {
        dataTest = myDatabase.GetData()
    }
}

//use DatabaseThingie() inject in class ExampleShopWeapon
var shop : ExampleShopWeapon = ExampleShopWeapon(databaseInjectClass: DatabaseThingie())



//MARK:  Sudo Code in Test case UnitTest
import XCTest

//class mock
class MockDatabaseThingie: Database {
    func GetData() -> String {
        return "DataTest"
    }
}

//Unittest sudo in Swift
final class ExampleTest: XCTestCase {
    
    func test_doStuff() {
        var mockShop : ExampleShopWeapon = ExampleShopWeapon(databaseInjectClass: MockDatabaseThingie())
        
        mockShop.doStuff()
        XCTAssertTrue(mockShop.dataTest == "DataTest")
    }

}
