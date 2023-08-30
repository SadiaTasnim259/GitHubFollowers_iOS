//
//  ErrorMessage.swift
//  GitHubFollowers
//
//  Created by Sadia on 30/8/23.
//

import Foundation

enum ErrorMessage: String{
    case invalidUsername = "This username created an invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case invalidResponse = "Invalid response from the server. please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
}
