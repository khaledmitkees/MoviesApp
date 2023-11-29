//
//  NetworkServiceTest.swift
//  MoviesAppTests
//
//  Created by Khaled Mitkees on 29/11/2023.
//

import XCTest

class NetworkServiceTests: XCTestCase {
    var config: URLConfigurationContract!
    
    override func setUp() {
        config = URLConfigurableMock()
    }
    
    override func tearDown() {
        config = nil
    }
    
    func test_whenMockDataPassed_shouldReturnProperResponse() {
        //given
        var completionCallsCount = 0
        
        let expectedResponseData = "Response data".data(using: .utf8)!
        let sut = DefaultNetworkService(
            config: config,
            sessionManager: NetworkSessionManagerMock(
                response: nil,
                data: expectedResponseData,
                error: nil
            )
        )
        //when
        _ = sut.request(endpoint: EndpointMock(path: "http://mock.test.com", method: .get)) { result in
            guard let responseData = try? result.get() else {
                XCTFail("Should return proper response")
                return
            }
            XCTAssertEqual(responseData, expectedResponseData)
            completionCallsCount += 1
        }
        //then
        XCTAssertEqual(completionCallsCount, 1)
    }
    
    func test_whenErrorWithNSURLErrorCancelledReturned_shouldReturnCancelledError() {
        //given
        var completionCallsCount = 0
        
        let cancelledError = NSError(domain: "network", code: NSURLErrorCancelled, userInfo: nil)
        let sut = DefaultNetworkService(config: config, sessionManager: NetworkSessionManagerMock(response: nil,
                                                                                                  data: nil,
                                                                                                  error: cancelledError as Error))
        //when
        _ = sut.request(endpoint: EndpointMock(path: "http://mock.test.com", method: .get)) { result in
            do {
                _ = try result.get()
                XCTFail("Should not happen")
            } catch let error {
                guard case NetworkError.cancelled = error else {
                    XCTFail("NetworkError.cancelled not found")
                    return
                }
                
                completionCallsCount += 1
            }
        }
        //then
        XCTAssertEqual(completionCallsCount, 1)
    }

    func test_whenStatusCodeEqualOrAbove400_shouldReturnhasStatusCodeError() {
        //given
        var completionCallsCount = 0
        
        let response = HTTPURLResponse(url: URL(string: "test_url")!,
                                       statusCode: 500,
                                       httpVersion: "1.1",
                                       headerFields: [:])
        let sut = DefaultNetworkService(config: config, sessionManager: NetworkSessionManagerMock(response: response,
                                                                                                  data: nil,
                                                                                                  error: NetworkErrorMock.someError))
        //when
        _ = sut.request(endpoint: EndpointMock(path: "http://mock.test.com", method: .get)) { result in
            do {
                _ = try result.get()
                XCTFail("Should not happen")
            } catch let error {
                if case NetworkError.error(let statusCode, _) = error {
                    XCTAssertEqual(statusCode, 500)
                    completionCallsCount += 1
                }
            }
        }
        //then
        XCTAssertEqual(completionCallsCount, 1)
    }
    
    func test_whenErrorWithNSURLErrorNotConnectedToInternetReturned_shouldReturnNotConnectedError() {
        //given
        var completionCallsCount = 0
        
        let error = NSError(domain: "network", code: NSURLErrorNotConnectedToInternet, userInfo: nil)
        let sut = DefaultNetworkService(config: config, sessionManager: NetworkSessionManagerMock(response: nil,
                                                                                                  data: nil,
                                                                                                  error: error as Error))
        
        //when
        _ = sut.request(endpoint: EndpointMock(path: "http://mock.test.com", method: .get)) { result in
            do {
                _ = try result.get()
                XCTFail("Should not happen")
            } catch let error {
                guard case NetworkError.notConnected = error else {
                    XCTFail("NetworkError.notConnected not found")
                    return
                }
                
                completionCallsCount += 1
            }
        }
        //then
        XCTAssertEqual(completionCallsCount, 1)
    }
        
    func test_whenErrorWithNSURLErrorNotConnectedToInternetReturned_shouldLogThisError() {
        //given
        var completionCallsCount = 0
        
        let error = NSError(domain: "network", code: NSURLErrorNotConnectedToInternet, userInfo: nil)
        let networkErrorLogger = NetworkLoggerMock()
        let sut = DefaultNetworkService(config: config, sessionManager: NetworkSessionManagerMock(response: nil,
                                                                                                  data: nil,
                                                                                                  error: error as Error),
                                        logger: networkErrorLogger)
        //when
        _ = sut.request(endpoint: EndpointMock(path: "http://mock.test.com", method: .get)) { result in
            do {
                _ = try result.get()
                XCTFail("Should not happen")
            } catch let error {
                guard case NetworkError.notConnected = error else {
                    XCTFail("NetworkError.notConnected not found")
                    return
                }
                
                completionCallsCount += 1
            }
        }
        
        //then
        XCTAssertEqual(completionCallsCount, 1)
        XCTAssertTrue(networkErrorLogger.loggedErrors.contains {
            guard case NetworkError.notConnected = $0 else { return false }
            return true
        })
    }
}
