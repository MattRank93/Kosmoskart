//
//  InsecureURLSessionDelegate.swift
//  Kosmoskart
//
//  Created by Matt R on 4/27/24.
//

import Foundation

class InsecureURLSessionDelegate: NSObject, URLSessionDelegate {
    // Implement URLSessionDelegate methods to allow insecure connections
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        // Allow insecure connections
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
            completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
        }
    }
}
