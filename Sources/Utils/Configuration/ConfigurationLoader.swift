//
//  ConfigurationLoader.swift
//
//
//  Created by Vladislav Lisianskii on 04.11.2023.
//

import Foundation
import Yams

struct ConfigurationLoader {
    func loadConfiguration() throws -> Configuration {
        let configurationData = FileManager.default.contents(atPath: Constants.configurationFilePath)

        guard let configurationData else {
            throw Error.configurationFileNotFound
        }

        let decoder = YAMLDecoder()
        do {
            let configuration = try decoder.decode(Configuration.self, from: configurationData)
            return configuration
        } catch {
            throw Error.invalidConfiguration(error)
        }
    }
}

// MARK: - Constants

extension ConfigurationLoader {
    private enum Constants {
        static let configurationFilePath = "foxgen.yml"
    }
}

extension ConfigurationLoader {
    private enum Error: LocalizedError {
        case configurationFileNotFound
        case invalidConfiguration(Swift.Error)

        var errorDescription: String? {
            switch self {
            case .configurationFileNotFound:
                return "Configuration file not found."

            case let .invalidConfiguration(error):
                return "Configuration file is not valid.\n\(error)"
            }
        }
    }
}
