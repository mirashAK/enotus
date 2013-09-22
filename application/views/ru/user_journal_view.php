<!-- сabinet [ -->
<div class="cabinet">

  {user_tabs}

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
                <li class="is-active" data-role="filter" data-option="alphabet"><span>время создания</span></li>
                <li data-role="filter" data-option="popularity"><span >тип документа</span></li>
                <li data-role="filter" data-option="availability"><span>контрагент</span></li>
            </ul>
            <!-- ] filters -->


            <!-- list [ -->
            <div class="result-list">


                <!-- collapsible block [ -->
                <div class="acc-block">
                    <div class="acc-head no-style js-acc-head">
                        <h2>2012 год, декабрь</h2><i class="acc-head-arrow"></i>
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
                        <h2>2012 год, ноябрь</h2><i class="acc-head-arrow"></i>
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
                        <h2>2012 год, март</h2><i class="acc-head-arrow"></i>
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