//
//  ErrorAsString.swift
//  Dreamer
//
//  Created by Dylan Mace on 6/16/21.
//

import Foundation

struct RuntimeError: LocalizedError
{
    let message: String

    init(_ message: String)
    {
        self.message = message
    }

    public var errorDescription: String?
    {
        return message
    }
}
