<?php
/**
 * The main template file.
 *
 * This is the most generic template file in a WordPress theme
 * and one of the two required files for a theme (the other being style.css).
 * It is used to display a page when nothing more specific matches a query.
 * E.g., it puts together the home page when no home.php file exists.
 *
 * @link https://codex.wordpress.org/Template_Hierarchy
 *
 * @package Astra
 * @since 1.0.0
 */

if ( ! defined( 'ABSPATH' ) ) {
	exit; // Exit if accessed directly.
}

?>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Landing Page</title>
    <style>
        body, html {
            height: 100%;
            margin: 0;
            #position: relative;
        }
        .container {
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            #position: relative;
        }
        .message {
            font-size: 42px;
            color: green;
            border: 2px solid green;
            padding: 20px;
            #text-align: center;
            border-radius: 8px;
        }
        img {
            position: relative;
            top: 0;
            left: 50%;
            transform: translate(-50%, 0);
        }
        .admin-button {
            margin-top: 20px;
            padding: 10px 20px;
            color: green;
            border: 2px solid green;
            border-radius: 8px;
        }
    </style>
</head>
<body>

    <div class="container">
        <a><img src="https://i.ibb.co/5hGMRTs/wemustgo.png" alt="wemustgo" border="0"></a>
	<br></br>
        <div class="message">
            Wordpress is working!
        </div>
        <a href="https://gde-alme.42.fr/wp-admin" class="admin-button">Go to admin panel</a>
    </div>

</body>
</html>

<?php
