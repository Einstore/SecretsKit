//
//  SecretsTests.swift
//  
//
//  Created by Ondrej Rafaj on 25/06/2019.
//

import XCTest
import SecretsKit
import CryptoKit


final class SecretsTests: XCTestCase {
    
    func testBase64EncodingDecoding() throws {
        let data = try Data(URandom().generateData(count: 128))
        let base64 = data.base64EncodedData()
        let result = Data(base64Encoded: base64)
        XCTAssertEqual(result, data, "Result don't match")
    }
    
    func testEncryptionDecryption() throws {
        let string = "hello"
        let secret = try Secrets.encrypt(string)
        let result = try Secrets.decrypt(string: secret)
        XCTAssertEqual(result, string, "Result don't match")
    }
    
    func testDataEncryptionDecryption() throws {
        let string = "hello"
        let secret = try Secrets.encrypt(asData: string)
        let result = try Secrets.decrypt(string: secret)
        XCTAssertEqual(result, string, "Result don't match")
    }
    
    func testDataObjectEncryptionDecryption() throws {
        let data = "hello".data(using: .utf8)!
        let secret = try Secrets.encrypt(data)
        let result = try Secrets.decrypt(data: secret)
        XCTAssertEqual(result, data, "Result don't match")
    }
    
    static let allTests = [
        ("testBase64EncodingDecoding", testBase64EncodingDecoding),
        ("testEncryptionDecryption", testEncryptionDecryption),
        ("testDataEncryptionDecryption", testDataEncryptionDecryption),
        ("testDataObjectEncryptionDecryption", testDataObjectEncryptionDecryption)
    ]
    
}

