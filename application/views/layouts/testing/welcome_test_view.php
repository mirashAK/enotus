<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Welcome to CodeIgniter</title>
    <style type="text/css">
    ::selection{ background-color: #E13300; color: white; }
    ::moz-selection{ background-color: #E13300; color: white; }
    ::webkit-selection{ background-color: #E13300; color: white; }
    body {background-color: #fff;margin: 40px;font: 13px/20px normal Helvetica, Arial, sans-serif;color: #4F5155;}
    a {color: #003399;background-color: transparent;font-weight: normal;}
    h1 {color: #444;background-color: transparent;border-bottom: 1px solid #D0D0D0;font-size: 19px;font-weight: normal;margin: 0 0 14px 0;padding: 14px 15px 10px 15px;}
    code {font-family: Consolas, Monaco, Courier New, Courier, monospace;font-size: 12px;background-color: #f9f9f9;border: 1px solid #D0D0D0;color: #002166;display: block;margin: 14px 0 14px 0;padding: 12px 10px 12px 10px;}
    #body{margin: 0 15px 0 15px;}
    p.footer{text-align: right;font-size: 11px;border-top: 1px solid #D0D0D0;line-height: 32px;padding: 0 10px 0 10px;margin: 20px 0 0 0;}
    #container{margin: 10px;border: 1px solid #D0D0D0;-webkit-box-shadow: 0 0 8px #D0D0D0;}
    </style>
</head>
<body>

<div id="container">
    <h1>Welcome to Fleksa v.02 !</h1>

    <div id="body">
        <p>Test some base parameters</p>

        <p>Config parameters:</p>
        <code><?php
        echo('current_url(): ');var_export(current_url());echo('<br/>');
        echo('sub_domain(): ');var_export(sub_domain());echo('<br/>');
        echo('base_url(): ');var_export(base_url());echo('<br/>');
        echo('base_url("testing/welcome_test"): ');var_export(base_url('testing/welcome_test'));echo('<br/>');
        echo('uri_string(): ');var_export(uri_string());echo('<br/>');
        echo('res_url(): ');var_export(res_url());echo('<br/>'); 
        echo('res_url("testing/welcome_test"): ');var_export(res_url('testing/welcome_test'));echo('<br/>'); 
        echo('site_url("testing/welcome_test"): ');var_export(site_url('testing/welcome_test'));echo('<br/>');
        echo('sub_url(): ');var_export(sub_url());echo('<br/>');
        echo('sub_url("testing/welcome_test"): ');var_export(sub_url('testing/welcome_test'));echo('<br/>');
        echo('sub_url("testing/welcome_test", false): ');var_export(sub_url('testing/welcome_test', false));echo('<br/>');
        ?></code>

        <p>Define language:</p>
        <code><?php var_export($lang); ?><br/>
        <?php var_export($uri_lang); ?><br/></code>
        <code>{test_email_missing}</code>

        <p>Test Extended parser</p>
        <code>{test_arr:social_description}<br/>
        {test_arr:reg_description}<br/>
        {test_arr:reg_title}</code><br/>
        
        <p>If you are exploring CodeIgniter for the very first time, you should start by reading the <a href="user_guide/">User Guide</a>.</p>
    </div>

    <p class="footer">Page rendered in <strong>{elapsed_time}</strong> seconds</p>
</div>

</body>
</html>