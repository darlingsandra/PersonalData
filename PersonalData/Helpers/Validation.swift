//
//  Validation.swift
//  PersonalData
//
//  Created by Александра Широкова on 21.11.2022.
//

import UIKit

/// Validate type
enum ValidateType {
    case none
    case adultAge
    case kidAge
}

extension ValidateType {
    /// Validation
    /// - Parameter text: text
    func isValid(text: String?) -> ValidationResult {
        guard let text = text, !text.isEmpty else {
            return ValidationResult(isSuccess: false, error: "поле не может быть пустым")
        }
        
        switch self {
        case .none:
            return ValidationResult()
        case .adultAge:
            let isValid = isValidAdultAge(text: text)
            return ValidationResult(
                isSuccess: isValid,
                error: isValid ? nil : "возраст взрослого 18-120"
            )
        case .kidAge:
            let isValid = isValidKidAge(text: text)
            return ValidationResult(
                isSuccess: isValid,
                error: isValid ? nil : "возраст ребенка 1-18"
            )
        }
    }
    
    /// Keyboard type
    func keyboardType() -> UIKeyboardType {
        switch self {
        case .none:
            return .default
        case .adultAge:
            return .asciiCapableNumberPad
        case .kidAge:
            return .asciiCapableNumberPad
        }
    }
}

private extension ValidateType {
    func isValidAdultAge(text: String) -> Bool {
        guard let value = Int(text) else { return false }
        return (18...120).contains(value)
    }
    
    func isValidKidAge(text: String) -> Bool {
        guard let value = Int(text) else { return false }
        return (1..<18).contains(value)
    }
}

/// Validation result
struct ValidationResult {
    var isSuccess: Bool
    var error: String?
    
    /// Init
    /// - Parameters:
    ///   - isSuccess: success bool. default true
    ///   - error: error string. default nil
    init(isSuccess: Bool = true, error: String? = nil) {
        self.isSuccess = isSuccess
        self.error = error
    }
}
