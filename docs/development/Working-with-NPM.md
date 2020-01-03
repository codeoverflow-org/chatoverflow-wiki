We use a npm package to connect the REST-API to our web client. The package is generated using [swagger](https://swagger.io/) annotations in our scala implementation of the interface. By this approach we ensure maximum reliability while having minimal manual implementation effort. The npm package is hosted with the [new github package registry](https://github.com/features/package-registry) and can be found [here](https://github.com/codeoverflow-org/chatoverflow/packages).

This article describes, how new versions of the package with the client bindings can be generated and published. This is important for team members and everyone interested in (G)UI development.

This task should be usually be handled by a GitHub Action that publishes the npm package once you update the version of the rest interface in the [VersionInfo.scala file](https://github.com/codeoverflow-org/chatoverflow/blob/develop/src/main/scala/org/codeoverflow/chatoverflow/VersionInfo.scala) in a commit inside the official repository. You can check whether it was successful on the actions tab in the main repository. If it was successful you can directly use the published package by bumping the version number of it in the `package.json` of the gui. In case the action isn't working or if you want to publish the package to your fork you can follow the instructions in this article.

## Prerequisites

There are three basic steps for settings started with this process.

1. Install [node / npm](https://nodejs.org/). If you have it already installed, make sure to update it to the last release using `sudo npm install -g npm@latest`.
2. Login to the github package registry. This is described [here](https://help.github.com/en/github/managing-packages-with-github-package-registry/configuring-npm-for-use-with-github-package-registry#authenticating-to-github-package-registry). Basically, it's one console command using a personal token from your [github user settings](https://github.com/settings/tokens): `npm login --registry=https://npm.pkg.github.com`
3. Download the latest *2.x*-version of `swagger-codegen-cli`. It can be found on [maven](https://mvnrepository.com/artifact/io.swagger/swagger-codegen-cli). Please make sure, that you do **not** use the *3.x*.-version, since it is not compatible with your current framework dependencies. At the time of writing this article, the latest *2.x*-version is `2.4.9`.

## Build

Next up, you can build a new version of the npm package. This is also applicable, if you won't publish the package and just want to test something locally.

1. Start by increasing the build-part of the version number of the REST-API by 1. It can be found the [VersionInfo](https://github.com/codeoverflow-org/chatoverflow/blob/develop/src/main/scala/org/codeoverflow/chatoverflow/VersionInfo.scala)-file (called `rest`). The build number is the last part, e.g. going from `3.0.0-5` to `3.0.0-6`. This step is only needed once per published version of your npm package build.

2. Start the framework and make sure, that the build version increase worked and your changes to the REST-API are available.

3. Generate the npm package using `swagger-codegen-cli`. This can be achieved with the following console command (the backslahes are only needed for *nix-systems):

   ```
   java -jar swagger-codegen-cli-2.4.9.jar generate \
      -i http://localhost:2400/api-docs/swagger.json \
      -l typescript-angular \
      -o ./angular_api_client \
      --additional-properties npmName=@codeoverflow-org/chatoverflow,snapshot=false,npmVersion=x.x.x-x,ngVersion=7.2.1
   ```

   Make sure to replace the `npm-version` with the version number you have used in the `VersionInfo`-file, e.g. `3.0.0-6`.

4. Next, some dependencies have to be installed. Navigate into your generated folder by using `cd angular_api_client `, then execute the following install-commands:

   ```
   npm install --save-dev typescript@3.2.4
   npm install --save-dev tsickle@0.35.0
   ```

5. After this, you have to update the generated `package.json`-file to make sure, that the package is published correctly to the github package registry. Add the following lines:

   ```
   "publishConfig": { "registry": "https://npm.pkg.github.com/" },
   "repository": "git://github.com/codeoverflow-org/chatoverflow.git",
   ```

6. There is only one configuration step left: Add a new file called `.npmrc` to the generated folder, containing the following line:

   ```
   registry=https://npm.pkg.github.com/codeoverflow-org
   ```

7. Now, everything is ready. You can now install and build your generated package:

   ```
   npm install
   npm run build
   ```

That's it. You have now a ready-to-use npm package with all the bindings for the REST-API, optimized for typescript in angular.

## Publish

To publish your freshly build version of the npm package, use the following command. Make sure, that you have the right to do so; and *never* forget the `dist` part.

```
npm publish dist
```

Now, you can open the `package.json` file of the [chatoverflow-gui](https://github.com/codeoverflow-org/chatoverflow-gui) project and update the version of the dependency `@codeoverflow-org/chatoverflow` to your new version. Simply run `npm install` afterwards and rebuild the gui.