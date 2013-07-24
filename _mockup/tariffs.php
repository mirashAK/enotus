<!DOCTYPE html>
<!--[if IE 7]>         <html class="ie7 lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="ie8 lt-ie9"> <![endif]-->
<!--[if IE 9]>         <html class="ie9"> <![endif]-->
<!--[if gt IE 9]><!-->
<html>
<!--<![endif]-->


    <head>

        <meta charset="utf-8">
        <title>Тарифы</title>


        <?php include_once('_head.php'); ?>
    </head>
    <body>


        <!-- application [ -->
        <div class="application">


            <?php $auth=true; $current=3; include_once('_header.php'); ?>


            <!-- application content [ -->
            <div class="app-content">
                <div class="app-content-inner">
                    <div class="container">
                        <ul class="breadcrumb">
                            <li><a href="#">Главная</a><i class="icon icon-bc-separator"></i></li>
                            <li class="is-current">Тарифы</li>
                        </ul>
                        <h1>Тарифы</h1>


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
                                            <button type="button" class="btn -primary">Оплатить пакет</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- ] item -->


                            <!-- item [ -->
                            <div class="tariffs-item -group is-disabled stiped-wrap">
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
                            <!-- ] item -->
                        </div>
                        <!-- ] tariffs -->


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