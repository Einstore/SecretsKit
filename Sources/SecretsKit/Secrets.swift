//
//  Secrets.swift
//  
//
//  Created by Ondrej Rafaj on 15/06/2019.
//

import Vapor
import CryptoKit


/// Secrets class
public class Secrets {
    
    // MARK: Public interface
    
    /// Environmental variable that reads SECRET random data
    public static var envVarName: String = "SECRET"
    
    /// Encrypt into byte array
    /// - Parameter data: Input CryptoData
    public static func encrypt(_ data: CryptoData) throws -> [UInt8] {
        let nonce = try URandom().generateData(count: 12)
        let (ciphertext, tag) = try AES256GCM.encrypt(data, key: .bytes(secret), iv: .bytes(nonce))
        
        var out: [UInt8] = nonce
        out.append(contentsOf: ciphertext.bytes())
        out.append(contentsOf: tag.bytes())
        return out
    }
    
    /// Encrypt into byte array
    /// - Parameter string: String to be encrypted
    public static func encrypt(_ string: String) throws -> [UInt8] {
        return try encrypt(.string(string))
    }
    
    /// Encrypt into byte array
    /// - Parameter data: Data to be encrypted
    public static func encrypt(_ data: Data) throws -> [UInt8] {
        return try encrypt(.data(data))
    }
    
    /// Encrypt into data
    /// - Parameter string: String to be encrypted
    public static func encrypt(asData string: String) throws -> Data {
        let out = try encrypt(string)
        return Data(out)
    }
    
    /// Decrypt into byte array
    /// - Parameter data: Byte array to be decrypted
    public static func decrypt(_ data: [UInt8]) throws -> [UInt8] {
        let nonce = Array(data[0...11])
        let ciphertext = Array(data[12...(data.count - 17)])
        let tag = Array(data[(data.endIndex - 16)...(data.count - 1)])
        
        let out = try AES256GCM.decrypt(.bytes(ciphertext), key: .bytes(secret), iv: .bytes(nonce), tag: .bytes(tag))
        return out.bytes()
    }
    
    /// Decrypt into string
    /// - Parameter data: Byte array to be decrypted
    public static func decrypt(string data: [UInt8]) throws -> String? {
        let bytes = try decrypt(data)
        return String(bytes: bytes, encoding: .utf8)
    }
    
    /// Decrypt into data
    /// - Parameter data: Byte array to be decrypted
    public static func decrypt(data: [UInt8]) throws -> Data? {
        let bytes: [UInt8] = try decrypt(data)
        return Data(bytes)
    }
    
    /// Decrypt into data
    /// - Parameter data: Data to be decrypted
    public static func decrypt(data: Data) throws -> Data? {
        let bytes: [UInt8] = try decrypt(Array(data))
        return Data(bytes)
    }
    
    /// Decrypt into string
    /// - Parameter data: Data to be decrypted
    public static func decrypt(string data: Data) throws -> String? {
        let data = Array(data)
        return try decrypt(string: data)
    }
    
    // MARK: Internal interface
    
    static var secret: [UInt8] {
        let refMessage = "Refer to https://github.com/Einstore/SecretsKit for details."
        guard let secret = Environment.get(envVarName) else {
            if (try? Environment.detect()) == Environment.development {
                return [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32]
            }
            fatalError("Environmental variable \(envVarName) has to be set! \(refMessage)")
        }
        
        guard let baseData = Data(base64Encoded: secret), baseData.count == 32 else {
            fatalError("Invalid \(envVarName). \(refMessage)")
        }
        return Array(baseData)
    }
    
}
