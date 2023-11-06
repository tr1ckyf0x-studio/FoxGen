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
        let outputPipe = Pipe()

        task.environment = ProcessInfo.processInfo.environment
        task.standardOutput = outputPipe
        task.standardError = outputPipe
        task.arguments = ["-c", command]
        task.executableURL = URL(fileURLWithPath: "/bin/zsh")
        task.standardInput = nil

        try task.run()
        task.waitUntilExit()

        let data = outputPipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8)!

        return output
    }

    func runInteractive(_ command: String) throws {
        let task = Process()
        let outputPipe = Pipe()

        task.environment = ProcessInfo.processInfo.environment
        task.standardOutput = outputPipe
        task.standardError = outputPipe
        task.arguments = ["-c", command]
        task.executableURL = URL(fileURLWithPath: "/bin/zsh")

        outputPipe.fileHandleForReading.readabilityHandler = { (fileHandle: FileHandle) in
            let data = fileHandle.availableData
            if data.isEmpty {
                outputPipe.fileHandleForReading.readabilityHandler = nil
                return
            }
            do {
                try FileHandle.standardOutput.write(contentsOf: data)
            } catch {
                print(error)
            }
        }

        try task.run()
        task.waitUntilExit()
    }
}
