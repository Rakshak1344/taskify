# Taskify

A Task manager app


## Prerequisites

- Install [FVM](https://fvm.app/documentation/getting-started/installation) (flutter version manager)

```bash
  curl -fsSL https://fvm.app/install.sh | bash
```
- Install [Firebase-cli](https://formulae.brew.sh/formula/firebase-cli) for firebase setup, [click](https://firebase.google.com/docs/flutter/setup?platform=ios) to know more on installation

```bash
  brew install firebase-cli
```
- Log into Firebase using your Google account by running the following command:
```bash
  firebase login
```
- In firebase project, create 3 apps - android, ios, and web. use `com.taskify.app` as package name.

- Create a Flutter project with the package name as `com.taskify.app` and enable google-signin method under authentication menu, by running the below command you can select the right project among multiple projects.

```bash
  flutterfire configure
```
- Setup Java keystore - you will have to setup store password, key password, and few details - Replace  `~/taskify-key.jks` to your desired loaction if needed.
```bash
keytool -genkey -v \
  -keystore ~/taskify-key.jks \
  -keyalg RSA \
  -keysize 2048 \
  -validity 10000 \
  -alias taskify
```

- Create a file called `key.properties` inside `packages/app/android` (refering to code  workspace) and add the details of jks and replace with the appropriate values provided.
```bash
storePassword=<YOUR_STORE_PASSWORD>
keyPassword=<YOUR_KEY_PASSWORD>
keyAlias=taskify
storeFile=~/taskify-key.jks
```

- Generate SHA-1 and SHA-256 by running the below command and use the values in respective values in the apps of a firebase project.

```bash
./gradlew signingReport
```
- Configure melos script inside `melos.yaml`at the root of the project. Under Web app in firebase project copy `app id` and add it inside melos.yaml it should look something like below
```bash
 flutterfire configure -p <PROJECT-NAME> \
      --platforms android,ios,web \
      -a com.taskify.app \
      -i com.taskify.app \
      -m com.taskify.app \
      -w <WEB_APP_ID> \
      -y
```
- Create `dev.define.json` at `packages/app` and replace the appropriate values.
  Note: For google's web and server's client ID go to google cloud console and concent and scope that are `/auth/userinfo.profile`,`/auth/user.birthday.read`,

```bash
{
  "APP_NAME": "Taskify",
  "APP_SUFFIX": ".dev",
  "BASE_URL": "http://<IP>:<PORT>/api/v1",
  "ENVIRONMENT": "dev",
  "GOOGLE_WEB_CLIENT_ID": <GOOGLE_WEB_CLIENT_ID>,
  "GOOGLE_SERVER_CLIENT_ID":<GOOGLE_SERVER_CLIENT_ID>
}


```

## Project setup

- Pub Global activation
```bash
fvm flutter pub global activate melos
fvm flutter pub global activate spider
```
- Setup
```bash
melos bs
melos gen
melos gen:firebase
```

- Run the project using
```bash
fvm flutter run --dart-define-from-file=dev.define.json
```
