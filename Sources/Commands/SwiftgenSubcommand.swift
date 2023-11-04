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

        let swiftgenConfigFiles = FileFinder().filePaths(withName: Constants.swiftgenFile, at: Constants.findRoot)

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
        static let findRoot = "."
        static let swiftgenFile = "swiftgen.yml"
        static let swiftgenCommand = "config run --config"
    }
}
