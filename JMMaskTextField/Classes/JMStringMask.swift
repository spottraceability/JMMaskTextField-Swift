//
//  JMStringMask.swift
//  JMMaskTextField Swift
//
//  Created by Jota Melo on 02/01/17.
//  Copyright © 2017 Jota. All rights reserved.
//

import Foundation

fileprivate struct Constants {
    static let letterMaskCharacter: Character = "S"
    static let numberMaskCharacter: Character = "0"
    static let alphanumericMaskCharacter: Character = "A"
    static let numberMaskCharacterPoundSign: Character = "#"
}

public struct JMStringMask: Equatable {
    
    var mask: String = ""
    
    private init() { }
    
    public init(mask: String) {
        self.init()
        
        self.mask = mask
    }
    
    public static func ==(lhs: JMStringMask, rhs: JMStringMask) -> Bool {
        return lhs.mask == rhs.mask
    }
    
    public func mask(string: String?) -> String? {
        
        guard let string = string else { return nil }

        if string.count > self.mask.count {
            return nil
        }
        
        var formattedString = ""
        
        var currentMaskIndex = 0
        for i in 0..<string.count {
            if currentMaskIndex >= self.mask.count {
                return nil
            }
            
            let currentCharacter = string[string.index(string.startIndex, offsetBy: i)]
            var maskCharacter = self.mask[self.mask.index(string.startIndex, offsetBy: currentMaskIndex)]
            
            if currentCharacter == maskCharacter {
                formattedString.append(currentCharacter)
            } else {
                while (maskCharacter != Constants.letterMaskCharacter
                    && maskCharacter != Constants.numberMaskCharacter
                    && maskCharacter != Constants.alphanumericMaskCharacter)
                    && maskCharacter != Constants.numberMaskCharacterPoundSign
                    && currentMaskIndex < self.mask.count {
                    
                    formattedString.append(maskCharacter)
                    
                    currentMaskIndex += 1
                    if currentMaskIndex < self.mask.count {
                        maskCharacter = self.mask[self.mask.index(string.startIndex, offsetBy: currentMaskIndex)]
                    }
                    else {
                        break
                    }
                }
                
                if maskCharacter != Constants.alphanumericMaskCharacter {
                    let isValidLetter = maskCharacter == Constants.letterMaskCharacter && self.isValidLetterCharacter(currentCharacter)
                    let isValidNumber = maskCharacter == Constants.numberMaskCharacter && self.isValidNumberCharacter(currentCharacter)
                    let isValidNumberWithPoundSign = maskCharacter == Constants.numberMaskCharacterPoundSign && self.isValidNumberCharacter(currentCharacter)
                    
                    if !isValidLetter && !isValidNumber && !isValidNumberWithPoundSign {
                        return nil
                    }
                }
                
                formattedString.append(currentCharacter)
            }
            
            currentMaskIndex += 1
        }
        
        return formattedString
    }
    
    public func unmask(string: String?) -> String? {
        
        guard let string = string else { return nil }
        var unmaskedValue = ""
        
        for character in string {
            if self.isValidLetterCharacter(character) || self.isValidNumberCharacter(character) {
                unmaskedValue.append(character)
            }
        }
        
        return unmaskedValue
    }
    
    private func isValidLetterCharacter(_ character: Character) -> Bool {

        let string = String(character)
        if string.unicodeScalars.count > 1 {
            return false
        }
        
        let lettersSet = NSCharacterSet.letters
        let unicodeScalars = string.unicodeScalars
        return lettersSet.contains(unicodeScalars[unicodeScalars.startIndex])
    }
    
    private func isValidNumberCharacter(_ character: Character) -> Bool {
        
        let string = String(character)
        if string.unicodeScalars.count > 1 {
            return false
        }
        
        let lettersSet = NSCharacterSet.decimalDigits
        let unicodeScalars = string.unicodeScalars
        return lettersSet.contains(unicodeScalars[unicodeScalars.startIndex])
    }
    
}
