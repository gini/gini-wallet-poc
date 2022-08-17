//
//  NetworkClient+Combine.swift
//  
//
//  Created by Botond Magyarosi on 03.11.2020.
//

import RestBird
import Combine

public struct CombineBase<Base> {
    public let base: Base

    public init(_ base: Base) {
        self.base = base
    }
}

protocol CombineCompatible {
    associatedtype SomeType
    var combine: SomeType { get }
}

extension CombineCompatible {

    var combine: CombineBase<Self> {
        return CombineBase(self)
    }
}

// MARK: - NetworkClient

extension NetworkClient: CombineCompatible { }

extension CombineBase where Base: NetworkClient {

    // MARK: - Data request
    
    func execute<Request: DataRequest>(request: Request) -> Future<Void, Error> where Request.ResponseType == EmptyResponse {
        Future { [base] promise in
            base.execute(request: request) { (result: Swift.Result<Void, Error>) in
                switch result {
                case .success: promise(.success(()))
                case .failure(let error): promise(.failure(error))
                }
            }
        }
    }

    func execute<Request: DataRequest>(request: Request) -> Future<Request.ResponseType, Error> {
        Future { [base] promise in
            base.execute(request: request) { (result: Swift.Result<Request.ResponseType, Error>) in
                switch result {
                case .success(let result): promise(.success(result))
                case .failure(let error): promise(.failure(error))
                }
            }
        }
    }
    
    // MARK: - Multipart
    
    func execute<Request: MultipartRequest>(request: Request) -> Future<Void, Error> where Request.ResponseType == EmptyResponse {
        Future { [base] promise in
            base.execute(request: request, uploadProgress: nil) { (result: Swift.Result<Void, Error>) in
                switch result {
                case .success: promise(.success(()))
                case .failure(let error): promise(.failure(error))
                }
            }
        }
    }
    
    func execute<Request: MultipartRequest>(request: Request) -> Future<Request.ResponseType, Error> {
        Future { promise in
            base.execute(request: request, uploadProgress: nil) { (result: Swift.Result<Request.ResponseType, Error>) in
                switch result {
                case .success(let result): promise(.success(result))
                case .failure(let error): promise(.failure(error))
                }
            }
        }
    }
}
