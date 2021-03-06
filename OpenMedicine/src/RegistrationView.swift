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
    
    @State var isLoading = false
    @AppStorage("uuid") var uuid: String = ""
    /*
     States
    */
    // email
    @AppStorage("email") var email: String = ""
    @State private var emailBinding: String = ""
    @State private var isEmailFocused = false
    @State private var isEmailError: Bool = false
    
    // gender
    @AppStorage("gender") var gender: String = ""
    @State private var genderBinding: String = ""
    @State private var isGenderError: Bool = false
    @State private var showGenderPicker: Bool = false
    
    // birthday
    @AppStorage("birthday") var birthday: String = ""
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
    @AppStorage("coate_item") var coateItem: Data = Data()
    @State private var regionBinding: String = ""
    @State private var isRegionError = false
    @State private var isRegionActive = false

    var body: some View {
        ZStack(alignment: .leading) {
            if isLoading {
                ZStack {
                    Color(.clear)
                        .ignoresSafeArea()
                    ProgressView("Загрузка")
                }
                .foregroundColor(Color.primary)
                .cornerRadius(20)
                .zIndex(1)
            }

            VStack(alignment: .leading, spacing: Value.FIELDS_PADDING) {
                Spacer()
                    .frame(height: Value.TOP_PADDING_RATIO)
                
                Text("Регистрация")
                    .font(.largeTitle)
                
                Spacer()
                    .frame(height: Value.TOP_PADDING_RATIO)
                
                // MARK: ELEMENTS
                VStack(spacing: 0) {
                    // email
                    TextFieldView(placeholder: "Электронная почта", bindingText: $emailBinding, isError: $isEmailError, errorMessage: "Почта введена не правильно", onChangeHandler: textFieldValidatorEmail)
                        .onTapGesture {
                            showGenderPicker = false
                            showBirthdayPicker = false
                        }
                    
                    // gender
                    TextFieldView(placeholder: "Пол", bindingText: $genderBinding, isError: $isGenderError, errorMessage: "Выберите пол", chevronName: "chevron.down", onChangeHandler: genderIsEmpty)
                    .onTapGesture {
                        self.showBirthdayPicker = false
                        withAnimation(.spring()) {
                            DispatchQueue.global().async {
                                self.showGenderPicker = true
                            }
                        }
                    }
                    
                    // date of birth
                    TextFieldView(placeholder: "Дата рождения", bindingText: $birthdayBinding, isError: $isBirthdayError, errorMessage: "Выберите дату рождения", chevronName: "chevron.down", onChangeHandler: birthdayIsEmpty)
                    .onTapGesture {
                        self.showGenderPicker = false
                        withAnimation(.spring()) {
                            DispatchQueue.global().async {
                                self.showBirthdayPicker = true
                            }
                        }
                    }
                    
                    // region
                    TextFieldView(placeholder: "Область/Район/Город/Село", bindingText: $regionBinding, isError: $isRegionError, errorMessage: "Выберите область", chevronName: "chevron.right", onChangeHandler: coateIsEmpty)
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
                
                // MARK: REGISTER BUTTON
                HStack {
                    Spacer()
                    Button(action: {
                        isEmailError = !textFieldValidatorEmail(emailBinding)
                        isGenderError = !genderIsEmpty(genderBinding)
                        isBirthdayError = !birthdayIsEmpty(birthdayBinding)
                        isRegionError = !coateIsEmpty(regionBinding)
                        
                        if isEmailError || isGenderError || isBirthdayError || isRegionError {
                            print("[ERROR] : \(String(describing: type(of: self)))")
                        } else {
                            // register device
                            checkUserExists()
                        }
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

                // MARK: PICKERS
                if showGenderPicker {
                    genderPickerSubview
                }
            
                if showBirthdayPicker {
                    birthdayPickerSubview
                }
            }
            .padding(.horizontal, Value.HORIZONTAL_PADDING)
            .disabled(isLoading)
            .blur(radius: isLoading ? 1 : 0)
        }
        .frame(width: Screen.width)
        .onAppear {
            restoreCoate()
        }
    }
    
    // MARK: SUBVIEWS
    private var genderPickerSubview: some View {
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
                isGenderError = genderBinding.isEmpty
            }
        }
    }
    
    private var birthdayPickerSubview: some View {
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
                    isBirthdayError = birthdayBinding.isEmpty
                }
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Group {
                RegistrationView().colorScheme(.dark)
            }
        }
    }
}

extension RegistrationView {
    private func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    private func textFieldValidatorEmail(_ string: String) -> Bool {
        if string.count > 100 {
            return false
        }
        let emailFormat = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" + "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" + "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        //let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        let result = emailPredicate.evaluate(with: string)
        
        // save email to AppStorage
        if result {
            email = string
        }
        return result
    }
    
    // save gender to AppStorage
    private func genderIsEmpty(_ string: String) -> Bool {
        let result = !string.isEmpty
        if result {
            gender = string
        }
        return result
    }
    
    // save birthday to AppStorage
    private func birthdayIsEmpty(_ string: String) -> Bool {
        let result = !string.isEmpty
        if result {
            birthday = string
        }
        return result
    }
    
    private func coateIsEmpty(_ string: String) -> Bool {
        return !string.isEmpty
    }

    private func restoreCoate() {
        guard let item = try? JSONDecoder().decode(CoateItem.self, from: coateItem) else { return }
        
        let str = item.code.replacingOccurrences(of: " ", with: "")
        regionBinding = "\(str) - \(item.nm)"
    }
    
    private func registerUser() {
        guard let item = try? JSONDecoder().decode(CoateItem.self, from: coateItem) else { return }
        let uuid = UUID().uuidString
        let url = K.API.USER_API
        let params = [
            "uuid=\(uuid)",
            "email=\(email.lowercased())",
            "gender=\(gender == Gender.male.rawValue ? 1 : 2)",
            "birthday=\(birthday)",
            "coate_id=\(item.cd)",
            "device_type=1"
        ].joined(separator: "&")
        Api.shared.fetch(of: SuccessModel.self, from: [url, params].joined(separator: "?"), isPost: true) { result in
            // hide spinnning
            isLoading = false

            switch result {
            case .failure(let error):
                print("[FAILED]: " + [url, params].joined(separator: "?"))
                print(String(describing: error))
            case .success(let data):
                print("[SUCCESS]: \(data.message)")
                
                DispatchQueue.main.async {
                    withAnimation(.easeInOut) {
                        // save uuid
                        self.uuid = uuid
                    }
                }
            }
        }
    }
    
    private func checkUserExists() {
        // show spinning
        isLoading = true
        
        let url = K.API.CHECK_USER
        let params = "email=\(email.lowercased())"
        Api.shared.fetch(of: UUIDModel.self, from: [url, params].joined(separator: "?")) { result in
            switch result {
            case .failure( _):
                print("PARAMS: \(params) does not exist")
//                print(String(describing: error))
                registerUser()
            case .success(let data):
                // hide spinning
                isLoading = false

                DispatchQueue.main.async {
                    withAnimation(.easeInOut) {
                        // save uuid
                        self.uuid = data.uuid
                    }
                }
            }
        }
    }
}

// MARK: CUSTOM PART
struct TextFieldView:  View {
    var placeholder: String
    @Binding var bindingText: String
    @Binding var isError: Bool
    var errorMessage: String
    var chevronName: String = ""
    var onChangeHandler: (String) -> (Bool)
    
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
                
                if onChangeHandler(bindingText) {
                    isError = false
                } else {
                    isError = true
                }
            }
        })
            .disableAutocorrection(true)
            .font(.title3)
            .frame(height: 30)
            .padding(7)
            .overlay(
                RoundedRectangle(cornerRadius: 10.0)
                    .strokeBorder(Color(uiColor: UIColor.systemGray3), style: StrokeStyle(lineWidth: 0.5))
            )
            .background(RoundedRectangle(cornerRadius: 10.0).fill(isError ? Color(.systemRed) : isFocused || !bindingText.isEmpty ? Color(UIColor.systemBackground) : Color(.secondarySystemBackground)))
    }
    
    private func onFieldChanged(_ text: String) {
        
    }
}
