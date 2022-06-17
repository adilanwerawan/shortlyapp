//
//	ShortenURLRoot.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

// MARK: I have tried using codable models but suddenly parsing getting failed from responce of api : https://api.shrtco.de/v2/shorten?url=anyURL
/* MARK: Important note
 After trying couple of things when i have spent much time and tried parsing through Codable, i have implemented manual parsing json which we can enhance later on.
 */
struct ShortenURLRoot : Equatable {
	var ok : Bool! = false
	var result : ShortenURLResult? = nil
}
