//
//  YarchModuleSubcommand.swift
//
//
//  Created by Vladislav Lisianskii on 04.11.2023.
//

import ArgumentParser
import Foundation

struct YarchModuleSubcommand: ParsableCommand {

    static var configuration = CommandConfiguration(
        commandName: "yarch",
        abstract: "Generates YARCH module"
    )

    @OptionGroup var moduleOptions: ModuleOptions

    func run() throws {
        let configuration = try ConfigurationLoader().loadConfiguration()

        guard let yarchConfiguration = configuration.yarch else {
            throw Error.invalidYarchConfiguration
        }

        let shell = Shell()

        let options = [
            "modules_path": yarchConfiguration.modulesPath,
            "module_name": moduleOptions.module,
            "submodule_name": moduleOptions.submodule,
            "developer_name": GitProvider(shell: shell).username,
            "current_date": DateProvider().date
        ]

        let genesisExecutor = GenesisExecutor(
            shell: shell,
            executable: configuration.executables.genesis,
            templatePath: yarchConfiguration.templatePath,
            options: options
        )

        let result = try genesisExecutor.execute()
        print(result)
    }
}

extension YarchModuleSubcommand {
    enum Error: LocalizedError {
        case invalidYarchConfiguration

        var errorDescription: String? {
            switch self {
            case .invalidYarchConfiguration:
                "Invalid YARCH configuration."
            }
        }
    }
}
