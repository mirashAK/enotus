<form action="{form:action}" name="{form:name}" method="post" class="form">
    <h2>Реквизиты организации</h2>

    <p class="form-legend">
        заполните эти поля, чтобы их значения автоматически в документ и вам не приходилось каждый раз вводить их вручную
    </p>


    <div class="control-row">
        <div class="control-cell">
            <label>
                Название организации:<br>
                <input name="{name:pc_name}" type="{HTML_type:pc_name}" value="{value:pc_name}" id="company-name" class="text company-name" />
            </label>
        </div>
    </div>


    <div class="control-row">
        <div class="control-cell">
            <label>
                Город:<br>
                <input name="{name:pc_city}" type="{HTML_type:pc_city}" value="{value:pc_city}" id="city" class="text city" />
            </label>
        </div>
    </div>


    <div class="control-row">
        <div class="control-cell">
            <label>
                Адрес организации:<br>
                <textarea name="{name:pc_adress}" type="{HTML_type:pc_adress}"  id="company-address">{value:pc_adress}</textarea>
            </label>
        </div>
    </div>


    <div class="control-row">
        <div class="control-cell">
            <label>
                Код ОКПО:<br>
                <input name="{name:pc_okpo}" type="{HTML_type:pc_okpo}" value="{value:pc_okpo}" id="code" class="text code" />
            </label>
        </div>
    </div>


    <div class="control-row">
        <div class="control-cell _fleft">
            <label>
                Расчетный счет:<br>
                <input name="{name:pc_account}" type="{HTML_type:pc_account}" value="{value:pc_account}" id="clearing-account" class="text clearing-account" />
            </label>
        </div>


        <div class="control-cell _fleft">
            <label>
                МФО:<br>
                <input name="{name:pc_mfo}" type="{HTML_type:pc_mfo}" value="{value:pc_mfo}" id="mfo" class="text mfo">
            </label>
        </div>


        <div class="_cfix"></div>
    </div>


    <div class="control-row">
        <div class="control-cell">
            <label>
                Название банка, в котором открыт расчетный счет:<br>
                <input name="{name:pc_bank}" type="{HTML_type:pc_bank}" value="{value:pc_bank}" id="bank" class="text bank">
            </label>
        </div>
    </div>
  
 <div id="phones-rows">
 {pc_phones}
    <div class="control-row">
        <div class="control-cell">
            <label>
                Контактный телефон:<br>
                <input type="text" name="{name:pc_phones}[{index}]" class="text" value="{value}">
            </label>
        </div>
    </div>
  {/pc_phones}
  </div><!--<div class="phones-rows">-->

  <div class="control-row add-phone-row">
        <div class="control-cell">
            <a href="#add-phone" id="add-phone" class="add-phone-link -dotted" data-new-name="{name:pc_phones}">Добавить телефон</a>
        </div>
    </div>

    <input type="hidden" name="{name:pc_id}" value="{value:pc_id}" />

    <div class="control-row">
        <div class="control-cell">
            <button type="submit" class="btn -primary">Сохранить</button>
            <button type="reset" class="btn">Отменить</button>
        </div>
    </div>
</form>