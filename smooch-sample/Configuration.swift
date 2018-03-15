//
//  Configuration.swift
//  smooch-sample
//
//  Created by Danilo Bürger on 15.03.18.
//  Copyright © 2018 Danilo Bürger. All rights reserved.
//

import JWT

struct Configuration {

    static let appId = ""
    static let userId = ""

    // Obivously keyId and secret should not be here, demo only
    static let keyId = ""
    static let secret = ""

    // This should come from the backend
    static func userToken() -> String {
        return JWT.encode(claims: [
            "scope": "appUser",
            "userId": Configuration.userId
        ], algorithm: .hs256(Configuration.secret.data(using: .utf8)!), headers: [
            "kid": Configuration.keyId
        ])
    }

    // This should be only on the backend
    static func appToken() -> String {
        return JWT.encode(claims: [
            "scope": "app",
        ], algorithm: .hs256(Configuration.secret.data(using: .utf8)!), headers: [
            "kid": Configuration.keyId
        ])
    }

}
