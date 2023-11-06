//
//  BundleSubcommand.swift
//  
//
//  Created by Vladislav Lisianskii on 10.09.2023.
//

import ArgumentParser
import Foundation

struct BundleSubcommand: ParsableCommand {

    static var configuration = CommandConfiguration(
        commandName: "bundle",
        abstract: "Generates Bundle file"
    )

    func run() throws {
        let configuration = try ConfigurationLoader().loadConfiguration()

        let shell = Shell()

        guard let bundleConfiguration = configuration.bundle else {
            throw Error.invalidBundleConfiguration
        }

        let options = [
            "modules_path": bundleConfiguration.modulesPath,
            "developer_name": GitProvider(shell: shell).username,
            "current_date": DateProvider().date
        ]

        let genesisExecutor = GenesisExecutor(
            shell: shell,
            executable: configuration.executables.genesis,
            templatePath: bundleConfiguration.templatePath,
            options: options
        )

        try genesisExecutor.execute()
    }
}

extension BundleSubcommand {
    enum Error: LocalizedError {
        case invalidBundleConfiguration

        var errorDescription: String? {
            switch self {
            case .invalidBundleConfiguration:
                "Invalid Bundle configuration."
            }
        }
    }
}
