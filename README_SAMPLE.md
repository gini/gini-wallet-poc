# Project name

> Short description application description.

## Requirements

* iOS 12.0+
* Xcode 12+
* Swift 5.2+

## Installation

This app is using [CocoaPods](https://cocoapods.org) to integrate and version control 3rd party dependencies.

[Bundler](https://bundler.io) makes sure all parties use the same CocoaPods (and Fastlane) version which increases stability during development.

```bash
bundle install
bundle exec pod install
```

[Swift Package manager](https://swift.org/package-manager/) is also used but it's dependencies are resolved automatically by Xcode, at both development and build time.

## Architecture

## Workflow

> Any additonal workflow step a new developer should know about
>
> * sync localizable strings
> * manual code generation
> * etc ...

## Environment

> Use [tablesgenerator](https://www.tablesgenerator.com/markdown_tables) to edit.
> 
> If code signing is other than Automatic, please include links to where the certificates are stores.

|                   | DEBUG       | INTERNAL     | RELEASE      |
|-------------------|-------------|--------------|--------------|
| Code signing      | Automatic   | [Match](https://google.com)        | Match        |
| Profile           | Debug       | Distribution | Distribution |
| API Configuration | Development | Development  | Production   |

### Renew certificates

There's a handly fastlane action (`fastlane/Fastfile`) that renews all necessary certificates. Please run this command locally on your machine:

```bash
bundle exec fastlane renew_certificates
```

### Notes

> Add if there are any notes.

## CI/CD

> Update this part based on the project configuration.

Continous integration & delivery is enabled using gitlab.com's built-in feature and configured using the [gitlab-ci.yml](gitlab-ci.yml) file.

### Nightly builds

Nightlies are set up using GitLab pipeline schedules (`Project > CI / CD > Schedules`).

Environment variables are used to configure how and where builds are distributed (check them out at `Project > Settings> CI / CD > Variables`).

## Accounts & Accesses

* **App Store Connect**: Client / Halcyon Mobile
* **Basecamp**: Halcyon Mobile
* ...
