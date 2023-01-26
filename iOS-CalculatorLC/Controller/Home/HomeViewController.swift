//
//  HomeViewController.swift
//  iOS-CalculatorLC
//
//  Created by u633168 on 25/01/2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: Outlets
    
    // Label
    @IBOutlet weak var resultLabel: UILabel!
    // Numbers
    
    @IBOutlet weak var number0: UIButton!
    @IBOutlet weak var number1: UIButton!
    @IBOutlet weak var number2: UIButton!
    @IBOutlet weak var number3: UIButton!
    @IBOutlet weak var number4: UIButton!
    @IBOutlet weak var number5: UIButton!
    @IBOutlet weak var number6: UIButton!
    @IBOutlet weak var number7: UIButton!
    @IBOutlet weak var number8: UIButton!
    @IBOutlet weak var number9: UIButton!
    
    // Operators
    
    @IBOutlet weak var operatorAC: UIButton!
    @IBOutlet weak var operatorPlusMinus: UIButton!
    @IBOutlet weak var operatorPorcent: UIButton!
    @IBOutlet weak var operatorEqual: UIButton!
    @IBOutlet weak var operatorPlus: UIButton!
    @IBOutlet weak var operatorMinus: UIButton!
    
    @IBOutlet weak var operatorMultiplication: UIButton!
    
    @IBOutlet weak var operationDivision: UIButton!
    //Comma
    @IBOutlet weak var commaButton: UIButton!
    
    //MARK: Variables
    
    private var total: Double = 0
    private var temp: Double = 0
    private var operating = false
    private var decimal = false
    private var operation: OperationType = .none
    
    enum OperationType{
        case none, plus, minus, multiplication, division, percent
    }
    
    // MARK: Constants
    
    private let kDecimalSeparator = Locale.current.decimalSeparator!
    private let kMaxLength = 9
    private let kMaxValue: Double = 999999999
    private let kMinValue: Double = 0.00000001
    
    // Formateo de valores auxiliares
        private let auxFormatter: NumberFormatter = {
            let formatter = NumberFormatter()
            let locale = Locale.current
            formatter.groupingSeparator = ""
            formatter.decimalSeparator = locale.decimalSeparator
            formatter.numberStyle = .decimal
            formatter.maximumIntegerDigits = 100
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 100
            return formatter
        }()
        
        // Formateo de valores auxiliares totales
        private let auxTotalFormatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.groupingSeparator = ""
            formatter.decimalSeparator = ""
            formatter.numberStyle = .decimal
            formatter.maximumIntegerDigits = 100
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 100
            return formatter
        }()
        
        // Formateo de valores por pantalla por defecto
        private let printFormatter: NumberFormatter = {
            let formatter = NumberFormatter()
            let locale = Locale.current
            formatter.groupingSeparator = locale.groupingSeparator
            formatter.decimalSeparator = locale.decimalSeparator
            formatter.numberStyle = .decimal
            formatter.maximumIntegerDigits = 9
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 8
            return formatter
        }()
        
        // Formateo de valores por pantalla en formato científico
        private let printScientificFormatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .scientific
            formatter.maximumFractionDigits = 3
            formatter.exponentSymbol = "e"
            return formatter
        }()
    
    
    
    // MARK: Initialization
    init(){
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    // MARK: Life Cycle 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        commaButton.setTitle(kDecimalSeparator, for: .normal)
        result()
        
    }
    
    // MARK: Actions
    
    
    @IBAction func operatorACAction(_ sender: UIButton) {
        clear()
        sender.shine()
    }
    @IBAction func operatorPlusMinusAction(_ sender: UIButton) {
    
        temp = temp * (-1)
        resultLabel.text = printFormatter.string(from: NSNumber(value: temp))
        sender.shine()
    }
    @IBAction func operatorEqualAction(_ sender: UIButton) {
        result()
        
        sender.shine()
    }
    
    @IBAction func operatorPlusAction(_ sender: UIButton) {
        result()
        operating = true
        operation = .plus
        sender.shine()
    }
    @IBAction func commaAction(_ sender: UIButton) {
        let currentTemp = auxTotalFormatter.string(from: NSNumber(value: temp))!
              if resultLabel.text?.contains(kDecimalSeparator) ?? false || (!operating && currentTemp.count >= kMaxLength) {
                  return
              }
              
              resultLabel.text = resultLabel.text! + kDecimalSeparator
              decimal = true
              
//              selectVisualOperation()
              
              sender.shine()
    }
    
    @IBAction func operatorMinusAction(_ sender: UIButton) {
        result()
        operating = true
        operation = .minus
        sender.shine()
    }
    @IBAction func operatorMultiplicationAction(_ sender: UIButton) {
        result()
        operating = true
        operation = .multiplication
        sender.shine()
    }
    @IBAction func operatorDivisionAction(_ sender: UIButton) {
        result()
        operating = true
        operation = .division
        sender.shine()
    }
    @IBAction func operatorPorcentAction(_ sender:UIButton) {
        if operation != .percent {
                    result()
                }
                operating = true
                operation = .percent
                result()
                
                sender.shine()
    }
    // Number Action
    @IBAction func numberAction(_ sender: UIButton) {
        operatorAC.setTitle("C", for: .normal)
                
                var currentTemp = auxTotalFormatter.string(from: NSNumber(value: temp))!
                if !operating && currentTemp.count >= kMaxLength {
                    return
                }
                
                currentTemp = auxFormatter.string(from: NSNumber(value: temp))!
                
                // Hemos seleccionado una operación
                if operating {
                    total = total == 0 ? temp : total
                    resultLabel.text = ""
                    currentTemp = ""
                    operating = false
                }
                
                // Hemos seleccionado decimales
                if decimal {
                    currentTemp = "\(currentTemp)\(kDecimalSeparator)"
                    decimal = false
                }
                
                let number = sender.tag
                temp = Double(currentTemp + String(number))!
                resultLabel.text = printFormatter.string(from: NSNumber(value: temp))
                
                //selectVisualOperation()
                
                sender.shine()
    }
    
    // MARK: Funciones
    
    // Borrar todo...
    private func clear(){
        operation = .none
        operatorAC.setTitle("AC", for: .normal)
        
        if temp != 0 {
            temp = 0
            resultLabel.text = "0"
        } else {
            total = 0
            result()
        }
        
    }
    
    private func result(){
        switch operation{
            
        case .none: break
                // no hacemos nada
        case .plus:
            total = total + temp
            break
        case .minus:
            total = total - temp
            break
        case .multiplication:
            total = total * temp
            break
        case .division:
            total = total / temp
            break
        case .percent:
            temp = temp / 100
            total = temp
            break
        }
        
        // formateo en pantalla
        if total <= kMaxValue || total >= kMinValue {
            resultLabel.text = printFormatter.string(from: NSNumber(value: total))
        }
        print("TOTAL:",total)
    }
    
}
