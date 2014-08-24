OblakanRM.SelectOption = Ember.SelectOption.extend
  attributeBindings: ['icon:data-icon']

  icon: (->
    iconPath = @get('parentView.optionIconPath')
    @get(iconPath)
  ).property('parentView.optionIconPath')

OblakanRM.SelectView = Ember.Select.extend
  defaultTemplate: Ember.Handlebars.compile('
    {{#if view.prompt}}<option value=""></option>{{/if}}
    {{#if view.optionGroupPath}}
      {{#each view.groupedContent}}
        {{view view.groupView content=content label=label}}
      {{/each}}
    {{else}}
      {{#each view.content}}
        {{view view.optionView content=this}}
      {{/each}}
    {{/if}}')

  optionView: OblakanRM.SelectOption

OblakanRM.CategorySelectView = OblakanRM.SelectView.extend
  didInsertElement: ->
    formatSelect = (category) ->
      icon = $(category.element).data('icon')
      if icon
        return "<i class=\"fa fa-#{icon}\"></i> #{category.text}"
      else
        return category.text

    $(@.$()).select2({
      placeholder: 'Выберите категорию'
      width: '100%'
      formatResult: formatSelect
      formatSelection: formatSelect
    }).select2('val','2')

  willDestroyElement: ->
    @.$().select2('destroy')

Ember.Handlebars.helper('c-select', OblakanRM.SelectView)
Ember.Handlebars.helper('o-select', Ember.Select)
Ember.Handlebars.helper('category-select', OblakanRM.CategorySelectView)