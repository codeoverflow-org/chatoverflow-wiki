We publish the API sbt project to [GitHub Package Registry](https://github.com/features/package-registry). This allows to develop Chat Overflow plugins using build tools other than sbt and languages that aren't supported by sbt like [Kotlin](https://kotlinlang.org). In the future we also want to publish the actual framework and gui to GPR, check issue [#161](https://github.com/codeoverflow-org/chatoverflow/issues/161) for progress on that. This will allow to download single jars to e.g. replace a older version of the gui in a working end-user deployment on the fly and embedding of Chat Overflow into other applications.

All projects should automatically be published by a GitHub Action once you create a tag. In case you want to publish to e.g. your private fork or want to test that publishing works you can follow these instructions in this wiki article.

## Initial setup

To authenticate add a file at `~/.sbt/1.0/gpr-codeoverflow.sbt` with the following content:

```scala
credentials += Credentials(
  "CodeOverflow GitHub Package Registry",
  "maven.pkg.github.com",
  "<GITHUB_USERNAME>",
  "<GITHUB_TOKEN>"    
)
```

Replace `<GITHUB_USERNAME>` with your user name and `<GITHUB_TOKEN>` with a personal access token with `read:packages`, `repo` and `write:packages` scopes. For further assistance on how to get a token check the [GitHub documentation](https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line#creating-a-token).

## Publishing

To publish a component first check that the version in the `build.sbt` of the project you want to publish contains the correct version number. If you want to publish it to a fork e.g. for testing purposes you can overwrite the default user, which is the CodeOverflow org, with your user name using the `GITHUB_OWNER` environment variable.

After you did that and have authenticated as mentioned in the section above you can just run `sbt apiProject/publish`. Replace the name of the project accordingly. 

*DO NOT* try to run `sbt publish`, it will try to publish all projects including plugins and the launcher, which don't have publishing set up. These projects let the task fail and sbt will abort all non finished publish processes, which may result in half published projects.