<?php
require_once "../application/includes/session.inc.php";
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
<!-- APP CONTAINER -->
    <div id="js_mApp">
        <!-- MAIN NAVI -->
        <div id="js_mAppNavi"></div>
        <!--CONTAINER-->
        <div id="js_mContents" class="container egg-l-contents-container">
    <!--  <p class="pull-right visible-xs"><button type="button" class="btn btn-primary btn-xs" data-toggle="offcanvas">Toggle nav</button></p> -->
        <!--ROW 1-->
            <div class="row">         
        <!--LEFT COLUMN-->
                <div id="js_col_left" class="col-md-8"></div>
        <!--RIGHT COLUMN-->
                <div id="js_col_right" class="col-md-4"></div>
            </div>
        <!-- MAIN NAVI -->
        <div id="js_mFooter"></div>
    </div> <!--App container END-->
    <!-- SCRIPTS -->
    <script data-main="script/blocks/app" src="script/blocks/libs/require.js"></script>    
    <script id="appdata">
        window.APP = { user: '<?php echo $user; ?>', year: '<?php echo $year; ?>', domain: '<?php echo $domain; ?>' };
    </script>
</body>
</html>