FoxGen
===
FoxGen is a tool to run different utilities such as XcodeGen, SwiftGen, etc. in a convenient way.

## Installing

### [Mint](https://github.com/yonaskolb/mint)
```sh
mint install tr1ckyf0x-studio/FoxGen
```

## Configuration
FoxGen expects `foxgen.yml` in root directory.

### Config example

```yaml
executables:
  genesis: "mint run genesis"
  swiftgen: "mint run swiftgen"

viper:
  modulesPath: "Modules"
  templatePath: "swift-templates/Genesis/VIPER/template.yml"

yarch:
  modulesPath: "Modules"
  templatePath: "swift-templates/Genesis/YARCH/template.yml"

bundle:
  modulesPath: "Modules"
  templatePath: "swift-templates/Genesis/Bundle/template.yml"
```
