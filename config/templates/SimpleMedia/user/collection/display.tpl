{* purpose of this template: collections display view in user area *}
{include file='user/header.tpl'}
<div class="simplemedia-collection simplemedia-display">
    {gt text='Collection' assign='templateTitle'}
    {assign var='templateTitle' value=$collection->getTitleFromDisplayPattern()|default:$templateTitle}
    {pagesetvar name='title' value=$templateTitle|@html_entity_decode}
    <h2>{$templateTitle|notifyfilters:'simplemedia.filter_hooks.collections.filter'}{icon id='itemActionsTrigger' type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}</h2>

    <div>{gt text='Description'} {$collection.description}</div>
    <div>Viewed: {$collection.viewsCount}</div>
    {include file='user/include_categories_display.tpl' obj=$collection}

    {if $collection.lvl gt 0}
        {if !isset($allParents) || $allParents eq true}
            {simplemediaTreeSelection objectType='collection' node=$collection target='allParents' assign='allParents'}
            {if $allParents ne null && count($allParents) gt 0}
                {gt text='Parents'}
                {foreach item='node' from=$allParents}
                    :: <a href="{modurl modname='SimpleMedia' type='user' func='display' ot='collection' id=$node.id}" title="{$node->getTitleFromDisplayPattern()|replace:'"':''}">{$node->getTitleFromDisplayPattern()}</a>
                {/foreach}
            {/if}
        {/if}
    {/if}

    {if !isset($directChildren) || $directChildren eq true}
        {simplemediaTreeSelection objectType='collection' node=$collection target='directChildren' assign='directChildren'}
        {if $directChildren ne null && count($directChildren) gt 0}
            <h4>{gt text='Collections'}</h4>
            {include file='user/collection/view_grid_items.tpl' collections=$directChildren gridLevel=$collection.lvl+1 thumbWidth=170 thumbHeight=150  wrapWidth=200 wrapHeight=220 collIcon='large'}
        {/if}
    {/if}

    {if isset($collection.media) && $collection.media ne null}
        <h4>{gt text='Media'}</h4>
        {include file='user/medium/include_displayItemGrid.tpl' items=$collection.media thumbWidth=150 thumbHeight=150}
    {/if}

    {include file='user/include_standardfields_display.tpl' obj=$collection}

    {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
    {* include display hooks *}
        {notifydisplayhooks eventname='simplemedia.ui_hooks.collections.display_view' id=$collection.id urlobject=$currentUrlObject assign='hooks'}
        {foreach key='providerArea' item='hook' from=$hooks}
            {$hook}
        {/foreach}
        {if count($collection._actions) gt 0}
            <p id="itemActions">
                {foreach item='option' from=$collection._actions}
                    <a href="{$option.url.type|simplemediaActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}" class="z-icon-es-{$option.icon}">{$option.linkText|safetext}</a>
                {/foreach}
            </p>
            <script type="text/javascript">
                // <![CDATA[
                document.observe('dom:loaded', function() {
                    simmedInitItemActions('collection', 'display', 'itemActions');
                });
                // ]]>
            </script>
        {/if}
        <br style="clear: right" />
    {/if}
</div>
{include file='user/footer.tpl'}
