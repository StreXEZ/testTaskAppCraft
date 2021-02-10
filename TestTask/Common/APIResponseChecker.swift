//
//  APIResponseChecker.swift
//  TestTask
//
//  Created by Khusnullin Denis on 10.02.2021.
//

import Foundation
import Alamofire

func checkResponse<T>(response: AFDataResponse<Any>,
                              callback: @escaping (Result<T, APIServiceError>) -> Void) -> Bool {
    if response.response?.statusCode == nil {
        callback(.failure(APIServiceError.nilValueError))
        return false
    } else if response.response?.statusCode == 200,
        response.data != nil {
        return true
    } else if response.response?.statusCode == 401 {
        callback(.failure(APIServiceError.invalidToken))
        return false
    } else {
        callback(.failure(APIServiceError.nilValueError))
        return false
    }
}
