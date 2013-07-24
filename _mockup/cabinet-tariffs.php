<!DOCTYPE html>
<!--[if IE 7]>         <html class="ie7 lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="ie8 lt-ie9"> <![endif]-->
<!--[if IE 9]>         <html class="ie9"> <![endif]-->
<!--[if gt IE 9]><!-->
<html>
<!--<![endif]-->


    <head>

        <meta charset="utf-8">
        <title>Мой профиль - Тарифный пакет</title>


        <?php include_once('_head.php'); ?>
    </head>
    <body>


        <!-- application [ -->
        <div class="application">


            <?php $auth=true; $tariff='ok'; include_once('_header.php'); ?>


            <!-- application content [ -->
            <div class="app-content">
                <div class="app-content-inner">
                    <div class="container">
                        <ul class="breadcrumb">
                            <li><a href="#">Главная</a><i class="icon icon-bc-separator"></i></li>
                            <li class="is-current">Мой профиль - Тарифный пакет</li>
                        </ul>


                        <!-- сabinet [ -->
                        <div class="cabinet">


                            <!-- tabs [ -->
                            <nav class="tabs _cfix" role="tabs">
                                <a class="tab" href="#"><i class="icon icon-journal"></i>Журнал</a>
                                <a class="tab is-current" href="#">Тарифный пакет</a>
                                <a class="tab" href="#">История оплат</a>
                                <a class="tab" href="#">Настройки</a>
                            </nav>
                            <!-- ] tabs -->


                            <!-- tab-content [ -->
                            <div class="tab-content">


                                <!-- tariffs [ -->
                                <div class="tariffs-list _cfix">


                                    <!-- item [ -->
                                    <div class="tariffs-item -light stiped-wrap">
                                        <div class="striped -type-2">
                                            <div class="striped-inner">
                                                <div class="tariffs-item-head">
                                                    <div>Тарифный пакет</div>
                                                    <div class="name colorize">Light<span class="current-tariff">Ваш пакет</span></div>
                                                </div>


                                                <div class="tariff-body">
                                                    <div class="tariff-features">
                                                        <i class="icon icon-features"></i>
                                                        <span class="colorize">Состав пакета:</span> позволяет создать 5 документов разных типов в месяц, сохранять и работать с созданными документами без ограничения по времени.
                                                    </div>


                                                    <div class="tariff-cost">
                                                        <i class="icon icon-cost"></i>
                                                        <span class="colorize">Стоимость пакета:</span> бесплатно.
                                                    </div>

                                                    <div class="tariff-footer">
                                                    <button type="button" class="btn">Перейти в пакет</button>
                                                </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- ] item -->

                                    <!-- item [ -->
                                    <div class="tariffs-item -optima stiped-wrap">
                                        <div class="striped -type-3">
                                            <div class="striped-inner">
                                                <div class="tariffs-item-head">
                                                    <div>Тарифный пакет</div>
                                                    <div class="name colorize">Optima<span class="current-tariff">Ваш пакет</span></div>
                                                </div>


                                                <div class="tariff-body">
                                                    <div class="tariff-features">
                                                        <i class="icon icon-features"></i>
                                                        <span class="colorize">Состав пакета:</span> неограниченное количество операций по созданию и работе с документами в течение месяца.
                                                    </div>


                                                    <div class="tariff-cost">
                                                        <i class="icon icon-cost"></i>
                                                        <span class="colorize">Стоимость пакета:</span> 50 грн в месяц.
                                                    </div>
                                                </div>


                                                <div class="tariff-footer">
                                                    <button type="button" class="btn -primary" disabled>Оплатить пакет</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- ] item -->


                                    <!-- optional item [ -->
                                    <div class="tariffs-item -group is-disabled stiped-wrap _dnone">
                                        <div class="striped -type-4">
                                            <div class="striped-inner">
                                                <div class="tariffs-item-head">
                                                    <div>Тарифный пакет</div>
                                                    <div class="name colorize">Group<span class="current-tariff">Ваш пакет</span></div>
                                                </div>


                                                <div class="tariff-body">
                                                    <div class="tariff-features">
                                                        <i class="icon icon-features"></i>
                                                        <span class="colorize">Состав пакета:</span> неограниченное количество операций по созданию и работе с документами в течение месяца.
                                                    </div>


                                                    <div class="tariff-cost">
                                                        <i class="icon icon-cost"></i>
                                                        <span class="colorize">Стоимость пакета:</span> 50 грн в месяц.
                                                    </div>
                                                </div>


                                                <div class="tariff-footer">
                                                    <div class="warning"><i class="icon icon-warning"></i>Пакет находится в разработке</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- ] optional item -->
                                </div>
                                <!-- ] tariffs -->


                                <!-- dropdown [ -->
                                <div class="tariff-dropdown">
                                    <div class="tariff-dropdown-head">
                                        Вы хотите приобрести тарифный пакет <span class="colorize">Optima</span>
                                    </div>

                                    <div class="tariff-options">
                                        <div class="heading">Выберите удобный вам способ оплаты:</div>
                                        <div><input type="radio" name="to[]" id="to-1-1">
                                        <label class="label" for="to-1-1">Получить квитанцию для оплаты в банке</label></div>
                                        <div><input type="radio" name="to[]" id="to-1-2">
                                        <label class="label" for="to-1-2">Оплатить с помощью Liqpay</label></div>
                                    </div>


                                    <div class="settings-row">
                                        <div class="settings-cell">
                                            <a href="#" class="btn -primary">Скачать квитанцию</a>
                                        </div>
                                    </div>
                                    <div class="tariff-dropdown-arrow"></div>
                                </div>
                                <!-- ] dropdown -->


                                <!-- dropdown [ -->
                                <div class="tariff-dropdown">
                                    <div class="tariff-dropdown-head">
                                        Вы хотите оплатить тарифный пакет <span class="colorize">Optima</span>
                                    </div>

                                    <div class="tariff-options">
                                        <div class="heading">Выберите удобный вам способ оплаты:</div>
                                        <div><input type="radio" name="to[]" id="to-2-1">
                                        <label class="label" for="to-2-1">Получить квитанцию для оплаты в банке</label></div>
                                        <div><input type="radio" name="to[]" id="to-2-2">
                                        <label class="label" for="to-2-2">Оплатить с помощью Liqpay</label></div>
                                    </div>


                                    <div class="settings-row _cfix">
                                        <div class="settings-cell _fleft">
                                            <a href="#" class="btn -primary">Перейти к оплате</a>
                                        </div>

                                        <p class="form-legend _fleft">
                                            вы перейдете на страницу Liqpay, где сможете оплатить тарифный пакет
                                        </p>
                                    </div>
                                    <div class="tariff-dropdown-arrow"></div>
                                </div>
                                <!-- ] dropdown -->


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


        <!-- js [ -->
        <script src="js/vendor/jquery.min.js"></script>
        <script src="js/plugins.js"></script>
        <script src="js/main.js"></script>
        <!-- ] js -->
    </body>
</html>