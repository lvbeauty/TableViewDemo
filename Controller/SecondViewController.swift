//
//  SecondViewController.swift
//  Touch
//
//  Created by Tong Yi on 5/4/20.
//  Copyright © 2020 Tong Yi. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet var brandTF: UITextField!
    @IBOutlet var makeupTF: UITextField!
    @IBOutlet var makeupPoster: UIImageView!
    @IBOutlet var moneyTF: UITextField!
    @IBOutlet var rateImage: UIImageView!
    @IBOutlet var rateNumTF: UITextField!
    @IBOutlet weak var detailTF: UITextView!
    @IBOutlet var mType: UITextField!
    @IBOutlet var rateTableView: UITableView!
    
    let rateStar: [UIImage] = [#imageLiteral(resourceName: "5_Star_Rating_System_1_star"), #imageLiteral(resourceName: "5_Star_Rating_System_2_stars"), #imageLiteral(resourceName: "5_Star_Rating_System_3_stars"), #imageLiteral(resourceName: "5_Star_Rating_System_4_stars"), #imageLiteral(resourceName: "5_Star_Rating_System_5_stars")]
    
    var sec = 0
    var row = 0
    var tagOfSave: Int = 0
    var delegate: DataArrangeDelegate?
    var brand: String?
    var makeup: String?
    var makeupPos: UIImage?
    var money: String?
    var rateImg: UIImage?
    var rateN: String?
    var makeupType: String?
    var detail: String?
    
    let makeupTypeCase = MakeupType.allCases
    private var pView: UIPickerView! = UIPickerView()
    private let photoPickCtrl = UIImagePickerController()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        pViewSetup()
        imgPkrSetUp()
        dropDownSetup()
    }
    
    // MARK: - Setup
    func setup()
    {
        self.navigationItem.leftBarButtonItem?.title = "Touch"
        let saveButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(saveButtonTapped(_:)))
        navigationItem.rightBarButtonItem = saveButton
        if tagOfSave == 0
        {
            self.title = "Add New Makeup"
        }else{
            self.title = "Touch Makeup"
        }
        brandTF.text = self.brand
        makeupTF.text = self.makeup
        makeupPoster.image = self.makeupPos
        mType.text = self.makeupType
        moneyTF.text = self.money
        rateImage.image = self.rateImg
        rateNumTF.text = self.rateN
        detailTF.text = self.detail
        mType.inputView = pView
    }
    
    @objc func saveButtonTapped(_ sender: UIBarButtonItem)
    {
        if let brandT = brandTF.text, let makeupT = makeupTF.text, let mtype = mType.text,  let makeupPo = makeupPoster.image, let moneyT = moneyTF.text, let rateI = rateImage.image, let rateN = rateNumTF.text, let det = detailTF.text
        {
            var makeupType: MakeupType
            
            switch mtype {
            case "Face":
                makeupType = .Face
            case "Eye":
                makeupType = .Eye
            case "Lip":
                makeupType = .Lip
            case "Brush":
                makeupType = .Brush
            default:
                makeupType = .Others
            }
                
            let data_Transferred = TouchMakeup(brand: brandT, makeup: makeupT, makeupType: makeupType, makeupPoster: makeupPo, money: moneyT, rateImage: rateI, rateNUm: rateN, detail: det)
            if self.tagOfSave == 1
            {
                self.delegate?.modifyExistMakeup(sec: self.sec, row: self.row, data: data_Transferred)
            }else{
                self.delegate?.addNewMakeup(data: data_Transferred)
            }
        }
        
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Picker View

extension SecondViewController: UIPickerViewDelegate, UIPickerViewDataSource
{
    func pViewSetup()
    {
        pView.dataSource = self
        pView.delegate = self
        dismissPV()
    }
    
    // MARK: - Picker View Data Source
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        makeupTypeCase.count
    }
    
    // MARK: - Picker View Delegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return makeupTypeCase[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.mType.text = makeupTypeCase[row].rawValue
    }
    
    func dismissPV()
    {
        // difine tool Bar of the accessory view
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let button = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(action))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        mType.inputAccessoryView = toolBar
    }
    
    @objc func action()
    {
        mType.endEditing(true)
    }
}

// MARK: - Image Picker and Gesture

extension SecondViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate
{
    func imgPkrSetUp()
    {
        photoPickCtrl.delegate = self
        photoPickCtrl.allowsEditing = true
        photoPickCtrl.sourceType = UIImagePickerController.isSourceTypeAvailable(.camera) ? .camera : .savedPhotosAlbum
        makeupPoster.isUserInteractionEnabled = true
        let imageGesture = UITapGestureRecognizer(target: self, action: #selector(photoPickButtonTapped(_:)))
        imageGesture.delegate = self
        imageGesture.numberOfTouchesRequired = 1
        imageGesture.numberOfTapsRequired = 1
        makeupPoster.addGestureRecognizer(imageGesture)
    }
    
    @objc func photoPickButtonTapped(_ sender: UIImageView) {
        self.present(photoPickCtrl, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        makeupPoster.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

// MARK: - Drop Down Menu

extension SecondViewController: UITableViewDataSource, UITableViewDelegate
{
    func dropDownSetup() {
        rateTableView.isHidden = true
        rateTableView.delegate = self
        rateTableView.dataSource = self
        rateImage.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(rateImgTapped(_:)))
        tapGesture.delegate = self
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        rateImage.addGestureRecognizer(tapGesture)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rateStar.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rateCell", for: indexPath)
        cell.imageView?.image = rateStar[indexPath.row]
        return cell
    }
    
    @objc func rateImgTapped(_ sender: UIImage)
    {
        UIView.animate(withDuration: 0.3)
        {
            self.rateTableView.isHidden = !self.rateTableView.isHidden
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rateImage.image = rateStar[indexPath.row]
        self.rateTableView.isHidden = true
    }
    
    
}
