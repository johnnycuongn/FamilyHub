//
//  JsonBundle.swift
//  iOSFamilyHub
//
//  Created by Johnny on 5/9/2023.
//

import Foundation

extension Bundle {
  func decode<T: Decodable>(filename: String, as type: T.Type) -> T {
    guard let url = self.url(forResource: filename, withExtension: nil) else {
      fatalError("Error --> There is no \(filename) in Bundle")
    }
    guard let data = try? Data(contentsOf: url) else {
      fatalError("Error --> Can't load the data from \(url).")
    }
    guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
      fatalError("Error --> Fail to decode data")
    }
    return decodedData
  }
}
