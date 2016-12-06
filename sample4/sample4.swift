import Foundation
import Unbox

class Sample4 {
    func printIdAndName(dictionary: UnboxableDictionary) throws {
        let pair: (UserId, String) = try Unboxer.performCustomUnboxing(dictionary: dictionary, closure: { unboxer in
            let id: UserId = try unboxer.unbox(key: "id", formatter: UserIdFormatter())
            let name: String = try unboxer.unbox(key: "name")
            return (id, name)
        })
        print(pair)
    }
    
    func getNames(dictionary: UnboxableDictionary) throws -> [String] {
        return try Unboxer.performCustomUnboxing(dictionary: dictionary, closure: { unboxer in
            let users: [UnboxableDictionary] = try unboxer.unbox(keyPath: "group.users")
            return try Unboxer.performCustomUnboxing(array: users, closure: { unboxer in
                return unboxer.unbox(key: "name")
            })
        })
    }
}
