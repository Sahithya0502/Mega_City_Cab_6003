<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;300;400;500;700;900&family=Sen:wght@400;700;800&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">
  <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel='stylesheet'>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="Register_Style.css">
  <title>Register</title>
</head>
<body>
  <div class="container">
    <div class="content-container">
      <div class="food-list-container">
        <div class="food-list-wrapper">
          <div class="food-list">
            <div class="register-body">
              <div class="register-body-designing">
                <div class="wrapper-registration">
                  <div class="form-wrapper sign up">
                    <form id="registration" method="post" action="addCustomer" onsubmit="return formValidation()">
                      <h1 style="font-size: 32px;">REGISTER</h1>
                      <div class="input-box">
                        <input class="text-input-field" type="text" id="CustomerFullName" name="CustomerFullName" required>
                        <label class="main-labels" for="">Enter Your Full Name</label>
                        <i class='i-icons bx bxs-user'></i>
                      </div>
                      <div class="input-box">
                        <input class="text-input-field" type="Email" id="CustomerEmail" name="CustomerEmail" required>
                        <label class="main-labels" for="Email">Enter Your Email</label>
                        <i class='i-icons bx bxs-envelope'></i>
                      </div>
                      <div class="input-box">
                        <input class="text-input-field" type="text" id="CustomerNIC" name="CustomerNIC" required>
                        <label class="main-labels" for="">Enter Your NIC Number</label>
                        <i class='i-icons bx bxs-user'></i>
                      </div>
                      <div class="input-box">
                        <input class="text-input-field" type="text" id="CustomerTelephoneNumber" name="CustomerTelephoneNumber" required>
                        <label class="main-labels" for="">Enter Your Telephone Number</label>
                        <i class='i-icons bx bxs-user'></i>
                      </div>
                      <div class="input-box">
                        <input class="text-input-field" type="text" id="CustomerAddress" name="CustomerAddress" required>
                        <label class="main-labels" for="">Enter Your Address</label>
                        <i class='i-icons bx bxs-user'></i>
                      </div>
                      <div class="input-box">
                        <div class="icons-container">
                          <i class="password-hide-icon fas fa-eye-slash" style="left:357px" onclick="togglePasswordVisibility('customerpassword', this)"></i>
                          <i class='i-icons fas fa-lock'></i>
                        </div>
                        <input class="password-field" type="password" name="CustomerPassword" id="customerpassword" required>
                        <label class="main-labels">Enter Your Password</label>
                      </div>
                      <div class="input-box">
                        <div class="icons-container">
                          <i class="password-hide-icon fas fa-eye-slash" style="left:357px" onclick="togglePasswordVisibility('confirmCustomerPassword', this)"></i>
                          <i class='i-icons fas fa-lock'></i>
                        </div>
                        <input class="password-field" type="password" name="ConfirmCustomerPassword" id="confirmCustomerPassword" required>
                        <label class="main-labels">Confirm Your Password</label>
                      </div>
                      
                      <button class="register-button" style="font-size:24px" type="submit" name="submit">Register</button>
                      <div class="signIn-link">
                        <p>Already have an account?<a href="Login.jsp"class="signInBtn"> Sign In</a>
                      </p>
                      </div>
                    </form>
                    <div id="message"></div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="pagination-container"></div>
    </div>
  </div>

  <script>
    function togglePasswordVisibility(fieldId, toggleIcon) {
      var input = document.getElementById(fieldId);
      var isPasswordVisible = input.type === 'password';
      input.type = isPasswordVisible ? 'text' : 'password';
      toggleIcon.className = isPasswordVisible ? 'password-hide-icon fas fa-eye' : 'password-hide-icon fas fa-eye-slash';
    }
  </script>

  <script type="text/javascript">
    function formValidation() {
      var CustomerFullName = document.getElementById('CustomerFullName').value;
      var CustomerEmail = document.getElementById('CustomerEmail').value;
      var CustomerPassword = document.getElementById('customerpassword').value; 
      var ConfirmCustomerPassword = document.getElementById('confirmCustomerPassword').value;

      if (allLetter(CustomerFullName)) {
        if (ValidateEmail(CustomerEmail)) {
          if (PasswordandConfirmPasswordMatching(CustomerPassword, ConfirmCustomerPassword)) {
        	if (PasswordLengthLong(CustomerPassword)) {
              return true;
        	}
          }
        }
      }
      return false;
    }

    function allLetter(CustomerFullName) {
      var letters = /^[A-Za-z ]+$/; 
      if (CustomerFullName.match(letters)) {
        return true;
      } else {
        alert('Full Name must have alphabet characters and spaces only');
        return false;
      }
    }

    function ValidateEmail(CustomerEmail) {
      var mailformat = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
      if (CustomerEmail.match(mailformat)) {
        return true;
      } else {
        alert("Invalid email address!");
        return false;
      }
    }

    function PasswordandConfirmPasswordMatching(CustomerPassword, ConfirmCustomerPassword) {
      if (CustomerPassword !== ConfirmCustomerPassword) {
        alert("Password and Confirm Password must be equal");
        return false;
      }
      return true;
    }
    
    function PasswordLengthLong(CustomerPassword) {
      if (CustomerPassword.length<5) {
        alert("Dear Customer, Password must have 4 or more than 4 characters!");
        return false;
      }
      return true;
    }
  </script>
</body>
</html>