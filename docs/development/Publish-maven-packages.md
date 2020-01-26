We publish the API sbt project to [GitHub Package Registry](https://github.com/features/package-registry). This allows to develop Chat Overflow plugins using build tools other than sbt and languages that aren't supported by sbt like [Kotlin](https://kotlinlang.org). The GUI and Framework are also being published to allow ChatOverflow to be embedded into other applications.

All projects should automatically be published by a GitHub Action once you create a tag. In case you want to publish to e.g. your private fork or want to test that publishing works you can follow these instructions in this wiki article.

## Initial setup

To authenticate add a file at `~/.sbt/1.0/gpr-codeoverflow.sbt` with the following content:

```scala
credentials += Credentials(
  "GitHub Package Registry",
  "maven.pkg.github.com",
  "<GITHUB_USERNAME>",
  "<GITHUB_TOKEN>"    
)
```

Replace `<GITHUB_USERNAME>` with your user name and `<GITHUB_TOKEN>` with a personal access token with `read:packages`, `repo` and `write:packages` scopes. For further assistance on how to get a token check the [GitHub documentation](https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line#creating-a-token).

## Publishing

To publish a component first check that the version in the `build.sbt` of the project you want to publish contains the correct version number. If you want to publish it to a fork e.g. for testing purposes you can overwrite the default user, which is the CodeOverflow org, with your user name using the `GITHUB_OWNER` environment variable.

After you did that and have authenticated as mentioned in the section above you can just run `sbt apiProject/publish`. Replace `apiProject` with `guiProject` if you want to publish the GUI. 

The framework is a bit trickier, because `sbt root/publish` won't work as it will execute `publish` in the framework, api, gui and all loaded plugins which don't have publishing set up. You should use `sbt publishFramework`, which only executes `publish` for the framework.