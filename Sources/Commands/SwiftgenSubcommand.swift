//
//  SwiftgenSubcommand.swift
//  
//
//  Created by Vladislav Lisianskii on 10.09.2023.
//

import ArgumentParser
import Foundation

struct SwiftgenSubcommand: ParsableCommand {

    static var configuration = CommandConfiguration(
        commandName: "swiftgen",
        abstract: "Executes swiftgen for all .swiftgen files in project"
    )

    func run() throws {
        let configuration = try ConfigurationLoader().loadConfiguration()

        let shell = Shell()

        let findCommand = [
            Constants.find,
            Constants.findRoot,
            Constants.findArguments
        ].joined(separator: " ")

        let swiftgenConfigFiles = try shell.run(findCommand).split(whereSeparator: \.isNewline)

        let swiftgenArguments = [
            configuration.executables.swiftgen,
            Constants.swiftgenCommand
        ].joined(separator: " ")

        for swiftgenConfigPath in swiftgenConfigFiles {
            let command = swiftgenArguments.appending(" \(swiftgenConfigPath)")
            let result = try shell.run(command)
            print(result)
        }
    }
}

extension SwiftgenSubcommand {
    private enum Constants {
        static let find = "find"
        static let findRoot = "."
        static let findArguments = "-name swiftgen.yml"
        static let swiftgenCommand = "config run --config"
    }
}
