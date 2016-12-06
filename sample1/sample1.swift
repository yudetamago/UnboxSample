import Foundation
import Unbox

struct User {
    let id: String
    let name: String
}

extension User: Unboxable {
    init(unboxer: Unboxer) throws {
        self.id = try unboxer.unbox(key: "id")
        self.name = try unboxer.unbox(key: "name")
    }
}

class Sample1 {
    static func fromJson(dictionary: UnboxableDictionary) throws {
        let user: User = try unbox(dictionary: dictionary)
        print(user)
    }
}
