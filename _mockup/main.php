<!DOCTYPE html>
<!--[if IE 7]>         <html class="ie7 lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="ie8 lt-ie9"> <![endif]-->
<!--[if IE 9]>         <html class="ie9"> <![endif]-->
<!--[if gt IE 9]><!-->
<html>
<!--<![endif]-->


    <head>

        <meta charset="utf-8">
        <title>Главная страница</title>


        <?php include_once('_head.php'); ?>
    </head>
    <body>


        <!-- application [ -->
        <div class="application">


            <?php include_once('_header.php'); ?>


            <!-- carousel [ -->
            <div class="container carousel-container">
                <div id="main-banner" class="carousel slide">
                    <ol class="carousel-indicators">
                        <li data-target="#main-banner" data-slide-to="0" class="active"></li>
                        <li data-target="#main-banner" data-slide-to="1"></li>
                        <li data-target="#main-banner" data-slide-to="2"></li>
                    </ol><!-- Carousel items -->
                    <div class="carousel-inner">
                        <div class="active item">
                            <div class="carousel-img">
                                <img src="img/banner/banner1.png">
                            </div>

                            <div class="carousel-text">
                                <span class="prepend-text">
                                    Новое событие на сайте
                                </span>

                                <div class="carousel-heading">
                                    На <div class="logo-text _iblock">Eнотусе</div> появился новый <a href="#">тарифный пакет</a> для групповой работы
                                </div>

                                <p>
                                    Теперь сервис стал еще удобнее. Новый тариф позволяет создать работать группе сотрудников, позволяет запоминать контрагентов. Цена пакета демократичная и умеренная.
                                </p>
                            </div>
                        </div>
                        <div class="item">
                            <div class="carousel-img">
                                <img src="img/banner/banner2.png">
                            </div>

                            <div class="carousel-text">
                                <span class="prepend-text">
                                    Что это за сервис?
                                </span>

                                <div class="carousel-heading">
                                    <div class="logo-text _iblock">Eнотус</div> &mdash; это сайт, позволяющий создавать документы он-лайн
                                </div>

                                <p>
                                    База сайта содержит образцы полезных и нужных документов, которые могут существенно упростить работу предпринимателей самостоятельно занимающихся ведением дел.
                                </p>
                            </div>
                        </div>
                        <div class="item">
                            <div class="carousel-img">
                                <img src="img/banner/banner3.png">
                            </div>

                            <div class="carousel-text">
                                <span class="prepend-text">
                                    Внимание! Акция!
                                </span>

                                <div class="carousel-heading">
                                    На <div class="logo-text _iblock">Eнотусе</div> появился новый <a href="#">тарифный пакет</a> для групповой работы
                                </div>

                                <p>
                                    Теперь сервис стал еще удобнее. Новый тариф позволяет создать работать группе сотрудников, позволяет запоминать контрагентов. Цена пакета демократичная и умеренная.
                                </p>
                                </div>
                        </div>
                    </div><!-- Carousel nav -->
                    <a class="carousel-control left" href="#main-banner" data-slide="prev">‹</a> <a class="carousel-control right" href="#main-banner" data-slide="next">›</a>
                </div>
            </div>
            <!-- ] carousel -->


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


        <?php include_once('_footer.php'); ?>


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
        <script src="js/vendor/jquery.min.js"></script>
        <script src="js/plugins.js"></script>
        <script src="js/main.js"></script>

        <script>
            $('#deal-country').select2();
        </script>
        <!-- ] js -->
    </body>
</html>