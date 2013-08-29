<!-- modal login [ -->
<div id="modal-login" class="modal modal-login hide fade" tabindex="-1" role="dialog" aria-hidden="true">
    <form action="{form:action}" name="{form:name}" method="post" class="modal-inner">
        <div class="modal-header">
            <i class="icon icon-close" data-dismiss="modal" aria-hidden="true"></i>
            <h3>Вход на сайт</h3>
        </div>

        <div class="modal-body form">
            <div class="control-row">
                <div class="control-cell">
                    <label>
                        E-mail:<br>
                        <input name="{name:user_email}" type="{HTML_type:user_email}" id="{caption:user_email}" value="{value:user_email}" class="text email">
                    </label>
                </div>
            </div>

            <div class="control-row">
                <div class="control-cell">
                    <label>
                        Пароль:<br>
                        <input name="{name:user_pass}" type="{HTML_type:user_pass}" id="{caption:user_pass}" value="{value:user_pass}" class="text password">
                        <a href="{sub_url}/auth/restoration">Я не помню пароль</a>
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