//
//  MockReader.swift
//  ComposableExample
//
//  Created by Dursun YILDIZ on 14.10.2022.
//

import Foundation
class MockReader {
    static func loadArray<T: Codable>(name: String) -> [T] {
        if let path = Bundle.main.path(forResource: name, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))

                let result = try JSONDecoder().decode([T].self, from: data)

                return result
            } catch {
                return []
            }
        }

        return []
    }

    static func loadObject<T: Codable>(name: String) -> T? {
        if let path = Bundle.main.path(forResource: name, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))

                let result = try JSONDecoder().decode(T.self, from: data)

                return result
            } catch {
                return nil
            }
        }

        return nil
    }
}
