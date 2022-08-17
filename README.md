# iOS Project Skeleton

This is the project template that's used by the iOS team at Halcyon Mobile. It has a unified project structure and various utility clases that's used on projects devleoped by Halcyon Mobile.

## Minimum requirements

The latest `master` version required **iOS 13+ and Xcode 12**.

If you're looking for an older version check out the following branches:

- `ios-12` - iOS 12+, Xcode 12

## Usage

- Open the **skeleton.xcodeproj** and rename the project in the Project Navigatior. That will rename the project file as well.
- Update `Podfile` - replace **skeleton** with the name of your project.
- Update `fastlane`
    - `fastlane/AppFile` - Replace the **team id** and **app id**.
    - `fastlane/FastFile` - Replace orrucanes of **skeleton** and double check if the setup is right for the project.
    - `fastlane/Matchfile` - Setup a match repo and replace what's inside this file.
- Replace this **README** file with **README_SAMPLE.md** and update the file with the project details.

## Copyright

The iOS Project Skeleton is the property of Halcyon Mobile. Any usage not related to Halcyon Mobile is strictly forbidden.