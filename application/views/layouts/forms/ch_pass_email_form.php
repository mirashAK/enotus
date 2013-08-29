<h1>Восстановление пароля</h1>
<div class="stiped-wrap form-recovery">
    <div class="striped -type-1">
        <div class="striped-inner" id="{form:name}_reload_container">
            <form action="{form:action}" name="{form:name}" method="post" class="form">
                <h2>Забыли пароль?</h2>

                <p class="form-legend">
                    Введите свой электронный адрес и мы вышлем вам инструкцию по восстановлению пароля.
                </p>

                <div class="control-row">
                    <div class="control-cell">
                        <label>
                            Ваше email:<br>
                            <input name="{name:user_email}" type="{HTML_type:user_email}" id="{caption:user_email}" value="{value:user_email}" class="text email">
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