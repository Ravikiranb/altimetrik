//
//  SearchOptionsViewController.swift
//  RavikiranB
//
//  Created by RaviKiran B on 14/09/20.
//  Copyright © 2020 RaviKiran B. All rights reserved.
//

import UIKit

protocol SearchOptionsViewControllerDelegate:class {
    func filterAlbums(_ searchOptions:SearchOptionViewModel)
}

class SearchOptionsViewController: UIViewController {
    @IBOutlet weak var artistNameTextField: UITextField!
    @IBOutlet weak var trackNameTextField: UITextField!
    @IBOutlet weak var collectionNameTextField: UITextField!
    @IBOutlet weak var collectionPriceTextField: UITextField!
    @IBOutlet weak var dateButton: UIButton!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var selectedDate:Date?
    weak var delegate:SearchOptionsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    @IBAction func dateButtonClicked(_ sender: Any) {
        datePicker.isHidden = !datePicker.isHidden
    }
    
    @IBAction func searchButtonClicked(_ sender: Any) {
        guard let artistName = artistNameTextField.text else {
            return
        }
        guard  let trackName = trackNameTextField.text else {
            return
        }
        
        let searchOptionVM = SearchOptionViewModel.init(artistName: artistName, trackName: trackName, collectionName: collectionNameTextField.text, collectionPrice: Double(collectionNameTextField.text ?? ""), releaseDate: selectedDate)
        delegate?.filterAlbums(searchOptionVM)
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dateChanged(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yy"
        
        dateButton.setTitle(formatter.string(from: datePicker.date), for: .normal)
        selectedDate = datePicker.date
    }
    
    
}
