import Foundation
import Unbox

struct User {
    let id: String
    let name: String
}

struct Group {
    let name: String
    let users: [User]
}

extension User: Unboxable {
    init(unboxer: Unboxer) throws {
        self.id = try unboxer.unbox(key: "id")
        self.name = try unboxer.unbox(key: "name")
    }
}

extension Group: Unboxable {
    init(unboxer: Unboxer) throws {
        self.name = try unboxer.unbox(keyPath: "group.name")
        self.users = try unboxer.unbox(keyPath: "group.users")
    }
}

class Sample2 {
    static func fromJson(dictionary: UnboxableDictionary) throws {
        let group: Group = try unbox(dictionary: dictionary)
        group.users.forEach { print($0) }
    }
}
