<!DOCTYPE html>
<!--[if IE 7]>         <html class="ie7 lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="ie8 lt-ie9"> <![endif]-->
<!--[if IE 9]>         <html class="ie9"> <![endif]-->
<!--[if gt IE 9]><!-->
<html>
<!--<![endif]-->


    <head>

        <meta charset="utf-8">
        <title>Контактная информация</title>


        <?php include_once('_head.php'); ?>
    </head>
    <body>


        <!-- application [ -->
        <div class="application">


            <?php $current = 5; include_once('_header.php'); ?>


            <!-- application content [ -->
            <div class="app-content">
                <div class="app-content-inner">
                    <div class="container">
                        <ul class="breadcrumb">
                            <li><a href="#">Главная</a><i class="icon icon-bc-separator"></i></li>
                            <li class="is-current">Контактная информация</li>
                        </ul>

                        <h1>Контактная информация</h1>


                        <div class="stiped-wrap form-contact">
                            <div class="striped -type-1">
                                <div class="striped-inner">
                                    <form action="" method="post" class="form">
                                        <h2>Обратная связь</h2>

                                        <p class="form-legend">
                                            вы можете связаться с нами, заполнив эту форму, все поля формы обязательны к заполнению
                                        </p>

                                        <div class="control-row">
                                            <div class="control-cell _fleft">
                                                <label>
                                                    Ваше имя:<br>
                                                    <input type="text" name="name" id="name" class="text required" value="Евгения">
                                                </label>
                                            </div>

                                            <div class="control-cell _fleft">
                                                <label>
                                                    E-mail:<br>
                                                    <input type="text" name="email" id="email" class="text email required" value="possumwood@gmail.com">
                                                </label>
                                            </div>

                                            <div class="_cfix"></div>
                                        </div>

                                        <div class="control-row">
                                            <div class="control-cell">
                                                <label>
                                                    Ваш вопрос:<br>
                                                    <textarea name="contact" id="contact" class="required">Можно ли добавить на сайт транспортную накладную?</textarea>
                                                </label>
                                            </div>
                                        </div>

                                        <div class="control-row captcha">
                                            <img src="media/captcha.jpg" title="Введите символы с изображения">
                                        </div>

                                        <div class="control-row">
                                            <div class="control-cell">
                                                <label>
                                                    Проверочный код:<br>
                                                    <input type="text" name="captcha_code" id="captcha-code" class="text captcha-code" value="1569">
                                                </label>
                                            </div>
                                        </div>

                                        <div class="control-row">
                                            <div class="control-cell">
                                                <button type="submit" class="btn -primary">Отправить</button>
                                                <button type="reset" class="btn">Очистить</button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>


                    </div>
                </div>
            </div>
            <!-- ] application content -->


        </div>
        <!-- ] application -->


        <?php include_once('_footer.php'); ?>


<!-- ===========================================================================
    START OF HIDDEN CONTENT
    ======================================================================== -->
        <!-- modal registration [ -->
        <div id="modal-registration" class="modal modal-registration hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
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
                                Как вы хотите, чтобы мы обращались к вам в письмах:<br>
                                <input type="text" name="fullname" id="fullname" class="text fullname" value="Евгения Александровна">
                            </label>
                        </div>
                    </div>

                    <p class="modal-addition">
                        Регистрируясь, вы принимаете <a href="#" class="-dotted">условия использования</a> сайта Енотус.
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
        <div id="modal-login" class="modal modal-login hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
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
<!-- ===========================================================================
    END OF HIDDEN CONTENT
    ======================================================================== -->


        <!-- js [ -->
        <script src="js/vendor/jquery.min.js"></script>
        <script src="js/plugins.js"></script>
        <script src="js/main.js"></script>
        <!-- ] js -->
    </body>
</html>