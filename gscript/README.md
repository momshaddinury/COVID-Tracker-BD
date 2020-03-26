# covid19 Cloud Functions

## Prerequisites

- Learn about [Git](https://git-scm.com/)
  - Use Git (latest)
- Learn about [NodeJS](https://nodejs.org/) and [NPM](https://nodejs.org/)
  - Use Node v11.3.0
  - Use Npm v6.12.0
- Learn about [Firebase Tools](https://github.com/firebase/firebase-tools)
  - User v7.6.1
- Learn about [TSLint](https://palantir.github.io/tslint/)
  - Use v5.18.0
  
## Installation

Run `npm install -g firebase-tools` For Firebase Tools

Run `npm install -g tslint@5.18.0` for tsLint.

Run `npm install` to grab all project dependencies. (be on the project directory)

Now Run `cd functions` to be at cloud functions directory now run `npm install` to install all the dependencies

### Build to development

Run  `firebase deploy --project development` to deploy the project to development environment.  

### Firestore

Modify `firebase.firestore.rules` and `firebase.firestore.indexes.json`.

### Storage

Modify `firebase.storage.rules`.

### Hosting

Modify `firebase.json`.

### Deployment

Run `firebase login` to login to your Firebase Console. Run `firebase deploy` to deploy the project and update firebase rules.

### Run Firebase function locally

- go to function folder

`cd functions`

 - Start the emulator

`firebase emulator:start`

### Deploy specific firebase function 

`firebase deploy --only functions:functionName`  

### To call the firebase functions 
Note: You must provide the corresponding params

`https://us-central1-covid19-bd.cloudfunctions.net/onUserResponseSubmit`

`https://us-central1-covid19-bd.cloudfunctions.net/getUserByUserPhone`

### Set Environment Variable  in firebase function
firebase functions:config:set service.name="your env var name "
firebase functions:config:set auth.migration_api=""

### Further help

To get more help on Firebase Tools use `firebase help` or go check out the [Firebase Tools Documentation](https://github.com/firebase/firebase-tools).
