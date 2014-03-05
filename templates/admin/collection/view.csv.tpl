{* purpose of this template: collections view csv view in admin area *}
{simplemediaTemplateHeaders contentType='text/comma-separated-values; charset=iso-8859-15' asAttachment=true filename='Collections.csv'}
{strip}"{gt text='Title'}";"{gt text='Description'}";"{gt text='Preview image'}";"{gt text='Views count'}";"{gt text='Sort value'}";"{gt text='Workflow state'}"
;"{gt text='Media'}"
{/strip}
{foreach item='collection' from=$items}
{strip}
    "{$collection.title}";"{$collection.description}";"{$collection.previewImage}";"{$collection.viewsCount}";"{$collection.sortValue}";"{$item.workflowState|simplemediaObjectState:false|lower}"
    ;"
        {if isset($collection.Media) && $collection.Media ne null}
            {foreach name='relationLoop' item='relatedItem' from=$collection.Media}
            {$relatedItem->getTitleFromDisplayPattern()|default:''}{if !$smarty.foreach.relationLoop.last}, {/if}
            {/foreach}
        {/if}
    "
{/strip}
{/foreach}
