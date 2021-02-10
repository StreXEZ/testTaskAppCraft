//
//  APIError.swift
//  TestTask
//
//  Created by Khusnullin Denis on 10.02.2021.
//

import Foundation

enum APIServiceError: Error, LocalizedError {
    case nilValueError
    case jsonDecodingError
    case invalidToken
    case jsonEncodingError
    case wrongPassword
    case serverResponseCode
    case other(str: String)
    
    var localizedDescription: String {
        switch self {
        case .nilValueError:
            return "Проблемы с сервером"
        case .jsonDecodingError:
            return "Ошибка при получении данных"
        case .jsonEncodingError:
            return "Ошибка при отправке данных"
        case .invalidToken:
            return "Ошибка при авторизации. Перезайдите в аккаунт"
        case .wrongPassword:
            return "Неправильный пароль/логин"
        case .other(let str):
            return str
        case .serverResponseCode:
            return ""
        }
    }
}
