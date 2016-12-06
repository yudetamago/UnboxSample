import Foundation
import Unbox

struct UserId {
    let value: UUID
}

struct User {
    let id: UserId
    let name: String
}

struct Group {
    let name: String
    let users: [User]
}

/* 明示的に型の変換を渡したいとき */
class UserIdFormatter: UnboxFormatter {
    typealias UnboxRawValue = String
    typealias UnboxFormattedType = UserId
    func format(unboxedValue: UnboxRawValue) -> UnboxFormattedType? {
        guard let uuid = UUID(uuidString: unboxedValue) else { return nil }
        return UserId(value: uuid)
    }
}

/* 暗黙的に型の変換をしたいとき */
extension UserId: UnboxableByTransform {
    typealias UnboxRawValue = String
    static func transform(unboxedValue: UnboxRawValue) -> UserId? {
        guard let uuid = UUID(uuidString: unboxedValue) else { return nil }
        return UserId(value: uuid)
    }
}

extension User: Unboxable {
    init(unboxer: Unboxer) throws {
        // UnboxableByTransformが実装されていればこちらでOK
        self.id = try unboxer.unbox(key: "id")
        
        // 明示的に変換する型を指定したいときはこちら
        // self.id = try unboxer.unbox(key: "id", formatter: UserIdFormatter())
        
        self.name = try unboxer.unbox(key: "name")
    }
}

extension Group: Unboxable {
    init(unboxer: Unboxer) throws {
        self.name = try unboxer.unbox(keyPath: "group.name")
        self.users = try unboxer.unbox(keyPath: "group.users")
    }
}

class Sample3 {
    func fromJson(dictionary: UnboxableDictionary) throws {
        let group: Group = try unbox(dictionary: dictionary)
        group.users.forEach { print($0) }
    }
}
