{* purpose of this template: inclusion template for display of related collections *}
{assign var='lct' value='user'}
{if isset($smarty.get.lct) && $smarty.get.lct eq 'admin'}
    {assign var='lct' value='admin'}
{/if}
{if $lct ne 'admin'}
    {checkpermission component='SimpleMedia:Collection:' instance='::' level='ACCESS_EDIT' assign='hasAdminPermission'}
    {checkpermission component='SimpleMedia:Collection:' instance='::' level='ACCESS_EDIT' assign='hasEditPermission'}
{/if}
{if !isset($nolink)}
    {assign var='nolink' value=false}
{/if}
{if isset($items) && $items ne null && count($items) gt 0}
<ul class="simplemedia-related-item-list collection">
{foreach name='relLoop' item='item' from=$items}
    {if $hasAdminPermission || $item.workflowState eq 'approved'}
    <li>
{strip}
{if !$nolink}
    <a href="{modurl modname='SimpleMedia' type=$lct func='display' ot='collection'  id=$item.id}" title="{$item->getTitleFromDisplayPattern()|replace:"\"":""}">
{/if}
    {$item->getTitleFromDisplayPattern()}
{if !$nolink}
    </a>
    <a id="collectionItem{$item.id}Display" href="{modurl modname='SimpleMedia' type=$lct func='display' ot='collection'  id=$item.id theme='Printer' forcelongurl=true}" title="{gt text='Open quick view window'}" class="z-hide">{icon type='view' size='extrasmall' __alt='Quick view'}</a>
{/if}
{/strip}
{if !$nolink}
<script type="text/javascript">
/* <![CDATA[ */
    document.observe('dom:loaded', function() {
        simmedInitInlineWindow($('collectionItem{{$item.id}}Display'), '{{$item->getTitleFromDisplayPattern()|replace:"'":""}}');
    });
/* ]]> */
</script>
{/if}
    </li>
    {/if}
{/foreach}
</ul>
{/if}