<form action="{form:action}" name="{form:name}" method="post" class="form">
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
              <input type="text" name="{name:u_name}" id="fullname" class="text fullname" value="{value:u_name}">
          </label>
      </div>
  </div>

  <div class="control-row">
      <div class="control-cell">
          <label>
              Страна, в которой вы ведете деятельность:<br>
              <span class="change-country-row"><span id="user_country">{user_country}</span> <a href="#modal-country" data-toggle="modal">Хотите изменить страну?</a></span>
          </label>
      </div>
  </div>
  
<!-- modal country [ -->
<div id="modal-country" class="modal modal-country hide fade" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-inner">
        <div class="modal-header">
            <i class="icon icon-close" data-dismiss="modal" aria-hidden="true"></i>
            <h3>Страна</h3>
        </div>

        <div class="modal-body form">
            <div class="control-row">
                <div class="control-cell">
                     <select name="{name:u_f_country}" id="deal-country">
                      <option id="{id:u_f_country}" value="{value:u_f_country}" {selected:u_f_country}>{transl:country_{caption:u_f_country}}</option>
                    </select>
                </div>
            </div>
        </div> <!--<div class="modal-body form">-->

        <div class="modal-footer">
            <button type="submit" class="btn -primary">Сохранить</button>
        </div>
        
    </div><!--<div class="modal-inner">-->
</div>
<!-- ] modal country -->

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