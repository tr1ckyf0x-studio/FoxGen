import ArgumentParser
import Foundation

struct FoxGen: ParsableCommand {
    public static let configuration = CommandConfiguration(
        commandName: "foxgen",
        abstract: "Generates project source files",
        version: "0.0.2",
        subcommands: [
            ModuleSubcommand.self,
            BundleSubcommand.self,
            SwiftgenSubcommand.self
        ]
    )
}

FoxGen.main()
