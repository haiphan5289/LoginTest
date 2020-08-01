//
//  Extension.swift
//  LoginProject
//
//  Created by Phan Hai on 31/07/2020.
//  Copyright © 2020 Phan Hai. All rights reserved.
//
import UIKit

public protocol CaseIterable {
    associatedtype AllCases: Collection where AllCases.Element == Self
    static var allCases: AllCases { get }
}
extension CaseIterable where Self: Hashable {
    static var allCases: [Self] {
        return [Self](AnySequence { () -> AnyIterator<Self> in
            var raw = 0
            var first: Self?
            return AnyIterator {
                let current = withUnsafeBytes(of: &raw) { $0.load(as: Self.self) }
                if raw == 0 {
                    first = current
                } else if current == first {
                    return nil
                }
                raw += 1
                return current
            }
        })
    }
}
extension UIViewController {
    func inputUserDefault<T: Encodable>(ofType type: T, key: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(type) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: key)
        }
    }
    func readUserDefault<T: Codable>(offtype type: T.Type, key: String) -> T? {
        let defaults = UserDefaults.standard
        if let savedPerson = defaults.object(forKey: key) as? Data {
            let decoder = JSONDecoder()
            do {
                let loadedPerson = try decoder.decode(T.self, from: savedPerson)
                return loadedPerson
            } catch let err {
                print(err.localizedDescription)
            }
        }
        return ErrorGeneral.self as? T
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
enum UserDefaulStandard: String {
    case userInfo = "userInfo"
    
    var textCode: String {
        return rawValue
    }
}
