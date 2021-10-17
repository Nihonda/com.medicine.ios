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
    
    // region
    @State private var regionBinding: String = ""
    @State private var isRegionError = false
    @State private var isRegionActive = false

    var body: some View {
        ZStack(alignment: .leading) {
            // background color
//            Color(red: 0.81, green: 0.81, blue: 0.81)
            Color(.systemBackground)
                .edgesIgnoringSafeArea(.all)

            VStack(alignment: .leading, spacing: Value.FIELDS_PADDING) {
                Spacer()
                    .frame(height: Value.TOP_PADDING_RATIO)
                
                Text("Регистрация")
                    .font(.largeTitle)
//                    .font(.system(size: 36))
                
                Spacer()
                    .frame(height: Value.TOP_PADDING_RATIO)
                
                // MARK: ELEMENTS
                VStack(spacing: 0) {
                    // email
                    TextFieldView(placeholder: "Электронная почта", bindingText: $emailBinding, errorMessage: "Почта введена не правильно")
                        .onTapGesture {
                            showGenderPicker = false
                            showBirthdayPicker = false
                        }
                    
                    // gender
                    TextFieldView(placeholder: "Пол", bindingText: $genderBinding, errorMessage: "Выберите пол", chevronName: "chevron.down")
                    .onTapGesture {
                        self.showBirthdayPicker = false
                        withAnimation(.spring()) {
                            DispatchQueue.global().async {
                                self.showGenderPicker = true
                            }
                        }
                    }
                    
                    // date of birth
                    TextFieldView(placeholder: "Дата рождения", bindingText: $birthdayBinding, errorMessage: "Выберите дату рождения", chevronName: "chevron.down")
                    .onTapGesture {
                        self.showGenderPicker = false
                        withAnimation(.spring()) {
                            DispatchQueue.global().async {
                                self.showBirthdayPicker = true
                            }
                        }
                    }
                    
                    // region
                    TextFieldView(placeholder: "Область", bindingText: $regionBinding, errorMessage: "Выберите область", chevronName: "chevron.right")
                        .multilineTextAlignment(.leading)
                        .background(NavigationLink(destination: CoateView(), isActive: $isRegionActive) {
                            EmptyView()
                        })
                        .onTapGesture {
                            self.showBirthdayPicker = false
                            self.showGenderPicker = false

                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                self.isRegionActive = true
                            }
                        }
                }
                
                Spacer()
                
                HStack {
                    Spacer()
                    Button(action: {
                        
                    }) {
                        Text("Зарегистрироваться".uppercased())
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .padding(.horizontal, 20)
                            .foregroundColor(Color.white)
                            .background(Color(red: 0, green: 163/255, blue: 1))
                            .cornerRadius(10)
                    }
                    Spacer()
                }

                Spacer()

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
                                 self.dismissKeyboard()
                            }
                            .onChange(of: birthDate) { value in
                                birthdayBinding = dateFormatter.string(from: value)
                            }
                    }
                }
            }
            .padding(.horizontal, Value.HORIZONTAL_PADDING)
        }
        .frame(width: Screen.width)
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Group {
//                RegistrationView().colorScheme(.light)
                RegistrationView().colorScheme(.dark)
            }
        }
    }
}

extension RegistrationView {
    private func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct TextFieldView:  View {
    var placeholder: String
    @Binding var bindingText: String
    var errorMessage: String
    var chevronName: String = ""
//    let onChangeHandler: (String) -> ()
    
    @State var isError: Bool = false
    @State var isFocused: Bool = false

    var body: some View {
        HStack(alignment:.top, spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                if chevronName.isEmpty {
                    innerTextField()
                } else {
                    innerTextField()
                        .disabled(true)
                        .modifier(TextFieldArrow(systemName: chevronName))
                }

                VStack(spacing: 10) {
                    if isError {
                        Text("⇑ \(errorMessage)")
                            .font(.system(size: 12))
                            .fontWeight(.regular)
                            .foregroundColor(.red)
                            .padding(.leading)
                    }
                }
                .frame(height: 20)
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    private func innerTextField() -> some View {
        return TextField(placeholder, text: self.$bindingText.onChange(onFieldChanged), onEditingChanged: { editingChanged in
            isFocused = editingChanged
            if editingChanged {
                // focused
                
            } else {
                // focus lost
                
            }
        })
            .disableAutocorrection(true)
            .font(.title2)
            .frame(height: 30)
            .padding(7)
            .overlay(
                RoundedRectangle(cornerRadius: 10.0)
                    .strokeBorder(Color(uiColor: UIColor.systemGray3), style: StrokeStyle(lineWidth: 0.5))
            )
            .background(RoundedRectangle(cornerRadius: 10.0).fill(isError ? Color(.systemPink) : isFocused || !bindingText.isEmpty ? Color.white : Color(.secondarySystemBackground)))
    }
    
    private func onFieldChanged(_ text: String) {
        
    }
}
