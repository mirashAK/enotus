<h1>Восстановление пароля</h1>
<div class="stiped-wrap form-recovery">
    <div class="striped -type-1">
        <div class="striped-inner" id="{form:name}_reload_container">
            <form action="{form:action}" name="{form:name}" method="post" class="form">
                <h2>Ввод нового пароля</h2>

<!--                <p class="form-legend">
                    Введите новый пароль
                </p>-->

                <div class="control-row">
                    <div class="control-cell">
                        <label>
                            Новый пароль:<br>
                            <input name="{name:user_pass}" type="{HTML_type:user_pass}" id="{caption:user_pass}" value="{value:user_pass}" class="text password">
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
                
                <div class="control-row">
                    <div class="control-cell">
                        <button type="submit" class="btn -primary">Отправить</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>