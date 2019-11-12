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

10. Upload the Chat Overflow API to the Github Maven Package Registry. For initial setup, create this file `~/.sbt/1.0/gpr-codeoverflow.sbt` with the following content:

    ```scala
    credentials += Credentials(
      "GitHub Package Registry",
      "maven.pkg.github.com",
      "<GITHUB_USERNAME>",
      "<GITHUB_TOKEN>"
    )
    ```

    Then, you can simply publish a new version (the version of the main api sbt file is used) by executing `sbt apiProject/publish`.

11. Draft a new [release](https://github.com/codeoverflow-org/chatoverflow/releases). Set the `tag version` to the version to release (following the main sbt version) and the target to the `develop`-branch.
12. Write release notes. These notes should at least contain the following information: Generic information, (major) changes, pull requests. Just have a look at existant [releases](https://github.com/codeoverflow-org/chatoverflow/releases).
13. Upload both zip files with the deployed (and plugin-dev-deployed) versions of Chat Overflow.
14. Double check again, that every step is completed and everything looks fine. Then, **release**!

## 4. Post-Release

After the release, some things have to be cleaned up.

15. By releasing, the current state of the selected branch in the main project is automatically tagged with the release version, e.g. `v3.2.1`. All other current states of all other projects (e.g. API, GUI, and so on) have to be tagged, too.
16. Merge the current states of all `develop`-branches in the `master`-branches, since these should always contain the currently released version. This should cause no problems though, because you already merged the `master`-branches in chapter 1. But it opens up new space for a new development version.
17. Add a commit to all `develop`-branches, incrementing the version number. If the increment is *major* or *minor* has to be determined first.
18. Delete all dead branches on all projects. This is applicable to all branches, which have been succesfully merged into the `develop`- or `master`-brach and whose issue has been closed. If you're not sure about a branch, please ask first.
19. That's it. Get yourself a cup of coffee, take a nap or cry in pain. A new version of Chat Overflow has been released, and it's time to start over again with the development of the next release. Thank you!

