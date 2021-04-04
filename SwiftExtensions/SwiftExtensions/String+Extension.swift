//
//  String+Extension.swift
//  SwiftExtensions
//
//  Created by Rahul Mahajan on 4/4/21.
//

import Foundation

enum Direction {
    case forward
    case backward
}

extension String {
    func substring(from direction: Direction, numberOfChars: Int) -> String? {
        guard numberOfChars <= self.count else {
            return nil
        }

        let noOfChars = direction == .forward ? numberOfChars: -(numberOfChars)
        let indexDirection = direction == .forward ? self.startIndex: self.endIndex
        let index = self.index(indexDirection, offsetBy: noOfChars)
        return direction == .forward ? String(self[..<index]): String(self[index...])
    }
    
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,3})$", options: .caseInsensitive)
      let valid = regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
      print("Email validation \(valid)")
        return valid
    }

    // vrify Valid PhoneNumber or Not
    func isValidPhone() -> Bool {

      let regex = try! NSRegularExpression(pattern: "^[0-9]\\d{9}$", options: .caseInsensitive)
      let valid = regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
      print("Mobile validation \(valid)")
        return valid
    }
    
    func maskedEmailString() -> String? {
        let comps = self.split(separator: "@")
        guard self.isValidEmail(),
              comps.count == 2 else {
            return nil
        }

        let userEmailId = String(comps[0])
        let emailHost = String(comps[1])
        let emailIdLength = userEmailId.count
        let canAddOne = emailIdLength % 2 != 0 && emailIdLength > 2
        var noOfChars = (emailIdLength / 2)
        guard let emailSubstring = userEmailId.substring(from: .backward, numberOfChars: noOfChars) else {
            return nil
        }

        noOfChars += canAddOne ? 1 : 0
        let starString = String(repeating: "*", count: emailIdLength - noOfChars)
        
        return starString + emailSubstring + "@" + emailHost
    }
}
