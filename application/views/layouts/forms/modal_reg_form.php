<!-- modal registration [ -->
<div id="modal-registration" class="modal modal-registration hide fade" tabindex="-1" role="dialog" aria-hidden="true">
      <form action="{form:action}" name="{form:name}"  method="post" class="modal-inner">
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
                        <input class="text email required" name="{name:user_email}" type="{HTML_type:user_email}" id="{caption:user_email}" value="{value:user_email}">
                    </label>
                </div>
            </div>

            <div class="control-row">
                <div class="control-cell">
                    <label>
                        Пароль<i class="field-mark">*</i>:<br>
                        <input class="text password required" name="{name:user_pass}" type="{HTML_type:user_pass}" id="{caption:user_pass}" value="{value:user_pass}">
                    </label>
                </div>
            </div>

            <div class="control-row">
                <div class="control-cell">
                    <label>
                        Страна, в которой вы ведете деятельность<i class="field-mark">*</i>:<br>
                    </label>
                    <!--<select name="deal_country" >-->
                    <select name="{name:u_f_country}" id="deal-country">
                      <option id="{id:u_f_country}" value="{value:u_f_country}" {selected:u_f_country}>{caption:u_f_country}</option>
                    </select>
                </div>
            </div>

            <div class="control-row">
                <div class="control-cell">
                    <label>
                        Как вы хотите, чтобы мы обращались к вам в письмах:<br>
                        <input name="{name:u_name}" type="{HTML_type:u_name}" id="{caption:u_name}" class="text fullname" value="{value:u_name}">
                    </label>
                </div>
            </div>

            <p class="modal-addition">
                Регистрируясь, вы принимаете <a href="#modal-rules" class="-dotted" data-toggle="modal" data-dismiss="modal" aria-hidden="true">условия использования</a> сайта Енотус.
            </p>
        </div>

        <div class="modal-footer">
            <button type="submit" class="btn -primary">Зарегистрироваться</button>
            <div class="modal-bottom-link"><a class="-dotted" href="#modal-login" data-toggle="modal" data-dismiss="modal" aria-hidden="true">Уже регистрировались? Войти</a></div>
        </div>
    </form>
</div>
<!-- ] modal registration -->

<!-- modal agreement [ -->
<div id="modal-rules" class="modal modal-rules hide fade" tabindex="-1" role="dialog" aria-hidden="true">
    <form action="" method="post" class="modal-inner">
        <div class="modal-header">
            <i class="icon icon-close" data-dismiss="modal" aria-hidden="true"></i>
            <h3>Условия использования</h3>
        </div>

        <div class="modal-body form">
            <p>Угрозы безопасности персональных данных - совокупность условий и факторов, создающих опасность несанкционированного, в том числе случайного, доступа к персональным данным, результатом которого может стать уничтожение, изменение, блокирование, копирование, распространение персональных данных, а также иных несанкционированных действий при их обработке в информационной системе персональных данных.</p>

            <p>Модель угроз безопасности персональных данных необходима для определения требований к системе защиты. Без модели угроз невозможно построить адекватную (с точки зрения денежных затрат) систему защиты информации, обеспечивающую безопасность персональных данных.</p>

            <p>Модель угроз (или как ее еще называют "Частная модель угроз") может разрабатываться ответственными за защиту персональных данных в организации. Также могут привлекаться сторонние эксперты. Разработчики модели угроз должны владеть полной информацией об информационной системе персональных данных, знать нормативную базу по защите информации.</p>

        </div>

        <div class="modal-footer">
            <a href="#modal-registration" data-toggle="modal" data-dismiss="modal" aria-hidden="true" class="btn -primary">Принимаю</a>
        </div>
    </form>
</div>
<!-- ] modal agreement -->