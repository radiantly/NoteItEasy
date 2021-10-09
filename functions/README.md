## How Cloud Functions for Firebase was setup

This is documentation for future me.

```sh
$ pwd
~/Documents/gitHub/noteiteasy

# Install firebase tools
$ sudo npm install -g firebase-tools

# Initialize firebase functions directory
$ firebase init functions
```

## Running and deploying the cloud functions

```sh
$ pwd
~/Documents/gitHub/noteiteasy/functions

# Copy config.example.json to config.json and change the values
$ cp config.example.json config.json

# Deploy cloud function
$ cd ..
$ firebase deploy --only functions
```
