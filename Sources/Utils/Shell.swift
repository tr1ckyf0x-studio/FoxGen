//
//  Shell.swift
//  
//
//  Created by Vladislav Lisianskii on 10.09.2023.
//

import Foundation

struct Shell {
    @discardableResult
    func run(_ command: String) throws -> String {
        let task = Process()
        let pipe = Pipe()


        task.environment = ProcessInfo.processInfo.environment
        task.standardOutput = pipe
        task.standardError = pipe
        task.arguments = ["-c", command]
        task.executableURL = URL(fileURLWithPath: "/bin/zsh")
        task.standardInput = nil

        try task.run()

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8)!

        return output
    }
}
