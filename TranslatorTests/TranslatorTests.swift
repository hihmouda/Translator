//
//  TranslatorTests.swift
//  TranslatorTests
//
//  Created by hadeel on 12/11/18.
//  Copyright © 2018 Hadeel. All rights reserved.
//

import XCTest

@testable import Translator

@testable import ObjectMapper

class TranslatorTests: XCTestCase {

    var sessionUnderTest: URLSession!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
 
        sessionUnderTest = URLSession(configuration: URLSessionConfiguration.default)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sessionUnderTest = nil
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    // Asynchronous test: success fast, failure slow
    func testValidCallAPIGetsHTTPStatusCode200() {
        // given
        let url = URL(string: "https://translate.yandex.net/api/v1.5/tr.json/translate?key=\(AppDefaults.apiKey)&text=Hi&lang=ar")

        let promise = expectation(description: "Status code: 200")
        
        let dataTask = sessionUnderTest.dataTask(with: url!) { data, response, error in
            // then
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
              
                if statusCode == 200 {

                    let responseStr = String(data: data ?? Data(), encoding:String.Encoding.utf8) ?? ""
                    
                    print("the response string is \(responseStr.contains("مرحبا"))")
                
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()

        waitForExpectations(timeout: 5, handler: nil)
    }
}
