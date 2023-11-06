//
//  ViperModuleSubcommand.swift
//  
//
//  Created by Vladislav Lisianskii on 04.11.2023.
//

import ArgumentParser
import Foundation

struct ViperModuleSubcommand: ParsableCommand {

    static var configuration = CommandConfiguration(
        commandName: "viper",
        abstract: "Generates VIPER module"
    )

    func run() throws {
        let configuration = try ConfigurationLoader().loadConfiguration()

        guard let viperConfiguration = configuration.viper else {
            throw Error.invalidViperConfiguration
        }

        let shell = Shell()

        let options = [
            "modules_path": viperConfiguration.modulesPath,
            "developer_name": GitProvider(shell: shell).username,
            "current_date": DateProvider().date
        ]

        let genesisExecutor = GenesisExecutor(
            shell: shell,
            executable: configuration.executables.genesis,
            templatePath: viperConfiguration.templatePath,
            options: options
        )

        try genesisExecutor.execute()
    }
}

extension ViperModuleSubcommand {
    enum Error: LocalizedError {
        case invalidViperConfiguration

        var errorDescription: String? {
            switch self {
            case .invalidViperConfiguration:
                return "Invalid VIPER configuration."
            }
        }
    }
}
