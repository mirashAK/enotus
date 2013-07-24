<!DOCTYPE html>
<!--[if IE 7]>         <html class="ie7 lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="ie8 lt-ie9"> <![endif]-->
<!--[if IE 9]>         <html class="ie9"> <![endif]-->
<!--[if gt IE 9]><!-->
<html>
<!--<![endif]-->


    <head>

        <meta charset="utf-8">
        <title>Мой профиль - Журнал</title>


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
                            <li class="is-current">Мой профиль - Журнал</li>
                        </ul>


                        <!-- сabinet [ -->
                        <div class="cabinet">


                            <!-- tabs [ -->
                            <nav class="tabs _cfix" role="tabs">
                                <a class="tab is-current" href="#"><i class="icon icon-journal"></i>Журнал</a>
                                <a class="tab" href="#">Тарифный пакет</a>
                                <a class="tab" href="#">История оплат</a>
                                <a class="tab" href="#">Настройки</a>
                            </nav>
                            <!-- ] tabs -->


                            <!-- tab-content [ -->
                            <div class="tab-content">


                                <!-- main column [ -->
                                <div class="main-col">


                                    <!-- search [ -->
                                    <div class="control-row search-helper-row">
                                        <form class="control-cell _prel" action="#" method="post">
                                            <input type="text" name="search_helper" id="search-helper" class="text search-helper" placeholder="Поиск">


                                            <!-- search pane [ -->
                                            <div class="search-pane" id="search-pane">
                                                <span class="icon icon-close-pane" id="close-pane"></span>


                                                <select name="doc_type" id="doc-type">
                                                    <option value="1" selected>Приходно-кассовый ордер</option>
                                                    <option value="2">Расходно-кассовый ордер</option>
                                                    <option value="3">Накладная</option>
                                                    <option value="4">Доверенность</option>
                                                </select>

                                                <div class="control-row">
                                                    <div class="control-cell">
                                                        <label>
                                                            Контрагент (покупатель):<br>
                                                            <input type="text" name="buyer" id="buyer" class="text buyer">
                                                        </label>
                                                    </div>
                                                </div>

                                                <div class="control-row">
                                                    <div class="control-cell">
                                                        <div>
                                                            Дата создания документа:<br>
                                                            <label>от <input type="text" name="date_from" id="date_from" class="text date" readonly></label>
                                                            <label>до <input type="text" name="date_to" id="date_to" class="text date" readonly></label>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="control-row">
                                                    <div class="control-cell">
                                                        <button class="btn -special link-search _fleft" type="submit">
                                                            <i class="icon icon-search"></i>
                                                        </button>

                                                        <div class="form-legend">
                                                            результат поиска также может быть сохранен в виде реестра, выборки документов, доступны формат Excel и PDF.
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- ] search pane -->


                                            <button class="btn -special link-search" type="submit">
                                                <i class="icon icon-search"></i>
                                            </button>


                                            <span class="clear-search-field icon icon-clear is-hidden" id="clear-search-field" title="Очистить"></span>
                                            <span class="icon icon-search-expand" id="icon-search-expand"></span>
                                        </form>
                                    </div>
                                    <!-- ] search -->


                                    <!-- filters [ -->
                                    <ul class="filters _cfix">
                                        <li data-role="filter" data-option="alphabet"><span>время создания</span></li>
                                        <li data-role="filter" data-option="popularity"><span >тип документа</span></li>
                                        <li class="is-active" data-role="filter" data-option="availability"><span>контрагент</span></li>
                                    </ul>
                                    <!-- ] filters -->


                                    <!-- list [ -->
                                    <div class="result-list">


                                        <!-- collapsible block [ -->
                                        <div class="acc-block">
                                            <div class="acc-head no-style js-acc-head">
                                                <h2>ЧП Герасимьюк</h2><i class="acc-head-arrow"></i>
                                            </div>


                                            <div class="acc-text js-acc-text">
                                                <div class="cabinet-journal-docs">
                                                    <div class="cabinet-journal-doc _cfix">
                                                        <div class="cabinet-journal-doc-date _fleft">10.12.2012</div>
                                                        <div class="cabinet-journal-doc-details _fleft">
                                                            <div><a href="#">Расходно-кассовый ордер №1</a><span class="dots"> . . . . . . . . . . . . </span>
                                                                <a class="icon icon-view" href="#" title="Просмотр"></a>
                                                                <a class="icon icon-edit" href="#" title="Редактировать"></a>
                                                                <a class="icon icon-foundation" href="#" title="Просмотр"></a>
                                                                <a class="icon icon-clone" href="#" title="Клонировать"></a>
                                                                <a class="icon icon-delete" href="#" title="Удалить"></a>
                                                            </div>
                                                            <div>Покупатель: ЧП Герасимьюк.</div>
                                                        </div>
                                                    </div>


                                                    <div class="cabinet-journal-doc _cfix">
                                                        <div class="cabinet-journal-doc-date _fleft">11.12.2012</div>
                                                        <div class="cabinet-journal-doc-details _fleft">
                                                            <div><a href="#">Накладная №1</a><span class="dots"> . . . . . . . . . . . . </span>
                                                                <a class="icon icon-view" href="#" title="Просмотр"></a>
                                                                <a class="icon icon-edit" href="#" title="Редактировать"></a>
                                                                <a class="icon icon-foundation" href="#" title="Просмотр"></a>
                                                                <a class="icon icon-clone" href="#" title="Клонировать"></a>
                                                                <a class="icon icon-delete" href="#" title="Удалить"></a>
                                                            </div>
                                                            <div>Покупатель: ЧП Герасимьюк.</div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- ] collapsible block -->


                                        <!-- collapsible block [ -->
                                        <div class="acc-block">
                                            <div class="acc-head no-style js-acc-head">
                                                <h2>ФОП Васильченко</h2><i class="acc-head-arrow"></i>
                                            </div>


                                            <div class="acc-text js-acc-text">
                                                <div class="cabinet-journal-docs">
                                                    <div class="cabinet-journal-doc _cfix">
                                                        <div class="cabinet-journal-doc-date _fleft">10.12.2012</div>
                                                        <div class="cabinet-journal-doc-details _fleft">
                                                            <div><a href="#">Расходно-кассовый ордер №1</a><span class="dots"> . . . . . . . . . . . . </span>
                                                                <a class="icon icon-view" href="#" title="Просмотр"></a>
                                                                <a class="icon icon-edit" href="#" title="Редактировать"></a>
                                                                <a class="icon icon-foundation" href="#" title="Просмотр"></a>
                                                                <a class="icon icon-clone" href="#" title="Клонировать"></a>
                                                                <a class="icon icon-delete" href="#" title="Удалить"></a>
                                                            </div>
                                                            <div>Покупатель: ЧП Герасимьюк.</div>
                                                        </div>
                                                    </div>


                                                    <div class="cabinet-journal-doc _cfix">
                                                        <div class="cabinet-journal-doc-date _fleft">11.12.2012</div>
                                                        <div class="cabinet-journal-doc-details _fleft">
                                                            <div><a href="#">Накладная №1</a><span class="dots"> . . . . . . . . . . . . </span>
                                                                <a class="icon icon-view" href="#" title="Просмотр"></a>
                                                                <a class="icon icon-edit" href="#" title="Редактировать"></a>
                                                                <a class="icon icon-foundation" href="#" title="Просмотр"></a>
                                                                <a class="icon icon-clone" href="#" title="Клонировать"></a>
                                                                <a class="icon icon-delete" href="#" title="Удалить"></a>
                                                            </div>
                                                            <div>Покупатель: ЧП Герасимьюк.</div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- ] collapsible block -->


                                        <!-- collapsible block [ -->
                                        <div class="acc-block">
                                            <div class="acc-head no-style js-acc-head">
                                                <h2>Очень длинное название контрагента, которое не помещается в одну строку</h2><i class="acc-head-arrow"></i>
                                            </div>


                                            <div class="acc-text js-acc-text">
                                                <div class="cabinet-journal-docs">
                                                    <div class="cabinet-journal-doc _cfix">
                                                        <div class="cabinet-journal-doc-date _fleft">10.12.2012</div>
                                                        <div class="cabinet-journal-doc-details _fleft">
                                                            <div><a href="#">Расходно-кассовый ордер №1</a><span class="dots"> . . . . . . . . . . . . </span>
                                                                <a class="icon icon-view" href="#" title="Просмотр"></a>
                                                                <a class="icon icon-edit" href="#" title="Редактировать"></a>
                                                                <a class="icon icon-foundation" href="#" title="Просмотр"></a>
                                                                <a class="icon icon-clone" href="#" title="Клонировать"></a>
                                                                <a class="icon icon-delete" href="#" title="Удалить"></a>
                                                            </div>
                                                            <div>Покупатель: ЧП Герасимьюк.</div>
                                                        </div>
                                                    </div>


                                                    <div class="cabinet-journal-doc _cfix">
                                                        <div class="cabinet-journal-doc-date _fleft">11.12.2012</div>
                                                        <div class="cabinet-journal-doc-details _fleft">
                                                            <div><a href="#">Накладная №1</a><span class="dots"> . . . . . . . . . . . . </span>
                                                                <a class="icon icon-view" href="#" title="Просмотр"></a>
                                                                <a class="icon icon-edit" href="#" title="Редактировать"></a>
                                                                <a class="icon icon-foundation" href="#" title="Просмотр"></a>
                                                                <a class="icon icon-clone" href="#" title="Клонировать"></a>
                                                                <a class="icon icon-delete" href="#" title="Удалить"></a>
                                                            </div>
                                                            <div>Покупатель: ЧП Герасимьюк.</div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- ] collapsible block -->


                                    </div>
                                    <!-- ] list -->


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
                                <!-- ] main column -->


                                <!-- side column [ -->
                                <div class="side-col">
                                    <div class="stiped-wrap" data-spy="affix" data-offset-top="200">
                                        <div class="striped -type-2">
                                            <div class="striped-inner">
                                                <h2>
                                                    Немного <br>статистики:
                                                </h2>

                                                <div>
                                                    <span class="stat"><i class="icon icon-doc"></i>432</span>
                                                </div>

                                                <div>
                                                    документа было вами создано в прошлом месяце
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- ] side column -->


                                <div class="_cfix"></div>


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