//
//  File.swift
//  
//
//  Created by Noemi Kalman on 18.09.2022.
//

import Alamofire
import Foundation

protocol NetworkService: AnyObject {
    func execute(with request: Request, completion: @escaping (DataResponse<Data, AFError>) -> Void)
}

final class NetworkServiceImpl: NetworkService {
    func execute(with request: Request, completion: @escaping (DataResponse<Data, AFError>) -> Void) {
        let urlString = APIConstants.baseURL + (request.path ?? "")
        let encoding: ParameterEncoding = request.body != nil ? BodyStringEncoding(body: request.body!) : request.parameterEncoding
        
        AF.request(urlString, method: request.method, parameters: Dictionary(), encoding: encoding, headers: request.headers)
            .responseData(completionHandler: { response in
                switch response.result {
                case .success(let data):
                    print(String(decoding: data, as: UTF8.self))
                case .failure(let error):
                    print(error.localizedDescription)
                }
                completion(response)
            })
    }
}

struct BodyStringEncoding: ParameterEncoding {

    private let body: String

    init(body: String) { self.body = body }

    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        guard var urlRequest = urlRequest.urlRequest else { throw Errors.emptyURLRequest }
        guard let data = body.data(using: .utf8) else { throw Errors.encodingProblem }
        urlRequest.httpBody = data
        return urlRequest
    }
}

extension BodyStringEncoding {
    enum Errors: Error {
        case emptyURLRequest
        case encodingProblem
    }
}

extension BodyStringEncoding.Errors: LocalizedError {
    var errorDescription: String? {
        switch self {
            case .emptyURLRequest: return "Empty url request"
            case .encodingProblem: return "Encoding problem"
        }
    }
}
