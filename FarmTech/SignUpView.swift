import SwiftUI

struct SignUpView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String? = nil
    @State private var isSignedUp: Bool = false  // Pour vérifier si l'inscription a réussi

    var body: some View {
        VStack {
            TextField("Name", text: $name)
                .padding()

            TextField("Email", text: $email)
                .padding()
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.none)

            SecureField("Password", text: $password)
                .padding()

            Button("Sign Up") {
                signup()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)

            if let errorMessage = errorMessage {
                Text(errorMessage).foregroundColor(.red)
            }

            if isSignedUp {
                Text("Signed Up Successfully!").foregroundColor(.green)
            }
        }
        .padding()
        .navigationTitle("Sign Up")
    }

    func signup() {
        NetworkService.shared.signup(name: name, email: email, password: password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    // Traitement de la réponse réussie
                    print("Inscription réussie : \(String(data: data, encoding: .utf8) ?? "")")
                    isSignedUp = true
                    // Vous pouvez gérer l'authentification ici (e.g., save token)
                case .failure(let error):
                    errorMessage = "Erreur : \(error.localizedDescription)"
                }
            }
        }
    }
}
