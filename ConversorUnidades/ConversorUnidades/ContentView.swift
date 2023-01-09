//
//  ContentView.swift
//  ConversorUnidades
//
//  Created by Ion Jaureguialzo Sarasola on 18/12/20.
//

import SwiftUI

enum Medida: String, CaseIterable, Identifiable {
    case centimetros
    case metros
    case kilometros

    var id: String { self.rawValue }
}
enum Conversion: String, CaseIterable, Identifiable {
    case Pulgadas
    case Pies
    case Millas

    var id: String { self.rawValue }
}

func Convert(medida: Medida, num: Double, conv: Conversion)-> Double{
    var resultado: Double
    switch(medida){
    case Medida.centimetros:
        if conv == Conversion.Pulgadas{
            resultado = num * 2.54
        } else if conv == Conversion.Pies {
            resultado = num * 30.48
        } else{
            resultado = num * 160900
        }
    case Medida.metros:
        if conv == Conversion.Pulgadas{
            resultado = num * 39.37
        } else if conv == Conversion.Pies {
            resultado = num * 3.281
        } else{
            resultado = num * 1609
        }
    case Medida.kilometros:
        if conv == Conversion.Pulgadas{
            resultado = num * 39370
        } else if conv == Conversion.Pies {
            resultado = num * 3281
        } else{
            resultado = num * 1.609
        }
    
    }
    return resultado
}

struct ContentView: View {
    
    @State private var speed = 50.0
    @State private var isEditing = false
    
    @State private var selec_medida = Medida.metros
    @State private var selec_conversion = Conversion.Pies
    
    

    var body: some View {
            VStack {
                Spacer()
                
                Picker("Topping", selection: $selec_medida) {
                    ForEach(Medida.allCases, id: \.self) { medida in
                        Text(medida.rawValue.capitalized)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                Divider()
                
                Slider(
                    value: $speed,
                    in: 0...100,
                    step: 0.25,
                    
                    onEditingChanged: { editing in
                        isEditing = editing
                    },
                    minimumValueLabel: Text("0"),
                    maximumValueLabel: Text("100")
                ) {
                    Text("Speed")
                }
                Divider()
                
                Picker("Topping", selection: $selec_conversion) {
                    ForEach(Conversion.allCases, id: \.self) { conversion in
                        Text(conversion.rawValue.capitalized)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                Spacer()
                
                ZStack{
                    Circle()
                        .fill(Color.purple)
                    
                    VStack{
                        let efe = Convert(medida: Medida(rawValue: selec_medida.rawValue) ?? Medida.metros, num: speed, conv: Conversion(rawValue: selec_conversion.rawValue) ?? Conversion.Pies)
                        
                        Text(String(format: "%.2f %@ son", speed, selec_medida.rawValue))
                            .foregroundColor(Color.white).font(.system(size: 20))
                      
                        Text(String(format:"%.2f", efe))
                            .foregroundColor(Color.white).font(.system(size: 70))
                    
                        Text(selec_conversion.rawValue)
                            .foregroundColor(Color.white).font(.system(size: 30))
                    }
                }
                Spacer()
                
            }
            .padding(.horizontal, 30)
         
           
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
