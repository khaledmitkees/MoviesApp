//
//  DataTransferServiceTests.swift
//  MoviesAppTests
//
//  Created by Khaled Mitkees on 29/11/2023.
//

import XCTest

private struct MockModel: Decodable {
    let name: String
}

final class DataTransferDispatchQueueMock: DataTransferDispatchQueue {
    func asyncExecute(work: @escaping () -> Void) {
        work()
    }
}

final class DataTransferServiceTests: XCTestCase {
    var config: URLConfigurationContract!
    
    override func setUp() {
        config = URLConfigurableMock()
    }
    
    override func tearDown() {
        config = nil
    }
    
    private enum DataTransferErrorMock: Error {
        case someError
    }
    
    func test_whenReceivedValidJsonInResponse_shouldDecodeResponseToDecodableObject() {
        //given
        var completionCallsCount = 0
        
        let responseData = #"{"name": "Hello"}"#.data(using: .utf8)
        let networkService = DefaultNetworkService(
            config: config,
            sessionManager: NetworkSessionManagerMock(
                response: nil,
                data: responseData,
                error: nil
            )
        )
        
        let sut = DefaultDataTransferService(with: networkService)
        //when
        _ = sut.request(
            with: Endpoint<MockModel>(path: "http://mock.endpoint.com", method: .get),
            on: DataTransferDispatchQueueMock()
        ) { result in
            do {
                let object = try result.get()
                XCTAssertEqual(object.name, "Hello")
                completionCallsCount += 1
            } catch {
                XCTFail("Failed decoding MockObject")
            }
        }
        //then
        XCTAssertEqual(completionCallsCount, 1)
    }
    
    func test_whenInvalidResponse_shouldNotDecodeObject() {
        //given
        var completionCallsCount = 0
        
        let responseData = #"{"age": 20}"#.data(using: .utf8)
        let networkService = DefaultNetworkService(
            config: config,
            sessionManager: NetworkSessionManagerMock(
                response: nil,
                data: responseData,
                error: nil
            )
        )
        
        let sut = DefaultDataTransferService(with: networkService)
        //when
        _ = sut.request(
            with: Endpoint<MockModel>(path: "http://mock.endpoint.com", method: .get),
            on: DataTransferDispatchQueueMock()
        ) { result in
            do {
                _ = try result.get()
                XCTFail("Should not happen")
            } catch {
                completionCallsCount += 1
            }
        }
        //then
        XCTAssertEqual(completionCallsCount, 1)
    }
    
    func test_whenBadRequestReceived_shouldRethrowNetworkError() {
        //given
        var completionCallsCount = 0
        
        let responseData = #"{"invalidStructure": "Nothing"}"#.data(using: .utf8)!
        let response = HTTPURLResponse(url: URL(string: "test_url")!,
                                       statusCode: 500,
                                       httpVersion: "1.1",
                                       headerFields: nil)
        let networkService = DefaultNetworkService(
            config: config,
            sessionManager: NetworkSessionManagerMock(
                response: response,
                data: responseData,
                error: DataTransferErrorMock.someError
            )
        )
        
        let sut = DefaultDataTransferService(with: networkService)
        //when
        _ = sut.request(
            with: Endpoint<MockModel>(path: "http://mock.endpoint.com", method: .get),
            on: DataTransferDispatchQueueMock()
        ) { result in
            do {
                _ = try result.get()
                XCTFail("Should not happen")
            } catch let error {
                
                if case DataTransferError.networkFailure(NetworkError.error(statusCode: 500, _)) = error {
                    completionCallsCount += 1
                } else {
                    XCTFail("Wrong error")
                }
            }
        }
        //then
        XCTAssertEqual(completionCallsCount, 1)
    }
    
    func test_whenNoDataReceived_shouldThrowNoDataError() {
        //given
        var completionCallsCount = 0
        
        let response = HTTPURLResponse(url: URL(string: "test_url")!,
                                       statusCode: 200,
                                       httpVersion: "1.1",
                                       headerFields: [:])
        let networkService = DefaultNetworkService(
            config: config,
            sessionManager: NetworkSessionManagerMock(
                response: response,
                data: nil,
                error: nil
            )
        )
        
        let sut = DefaultDataTransferService(with: networkService)
        //when
        _ = sut.request(
            with: Endpoint<MockModel>(path: "http://mock.endpoint.com", method: .get),
            on: DataTransferDispatchQueueMock()
        ) { result in
            do {
                _ = try result.get()
                XCTFail("Should not happen")
            } catch let error {
                if case DataTransferError.noResponse = error {
                    completionCallsCount += 1
                } else {
                    XCTFail("Wrong error")
                }
            }
        }
        //then
        XCTAssertEqual(completionCallsCount, 1)
    }
}
