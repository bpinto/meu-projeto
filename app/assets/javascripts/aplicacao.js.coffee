jQuery ->
  $.mask = {
    definitions: {
        '#': "[0-9]",
        '@': "[A-Za-z]",
        '*': "[A-Za-z0-9]"
    },
    dataName:"rawMaskFn"
  };

  $.UFFInternals = {}
  #colocando a linha abaixo recebendo 1, o javascript desabilita
  #nÃ£o submeter com configuraÃ§Ã£o 1
  $.UFFInternals.DEBUG = 0

  $.addFunction = (name, fcn)->
    if !name || typeof name != "string"
        $.error("Um nome de funÃ§Ã£o vÃ¡lido deve ser especificado")
    if !fcn || !$.isFunction(fcn)
        $.error("Uma funÃ§Ã£o vÃ¡lida deve ser especificada")

    if($.UFFInternals.DEBUG != 0 && console)
      $.UFFInternals["__" + name] = fcn
      eval("$[name] = function(){ var _val; console.group(name); console.log('Argumentos: ', arguments); _val = $.UFFInternals['__' + '" + name + "'].apply(this, arguments); console.groupEnd(); return _val; }")
    else
      $[name] = fcn

  $.addFunction("transform_combobox", ->
    $("._ui_autocomplete_combobox").each ->
        $(this).removeClass("_ui_autocomplete_combobox").combobox();
  )

  $.addFunction("transform_remove_link", (item)->
    $("._remove_buttons").each ->
        removeButtonContainer = $(this)
        removeButtonContainer.removeClass("_remove_buttons")
        removeButtonContainer.find('input[type="checkbox"]').remove();
        _label = removeButtonContainer.find('label')
        _labelText = _label.html()
        _label.remove();

        removeLink = $('<a href="javascript:void(0)" class="botaoForm btRemover" onclick="$.remove_fields(this)" >'+_labelText+'</a>');
        removeButtonContainer.append(removeLink);
  )

  $.addFunction("switcher", ->

    $("*[data-switcher]").each ->
      $dataSwitcher = $(this)

      $dataSwitcher.attr('data-switched', $dataSwitcher.attr('data-switcher'))
      $dataSwitcher.removeAttr('data-switcher')

      _switcherOnSelectTag = (new String($dataSwitcher[0].tagName).toUpperCase() == 'SELECT')
      if _switcherOnSelectTag
        _elements = $dataSwitcher
      else
        _elements = $dataSwitcher.find('input[type=radio], input[type=checkbox]')

      $.addFunction("switcher_change", ->
        # NÃ£o devemos atualizar informaÃ§Ãµes de campos de formulÃ¡rios que nÃ£o estÃ£o habilitados
        # Isso pode fazer com que outras partes do formulÃ¡rio sejam afetadas
        # por itens que nÃ£o estÃ£o sendo utilizados no momento
        return if this.disabled

        if _switcherOnSelectTag
          _values = $.makeArray(_elements.val())
        else
          _values = $.makeArray($dataSwitcher.find('input[type=radio]:checked, input[type=checkbox]:checked').map( (i, elem)->  $(elem).val()  ))

        $this = $(this);
        _switchValues = $this.attr('data-switched') || $this.parents('*[data-switched]').first().attr('data-switched')
        _thisValue = $this.val()

        if $this.hasClass('field')
          _field = $this.parent()
        else
          _field = $this.parents('.field').first().parent()

        _showElements = []
        _allElements = []
        $.each(_switchValues.split('||'), ->
          _split = this.split(":")
          _jquerySelector = _split[1].match(/^\$this(.*)/)

          if _jquerySelector
            _selected = _field.find(_jquerySelector[1]) #Aqui ele busca todos com o mesmo seletor relativo ao elemento pai do ".field"
          else
            _selected = $(_split[1]) #Aqui ele busca todos com o mesmo seletor globalmente

          if $.inArray(_split[0], _values) != -1
            $.merge(_showElements, _selected)

          $.merge(_allElements, _selected)
        )
        $(_allElements).hide().find('input,select,textarea,button').attr("disabled", "disabled")
        $(_showElements).show().find('input,select,textarea,button').attr("disabled", false)
      )
      _elements.change($.switcher_change)
      _elements.first().trigger("change")
  )

  $.addFunction("remove_fields", (link)->
    item = $(link).parents("._item").first();
    item.find("input[type='hidden'][name*='_destroy']").val(1);
    item.hide()
  )

  $.addFunction("add_fields", (link, association, content)->
    _this = $(link)
    _container = _this.parents('fieldset').first().find("." + association)
    new_id = _container.find("._item").length;
    regexp = new RegExp("new_" + association, "g");
    content = $(content.replace(regexp, new_id));
    _container.append(content);
    if(content.data('js-insert'))
        functionArr = content.data('js-insert').split(',');
        $.each(functionArr, ->
            $[this](content));
  )

  $("document").ready ->

    $.transform_combobox();
    $.switcher();

    $("._remove_buttons").each ->
        $.transform_remove_link( $(this).parent() );

    $("*[data-mask]").each ->
        $(this).mask($(this).attr('data-mask'));

  $.addFunction("formatDate", (date) ->
    ("0#{date.getDate()}").slice(-2)        + "/" +
    ("0#{date.getMonth() + 1}").slice(-2) + "/" +
    date.getFullYear()
  )
