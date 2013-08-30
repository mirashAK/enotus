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
                {company_settings_form}
            </div><!--<div class="second-col">-->


            <div class="_cfix"></div>
        </div>
        <!-- ] settings -->


    </div>
    <!-- ] tab-content -->


</div>
<!-- ] сabinet -->