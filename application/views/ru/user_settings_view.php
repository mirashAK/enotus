<!-- сabinet [ -->
<div class="cabinet">

  {user_tabs}

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
                                    {user_email}
                                </div>
                            </div>
                        </div>
                    </div>


                    <div class="control-row">
                        <div class="control-cell">
                            <label>
                                Как вы хотите, чтобы мы обращались к вам в письмах:<br>
                                <input type="text" name="fullname" id="fullname" class="text fullname" value="{user_public:u_name}">
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