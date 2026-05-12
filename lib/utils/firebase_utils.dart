
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:route/models/my_user.dart';

import '../models/event.dart';

class FirebaseUtils{

  static CollectionReference<Event> getEventCollection(String uId) {
   return getUserCollection().doc(uId).collection("events").withConverter<Event>(
        fromFirestore: (snapshot, options) => Event.fromFireStore(snapshot.data()!),
        toFirestore: (event, options) => event.toFireStore()
    );
  }

 static Future<void> addEventToFirebase(Event event, String uId) {
  //todo: create collection
   CollectionReference<Event> collectionRef = getEventCollection(uId);
   //todo: create document
   DocumentReference<Event> documentRef = collectionRef.doc();
   //todo: assign document id
   event.id = documentRef.id;
   //todo: add data to document
  return documentRef.set(event);
 }


 static CollectionReference<MyUser> getUserCollection() {
    return FirebaseFirestore.instance.collection("users").withConverter<MyUser>(
        fromFirestore: (snapshot, options) => MyUser.fromFireStore(snapshot.data()!),
        toFirestore: (user, options) => user.toFireStore()
    );
 }

 static Future<void> addUserToFirebase(MyUser user) {
   //todo: create collection
   return getUserCollection().doc(user.id).set(user);;
 }

 static Future<MyUser?> getUserFromFirebaseFireStore(String id) async {
    var querySnapShot = await getUserCollection().doc(id).get();
    if(querySnapShot.exists) {
      return querySnapShot.data();
    }
    return null;
 }
 }



