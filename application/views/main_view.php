<!DOCTYPE html>
<!--[if IE 7]>         <html class="ie7 lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="ie8 lt-ie9"> <![endif]-->
<!--[if IE 9]>         <html class="ie9"> <![endif]-->
<!--[if gt IE 9]><!-->
<html>
<!--<![endif]-->
  <head>
    <meta charset="utf-8">
    <title>Enotus - {site_title}</title>
    <meta name="description" content="{site_metadata_description}" />
    <meta name="keywords" content="{site_metadata_keywords}" />

    <!-- helpers [ -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <!--[if lt IE 9]>
        <script src="{res_js}/vendor/html5shiv.js"></script>
    <![endif]-->
    <!-- ] helpers -->

    <!-- css [ -->
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,800,700,300&subset=latin,cyrillic' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" href="{res_css}/main.css" media="all">
    <!-- ] css -->
    
  </head>

  <body> 
      <!-- application [ -->
      <div class="application">
        {site_header} 
        {site_body}
      </div>
      <!-- ] application -->
      {site_footer} 

        <!-- js [ -->
        <script src="{res_js}/vendor/jquery.min.js"></script>
        <script src="{res_js}/plugins.js"></script>
        <script src="{res_js}/main.js"></script>

        <script>
            $('#deal-country').select2();
        </script>
        <!-- ] js -->
    </body>
</html>