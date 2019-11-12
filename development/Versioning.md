This article summarizes how we handle versioning in the Chat Overflow project. This is primarily relevant for team members while releasing new builds but also for every other developer. The scope of this article is *versioning*, not *version control*. Obviously, we use git and every component is available through github.

## Versioned artefacts

The following components / artefacts / parts of the Chat Overflow project have a dedicated version number:

* Framework (contains startup code and service implementation, specifies release version)
* API (contains interfaces to connect every plugin to the framework, specifies executable plugin versions)
* REST-API (used to control the framework)
* NPM package version (used for client bindings to the REST-API, should always be the same as above)
* GUI (the version of the frontend implementation)

These versions are displayed while the framework is starting. Please note, that we do not display dedicated versions for the build environment or the (bootstrap) launcher / updater. Install scripts and plugin versions are out of scope, too.

Although these artefacts are usually deployed together, the specific version numbers are independent. The framework version does always include all changes and specifies the release version.

## Versioning

We use semantic versioning, which is documented [here](https://semver.org/). Semantic version numbers have the following pattern: `MAJOR.MINOR.PATCH`. To summarize:

- **Major** changes are new releases with API-incompatible changes
- **Minor** changes are e.g. new features which do not break the current API
- **Patch** changes fix bugs and are compatible to the current release and its features

Following the guidelines of semantic versioning, version `3.2.1` should be compatible with `3.4.5` but not with `4.0.0`.

There are, however, two exceptions: The *REST-API* and *NPM package for the REST-API client bindings* have an additional build number, e.g. `3.2.5-8`. This mechanism is used to enable easier development workflow with snapshot versions. This has no impact to plugin devs or end users.

Besides these two exceptions where version numbers change while a new release is developed, a version number change should always cause a new release.



