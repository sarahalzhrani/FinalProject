//
//  Services.swift
//  EsayFlight
//
//  Created by sara al zhrani on 19/04/1443 AH.
import UIKit
import DropDown
import FirebaseFirestore




struct information {
   var name:  String
    var  helath: String
    var specailNeeds: String
    var flightNumber: String
}

class AskForHelp : UIViewController, UITextViewDelegate {
    var blackSquare: UIView!
    let dropDown = DropDown()
    let dropDown1 = DropDown()
    var Square: UIView!
    var Square2: UIView!
    var line: UIView!
    var line2: UIView!
    var line3: UIView!
    var line4: UIView!
    let data = ["Old","blind","paralyzed","child"]
    let data2 = ["wheel chair","personal escort"]
    let timePicker = UIDatePicker()
    
   
    
    let name: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Name:", comment: "")
        label.textAlignment = .left
        label.textColor = .black
        label.font = label.font.withSize(25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let helath : UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Health status:", comment: "")
        label.textColor = .black
        label.font = label.font.withSize(25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let specailNeeds : UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Flight number:", comment: "")
        label.textColor = .black
        label.font = label.font.withSize(25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let flightNumber : UILabel = {
        let label = UILabel()
        label.text =  NSLocalizedString("special Needs:", comment: "")
        label.textColor = .black
        label.font = label.font.withSize(25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dropdownlable : UILabel = {
        let label = UILabel()
        label.text =  NSLocalizedString( "select health status..", comment: "")
        label.textColor = .black
        label.font = label.font.withSize(19)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let dropdownlable2 : UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("select your needs..", comment: "")
        label.textColor = .black
        label.font = label.font.withSize(19)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let timeOfArrival: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Arrival Time..", comment: "")
        label.textColor = .black
        label.font = label.font.withSize(20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var listeBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("", for: .normal)
        btn.layer.cornerRadius = 15
        btn.setTitleColor(UIColor.systemMint, for: UIControl.State.normal)
        btn.addTarget(self, action: #selector(listbt), for: .touchUpInside)
        return btn
    }()
    
    
    var listeBtn1: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 15
        btn.setTitleColor(UIColor.systemMint, for: UIControl.State.normal)
        btn.addTarget(self, action: #selector(listbt2), for: .touchUpInside)
        return btn
    }()
    
    var registerBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("send", for: .normal)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 15
        btn.setTitleColor(UIColor.systemMint, for: UIControl.State.normal)
        btn.layer.borderColor = UIColor.systemMint.cgColor
        btn.layer.borderWidth = 2
        btn.addTarget(self, action: #selector(sendPressed), for: .touchUpInside)
        return btn
    }()
    
    
    var timeTF: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = .systemGray6
        tf.layer.cornerRadius = 15
//        tf.layer.borderColor = UIColor.systemMint.cgColor
        tf.textAlignment = .center
//        tf.layer.borderWidth = 2
        tf.text = ""
       
        return tf
    }()
    
    let textView = UITextView(frame: CGRect(x: 30, y: 190, width: 350, height: 45.0))
    let textView2 = UITextView(frame: CGRect(x: 30, y: 370, width: 350, height: 45.0))
    let stackView   = UIStackView()
    

    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupView()
       
        dropDown.willShowAction = { [unowned self] in
            print("- \(dropDown.selectedItem ?? "")")
            self.dropdownlable.text = dropDown.selectedItem
            let data2 = self.dropdownlable.text = dropDown.selectedItem
//            self.listeBtn.setTitle(dropDown.selectedItem, for: .normal)
        }

        dropDown1.cellConfiguration = { [unowned self] (index: Int, item:String) in

            print("- \(item) (\(index))")
            self.dropdownlable2.text =  data2[index]
            let data = self.dropdownlable2.text =  data2[index]
            return "\(item)"
        }
        let name =  UserDefaults.standard.value(forKey: "namekey") as? String
        textView.text = name
        
        let flight = UserDefaults.standard.value(forKey: "specailNeeds") as? String
        textView2.text = flight
        
       
    }
    
    
    
    
    private func SetupView () {
        view.backgroundColor = .systemMint
        self.navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Back", comment: ""), style: .plain, target: self, action: #selector(handleCancel))
        self.timePicker.datePickerMode = .time
        openTimePicker()
        blackSquare = UIView(frame: CGRect(x: 0, y: 100, width: view.bounds.width, height: 800))
        blackSquare.backgroundColor = .white
        blackSquare.layer.cornerRadius = 55
        view.addSubview(blackSquare)
        
        Square = UIView(frame: CGRect(x: 30, y: 290, width: 350, height:40))
        Square.backgroundColor = .systemGray6
        Square.layer.cornerRadius = 10
        view.addSubview(Square)
        view.backgroundColor = .systemMint
       line = UIView(frame: CGRect(x: 30, y: 236, width: 350, height:1))
        line.backgroundColor = .gray
        line.layer.cornerRadius = 10
        view.addSubview(line)
       
        line2 = UIView(frame: CGRect(x: 30, y: 331, width: 350, height:1))
         line2.backgroundColor = .gray
         line2.layer.cornerRadius = 10
         view.addSubview(line2)
        line3 = UIView(frame: CGRect(x: 30, y: 416, width: 350, height:1))
         line3.backgroundColor = .gray
         line3.layer.cornerRadius = 10
         view.addSubview(line3)
        line4 = UIView(frame: CGRect(x: 30, y: 511, width: 350, height:1))
         line4.backgroundColor = .gray
         line4.layer.cornerRadius = 10
         view.addSubview(line4)
        
        Square2 = UIView(frame: CGRect(x: 30, y: 470, width: 350, height:40))
        Square2.backgroundColor = .systemGray6
        Square2.layer.cornerRadius = 10
        view.addSubview(Square2)
        view.addSubview(listeBtn1)
        view.addSubview(listeBtn)
        self.view.addSubview(textView)
        self.view.addSubview(textView2)
        view.addSubview(dropdownlable)
        view.addSubview(registerBtn)
        view.addSubview(dropdownlable2)
        view.addSubview(timeOfArrival)
        view.addSubview(timeTF)
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 60
        stackView.addArrangedSubview(name)
        stackView.addArrangedSubview(helath)
        stackView.addArrangedSubview(specailNeeds)
        stackView.addArrangedSubview(flightNumber)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(stackView)
        stackView.leftAnchor.constraint(equalTo: self.view.leftAnchor,constant: 20).isActive = true
        stackView.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 160).isActive = true
    

        listeBtn1.topAnchor.constraint(equalTo: view.topAnchor, constant: 450).isActive = true
        listeBtn1.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 180).isActive = true
        listeBtn1.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

       
        listeBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 290).isActive = true
        listeBtn.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 30).isActive = true
        listeBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        textView.contentInsetAdjustmentBehavior = .automatic
        textView.textAlignment = .left
        textView.backgroundColor = UIColor.systemGray6
        textView.textColor = UIColor.black
        textView.font = .systemFont(ofSize: 20)
        textView.isSelectable = true
        textView.isEditable = false
        textView.dataDetectorTypes = UIDataDetectorTypes.link
        textView.layer.cornerRadius = 10
        textView.autocorrectionType = UITextAutocorrectionType.yes
        textView.spellCheckingType = UITextSpellCheckingType.yes
        textView.isEditable = true
        textView.delegate = self

        
        textView2.contentInsetAdjustmentBehavior = .automatic
        textView2.textAlignment = .left
        textView2.backgroundColor = UIColor.systemGray6
        textView2.textColor = UIColor.black
        textView2.font = .systemFont(ofSize: 20)
        textView2.isSelectable = true
        textView2.isEditable = false
        textView2.dataDetectorTypes = UIDataDetectorTypes.link
        textView2.layer.cornerRadius = 10
        textView2.autocorrectionType = UITextAutocorrectionType.yes
        textView2.spellCheckingType = UITextSpellCheckingType.yes
        textView2.isEditable = true
        textView2.delegate = self

    
      
        dropdownlable.topAnchor.constraint(equalTo: view.topAnchor, constant: 300).isActive = true
        dropdownlable.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 30).isActive = true
        dropdownlable.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
      
        registerBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 700).isActive = true
        registerBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32).isActive = true
        registerBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32).isActive = true
        registerBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        dropdownlable2.topAnchor.constraint(equalTo: view.topAnchor, constant: 480).isActive = true
        dropdownlable2.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        dropdownlable2.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
    
        timeOfArrival.topAnchor.constraint(equalTo: view.topAnchor, constant: 520).isActive = true
        timeOfArrival.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        
       
        timeTF.topAnchor.constraint(equalTo: view.topAnchor, constant: 550).isActive = true
        timeTF.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        timeTF.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        timeTF.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        dropDown.anchorView = Square
        dropDown.dataSource = data
        DropDown.startListeningToKeyboard()
        dropDown.direction = .bottom
        
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.topOffset = CGPoint(x: 0, y:-(dropDown.anchorView?.plainView.bounds.height)!)
        
        dropDown1.anchorView = Square2
        dropDown1.dataSource = data2
        dropDown1.direction = .bottom
        
        dropDown1.bottomOffset = CGPoint(x: 0, y:(dropDown1.anchorView?.plainView.bounds.height)!)
        dropDown1.topOffset = CGPoint(x: 0, y:-(dropDown1.anchorView?.plainView.bounds.height)!)
        
        
    }
    func openTimePicker()  {
        timePicker.datePickerMode = UIDatePicker.Mode.time
        timePicker.frame = CGRect(x: 200, y: 600, width:300, height: 150)
        timePicker.backgroundColor = UIColor.green
        self.view.addSubview(timePicker)
        timePicker.addTarget(self, action: #selector(AskForHelp.startTimeDiveChanged), for: UIControl.Event.valueChanged)
    }

    @objc func startTimeDiveChanged(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        timeTF.text = formatter.string(from: sender.date)
        timePicker.removeFromSuperview() 
    }
    
   
      
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }

    
    @objc func listbt() {
        dropDown.show()
    }
    
    @objc func listbt2() {
        dropDown1.show()
    }
    
    @objc func sendPressed() {
        
        let  name = textView.text
         let specailNeeds = textView2.text
        UserDefaults.standard.set(name,forKey: "namekey")
        UserDefaults.standard.set(specailNeeds,forKey: "specailNeeds")
        
        Firestore.firestore().collection("profile").document().setData([
            "name": name ?? "",
            "helath": data ,
            "specailNeeds":specailNeeds ?? "",
            "flightNumber": data2 ,
        ], merge: true)
    }
    
    }
      




    
    




