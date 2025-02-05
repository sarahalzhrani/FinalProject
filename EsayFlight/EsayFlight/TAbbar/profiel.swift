//
//  AskForHelp.swift
//  EsayFlight
//
//  Created by sara al zhrani on 19/04/1443 AH.
//


import UIKit
import FirebaseFirestore
import FirebaseAuth




class profiel : UIViewController,  UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource {

  
    
    lazy var tableView1: UITableView = {
        let tablaView = UITableView()
        tablaView.translatesAutoresizingMaskIntoConstraints = false
        tablaView.delegate = self
        tablaView.dataSource = self
        tablaView.register(ProfileCell.self, forCellReuseIdentifier: ProfileCell.identifire)
        tablaView.backgroundColor = UIColor(named: "Color")
        return tablaView
       }()
    
    
    
    
    
    
    
    var blackSquare: UIView!
   
    var users = [information]() {
        didSet{
            tableView1.reloadData()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
              let data = users[indexPath.row]
        cell.name1.text = data.name
        cell.flightNumber1.text = data.flightNumber
        cell.helath1.text = data.helath
        cell.specailNeeds1.text = data.specailNeeds
        
        
              return cell
    }
    var selectedIndex  = -1
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         if indexPath.row == selectedIndex {
          return 140
         }else {
          return 140
         }
        }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let cell = self.users[indexPath.row]
         self.users.remove(at: indexPath.row)
        let alertcontroller = UIAlertController(title: NSLocalizedString("Delete", comment: "")
                  , message: NSLocalizedString("Are you sure you want to delete?", comment: "")
                  , preferredStyle: UIAlertController.Style.alert
        )
          alertcontroller.addAction(
            UIAlertAction(title: NSLocalizedString("cancel", comment: ""),
               style: UIAlertAction.Style.default,
               handler: { Action in print("...")
         })
        )
        alertcontroller.addAction(
         UIAlertAction(title: NSLocalizedString("Delete", comment: ""),
             style: UIAlertAction.Style.destructive,
             handler: { Action in
          if editingStyle == .delete {
              
              Firestore.firestore().collection("profile").document(cell.name).delete { error in
                  if let error = error {
                      
                      print(error)
                      print("tere is error ")
                  } else {
                      print("data removing")
                  }
              }
  
          }
          self.tableView1.reloadData()
         })
        )
        self.present(alertcontroller, animated: true, completion: nil)
       }
      
    

    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView1)
        tableView1.backgroundColor = UIColor(named: "Color")
        view.backgroundColor = .white

        
      

        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(newask)
        )
        title = NSLocalizedString("My order", comment:"الصفحه الشخصيه")
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 60, width: view.frame.size.width, height: 60))
        view.addSubview(navBar)
        
        NSLayoutConstraint.activate([
            
            tableView1.topAnchor.constraint(equalTo: view.topAnchor),
                tableView1.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                tableView1.rightAnchor.constraint(equalTo: view.rightAnchor),
                tableView1.leftAnchor.constraint(equalTo: view.leftAnchor),
            
            
        ])
        
    
        
        
        
       
        
        Firestore.firestore().collection("profile").addSnapshotListener { snapshot, error in
            
            
            if error != nil {
                print(snapshot)
                return
            }
            print(snapshot)
            
            guard let docs = snapshot?.documents else {
                return
            }
            print(docs)
            
            var details : [information] = []
            for doc in docs {
                let data = doc.data()
               
                    let userdetails = information(
                        name: (data["name"] as? String) ?? "",
                       helath:(data["helath"] as? String) ?? "",
                    specailNeeds: (data["specailNeeds"] as? String) ?? "",
                    flightNumber: (data["flightNumber"] as? String) ?? ""
                                           )
                details.append(userdetails)
                    
                }
                 self.users = details
            }
        
    }
 
  
    
    
    @objc func changeLang() {
     
       
    }
    
    @objc func didTapMenuButton() {

        let vc = AskForHelp()
            self.present(AskForHelp(), animated: true, completion: nil)
        
        print("tapp is active ")
    }
    
    @objc func newask() {
        let vc = AskForHelp()
        self.present(AskForHelp(), animated: true, completion: nil)
    
    }
   
}
class ProfileCell: UITableViewCell {
    
 static let identifire = "ProfileCell"
   
    
    let name: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Name:", comment: "")
        label.textColor = .black
        label.font = label.font.withSize(16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let helath : UILabel = {
        let label = UILabel()
        label.text =  NSLocalizedString("Health status:", comment: "")
        label.textColor = .black
        label.font = label.font.withSize(16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let flightNumber: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("special Needs:", comment: "")
        label.textColor = .black
        label.font = label.font.withSize(16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let specailNeeds: UILabel = {
        let label = UILabel()
        label.text =  NSLocalizedString("Flight number:", comment: "")
        label.textColor = .black
        label.font = label.font.withSize(16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let name1: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = label.font.withSize(16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let helath1 : UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = label.font.withSize(16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let specailNeeds1 : UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = label.font.withSize(16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    let flightNumber1 : UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = label.font.withSize(16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    
    
    
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
  super.init(style: style, reuseIdentifier: reuseIdentifier)
  contentView.backgroundColor = UIColor(named: "Color-1")
      
           contentView.addSubview(name)
           contentView.addSubview(helath)
           contentView.addSubview(flightNumber)
           contentView.addSubview(specailNeeds)
           contentView.addSubview(name1)
            contentView.addSubview(helath1)
           contentView.addSubview(flightNumber1)
          contentView.addSubview(specailNeeds1)
           contentView.clipsToBounds = true
    
      
 }
    
    
 required init?(coder: NSCoder) {
  fatalError("init(coder:) has not been implemented")
 }
    
 override func layoutSubviews() {
  super.layoutSubviews()
     // x: right and left
     // y: up and down
     name.frame = CGRect(x: 20,
                 y: 10 ,
                 width: 50,
                 height: 20)
     helath.frame = CGRect(x: 20,
                   y: 40 ,
                 width: 120,
                 height: 20)
     flightNumber.frame = CGRect(x: 20,
                   y: 70 ,
                 width: 120,
                 height: 20)
     specailNeeds.frame = CGRect(x: 20,
                   y: 100 ,
                 width: 120,
                 height: 20)
     name1.frame = CGRect(x: 80,
                          y: 10 ,
                        width: 120,
                        height: 20)
     helath1.frame = CGRect(x: 130,
                   y: 40 ,
                 width: 130,
                 height: 20)
     flightNumber1.frame = CGRect(x: 130,
                   y: 70 ,
                 width: 130,
                 height: 20)
     specailNeeds1.frame = CGRect(x: 130,
                   y: 100 ,
                 width: 130,
                 height: 20)
 
 }
 }
    
    

        


