<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="Register_Style.css">
  <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;300;400;500;700;900&family=Sen:wght@400;700;800&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">
  <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel='stylesheet'>
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
                    <form id="registration" method="post" action="customerLogin">
                      <h1 style="font-size: 32px;">LOGIN</h1>
                      <div class="input-box" style="margin-top: 50px;">
                        <input class="text-input-field" type="Email" id="CustomerEmail" name="CustomerEmail" required>
                        <label class="main-labels" for="Email">Enter Your Email Here</label>
                        <i class='i-icons bx bxs-envelope'></i>
                      </div>
                      <div class="input-box" style="margin-top: 50px;">
                        <div class="icons-container">
                          <i class="password-hide-icon fas fa-eye-slash" style="left:357px" onclick="togglePasswordVisibility('customerpassword', this)"></i>
                          <i class='i-icons fas fa-lock'></i>
                        </div>
                        <input class="password-field" type="password" name="CustomerPassword" id="customerpassword" required>
                        <label class="main-labels">Enter Your Password Here</label>
                      </div>                      
                      <button class="register-button" style="font-size:24px; margin-top: 30px;" type="submit" name="submit">Login</button>
                      <div class="signIn-link">
                        <p>Do not have an account?<a href="Register.jsp"class="signInBtn"> Sign In</a>
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
</body>
</html>