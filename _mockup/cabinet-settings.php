<!DOCTYPE html>
<!--[if IE 7]>         <html class="ie7 lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="ie8 lt-ie9"> <![endif]-->
<!--[if IE 9]>         <html class="ie9"> <![endif]-->
<!--[if gt IE 9]><!-->
<html>
<!--<![endif]-->


    <head>

        <meta charset="utf-8">
        <title>Мой профиль - Настройки</title>


        <?php include_once('_head.php'); ?>
    </head>
    <body>


        <!-- application [ -->
        <div class="application">


            <?php $auth=true; include_once('_header.php'); ?>


            <!-- application content [ -->
            <div class="app-content">
                <div class="app-content-inner">
                    <div class="container">
                        <ul class="breadcrumb">
                            <li><a href="#">Главная</a><i class="icon icon-bc-separator"></i></li>
                            <li class="is-current">Мой профиль - Настройки</li>
                        </ul>


                        <!-- сabinet [ -->
                        <div class="cabinet">


                            <!-- tabs [ -->
                            <nav class="tabs _cfix" role="tabs">
                                <a class="tab" href="#"><i class="icon icon-journal"></i>Журнал</a>
                                <a class="tab" href="#">Тарифный пакет</a>
                                <a class="tab" href="#">История оплат</a>
                                <a class="tab is-current" href="#">Настройки</a>
                            </nav>
                            <!-- ] tabs -->


                            <!-- tab-content [ -->
                            <div class="tab-content">


                                <!-- settings [ -->
                                <div class="cabinet-settings">
                                    <div class="first-col">
                                        <form action="" method="post" class="form">
                                            <h2>Данные пользователя</h2>

                                            <p class="form-legend">
                                                это ваши персональные данные, необходимые для того, чтобы входить на сайт
                                            </p>


                                            <div class="control-row">
                                                <div class="control-cell">
                                                    <div>
                                                        Ваш Email (логин):<br>
                                                        <div class="field-placeholder">
                                                            possumwood@gmail.com
                                                        </div>
                                                    </div>
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

                                            <div class="control-row">
                                                <div class="control-cell">
                                                    <label>
                                                        Страна, в которой вы ведете деятельность:<br>
                                                        <span class="change-country-row">Украина <a href="#">Хотите изменить страну?</a></span>
                                                    </label>
                                                </div>
                                            </div>


                                            <div class="control-row change-pass-row">
                                                <div class="controll-cell">
                                                    <a href="#modal-change-password" data-toggle="modal"><i class="icon icon-lock"></i><span>Изменить пароль</span></a>
                                                </div>
                                            </div>


                                            <div class="control-row">
                                                <div class="control-cell">
                                                    <button type="submit" class="btn -primary">Сохранить</button>
                                                    <button type="reset" class="btn">Отменить</button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>


                                    <div class="second-col">
                                        <form action="" method="post" class="form">
                                            <h2>Реквизиты организации</h2>

                                            <p class="form-legend">
                                                заполните эти поля, чтобы их значения автоматически в документ и вам не приходилось каждый раз вводить их вручную
                                            </p>


                                            <div class="control-row">
                                                <div class="control-cell">
                                                    <label>
                                                        Название организации:<br>
                                                        <input type="text" name="company_name" id="company-name" class="text company-name" value="ЧП Васильченко">
                                                    </label>
                                                </div>
                                            </div>


                                            <div class="control-row">
                                                <div class="control-cell">
                                                    <label>
                                                        Город:<br>
                                                        <input type="text" name="city" id="city" class="text city" value="Днепропетровск">
                                                    </label>
                                                </div>
                                            </div>


                                            <div class="control-row">
                                                <div class="control-cell">
                                                    <label>
                                                        Адрес организации:<br>
                                                        <textarea name="company_address" id="company-address">пр. К. Маркса, 37/79</textarea>
                                                    </label>
                                                </div>
                                            </div>


                                            <div class="control-row">
                                                <div class="control-cell">
                                                    <label>
                                                        Код ОКПО:<br>
                                                        <input type="text" name="code" id="code" class="text code" value="15503654651651565">
                                                    </label>
                                                </div>
                                            </div>


                                            <div class="control-row">
                                                <div class="control-cell _fleft">
                                                    <label>
                                                        Расчетный счет:<br>
                                                        <input type="text" name="clearing_account" id="clearing-account" class="text clearing-account" value="6005789854">
                                                    </label>
                                                </div>


                                                <div class="control-cell _fleft">
                                                    <label>
                                                        МФО:<br>
                                                        <input type="text" name="mfo" id="mfo" class="text mfo" value="256489">
                                                    </label>
                                                </div>


                                                <div class="_cfix"></div>
                                            </div>


                                            <div class="control-row">
                                                <div class="control-cell">
                                                    <label>
                                                        Название банка, в котором открыт расчетный счет:<br>
                                                        <input type="text" name="bank" id="bank" class="text bank" value="КБ «Златобанк»">
                                                    </label>
                                                </div>
                                            </div>


                                            <div class="control-row">
                                                <div class="control-cell">
                                                    <label>
                                                        Контактный телефон:<br>
                                                        <input type="text" name="contact_phone[]" class="text" value="+38">
                                                    </label>
                                                </div>
                                            </div>


                                            <div class="control-row add-phone-row">
                                                <div class="control-cell">
                                                    <a href="#add-phone" id="add-phone" class="add-phone-link -dotted">Добавить телефон</a>
                                                </div>
                                            </div>


                                            <div class="control-row">
                                                <div class="control-cell">
                                                    <button type="submit" class="btn -primary">Сохранить</button>
                                                    <button type="reset" class="btn">Отменить</button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>


                                    <div class="_cfix"></div>
                                </div>
                                <!-- ] settings -->


                            </div>
                            <!-- ] tab-content -->


                        </div>
                        <!-- ] сabinet -->


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
    <!-- modal change password [ -->
    <div id="modal-change-password" class="modal modal-change-password hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <form action="" method="post" class="modal-inner">
            <div class="modal-header">
                <i class="icon icon-close" data-dismiss="modal" aria-hidden="true"></i>
                <h3>Изменение пароля</h3>
            </div>

            <div class="modal-body form">
                <div class="control-row">
                    <div class="control-cell">
                        <label>
                            E-mail:<br>
                            <input type="password" name="old" id="old" class="text password required">
                            <a href="#">Я не помню пароль</a>
                        </label>
                    </div>
                </div>

                <div class="control-row">
                    <div class="control-cell">
                        <label>
                            Пароль:<br>
                            <input type="password" name="new" id="new" class="text password required">
                        </label>
                    </div>
                </div>

                <div class="control-row">
                    <div class="control-cell">
                        <label>
                            Пароль:<br>
                            <input type="password" name="confirm" id="confirm" class="text password required">
                        </label>
                    </div>
                </div>
            </div>

            <div class="modal-footer">
                <button type="submit" class="btn -primary">Сохранить</button>
                <button type="куіуе" class="btn">Отменить</button>
            </div>
        </form>
    </div>
    <!-- ] modal change password -->
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