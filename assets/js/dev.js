jQuery(document).ready(function()
{

  App = {};
  
  /**
   * Определение отправщика формы
   */
  App.Forms_sender = function(form_data)
  {
    var form = $('form[name="'+form_data.form_name+'"]');

    // Служебка для проверки результата работы $ find(), чтобы знать, когда элемент не найден
    var check_result = function (result)
    {
      if (result.length === 0) { return false; }
      else { return result; }
    };

    $(form).on('submit', function (e)
    {
      e.preventDefault();

      // Формируем данные для отправки, чтобы они передавались как единственный параметр
      var data = {};
      data[form.attr('name')] = this.prep_form_data(form);

      // Адрес action формируется в контроллере при создании формы и выводится во view шаблона формы
      var url = form.attr('action');

      // Контейнер используем для замены его содержимого кодом HTML, сформированным после обработки формы
      var reload_container = form_data.reload_container || '.'+form.attr('name')+'_reload_container';
      reload_container = check_result(jQuery(reload_container).first()) || false;

      var before_send = form_data.before_send || function(){};
      var after_send = form_data.after_send || function(){};
      var success_send = form_data.success_send || function(){};

      // Ajax sending
      $.ajax (
      {
        url: url,
        type: 'post',
        dataType: 'json',
        data: data,
        beforeSend: function ( xhr ) { before_send (form, xhr); },
        success: function(answer)
        {
          if (answer.valid === true)
          {
            // Меняем значения полей, например при добавлении новой записи
            if (answer.update !== false)
              jQuery.each(answer.update, function (name, value) { form.find('[name="'+name+'"]').val(value); });
            // Сервер в ответе выдаёт либо адрес редиректа
            if (answer.redirect !== false) { window.location = answer.redirect; }
            //  либо код HTML, который нужно поместить на место формы (в reload_container)
            else if (answer.view !== false && reload_container) {
              reload_container.html(answer.view);
            }

            success_send(form);
          }
          else
          {
            for ( var name in answer.errors )
            {
              if ( answer.errors.hasOwnProperty(name) ) {
                // Имена элементов массива с ошибками соответствуют либо name поля ввода либо его id
                var elem = check_result(form.find('[name="'+name+'"]')) || check_result(form.find('#'+name));
                if (elem && form_data.on_error)
                {
                  form_data.on_error(elem, answer.errors[name]);
                  elem.on('keypress', form_data.on_key_press);
                }
              }
            }
          }
        },
        error: function(e)
        {
          console.log("error"+e);
        }
      },).always(function() { after_send (form); });
    });
  };
  
  App.prep_form_data = function (form)
  {
      var a = [];
      $(form).
      find("input[type='checkbox']:checked, input[type='file'], input[type='hidden'], input[type='password'], input[type='radio']:checked, input[type='text'], textarea, select").
      each(function(){
          if(this.tagName == 'SELECT' && $(this).attr('multiple') == true) {
              var select_name = this.name;
              $(this).find('option:selected').each(function(){
                  a.push(select_name+'[]=' + this.value);
              })
          } else {
              var content = $(this).hasClass('tiny-mce') ? tinyMCE.get($(this).attr('id')).getContent() : this.value;
              a.push(this.name + '=' + encodeURIComponent(content));
          }
      });
      return a.join('&');
  }
  
  
  
   
  App.Forms_sender(
  {
    form_name: 'auth_form'
  });
  
  App.Forms_sender(
  {
    form_name: 'reg_form',
    reload_container: '#reload_container',
    on_key_press: function (event) { jQuery(event.target).removeClass('error'); },
    on_error: function (elem, errors) {elem.addClass('error').after('<span>'+errors+'</span>'); },
    before_send: function (form) { form.find('.btn-primary').addClass('is-wait'); }        
  });
  
  
}); 
