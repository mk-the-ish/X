// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { initializeAuth } from "firebase/auth";
import  getReactNativePersistence  from "@firebase/auth/react-native";
import ReactNativeAsyncStorage from "@react-native-async-storage/async-storage";
import { getFirestore } from "firebase/firestore";
import { getAnalytics } from "firebase/analytics";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
    apiKey: "AIzaSyBzGzhCPKgWAB9WNAOWyvWigH-xf8AF0VM",
    authDomain: "xplatform-7551e.firebaseapp.com",
    projectId: "xplatform-7551e",
    storageBucket: "xplatform-7551e.firebasestorage.app",
    messagingSenderId: "785905781269",
    appId: "1:785905781269:web:3cd6b42887273ad3e79c1c",
    measurementId: "G-FT7M6KTRDF"
};

// Initialize Firebase
export const app = initializeApp(firebaseConfig);
export const auth = initializeAuth(app, {
    persistence: getReactNativePersistence(ReactNativeAsyncStorage),});
export const db = getFirestore(app);
const analytics = getAnalytics(app);