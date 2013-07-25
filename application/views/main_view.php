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


        <!-- application content [ -->
        <div class="app-content">
            <div class="app-content-inner features">
                <div class="container">
                    <h1 class="_tcenter">Как это работает?</h1>

                    <ul class="features-list">
                        <li class="feature -step1 _iblock">
                            <div class="feature-inner">
                                <h2>Зарегистрируйтесь на сайте</h2>

                                <p>
                                    Этот шаг не является необходимым, вы сможете искать и заполнять документы и без этого, <a href="#modal-registration" data-toggle="modal">регистрация</a> просто сделает работу с сайтом более комфортной.
                                </p>
                            </div>
                        </li>

                        <li class="feature -step2 _iblock">
                            <div class="feature-inner">
                                <h2>Найдите нужный документ</h2>

                                <p>
                                    <a href="#">База сайта</a> содержит образцы полезных и нужных документов, поиск по базе прост и удобен, легко позволяет быстро найти необходимый документ.
                                </p>
                            </div>
                        </li>

                        <li class="feature -step3 _iblock">
                            <div class="feature-inner">
                                <h2>Заполните его поля</h2>

                                <p>
                                    Если вы регистрировались и раньше заполняли подобный документ, то сайт автоматически подставит значения в поля документа, избавив вас от необходимости заполнять все по новой.
                                </p>
                            </div>
                        </li>

                    </ul>
                </div>
            </div>
        </div>
        <!-- ] application content -->


        </div>
        <!-- ] application -->


        {site_footer} 


<!-- ===========================================================================
    START OF HIDDEN CONTENT
    ======================================================================== -->
        <!-- modal registration [ -->
        <div id="modal-registration" class="modal modal-registration hide fade" tabindex="-1" role="dialog" aria-hidden="true">
              <form action="" method="post" class="modal-inner">
                <div class="modal-header">
                    <i class="icon icon-close" data-dismiss="modal" aria-hidden="true"></i>
                    <h3>Регистрация</h3>
                    <div class="field-mark-explanation">
                        поля, помеченные <i class="field-mark">*</i>, обязательны для заполнения
                    </div>
                </div>

                <div class="modal-body form">
                    <div class="control-row">
                        <div class="control-cell">
                            <label>
                                E-mail<i class="field-mark">*</i>:<br>
                                <input type="text" name="emailreg" id="emailreg" class="text email required" value="possumwood@gmail.com">
                            </label>
                        </div>
                    </div>

                    <div class="control-row">
                        <div class="control-cell">
                            <label>
                                Пароль<i class="field-mark">*</i>:<br>
                                <input type="password" name="passwordreg" id="passwordreg" class="text password required" value="qweqrqr">
                            </label>
                        </div>
                    </div>

                    <div class="control-row">
                        <div class="control-cell">
                            <label>
                                Страна, в которой вы ведете деятельность<i class="field-mark">*</i>:<br>
                            </label>
                            <select name="deal_country" id="deal-country">
                                <option value="1" selected>Украина</option>
                                <option value="2">Россия</option>
                                <option value="3">Белоруссия</option>
                            </select>
                        </div>
                    </div>

                    <div class="control-row">
                        <div class="control-cell">
                            <label>
                                Как вы хотите, чтобы мы обращались к вам в письмах:<br>
                                <input type="text" name="fullname" id="fullname" class="text fullname" value="Евгения Александровна">
                            </label>
                        </div>
                    </div>

                    <p class="modal-addition">
                        Регистрируясь, вы принимаете <a href="#modal-rules" class="-dotted" data-toggle="modal" data-dismiss="modal" aria-hidden="true">условия использования</a> сайта Енотус.
                    </p>
                </div>

                <div class="modal-footer">
                    <button type="submit" class="btn -primary">Зарегистрироваться</button>
                    <div class="modal-bottom-link"><a class="-dotted" href="#modal-login" data-toggle="modal" data-dismiss="modal" aria-hidden="true">Уже регистрировались? Войти</a></div>
                </div>
            </form>
        </div>
        <!-- ] modal registration -->


        <!-- modal login [ -->
        <div id="modal-login" class="modal modal-login hide fade" tabindex="-1" role="dialog" aria-hidden="true">
            <form action="" method="post" class="modal-inner">
                <div class="modal-header">
                    <i class="icon icon-close" data-dismiss="modal" aria-hidden="true"></i>
                    <h3>Вход на сайт</h3>
                </div>

                <div class="modal-body form">
                    <div class="control-row">
                        <div class="control-cell">
                            <label>
                                E-mail:<br>
                                <input type="email" name="emaillogin" id="emaillogin" class="text email">
                            </label>
                        </div>
                    </div>

                    <div class="control-row">
                        <div class="control-cell">
                            <label>
                                Пароль:<br>
                                <input type="password" name="passwordlogin" id="passwordlogin" class="text password">
                                <a href="#">Я не помню пароль</a>
                            </label>
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="submit" class="btn -primary">Войти</button>
                    <div class="modal-bottom-link"><a class="-dotted" href="#modal-registration" data-toggle="modal" data-dismiss="modal" aria-hidden="true">Зарегистрироваться</a></div>
                </div>
            </form>
        </div>
        <!-- ] modal login -->


        <!-- modal login [ -->
        <div id="modal-rules" class="modal modal-rules hide fade" tabindex="-1" role="dialog" aria-hidden="true">
            <form action="" method="post" class="modal-inner">
                <div class="modal-header">
                    <i class="icon icon-close" data-dismiss="modal" aria-hidden="true"></i>
                    <h3>Условия использования</h3>
                </div>

                <div class="modal-body form">
                    <p>Угрозы безопасности персональных данных - совокупность условий и факторов, создающих опасность несанкционированного, в том числе случайного, доступа к персональным данным, результатом которого может стать уничтожение, изменение, блокирование, копирование, распространение персональных данных, а также иных несанкционированных действий при их обработке в информационной системе персональных данных.</p>

                    <p>Модель угроз безопасности персональных данных необходима для определения требований к системе защиты. Без модели угроз невозможно построить адекватную (с точки зрения денежных затрат) систему защиты информации, обеспечивающую безопасность персональных данных.</p>

                    <p>Модель угроз (или как ее еще называют "Частная модель угроз") может разрабатываться ответственными за защиту персональных данных в организации. Также могут привлекаться сторонние эксперты. Разработчики модели угроз должны владеть полной информацией об информационной системе персональных данных, знать нормативную базу по защите информации.</p>

                </div>

                <div class="modal-footer">
                    <a href="#modal-registration" data-toggle="modal" data-dismiss="modal" aria-hidden="true" class="btn -primary">Принимаю</a>
                </div>
            </form>
        </div>
        <!-- ] modal login -->
<!-- ===========================================================================
    END OF HIDDEN CONTENT
    ======================================================================== -->


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