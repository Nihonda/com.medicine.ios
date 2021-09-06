//
//  RegistrationView.swift
//  RegistrationView
//
//  Created by Nurlan Nihonda on 23/8/21.
//

import SwiftUI

enum Gender: String, CaseIterable {
    case male = "Мужской"
    case female = "Женский"
    case none = ""
}

struct RegistrationView: View {
    typealias Value = Layout.Registration
    
    /*
     States
    */
    // email
    @State private var emailBinding: String = ""
    @State private var isEmailFocused = false
    @State private var isEmailError: Bool = false
    
    // gender
    @State private var genderBinding: String = ""
    @State private var isGenderError: Bool = false
    @State private var showGenderPicker: Bool = false
    
    // birthday
    var dateClosedRange: ClosedRange<Date> {
        let min = Calendar.current.date(byAdding: .year, value: -99, to: Date())!
        let max = Calendar.current.date(byAdding: .year, value: -15, to: Date())!
        return min...max
    }
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.locale = Locale.init(identifier: "ru_RU")
        formatter.dateFormat = "YYYY-MM-dd"
        return formatter
    }
    @State private var birthdayBinding: String = ""
    @State private var birthDate = Date()
    @State private var showBirthdayPicker = false
    @State private var isBirthdayError: Bool = false

    var body: some View {
        ZStack(alignment: .leading) {
            // background color
            Color(red: 0.97, green: 0.98, blue: 1)
                .edgesIgnoringSafeArea(.all)

            VStack(alignment: .leading, spacing: Value.FIELDS_PADDING) {
                Spacer()
                    .frame(height: Value.TOP_PADDING_RATIO)
                
                Text("Регистрация")
                    .font(.system(size: 36))
                
                Spacer()
                    .frame(height: Value.TOP_PADDING_RATIO)
                
                VStack(spacing: 3) {
                    // email
                    HStack(alignment:.top, spacing: 0) {
                        VStack(alignment: .leading, spacing: 0) {
                            TextField("Электронная почта", text: self.$emailBinding.onChange(onEmailChanged), onEditingChanged: { editingChanged in
                                isEmailFocused = editingChanged
                                if editingChanged {
                                    // focused
                                    
                                } else {
                                    // focus lost
                                    
                                }
                            })
                                .disableAutocorrection(true)
                                .font(Font.system(size: 16))
                                .frame(height: 30)
                                .padding(7)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10.0)
                                        .strokeBorder(Color.black, style: StrokeStyle(lineWidth: 0.5))
                                )
                                .background(RoundedRectangle(cornerRadius: 10.0).fill(isEmailError ? Color(red: 0.93, green: 0.74, blue: 0.71, opacity: 1.0) : isEmailFocused || !emailBinding.isEmpty ? Color.white : Color(red: 230/255, green: 236/255, blue: 239/255)))
                            
                            VStack {
                                if isEmailError {
                                    Text("Проверьте правильность")
                                        .font(.system(size: 12))
                                        .fontWeight(.light)
                                        .foregroundColor(.red)
                                        .padding(.leading)
                                }
                            }
                            .frame(height: 14)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    
                    // gender
                    HStack(alignment:.top, spacing: 0) {
                        VStack(alignment: .leading, spacing: 0) {
                            TextField("Пол", text: self.$genderBinding.onChange(onGenderChanged), onEditingChanged: { editingChanged in
                                if editingChanged {
                                    // focused
                                    
                                } else {
                                    // focus lost
                                    
                                }
                            })
                                .disableAutocorrection(true)
                                .disabled(true)
                                .font(Font.system(size: 16))
                                .frame(height: 30)
                                .padding(7)
                                .modifier(TextFieldArrow(systemName: "chevron.down"))
                                .overlay(
                                    VStack {
                                        RoundedRectangle(cornerRadius: 10.0)
                                            .strokeBorder(Color.black, style: StrokeStyle(lineWidth: 0.5))
                                    }
                                )
                                .background(RoundedRectangle(cornerRadius: 10.0).fill(isEmailError ? Color(red: 0.93, green: 0.74, blue: 0.71, opacity: 1.0) : !genderBinding.isEmpty ? Color.white : Color(red: 230/255, green: 236/255, blue: 239/255)))
                            
                            VStack {
                                if isGenderError {
                                    Text("Выберите пол")
                                        .font(.system(size: 12))
                                        .fontWeight(.light)
                                        .foregroundColor(.red)
                                        .padding(.leading)
                                }
                            }
                            .frame(height: 14)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .onTapGesture {
                        self.showGenderPicker = true
                    }
                    
                    // date of birth
                    HStack(alignment:.top, spacing: 0) {
                        VStack(alignment: .leading, spacing: 0) {
                            TextField("Дата рождения", text: self.$birthdayBinding.onChange(onBirthdayChanged), onEditingChanged: { editingChanged in
                                if editingChanged {
                                    // focused
                                    
                                } else {
                                    // focus lost
                                    
                                }
                            })
                                .disableAutocorrection(true)
                                .disabled(true)
                                .font(Font.system(size: 16))
                                .frame(height: 30)
                                .padding(7)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10.0)
                                        .strokeBorder(Color.black, style: StrokeStyle(lineWidth: 0.5))
                                )
                                .background(RoundedRectangle(cornerRadius: 10.0).fill(isBirthdayError ? Color(red: 0.93, green: 0.74, blue: 0.71, opacity: 1.0) : !birthdayBinding.isEmpty ? Color.white : Color(red: 230/255, green: 236/255, blue: 239/255)))
                            
                            VStack {
                                if isBirthdayError {
                                    Text("Проверьте правильность")
                                        .font(.system(size: 12))
                                        .fontWeight(.light)
                                        .foregroundColor(.red)
                                        .padding(.leading)
                                }
                            }
                            .frame(height: 14)
                        }
                        .onTapGesture {
                            self.showBirthdayPicker = true
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                
                Spacer()
                
            }
            .padding(.horizontal, Value.HORIZONTAL_PADDING)
            
            /*
             * Picker section
             */
            if showGenderPicker {
                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()

                        Button(action: {
                            showGenderPicker = false
                        }) {
                            Text("Закрыть")
                        }
                        .padding([.horizontal, .vertical], 10)
                    }

                    Picker("Gender", selection: $genderBinding) {
                        Text("Выберите пол")
                            .tag(Gender.none.rawValue)
                        Text(Gender.male.rawValue)
                            .tag(Gender.male.rawValue)
                        Text(Gender.female.rawValue)
                            .tag(Gender.female.rawValue)
                    }
                    .pickerStyle(WheelPickerStyle())
                    .onAppear {
                        self.dismissKeyboard()
                    }
                    .onChange(of: genderBinding) {
                        if genderBinding == "Выберите пол" {
                            genderBinding = ""
                        }
                        print($0)
                    }
                }
            }
            
            if showBirthdayPicker {
                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()

                        Button(action: {
                            showBirthdayPicker = false
                        }) {
                            Text("Закрыть")
                        }
                        .padding([.horizontal, .vertical], 10)
                    }

                    DatePicker(
                        "Please choose date",
                        selection: $birthDate,
                        in: dateClosedRange,
                        displayedComponents: .date
                    )
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                        .environment(\.locale, Locale.init(identifier: "ru_RU"))
                        .onAppear {
                            // self.dismissKeyboard()
                        }
                        .onChange(of: birthDate) { value in
                            birthdayBinding = dateFormatter.string(from: value)
                        }
                }
            }
        }
        .frame(width: Screen.width)
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}

extension RegistrationView {
    private func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    private func onEmailChanged(_ text: String) {
        
    }
    
    private func onGenderChanged(_ text: String) {

    }
    
    private func onBirthdayChanged(_ text: String) {
        
    }
}
