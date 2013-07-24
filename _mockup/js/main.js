/**
 * Clientside-validation
 * @wrapper, @errorPlace - html elements
 * @errors - object with strings
 * @regexps - object with regular expressions
 */
var jsValidation = function() {
    var
        wrapper = $('<div class="form-error-wrap"></div>'),
        errorPlace = $('<div class="form-error"></div>'),

        errors = {
            required: "Это поле не должно быть пустым.",
            email: "Введите корректный email."
        },

        regexps = {
            email: /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
        }

    // required validation
    $(document).on('blur change', '.required', function() {
        var field = $(this);

        if (!field.val() || $.trim(field.val()).length < 1) {
            if(!field.closest('.form-error-wrap').length) {
                field.wrap(wrapper).after(errorPlace.clone().html(errors.required));
                field.attr('data-valid', "false");
            }
        } else {
            if(field.closest('.form-error-wrap').length) {
                field.next('.form-error').remove();
                field.unwrap('.form-error-wrap');
                field.removeAttr('data-valid');
            }
        }
    });

    // email validation
    $(document).on('blur change', '.required.email', function() {
        var field = $(this);

        if (!regexps.email.test(field.val()) && $.trim(field.val()).length) {
            if(field.next('.form-error').length) {
                field.next('.form-error').html(errors.email);
                field.attr('data-valid', "false");
            } else {
                field.wrap(wrapper).after(errorPlace.clone().html(errors.email));
                field.attr('data-valid', "false");
            }
        } else if (!regexps.email.test(field.val()) && $.trim(field.val()).length < 1) {
            if(field.next('.form-error').length) {
                field.next('.form-error').html(errors.required);
                field.attr('data-valid', "false");
            }
        }
    });

    // form stopping
    $(document).on('submit', 'form', function(event) {
        var form, formHasInvalidFields, formHasRequiredEmptyFields;


        form = $(this);
        formHasInvalidFields = form.find('input[data-valid="false"]').length > 0;
        formHasRequiredEmptyFields = _formHasRequiredEmptyFields(form);


        function _formHasRequiredEmptyFields(form) {
            var emptyCount = 0;
            form.find('.required').each(function() {
                var field = $(this);
                if (!field.val() || $.trim(field.val()).length < 1) {
                    if(!field.closest('.form-error-wrap').length) {
                        field.wrap(wrapper).after(errorPlace.clone().html(errors.required));
                        field.attr('data-valid', "false");
                    }
                    emptyCount++;
                }
            });
            if (emptyCount > 0) {
                return true;
            }
        };


        if (formHasInvalidFields || formHasRequiredEmptyFields) {
            event.preventDefault();

            form.find('input[data-valid="false"]').first().trigger('focus');
        }
    });
};
jsValidation();


/**
 * Collapsible blocks for F.A.Q.
 */
var collapsibleBlock = function() {
    var
        toggler,
        content;

    $('.js-acc-head').click(function() {
        toggler = $(this);
        content = toggler.next('.js-acc-text');

        if (toggler.hasClass('is-expanded')) {
            content.slideUp('230');
            toggler.removeClass('is-expanded');
        } else {
            content.slideDown('230');
            toggler.addClass('is-expanded');
        }
    });
};
collapsibleBlock();


var searchPane = function() {
    $(document).off('focus.searchHelper').on('focus.searchHelper', "#search-helper", function() {
        var field = $(this);


        field.addClass('is-active');
        if (('html').is('.ie8')) {
            field.parent().addClass('ie8-rerendring').removeClass('ie8-rerendring');
        }
    });


    $(document).off('change keydown keyup.searchHelper').on('change keydown keyup.searchHelper', "#search-helper", function() {
        var field = $(this);
        var clearer = $('#clear-search-field');


        if ($.trim(field.val()).length) {
            clearer.removeClass('is-hidden');
        } else {
            clearer.addClass('is-hidden');
        }
    });


    $(document).off('click.closePane').on('click.closePane', "#close-pane", function() {
        var field = $('#search-helper');


        field.removeClass('is-active');
        if (('html').is('.ie8')) {
            field.parent().addClass('ie8-rerendring').removeClass('ie8-rerendring');
        }
    });


    $(document).off('click.clearSearchField').on('click.clearSearchField', "#clear-search-field", function() {
        var field = $('#search-helper');
        var clearer = $(this);


        field.val('').blur();
        clearer.addClass('is-hidden');
    });


    $(document).off('click.expandSearchField').on('click.expandSearchField', "#icon-search-expand", function() {
        var field = $('#search-helper');
        var expander = $(this);


        field.focus();
    });
};
searchPane();


var userOptionsDropdown =function() {
    $('.user-link-wrap').click(function(event) {
        event.preventDefault();


        var link, tempDiv, text, textWidth;
        var link = $(this);


        tempDiv = $('<div style="display: inline-block; position: absolute; left: -99999em"></div>');
        tempDiv.appendTo('body');
        text = $('.user-block-head').text();
        tempDiv = tempDiv.append(text);
        textWidth = tempDiv.width();
        tempDiv.remove();
        textWidth += 55;

        $('.user-block').css('width', textWidth);


        if (link.hasClass('is-active')) {
            link.removeClass('is-active');
        } else {
            link.addClass('is-active');
        }
    });


    $('.user-link-block, .user-block-arrow').click(function(event) {
        event.preventDefault();


        var originalLink = $(this).closest('.user-block').prev('.user-link-wrap');


        if (originalLink.hasClass('is-active')) {
            originalLink.removeClass('is-active');
        } else {
            originalLink.addClass('is-active');
        }
    });


    $(document).off('click.closeUserDropdown').on('click.closeUserDropdown', function(event) {
        var block, eTarget;


        block = $('.user-block');
        eTarget = $(event.target)


        if (block.is(':visible') && !eTarget.closest('.user-block').length && !eTarget.closest('.user-link-wrap').length) {
            block.prev('.user-link-wrap').removeClass('is-active');
        }
    });
};
userOptionsDropdown();


var addPhone = function() {
    $('#add-phone').click(function(event) {
        event.preventDefault();


        var adderLink, adderRow, htmlToAdd;
        adderLink = $(this);
        adderRow = adderLink.closest('.control-row');
        htmlToAdd = '<div class="control-row add-phone-row">' +
                        '<div class="control-cell">' +
                            '<label>' +
                                'Контактный телефон:<br>' +
                                '<input type="text" name="contact_phone[]" class="text phone" value="+38">' +
                            '</label>' +
                        '</div>' +
                    '</div>';
        adderRow.before(htmlToAdd);
    });
};
addPhone();


var services = function() {
    $('#js-add-link').click(function(event) {
        event.preventDefault();


        var services, number, htmlToAppend;
        services = $('#services');
        if (typeof number !== 'undefined' && !number.length) {
            number = 0;
        } else {
            number = + $('.service-number').last().text() + 1 + '.';
        }
        htmlToAppend =  '<div class="service-row">' +
                            '<a class="delete-service icon icon-delete-service" href="#" title="Удалить услугу"></a>' +
                            '<div class="service-number">' +
                                number +
                            '</div>' +
                            '<div class="control-row -top">' +
                                '<div class="control-cell">' +
                                    '<label>' +
                                        'Товар/услуга:<br>' +
                                        '<input type="text" name="warrant_number[]" class="text">' +
                                    '</label>' +
                                '</div>' +
                            '</div>' +
                            '<div class="_cfix"></div>' +

                            '<div class="control-row">' +
                                '<div class="control-cell _fleft">' +
                                    '<label>' +
                                        'Артикул:<br>' +
                                        '<input type="text" name="articul[]" class="text articul">' +
                                    '</label>' +
                                '</div>' +

                                '<div class="control-cell _fleft">' +
                                    '<label>' +
                                        'Ед. измерения:<br>' +
                                        '<input type="text" name="units[]" class="text units">' +
                                    '</label>' +
                                '</div>' +

                                '<div class="control-cell _fleft">' +
                                    '<label>' +
                                        'Кол-во:<br>' +
                                        '<input type="text" name="count[]" class="text count">' +
                                    '</label>' +
                                '</div>' +

                                '<div class="control-cell _fleft">' +
                                    '<label>' +
                                        'Без НДС, грн:<br>' +
                                        '<input type="text" name="nettomoney[]" class="text nettomoney">' +
                                    '</label>' +
                                '</div>' +

                                '<div class="control-cell _fleft">' +
                                    '<label>' +
                                        'Сумма, грн:<br>' +
                                        '<input type="text" name="bruttomoney[]" class="text bruttomoney">' +
                                    '</label>' +
                                '</div>' +

                                '<div class="_cfix"></div>' +
                            '</div>' +
                        '</div>';
        services.append(htmlToAppend);

    });


    $(document).on('click.deleteService', '.delete-service', function(event) {
        event.preventDefault();
        $(this).closest('.service-row').remove();
        $('.service-number').each(function(index) {
            $(this).text(index + 1 + '.');
        });
    });
};
services();


var docBlockExpand = function() {
    $('.doc-data-expander').click(function() {
        var expander = $(this);
        if(!expander.hasClass('is-active')) {
            expander.addClass('is-active');
            $('.doc-collapsible').removeClass('is-hidden');
        } else {
            expander.removeClass('is-active');
            $('.doc-collapsible').addClass('is-hidden');
        }
    });
};
docBlockExpand();


var pluginsInit = function() {
    $('#doc-type').select2();


    $.datepicker.regional['ru'] = {
        closeText: 'Закрыть',
        prevText: '&#x3c;Пред',
        nextText: 'След&#x3e;',
        currentText: 'Сегодня',
        monthNames: ['Январь','Февраль','Март','Апрель','Май','Июнь',
        'Июль','Август','Сентябрь','Октябрь','Ноябрь','Декабрь'],
         monthNamesShort: [
            "Январь",
            "Февраль",
            "Март",
            "Апрель",
            "Май",
            "Июнь",
            "Июль",
            "Август",
            "Сентябрь",
            "Октябрь",
            "Ноябрь",
            "Декабрь"
        ],
        dayNames: ['Воскресенье','Понедельник','Вторник','Среда','Четверг','Пятница','Суббота'],
        dayNamesShort: ['вск','пнд','втр','срд','чтв','птн','сбт'],
        dayNamesMin: [
            "вс",
            "пн",
            "вт",
            "ср",
            "чт",
            "пт",
            "сб"
        ],
        weekHeader: 'Не',
        dateFormat: 'dd.mm.yy',
        firstDay: 1,
        isRTL: false,
        showMonthAfterYear: false,
        yearSuffix: ''
    };
    $.datepicker.setDefaults($.datepicker.regional['ru']);
    $('.date').datepicker({
        changeMonth: true,
        changeYear: true,
        showButtonPanel: true
    });
};
pluginsInit();