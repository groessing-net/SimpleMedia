{* purpose of this template: collections xml inclusion template in user area *}
<collection id="{$item.id}" createdon="{$item.createdDate|dateformat}" updatedon="{$item.updatedDate|dateformat}">
    <id>{$item.id}</id>
    <title><![CDATA[{$item.title}]]></title>
    <description><![CDATA[{$item.description}]]></description>
    <previewImage>{$item.previewImage}</previewImage>
    <viewsCount>{$item.viewsCount}</viewsCount>
    <sortValue>{$item.sortValue}</sortValue>
    <workflowState>{$item.workflowState|simplemediaObjectState:false|lower}</workflowState>
    <media>
    {if isset($item.Media) && $item.Media ne null}
        {foreach name='relationLoop' item='relatedItem' from=$item.Media}
        <medium>{$relatedItem->getTitleFromDisplayPattern()|default:''}</medium>
        {/foreach}
    {/if}
    </media>
</collection>
