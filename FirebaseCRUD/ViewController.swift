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

    @IBOutlet weak var nombreTF: UITextField!
    @IBOutlet weak var apellidoTF: UITextField!
    @IBOutlet weak var apodoTF: UITextField!
   
    @IBOutlet weak var usuarios: UITextView!
    
    var db: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        
    }
    
    @IBAction func saveUser(_ sender: UIButton) {
        
        db.collection("users").document(self.apodoTF.text!).setData([
            "nombre": self.nombreTF.text!,
            "apellido": self.apellidoTF.text!
            ]) { err in
                if let err = err {
                    print("Error al escribir el Documento: \(err)")
                } else {
                    print("El Documento se escribio exitosamente!")
                }
            }
        
    }
    
    @IBAction func deleteUser(_ sender: UIButton) {
        db.collection("users").document(self.apodoTF.text!).delete() { err in
            if let err = err {
                print("No se removio ningun documento: \(err)")
            } else {
                print("Documento removido satisfactoriamente")
            }
        }
    }
    @IBAction func editUser(_ sender: UIButton) {
        
        let user = db.collection("users").document(self.apodoTF.text!)

        user.updateData([
            "nombre": self.nombreTF.text!,
            "apellido": self.apellidoTF.text!
        ]) { err in
            if let err = err {
                print("Error al editar: \(err)")
            } else {
                print("Documento editado")
            }
        }
        
    }
    @IBAction func readUser(_ sender: UIButton) {
        db.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                print("DOCUMENTOS POR USUARIO")
                for document in querySnapshot!.documents {
                    self.usuarios.text! += "\(document.data())"+"\n"
                    print("\(document.documentID) => \(document.data())")
                    
                }
            }
        }
        
    }

}

