//
//  Protocol.swift
//  Extension
//
//  Created by Николай Никитин on 27.01.2022.
//

import Foundation

protocol ScriptDelegate: class {

  func loadSelectedScript(scriptString: String)
  
  func deleteSelectedScript(scriptString: String)

}
