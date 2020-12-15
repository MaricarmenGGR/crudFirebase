//
//  ViewController.swift
//  FirebaseCRUD
//
//  Created by Catalina on 15/12/20.
//

import UIKit
import FirebaseCore
import FirebaseFirestore

class ViewController: UIViewController {

    var db: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let settings = FirestoreSettings()

        Firestore.firestore().settings = settings
                // [END setup]
        db = Firestore.firestore()
        
        agregarUsuario()
        
    }
    
    func leerUsuarios() {
        db.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                print("DOCUMENTOS POR USUARIO")
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
        
    }
    
    func agregarUsuario() {
        // Add a new document in collection "cities"
        db.collection("users").document("U1").setData([
            "first": "Mari",
            "last": "Rodriguez",
            "born": 1998
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    func borrarUsuarios(){
        
        db.collection("users").document("U1").delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
    private func updateDocument() {
            // [START update_document]
            let user = db.collection("users").document("hKn8iKCDHmL4RyfPKmmA")

            // Set the "capital" field of the city 'DC'
            user.updateData([
                "born": 1990
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                }
            }
            
        }


}

