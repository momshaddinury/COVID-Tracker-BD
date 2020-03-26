import * as functions from 'firebase-functions';
import * as admin     from 'firebase-admin';

// Initialize Firebase Admin SDK
admin.initializeApp(functions.config().firebase);

// Expose user call Cloud Functions
export * from './user.call';
