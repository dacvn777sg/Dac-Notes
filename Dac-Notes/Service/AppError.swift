//
//  AppError.swift
//  Dac-Notes
//
//  Created by Dac Vu on 26/02/2023.
//

import Foundation
enum AppError: Error {
    case configError
    case parseError(Error)
    
    var message: String {
        switch self {
        case .configError:
            return "An unknown error"
        case .parseError(let error):
            return "\(error.localizedDescription)"
        }
    }
}
