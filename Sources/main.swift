import ArgumentParser
import Foundation

struct FoxGen: ParsableCommand {
    public static let configuration = CommandConfiguration(
        commandName: "foxgen",
        abstract: "Generates project source files",
        version: "1.1.0",
        subcommands: [
            BundleSubcommand.self,
            ModuleSubcommand.self,
            SourcerySubcommand.self,
            SwiftgenSubcommand.self
        ]
    )
}

FoxGen.main()
