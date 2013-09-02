<!-- modal login [ -->
<div id="modal-change-password" class="modal modal-change-password hide fade" tabindex="-1" role="dialog" aria-hidden="true">
    <form action="{form:action}" name="{form:name}" method="post" class="modal-inner">
        <div class="modal-header">
            <i class="icon icon-close" data-dismiss="modal" aria-hidden="true"></i>
            <h3>Смена пароля</h3>
        </div>

        <div class="modal-body form">
            <div class="control-row">
                <div class="control-cell">
                    <label>
                        Пароль:<br>
                        <input name="{name:user_pass}" type="{HTML_type:user_pass}" id="{caption:user_pass}" value="{value:user_pass}" class="text email">
                    </label>
                </div>
            </div>

            <div class="control-row">
                <div class="control-cell">
                    <label>
                        Повтор пароля:<br>
                        <input name="{name:user_re_pass}" type="{HTML_type:user_re_pass}" id="{caption:user_re_pass}" value="{value:user_re_pass}" class="text password">
                    </label>
                </div>
            </div>
        </div>

        <div class="modal-footer">
            <button type="submit" class="btn -primary">Сменить</button>
        </div>
    </form>
</div>
<!-- ] modal login -->