The scope of this article is to serve all Chat Overflow team members when releasing a new version. As statet in [the versioning article](development/Versioning.md), this might be the case for:

- New releases (*MAJOR*): New major feature releases with (breaking) API-Updates. New major releases are alsways documented in the [milestone](https://github.com/codeoverflow-org/chatoverflow/milestones)-section of the github issue tracker.
- Feature-Upgrades (*MINOR*): Small feature upgrades, which do not require any breaking API-Updates and can be pushed earlier.
- Bugfixes / Hotfixes (*PATCH*): Updates to resolve bugs inside any part of the Chat Overflow project.

This article guides you through the process of building, deploying and releasing new Chat Overflow versions. Please read [versioning](development/Versioning.md), [deploying](development/Deploy-ChatOverflow.md), and [working with npm](development/Working-with-NPM.md) first and if there are any questions (or there is some information missing in the article), feel free to conact us.

## Overview

The (major) release of a new Chat Overflow version can be summerized in four steps:

1. Prepare Environment
2. Deploy new version
3. Release
4. Post-Release

## 1. Prepare

First, everything has to be prepared for a new release.

1. Make sure, that all current [issues](https://github.com/codeoverflow-org/chatoverflow/issues) are resolved (for a minor release) or all issues for a major milestone are done.
2. Update (all) version numbers (have a look at the [versioning](development/Versioning.md)-article). If this is a major release, this step has probably already been done (see chapter 4).
3. Merge the `master` branches of the six sub-projects into the `develop` branches. Make sure, that all new features are now available in the `develop`-branch. Resolve all merge issues. This does apply to:
   - Chat Overflow Framework (main repository)
   - Chatoverflow-API
   - Chatoverflow-Plugins
   - Chatoverflow-Launcher
   - Chatoverflow-GUI
   - Chatoverflow-Setup
   - Chatoverflow-Wiki (make sure not to break things here!)
4. Test the current version at least with the `testall`-plugin to make sure, that there are not major flaws left. Make sure to execute the `[Advanced]`-task this time to rebuild everything.
5. Create a new version of the [npm-package](development/Working-with-NPM.md) with the new version or at least a new build version.
6. Push your local, prepared version of all projects and mention the release state in the commit message.

## 2. Deploy

After these steps, there is a merged and "tested" version of Chat Overflow available. Now, it's time to [deploy](development/Deploy-ChatOverflow.md):

7. Use the `[Deploy]`-task to create a deployed version of the Chat Overflow project. Copy these files to a different directory. Then use the `[DeployDev]`-task to create a version of Chat Overflow for plugin developers. Do also copy this files to a different folder.
8. For both environments / deployed versions, execute your copied versions and make sure, that everything is downloaded and starts correctly and all runtime files (e.g. the `config`-files) are generated.
9. Return to your original, deployed versions. Zip them in separate files. Make sure to include all needed files but *none* of the generated files of your runtime versions (see [deploying](development/Deploy-ChatOverflow.md) for more information).

## 3. Release

With the two deployed versions of Chat Overflow, we are now ready to release!

TODO (upload api, upload, notes, publish)

## 4. Post-Release

TODO (increment version, delete branches)

