//
//  MvpModuleSubcommand.swift
//  
//
//  Created by Vladislav Lisianskii on 01.02.2024.
//

import ArgumentParser
import Foundation

struct MvpModuleSubcommand: ParsableCommand {

    static var configuration = CommandConfiguration(
        commandName: "mvp",
        abstract: "Generates MVP module"
    )

    func run() throws {
        let configuration = try ConfigurationLoader().loadConfiguration()

        guard let mvpConfiguration = configuration.mvp else {
            throw Error.invalidMvpConfiguration
        }

        let shell = Shell()

        let options = [
            "modules_path": mvpConfiguration.modulesPath,
            "developer_name": GitProvider(shell: shell).username,
            "current_date": DateProvider().date
        ]

        let genesisExecutor = GenesisExecutor(
            shell: shell,
            executable: configuration.executables.genesis,
            templatePath: mvpConfiguration.templatePath,
            options: options
        )

        try genesisExecutor.execute()
    }
}

extension MvpModuleSubcommand {
    enum Error: LocalizedError {
        case invalidMvpConfiguration

        var errorDescription: String? {
            switch self {
            case .invalidMvpConfiguration:
                return "Invalid MVP configuration."
            }
        }
    }
}
