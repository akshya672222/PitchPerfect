//
//  ViewController.swift
//  PitchPerfect
//
//  Created by AKSHAY SUNDERWANI on 21/04/17.
//  Copyright © 2017 AKSHAY SUNDERWANI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblRecordingLabel: UILabel!
    @IBOutlet weak var stopRecordingButton: UIButton!
    @IBOutlet weak var startRecordingButton: UIButton!
    
    @IBAction func recordVoice(_ sender: Any) {
        lblRecordingLabel.text = "Recording in Progress"
        stopRecordingButton.isEnabled = true
        startRecordingButton.isEnabled = false
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        lblRecordingLabel.text = "Tap to Record"
        stopRecordingButton.isEnabled = false
        startRecordingButton.isEnabled = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        stopRecordingButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

