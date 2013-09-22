<!DOCTYPE html>
<!--[if IE 7]>         <html class="ie7 lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="ie8 lt-ie9"> <![endif]-->
<!--[if IE 9]>         <html class="ie9"> <![endif]-->
<!--[if gt IE 9]><!-->
<html>
<!--<![endif]-->


    <head>

        <meta charset="utf-8">
        <title>База документов</title>


        <?php include_once('_head.php'); ?>
    </head>
    <body>


        <!-- application [ -->
        <div class="application">


            <?php $current = 1; include_once('_header.php'); ?>


            <!-- application content [ -->
            <div class="app-content">
                <div class="app-content-inner">
                    <div class="container">
                        <ul class="breadcrumb">
                            <li><a href="#">Главная</a><i class="icon icon-bc-separator"></i></li>
                            <li class="is-current">База документов</li>
                        </ul>

                        <h1 class="_fleft no-bottom">База документов</h1>

                        <ul class="filters _fright -in-heading">
                            <li class="is-active" data-role="filter" data-option="alphabet"><span>по алфавиту</span></li>
                            <li data-role="filter" data-option="popularity"><span >по популярности</span></li>
                            <li data-role="filter" data-option="availability"><span>доступные</span></li>
                        </ul>


                        <div class="_cfix"></div>

                        <div class="base-sub-heading">показывать документы <a class="drop-link link-choose-country -open" href="#"><span class="title">для всех стран</span><i class="icon icon-choose-country"></i></a></div>

                        <div class="main-col">


                            <div class="control-row search-helper-row doc-base-search">
                                <form class="control-cell _prel" action="#" method="post">
                                    <input type="text" name="search_helper" id="search-helper" class="text search-helper" placeholder="Название документа">


                                    <button class="btn -special link-search" type="submit">
                                        <i class="icon icon-search"></i>
                                    </button>
                                    <span class="clear-search-field icon icon-clear is-hidden" id="clear-search-field" title="Очистить"></span>
                                </form>
                            </div>


                            <!-- item -->
                            <article class="doc-block">
                                <table>
                                    <tr>
                                        <td>
                                            <h2><a href="#">Доверенность (М2)</a></h2>

                                            <p>
                                                документ, выдаваемый одним лицом другому для представительства перед третьим лицом
                                            </p>
                                        </td>
                                        <td class="doc-desc">
                                            <div class="doc-prev">
                                                <span class="doc-prev-figure"></span>
                                            </div>
                                            <div class="doc-type">
                                                <b>A4,</b> <br>горизонтальный
                                            </div>
                                            <div class="_cfix"></div>
                                            <p>Вы можете создать документ этого типа.</p>
                                            <p><a href="#"><i class="icon icon-doc-ex"></i>Пример документа</a></p>
                                        </td>
                                    </tr>
                                </table>
                                <div class="addition">
                                    У вас в <a href="#">журнале</a> <b>5</b> документов этого типа.
                                </div>
                            </article>
                            <!-- /item -->


                            <!-- item -->
                            <article class="doc-block is-blocked">
                                <table>
                                    <tr>
                                        <td>
                                            <h2><a href="#">Расходная накладная</a></h2>

                                            <p>
                                                документ, используемый при передаче товарно-материальных ценностей от одного лица другому
                                            </p>
                                        </td>
                                        <td class="doc-desc">
                                            <div class="doc-prev">
                                                <span class="doc-prev-figure is-vertical"></span>
                                            </div>
                                            <div class="doc-type">
                                                <b>A4,</b> <br>вертикальный
                                            </div>
                                            <div class="_cfix"></div>
                                            <p>Создание такого документа не доступно в вашем пакете. 
                                                <br><a href="#">Улучшить тарифный пакет?</a></p>
                                            <p><a href="#"><i class="icon icon-doc-ex"></i>Пример документа</a></p>
                                        </td>
                                    </tr>
                                </table>
                                <div class="addition">
                                    Вы пока не создавали таких документов.
                                </div>
                            </article>
                            <!-- /item -->


                            <!-- item -->
                            <article class="doc-block">
                                <table>
                                    <tr>
                                        <td>
                                            <h2><a href="#">Расходно-кассовый ордер</a></h2>

                                            <p>
                                                денежный документ, которым оформляется кассовая операция по выдаче наличных денег предприятиями, учреждениями
                                            </p>
                                        </td>
                                        <td class="doc-desc">
                                            <div class="doc-prev">
                                                <span class="doc-prev-figure"></span>
                                            </div>
                                            <div class="doc-type">
                                                <b>A5,</b> <br>горизонтальный
                                            </div>
                                            <div class="_cfix"></div>
                                            <p>Вы можете создать документ этого типа.</p>
                                            <p><a href="#"><i class="icon icon-doc-ex"></i>Пример документа</a></p>
                                        </td>
                                    </tr>
                                </table>
                                <div class="addition">
                                    У вас в <a href="#">журнале</a> <b>12</b> документов этого типа.
                                </div>
                            </article>
                            <!-- /item -->


                            <!-- item -->
                            <article class="doc-block is-blocked">
                                <table>
                                    <tr>
                                        <td>
                                            <h2><a href="#">Приходно-кассовый ордер</a></h2>

                                            <p>
                                                документ первичной учетной документации кассовых операций, по которому производится прием средств в кассу организации
                                            </p>
                                        </td>
                                        <td class="doc-desc">
                                            <div class="doc-prev">
                                                <span class="doc-prev-figure is-vertical"></span>
                                            </div>
                                            <div class="doc-type">
                                                <b>A4,</b> <br>вертикальный
                                            </div>
                                            <div class="_cfix"></div>
                                            <p>Создание такого документа не доступно в вашем пакете. 
                                                <br><a href="#">Улучшить тарифный пакет?</a></p>
                                            <p><a href="#"><i class="icon icon-doc-ex"></i>Пример документа</a></p>
                                        </td>
                                    </tr>
                                </table>
                                <div class="addition">
                                    У вас в <a href="#">журнале</a> <b>7</b> документов этого типа.
                                </div>
                            </article>
                            <!-- /item -->


                            <!-- item -->
                            <article class="doc-block is-blocked">
                                <table>
                                    <tr>
                                        <td>
                                            <h2><a href="#">Cчет (на оплату)</a></h2>

                                            <p>
                                                документ, содержащий платежные реквизиты получателя, по которым плательщик осуществляет безналичный перевод денежных средств за перечисленные товары и (или) услуги
                                            </p>
                                        </td>
                                        <td class="doc-desc">
                                            <div class="doc-prev">
                                                <span class="doc-prev-figure is-vertical"></span>
                                            </div>
                                            <div class="doc-type">
                                                <b>A5,</b> <br>вертикальный
                                            </div>
                                            <div class="_cfix"></div>
                                            <p>Вы создали максимальное количество таких документов, доступное в вашем пакете.
                                                <br><a href="#">Улучшить тарифный пакет?</a></p>
                                            <p><a href="#"><i class="icon icon-doc-ex"></i>Пример документа</a></p>
                                        </td>
                                    </tr>
                                </table>
                                <div class="addition">
                                    У вас в <a href="#">журнале</a> <b>5</b> документов этого типа.
                                </div>
                            </article>
                            <!-- /item -->


                            <!-- pagination [ -->
                            <div class="pagination">
                                <ul>
                                    <li class="edge"><a href="#p-first">первая</a></li>
                                    <li class="controls-prev icon icon-prev"><a href="#p-prev">предыдущая</a></li>
                                    <li><a href="#p-1">1</a></li>
                                    <li class="is-current"><span>2</span></li>
                                    <li><a href="#p-3">3</a></li>
                                    <li><a href="#p-4">4</a></li>
                                    <li><a href="#p-5">5</a></li>
                                    <li class="controls-next icon icon-next"><a href="#p-next">следующая</a></li>
                                    <li class="edge"><a href="#p-last">последняя</a></li>
                                </ul>
                            </div>
                            <!-- ] pagination -->


                        </div>

                        <div class="side-col">
                            <div class="stiped-wrap" data-spy="affix" data-offset-top="200">
                                <div class="striped -type-2">
                                    <div class="striped-inner">
                                        <h2>
                                            Ваш тарифный пакет <a href="#">Light</a>
                                        </h2>

                                        <p>
                                            <a href="#"><i class="icon icon-doc-clip"></i>Журнал документов</a>
                                        </p>

                                        <p>
                                            В этом месяце вы можете создать еще <b>4</b> документа.
                                        </p>

                                        <div class="doc-counter">
                                            <span class="doc-counter-item is-active"></span>
                                            <span class="doc-counter-item is-active"></span>
                                            <span class="doc-counter-item is-active"></span>
                                            <span class="doc-counter-item is-active"></span>
                                            <span class="doc-counter-item"></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>


                        <div class="_cfix"></div>


                    </div><!--<div class="container">-->
                </div><!--<div class="app-content-inner">-->
            </div><!--<div class="app-content">-->
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

        <!-- choose country block [ -->
        <div class="choose-country-block">
            <a class="drop-link link-choose-country -close" href="#"><span class="title">для всех стран</span><i class="icon icon-choose-country"></i></a>
            <div class="explanation-text">
                на сайте представлены образцы документов разных стран, выберите страну, для которой вы хотите видеть документы
            </div>
            <div class="country-list">
                <a href="#c_0">для всех стран</a>
                <a href="#c_1">для Украины</a>
                <a href="#c_2">для России</a>
                <a href="#c_3">для Европы</a>
            </div>
        </div>
        <!-- ] choose country block -->
<!-- ===========================================================================
    END OF HIDDEN CONTENT
    ======================================================================== -->


        <!-- js [ -->
        <script src="js/vendor/jquery.min.js"></script>
        <script src="js/plugins.js"></script>
        <script src="js/main.js"></script>

        <script>
            $(function() {
                var chooseCountry = function() {
                    var leftOffset,
                        topOffset,
                        originalLeftOffset,
                        originalTopOffset,
                        linkOpen = $('.link-choose-country.-open'),
                        linkClose = $('.link-choose-country.-close');

                    linkOpen.on('click', function(event) {
                        event.preventDefault();

                        var newWidth = linkOpen.width();

                        originalLeftOffset = linkOpen.offset().left;
                        originalTopOffset = linkOpen.offset().top;

                        leftOffset = originalLeftOffset - 11;
                        topOffset = originalTopOffset;

                        $('.choose-country-block').css({
                            left: leftOffset,
                            top: topOffset,
                            width: newWidth
                        }).show();
                    });

                    linkClose.on('click', function(event) {
                        event.preventDefault();

                        $(this).closest('.choose-country-block').hide();
                    });

                    $('.choose-country-block .country-list a').on('click', function(event) {
                        event.preventDefault();

                        var link = $(this),
                            text = link.text(),
                            newWidth;

                        linkClose.find('.title').text(text);
                        linkOpen.find('.title').text(text);
                        newWidth = linkOpen.width();

                        link.closest('.choose-country-block').css({
                            width: newWidth
                        }).hide();
                        // SEND AJAX
                    });
                };
                chooseCountry();
            });
        </script>
        <!-- ] js -->
    </body>
</html>