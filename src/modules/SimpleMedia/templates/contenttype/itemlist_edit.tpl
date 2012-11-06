{* Purpose of this template: edit view of generic item list content type *}

<div class="z-formrow">
    {formlabel for='SimpleMedia_objecttype' __text='Object type'}
    {simplemediaSelectorObjectTypes assign='allObjectTypes'}
    {formdropdownlist id='SimpleMedia_objecttype' dataField='objectType' group='data' mandatory=true items=$allObjectTypes}
    <div class="z-sub z-formnote">{gt text='If you change this please save the element once to reload the parameters below.'}</div>
</div>

{formvolatile}
{if $properties ne null && is_array($properties)}
    {nocache}
    {foreach key='registryId' item='registryCid' from=$registries}
        {assign var='propName' value=''}
        {foreach key='propertyName' item='propertyId' from=$properties}
            {if $propertyId eq $registryId}
                {assign var='propName' value=$propertyName}
            {/if}
        {/foreach}
        <div class="z-formrow">
            {modapifunc modname='SimpleMedia' type='category' func='hasMultipleSelection' ot=$objectType registry=$propertyName assign='hasMultiSelection'}
            {gt text='Category' assign='categorySelectorLabel'}
            {assign var='selectionMode' value='single'}
            {if $hasMultiSelection eq true}
                {gt text='Categories' assign='categorySelectorLabel'}
                {assign var='selectionMode' value='multiple'}
            {/if}
            {formlabel for="SimpleMedia_catids`$propertyName`" text=$categorySelectorLabel}
            {formcategoryselector id="SimpleMedia_catids`$propertyName`" category=$registryCid
                                  dataField='catids' group='data' registryId=$registryId doctrine2=true
                                  selectionMode=$selectionMode}
            <div class="z-sub z-formnote">{gt text='This is an optional filter.'}</div>
        </div>
    {/foreach}
{/if}
{/formvolatile}

<div class="z-formrow">
    {formlabel __text='Sorting'}
    <div>
        {formradiobutton id='SimpleMedia_srandom' value='random' dataField='sorting' group='data' mandatory=true}
        {formlabel for='SimpleMedia_srandom' __text='Random'}
        {formradiobutton id='SimpleMedia_snewest' value='newest' dataField='sorting' group='data' mandatory=true}
        {formlabel for='SimpleMedia_snewest' __text='Newest'}
        {formradiobutton id='SimpleMedia_sdefault' value='default' dataField='sorting' group='data' mandatory=true}
        {formlabel for='SimpleMedia_sdefault' __text='Default'}
    </div>
</div>

<div class="z-formrow">
    {formlabel for='SimpleMedia_amount' __text='Amount'}
    {formintinput id='SimpleMedia_amount' dataField='amount' group='data' mandatory=true maxLength=2}
</div>

<div class="z-formrow">
    {formlabel for='SimpleMedia_template' __text='Template'}
    {simplemediaSelectorTemplates assign='allTemplates'}
    {formdropdownlist id='SimpleMedia_template' dataField='template' group='data' mandatory=true items=$allTemplates}
</div>

<div id="customtemplatearea" class="z-formrow z-hide">
    {formlabel for='SimpleMedia_customtemplate' __text='Custom template'}
    {formtextinput id='SimpleMedia_customtemplate' dataField='customTemplate' group='data' mandatory=false maxLength=80}
    <div class="z-sub z-formnote">{gt text='Example'}: <em>itemlist_{objecttype}_display.tpl</em></div>
</div>

<div class="z-formrow z-hide">
    {formlabel for='SimpleMedia_filter' __text='Filter (expert option)'}
    {formtextinput id='SimpleMedia_filter' dataField='filter' group='data' mandatory=false maxLength=255}
    <div class="z-sub z-formnote">({gt text='Syntax examples'}: <kbd>name:like:foobar</kbd> {gt text='or'} <kbd>status:ne:3</kbd>)</div>
</div>

{pageaddvar name='javascript' value='prototype'}
<script type="text/javascript">
/* <![CDATA[ */
    function simmedToggleCustomTemplate() {
        if ($F('SimpleMedia_template') == 'custom') {
            $('customtemplatearea').removeClassName('z-hide');
        } else {
            $('customtemplatearea').addClassName('z-hide');
        }
    }

    document.observe('dom:loaded', function() {
        simmedToggleCustomTemplate();
        $('SimpleMedia_template').observe('change', function(e) {
            simmedToggleCustomTemplate();
        });
    });
/* ]]> */
</script>
