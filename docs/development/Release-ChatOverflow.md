The scope of this article is to serve all Chat Overflow team members when releasing a new version. As stated in [the versioning article](/docs/development/Versioning.md), this might be the case for:

- New releases (*MAJOR*): New major feature releases with (breaking) API-Updates. New major releases are always documented in the [milestone](https://github.com/codeoverflow-org/chatoverflow/milestones)-section of the github issue tracker.
- Feature-Upgrades (*MINOR*): Small feature upgrades, which do not require any breaking API-Updates and can be pushed earlier.
- Bugfixes / Hotfixes (*PATCH*): Updates to resolve bugs inside any part of the Chat Overflow project.

This article guides you through the process of building, deploying and releasing new Chat Overflow versions. Please read [versioning](/docs/development/Versioning.md), [deploying](/docs/development/Deploy-ChatOverflow.md), and [working with npm](/docs/development/Working-with-NPM.md) first and if there are any questions (or there is some information missing in the article), feel free to contact us.

## Overview

The (major) release of a new Chat Overflow version can be summarized in four steps:

1. Prepare Environment
2. Deploy new version
3. Release
4. Post-Release

## 1. Prepare

First, everything has to be prepared for a new release.

1. Make sure, that all current [issues](https://github.com/codeoverflow-org/chatoverflow/issues) are resolved (for a minor release) or all issues for a major milestone are done.
2. Update (all) version numbers (have a look at the [versioning](/docs/development/Versioning.md)-article). If this is a major release, this step has probably already been done (see chapter 3).
3. Merge the `master` branches of the six sub-projects into the `develop` branches. Make sure, that all new features are now available in the `develop`-branch. Resolve all merge issues. This does apply to:
   - Chat Overflow Framework (main repository)
   - Chatoverflow-API
   - Chatoverflow-Plugins
   - Chatoverflow-Launcher
   - Chatoverflow-GUI
   - Chatoverflow-Setup
   - Chatoverflow-Wiki (make sure not to break things here!) 
     Also don't forget create a tag for the release in each repository.
4. Test the current version at least with the `testall`-plugin to make sure, that there are not major flaws left. Make sure to execute the `[Advanced]`-task this time to rebuild everything.
5. Create a new version of the [npm-package](/docs/development/Working-with-NPM.md) with the new version or at least a new build version.
6. Push your local, prepared version of all projects and mention the release state in the commit message.

## 2. Release

With the two deployed versions of Chat Overflow, we are now ready to release!

7. Draft a new [release](https://github.com/codeoverflow-org/chatoverflow/releases). Set the `tag version` to the version number of the release (following the main sbt version) and the target to the `develop`-branch. Make sure that the tag version is the same as in the bootstrap module, it can be found in `launcher/bootstrap/build.sbt`. Otherwise the updater won't be able to do update checks with the to be released version.

8. Write release notes. These notes should at least contain the following information: Generic information, (major) changes, pull requests. Just have a look at existent [releases](https://github.com/codeoverflow-org/chatoverflow/releases).

9. Double check again, that every step is completed and everything looks fine. Then, **release**!

10. Within about 5 minutes a GitHub action should automatically build and upload a end-user and plugin developer deployment. Check that it is working successfully in the actions tab of the main repository. If it fails create deployments manually as detailed in the [deploy article](/docs/development/Deploy-ChatOverflow.md) and open an issue so it gets fixed till the next release.

    Also within about 5 minutes the API, GUI and Framework should be published to GitHub Package Registry by an action. If it fails refer to the [publish maven packages](/docs/development/Publish-maven-packages.md), do it manually and also open an issue so it gets fixed till the next release.

## 3. Post-Release

After the release, some things have to be cleaned up.

11. By releasing, the current state of the selected branch in the main project is automatically tagged with the release version, e.g. `3.2.1-prealpha`.
12. Merge the current states of all `develop`-branches in the `master`-branches, since these should always contain the currently released version. This should cause no problems though, because you already merged the `master`-branches in chapter 1. But it opens up new space for a new development version.
13. Add a commit to all `develop`-branches, incrementing the version number. If the increment is *major* or *minor* has to be determined first.
14. Delete all dead branches on all repositories. This is applicable to all branches, which have been successfully merged into the `develop`- or `master`-branch and whose issue has been closed. If you're not sure about a branch, please ask first.
15. That's it. Get yourself a cup of coffee, take a nap or cry in pain. A new version of Chat Overflow has been released, and it's time to start over again with the development of the next release. Thank you!

