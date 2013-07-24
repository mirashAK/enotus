<!DOCTYPE html>
<!--[if IE 7]>         <html class="ie7 lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="ie8 lt-ie9"> <![endif]-->
<!--[if IE 9]>         <html class="ie9"> <![endif]-->
<!--[if gt IE 9]><!-->
<html>
<!--<![endif]-->


    <head>

        <meta charset="utf-8">
        <title>Мой профиль - История оплат</title>


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
                            <li class="is-current">Мой профиль - История оплат</li>
                        </ul>


                        <!-- сabinet [ -->
                        <div class="cabinet">


                            <!-- tabs [ -->
                            <nav class="tabs _cfix" role="tabs">
                                <a class="tab" href="#"><i class="icon icon-journal"></i>Журнал</a>
                                <a class="tab" href="#">Тарифный пакет</a>
                                <a class="tab is-current" href="#">История оплат</a>
                                <a class="tab" href="#">Настройки</a>
                            </nav>
                            <!-- ] tabs -->


                            <!-- tab-content [ -->
                            <div class="tab-content">
                                

                                <!-- payment history [ -->
                                <table class="payment-history">
                                    <tr>
                                        <td class="payment-date">10.01.2012</td>
                                        <td class="payment-action">Оплата по квитанции</td>
                                        <td class="payment-money"><span class="payment-label">Внесно: 50 грн<span></td>
                                    </tr>


                                    <tr>
                                        <td class="payment-date">10.12.2011</td>
                                        <td class="payment-action">Оплата через Liqpay</td>
                                        <td class="payment-money"><span class="payment-label">Внесно: 50 грн<span></td>
                                    </tr>


                                    <tr>
                                        <td class="payment-date">10.11.2011</td>
                                        <td class="payment-action">Оплата через Liqpay</td>
                                        <td class="payment-money"><span class="payment-label">Внесно: 50 грн<span></td>
                                    </tr>


                                    <tr>
                                        <td class="payment-date">10.10.2011</td>
                                        <td class="payment-action">Оплата через Liqpay</td>
                                        <td class="payment-money"><span class="payment-label">Внесно: 50 грн<span></td>
                                    </tr>


                                    <tr>
                                        <td class="payment-date">10.09.2011</td>
                                        <td class="payment-action">Оплата через Liqpay</td>
                                        <td class="payment-money"><span class="payment-label">Внесно: 50 грн<span></td>
                                    </tr>
                                </table>
                                <!-- ] payment history -->


                                <!-- pagination [ -->
                                <div class="pagination">
                                    <ul>
                                        <li class="edge">первая</li>
                                        <li class="is-current"><span>1</span></li>
                                        <li><a href="#p-2">2</a></li>
                                        <li><a href="#p-3">3</a></li>
                                        <li><a href="#p-4">4</a></li>
                                        <li><a href="#p-5">5</a></li>
                                        <li class="controls-next icon icon-next"><a href="#p-next">следующая</a></li>
                                        <li class="edge"><a href="#p-last">последняя</a></li>
                                    </ul>
                                </div>
                                <!-- ] pagination -->


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