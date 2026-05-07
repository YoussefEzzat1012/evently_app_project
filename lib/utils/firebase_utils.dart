
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/event.dart';

class FirebaseUtils{

  static CollectionReference<Event> getEventCollection() {
   return FirebaseFirestore.instance.collection("events").withConverter(
        fromFirestore: (snapshot, options) => Event.fromFireStore(snapshot.data()!),
        toFirestore: (event, options) => event.toFireStore()
    );
  }

 static Future<void> addEventToFirebase(Event event) {
  //todo: create collection
   CollectionReference<Event> collectionRef = getEventCollection();
   //todo: create document
   DocumentReference<Event> documentRef = collectionRef.doc();
   //todo: assign document id
   event.id = documentRef.id;
   //todo: add data to document
  return documentRef.set(event);
 }
}