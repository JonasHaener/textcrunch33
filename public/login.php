<?php require_once "../application/login_user.php"; 
//echo password_hash("fruit", PASSWORD_DEFAULT);
?>
<!DOCTYPE HTML>
<html lang="en">
<head>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <!--<link rel="shortcut icon" href="favicon.png">-->
    <title>Textcrunch</title>
    <!-- Core CSS -->
    <link href="css/libs/bootstrap.css" rel="stylesheet">
    <!-- Off canvas styles -->
    <!--<link href="css/stylesheets/bstrap-offcanvas.css" rel="stylesheet">-->
    <link href="css/stylesheets/screen.css" rel="stylesheet">
</head>
<body>
    <div class="container egg-m-login">
    <!--ROW 1-->
        <div class="row navbar-header col-lg-12 egg-m-login__header"></div>
    <!--ROW 2 -->
        <div class="row egg-m-login__form">
            <div class="col-lg-8">
                <span class="egg-m-login__logo">TeC+i</span>
                <span class="egg-m-login__tagline">For Technical Documentation.</span>
            </div>
            <div class="col-lg-4">
                <form role="form" action="" method="post">
                    <div class="form-group">
                        <input id="user_name" name="user_name" class="form-control" type="text" required placeholder="Enter username">
                    </div>
                    <div class="form-group">
                        <input id="user_password" name="user_password" class="form-control" type="password" required placeholder="Enter your password">
                    </div>
                    <p class="egg-m-login__form__error">
                        <?php if(!empty($error)) { ?>
                            <span class="glyphicon glyphicon-exclamation-sign"></span>
                        <?php } ?>
                        <?php if( isset($error["login"]) ) { echo $error["login"]; 
                              } elseif( isset($error["system"]) ) { echo $error["system"]; } 
                        ?>
                    </p>
                    <button class="btn btn-success" type="submit">Sign in</button>
                </form>
            </div>
        </div>
    <!--ROW 3-->   
        <div class="row egg-m-login__brand-banner">         
            <div class="col-md-6"></div>
            <div id="js_col_left" class="col-md-6">
            </div>
        </div>

    <!--FOOTER-->
    <footer class="row egg-m-login__footer">
        <p>© 2014 eggbg</p>
    </footer>

</body>
</html>