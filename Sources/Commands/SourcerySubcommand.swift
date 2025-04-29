//
//  SourceryCommand.swift
//  FoxGen
//
//  Created by Dmitry Stavitsky on 29.04.2025.
//

import ArgumentParser
import Foundation

struct SourcerySubcommand: ParsableCommand {

    static var configuration = CommandConfiguration(
        commandName: "sourcery",
        abstract: "Executes sourcery for all sourcery.yml files in project"
    )

    func run() throws {
        let configuration = try ConfigurationLoader().loadConfiguration()
        let shell = Shell()
        let fileFinder = FileFinder()

        let sourceryConfigFiles = fileFinder.filePaths(
            withName: Constants.sourceryFile,
            at: Constants.findRoot,
            options: [.skipsPackageDescendants]
        )

        let sourceryArguments = [
            configuration.executables.sourcery,
            Constants.sourceryCommand
        ].joined(separator: " ")

        for sourceryConfigPath in sourceryConfigFiles {
            let escapedPath = "\"\(sourceryConfigPath)\""
            let command = sourceryArguments.appending(" \(escapedPath)")
            let result = try shell.run(command)
            print(result)
        }
    }
}

extension SourcerySubcommand {
    private enum Constants {
        static let findRoot = "."
        static let sourceryFile = ".sourcery.yml"
        static let sourceryCommand = "--config"
    }
}
