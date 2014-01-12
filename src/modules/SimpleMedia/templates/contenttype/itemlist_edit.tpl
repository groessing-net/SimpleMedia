{* Purpose of this template: edit view of generic item list content type *}

<div class="z-formrow">
    {gt text='Object type' domain='module_simplemedia' assign='objectTypeSelectorLabel'}
    {formlabel for='simpleMediaObjectType' text=$objectTypeSelectorLabel}
        {simplemediaObjectTypeSelector assign='allObjectTypes'}
        {formdropdownlist id='simpleMediaOjectType' dataField='objectType' group='data' mandatory=true items=$allObjectTypes}
        <span class="z-sub z-formnote">{gt text='If you change this please save the element once to reload the parameters below.' domain='module_simplemedia'}</span>
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
            {gt text='Category' domain='module_simplemedia' assign='categorySelectorLabel'}
            {assign var='selectionMode' value='single'}
            {if $hasMultiSelection eq true}
                {gt text='Categories' domain='module_simplemedia' assign='categorySelectorLabel'}
                {assign var='selectionMode' value='multiple'}
            {/if}
            {formlabel for="simpleMediaCatIds`$propertyName`" text=$categorySelectorLabel}
                {formdropdownlist id="simpleMediaCatIds`$propName`" items=$categories.$propName dataField="catids`$propName`" group='data' selectionMode=$selectionMode}
                <span class="z-sub z-formnote">{gt text='This is an optional filter.' domain='module_simplemedia'}</span>
        </div>
    {/foreach}
    {/nocache}
{/if}
{/formvolatile}

<div class="z-formrow">
    {gt text='Sorting' domain='module_simplemedia' assign='sortingLabel'}
    {formlabel text=$sortingLabel}
    <div>
        {formradiobutton id='simpleMediaSortRandom' value='random' dataField='sorting' group='data' mandatory=true}
        {gt text='Random' domain='module_simplemedia' assign='sortingRandomLabel'}
        {formlabel for='simpleMediaSortRandom' text=$sortingRandomLabel}
        {formradiobutton id='simpleMediaSortNewest' value='newest' dataField='sorting' group='data' mandatory=true}
        {gt text='Newest' domain='module_simplemedia' assign='sortingNewestLabel'}
        {formlabel for='simpleMediaSortNewest' text=$sortingNewestLabel}
        {formradiobutton id='simpleMediaSortDefault' value='default' dataField='sorting' group='data' mandatory=true}
        {gt text='Default' domain='module_simplemedia' assign='sortingDefaultLabel'}
        {formlabel for='simpleMediaSortDefault' text=$sortingDefaultLabel}
    </div>
</div>

<div class="z-formrow">
    {gt text='Amount' domain='module_simplemedia' assign='amountLabel'}
    {formlabel for='simpleMediaAmount' text=$amountLabel}
        {formintinput id='simpleMediaAmount' dataField='amount' group='data' mandatory=true maxLength=2}
</div>

<div class="z-formrow">
    {gt text='Template' domain='module_simplemedia' assign='templateLabel'}
    {formlabel for='simpleMediaTemplate' text=$templateLabel}
        {simplemediaTemplateSelector assign='allTemplates'}
        {formdropdownlist id='simpleMediaTemplate' dataField='template' group='data' mandatory=true items=$allTemplates}
</div>

<div id="customTemplateArea" class="z-formrow z-hide">
    {gt text='Custom template' domain='module_simplemedia' assign='customTemplateLabel'}
    {formlabel for='simpleMediaCustomTemplate' text=$customTemplateLabel}
        {formtextinput id='simpleMediaCustomTemplate' dataField='customTemplate' group='data' mandatory=false maxLength=80}
        <span class="z-sub z-formnote">{gt text='Example' domain='module_simplemedia'}: <em>itemlist_[objecttype]_display.tpl</em></span>
</div>

<div class="z-formrow z-hide">
    {gt text='Filter (expert option)' domain='module_simplemedia' assign='filterLabel'}
    {formlabel for='simpleMediaFilter' text=$filterLabel}
        {formtextinput id='simpleMediaFilter' dataField='filter' group='data' mandatory=false maxLength=255}
        <span class="z-sub z-formnote">
            ({gt text='Syntax examples'}: <kbd>name:like:foobar</kbd> {gt text='or'} <kbd>status:ne:3</kbd>)
        </span>
</div>

{pageaddvar name='javascript' value='prototype'}
<script type="text/javascript">
/* <![CDATA[ */
    function simmedToggleCustomTemplate() {
        if ($F('simpleMediaTemplate') == 'custom') {
            $('customTemplateArea').removeClassName('z-hide');
        } else {
            $('customTemplateArea').addClassName('z-hide');
        }
    }

    document.observe('dom:loaded', function() {
        simmedToggleCustomTemplate();
        $('simpleMediaTemplate').observe('change', function(e) {
            simmedToggleCustomTemplate();
        });
    });
/* ]]> */
</script>
