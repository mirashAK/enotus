jQuery(document).ready(function()
{

  App = {};
  
  App.Forms_sender = function(form_data)
  {
    var form = jQuery('form[name="'+form_data.form_name+'"]');
    
    var check_result = function (result)
    {
      if (result.length == 0) return false
      else return result;
    }

    jQuery(form).on('submit', function (e)
    {
      e.preventDefault();
      
      // Формируем данные для отправки, чтобы они передавались как единственный параметр
      var data = new Object ();
      data[form.attr('name')] = form.serialize();

      // Контейнер используем для замены его содержимого кодом HTML, сформированным после обработки формы
      var reload_container = form_data.reload_container || '.'+form.attr('name')+'_reload_container';
      reload_container = check_result(form.parents(reload_container).first()) || false;
      
      var before_send = form_data.before_send || function(){};
      var after_send = form_data.after_send || function(){};

      // Ajax sending
      jQuery.ajax (
      {
        url: form.attr('action'), // Адрес action формируется в контроллере при создании формы и выводится во view шаблона формы
        type: 'post',
        dataType: 'json',
        data: data,
        beforeSend: before_send (form),
        success: function(answer)
        {
          if (answer.valid == true)
          {
            // Сервер в ответе выдаёт либо адрес редиректа
            if (answer.redirect !== false) window.location = answer.redirect;
            //  либо код HTML, который нужно поместить на место формы (в reload_container)
            else if (answer.view !== false && reload_container) reload_container.html(answer.view);
          }
          else
          {
            for ( name in answer.errors ) 
            { 
              // Имена элементов массива с ошибками соответствуют либо name поля ввода либо его id
              elem = check_result(form.find('[name="'+name+'"]')) || check_result(form.find('#'+name));
              if (elem && form_data.on_error)
              { 
                form_data.on_error(elem, answer.errors[name]);
                elem.on('keypress', form_data.on_key_press);
              }
            };
          }
        },
        error: function(e)
        {
          console.log("error"+e);
        }
      }).always(function() { after_send (form); });
    });
  };
  
   
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


function prep_form_data(form){
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