{* purpose of this template: reusable display of entity attributes *}
{if isset($obj.attributes)}
    {if isset($panel) && $panel eq true}
        <h3 class="attributes z-panel-header z-panel-indicator z-pointer">{gt text='Attributes'}</h3>
        <div class="attributes z-panel-content" style="display: none">
    {else}
        <h3 class="attributes">{gt text='Attributes'}</h3>
    {/if}
    <dl class="propertylist">
    {foreach key='fieldName' item='fieldInfo' from=$obj.attributes}
        <dt>{$fieldName|safetext}</dt>
        <dd>{$fieldInfo.value|default:''|safetext}</dd>
    {/foreach}
    </dl>
    {if isset($panel) && $panel eq true}
        </div>
    {/if}
{/if}
