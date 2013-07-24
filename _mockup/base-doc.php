<!DOCTYPE html>
<!--[if IE 7]>         <html class="ie7 lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="ie8 lt-ie9"> <![endif]-->
<!--[if IE 9]>         <html class="ie9"> <![endif]-->
<!--[if gt IE 9]><!-->
<html>
<!--<![endif]-->


    <head>

        <meta charset="utf-8">
        <title>База документов - База документов</title>


        <?php $current = 1; include_once('_head.php'); ?>
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
                            <li><a href="#">База документов</a><i class="icon icon-bc-separator"></i></li>
                            <li class="is-current">Расходная накладная</li>
                        </ul>


                        <h1 class="_fleft">Расходная накладная</h1>
                        <p class="form-legend -doc _fleft">
                            поля, помеченные <i class="field-mark">*</i> , обязательны для заполнения
                        </p>
                        <div class="_cfix"></div>


                                <!-- main column [ -->
                                <div class="main-col">
                                    <form class="doc-block form">
                                        <table>
                                            <tbody>
                                                <tr>
                                                    <td class="first-col">
                                                        <h2 class="doc-data-expander"><span>Реквизиты организации</span><i></i></h2>

                                                        <p class="form-legend">
                                                            это ваши персональные данные, необходимые для того, чтобы входить на сайт
                                                        </p>


                                                        <div class="doc-collapsible is-hidden">


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
                                                                        Код ОКПО<i class="field-mark">*</i>:<br>
                                                                        <input type="text" name="code" id="code" class="text code required" value="15503654651651565">
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
                                                                        <input type="text" name="contact_phone[]" class="text phone" value="+38">
                                                                    </label>
                                                                </div>
                                                            </div>


                                                            <div class="control-row add-phone-row">
                                                                <div class="control-cell">
                                                                    <a href="#add-phone" id="add-phone" class="add-phone-link -dotted">Добавить телефон</a>
                                                                </div>
                                                            </div>


                                                        </div>
                                                    </td>
                                                    <td class="doc-desc">
                                                        <div class="doc-prev">
                                                            <span class="doc-prev-figure -empty"></span>
                                                        </div>
                                                        <div class="doc-type">
                                                            <b>A4,</b> <br>горизонтальный
                                                        </div>
                                                        <div class="_cfix"></div>


                                                        <div class="doc-collapsible is-hidden">


                                                            <p>Вы можете создать документ этого типа.</p>
                                                            <p><a href="#"><i class="icon icon-doc-ex"></i>Пример документа</a></p>

                                                            <p class="form-legend">
                                                                Накладная — документ, используемый при передаче товарно-материальных ценностей от одного лица другому.
                                                            </p>


                                                            <p class="form-legend">
                                                                Товарная накладная — документ, предназначенный для оформления операций по отпуску и приёму товаров со склада. Является одним из документов первичной бухгалтерской отчётности. Содержит название организации, номер накладной, дату отпуска товара, его наименование, кем отпущен товар, кому отпущен товар, его количество, сорт, цена и другие данные, основание для отпуска товара, подписи материально ответственных лиц в его отпуске и приеме.
                                                            </p>
                                                            

                                                        </div>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>


                                        <div class="doc-block-expanded-data">
                                            <h2>Данные документа</h2>

                                            <div class="control-row">
                                                <div class="control-cell _fleft">
                                                    <label>
                                                        №<i class="field-mark">*</i>:<br>
                                                        <input type="text" name="number" id="number" class="text number required" value="">
                                                    </label>
                                                </div>
                                                <div class="control-cell _fleft">
                                                    <label>
                                                        Дата выдачи<i class="field-mark">*</i>:<br>
                                                        <input type="text" name="date" id="date" class="text date required" value="">
                                                    </label>
                                                </div>


                                                <div class="_cfix"></div>
                                            </div>


                                            <div class="control-row">
                                                <div class="control-cell _fleft">
                                                    <label>
                                                        Покупатель<i class="field-mark">*</i>:<br>
                                                        <input type="text" name="buyer" id="buyer" class="text required" value="">
                                                    </label>
                                                </div>
                                                <div class="control-cell _fleft">
                                                    <label>
                                                        Плательщик<i class="field-mark">*</i>:<br>
                                                        <input type="text" name="seller" id="seller" class="text required" value="">
                                                    </label>
                                                </div>


                                                <div class="_cfix"></div>
                                            </div>


                                            <div class="control-row">
                                                <div class="control-cell _fleft">
                                                    <label>
                                                        Доверенность №<i class="field-mark">*</i>:<br>
                                                        <input type="text" name="warrant_number" id="warrant-number" class="text required" value="">
                                                    </label>
                                                </div>
                                                <div class="control-cell _fleft">
                                                    <label>
                                                        Основание выдачи доверенности<i class="field-mark">*</i>:<br>
                                                        <input type="text" name="base_of_deal" id="base-of-deal" class="text required" value="">
                                                    </label>
                                                </div>


                                                <div class="_cfix"></div>
                                            </div>


                                            <div class="services" id="services">
                                                <div class="service-row">
                                                    <a class="delete-service icon icon-delete-service" href="#" title="Удалить услугу"></a>
                                                    <div class="service-number">
                                                        1.
                                                    </div>
                                                    <div class="control-row -top">
                                                        <div class="control-cell">
                                                            <label>
                                                                Товар/услуга:<br>
                                                                <input type="text" name="warrant_number[]" class="text" value="">
                                                            </label>
                                                        </div>


                                                    </div>


                                                    <div class="_cfix"></div>


                                                    <div class="control-row">
                                                        <div class="control-cell _fleft">
                                                            <label>
                                                                Артикул:<br>
                                                                <input type="text" name="articul[]" class="text articul" value="">
                                                            </label>
                                                        </div>


                                                        <div class="control-cell _fleft">
                                                            <label>
                                                                Ед. измерения:<br>
                                                                <input type="text" name="units[]" class="text units" value="">
                                                            </label>
                                                        </div>


                                                        <div class="control-cell _fleft">
                                                            <label>
                                                                Кол-во:<br>
                                                                <input type="text" name="count[]" class="text count" value="">
                                                            </label>
                                                        </div>


                                                        <div class="control-cell _fleft">
                                                            <label>
                                                                Без НДС, грн:<br>
                                                                <input type="text" name="nettomoney[]" class="text nettomoney" value="">
                                                            </label>
                                                        </div>


                                                        <div class="control-cell _fleft">
                                                            <label>
                                                                Сумма, грн:<br>
                                                                <input type="text" name="bruttomoney[]" class="text bruttomoney" value="">
                                                            </label>
                                                        </div>


                                                        <div class="_cfix"></div>
                                                    </div>
                                                </div>


                                            </div>

                                            
                                            <div class="total">
                                                <div class="service-adder-block _fleft">
                                                    <a href="#service-adder-link" class="service-adder-link -dotted" id="js-add-link">Добавить товар/услугу</a>
                                                </div>


                                                <div class="service-adder-table _fright">
                                                    <table>
                                                        <tr>
                                                            <td class="label">Итого, грн:</td>
                                                            <td>850000,00</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="label">Итого с НДС, грн:</td>
                                                            <td>100500,00</td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2">
                                                                <input type="checkbox" name="tax" id="tax">
                                                                <label class="label" for="tax">Включить 20% налог</label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>


                                                <div class="_cfix"></div>
                                            </div>


                                            <div class="control-row additional-options">
                                                <div class="control-cell ckeck-cell _fleft">
                                                    <input type="checkbox" name="send_check" id="send-check">
                                                    <label class="label" for="send-check">Отправить документ при сохранении на почту</label>
                                                </div>

                                                <div class="control-cell send-as-cell _fleft">
                                                    Отправить как:<br>
                                                    <input type="radio" name="send_as[]" id="send-as-1">
                                                    <label class="label" for="send-as-1">Ссылку</label><br>
                                                    <input type="radio" name="send_as[]" id="send-as-2">
                                                    <label class="label" for="send-as-2">PDF-документ</label>
                                                </div>


                                                <div class="control-cell _fleft">
                                                    <label>
                                                        Адрес электронной почты:<br>
                                                        <input type="text" name="send_to_email" id="send-to-email" class="text email send-to-email">
                                                    </label>
                                                </div>


                                                <div class="_cfix"></div>
                                            </div>


                                            <div class="control-row">
                                                <div class="control-cell">
                                                    <button type="submit" class="btn -primary">Cохранить</button>
                                                    <button class="btn -primary js-print">Распечатать</button>
                                                    <button type="reset" class="btn">Очистить</button>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                                <!-- ] main column -->


                                <!-- side column [ -->
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
                                <!-- ] side column -->


                                <div class="_cfix"></div>


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