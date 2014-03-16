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
        <div id="js_mContents" class="container egg-m-stats egg-l-contents-container">
            <h1>Statistics</h1>
            <div id="js_mStatistics"></div>       
            <div class="row">
                <div id="js_mFooter"></div>    
            </div>
        </div> <!--App container END-->
    </div>  <!--App container END-->    
<!-- SCRIPTS -->
    

    <script data-main="script/statistics/app" src="script/statistics/libs/require.js"></script>    
    <script id="appdata">
        window.APP = { year: '<?php echo $year; ?>', domain: '<?php echo $domain; ?>' };
    </script>


</body>
</html>