{* purpose of this template: collections display view in user area *}
{include file='user/header.tpl'}
<div class="simplemedia-collection simplemedia-display">
    {gt text='Collection' assign='templateTitle'}
    {assign var='templateTitle' value=$collection->getTitleFromDisplayPattern()|default:$templateTitle}
    {pagesetvar name='title' value=$templateTitle|@html_entity_decode}
    <h2>{$templateTitle|notifyfilters:'simplemedia.filter_hooks.collections.filter'} {icon id='itemActionsTrigger' type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}</h2>

    {* show parent collections in a breadcrumb view, only for non-root collections *}
    {* TODO check this functionlaity *}
    {if !isset($allParents) || $allParents eq true}
    {simplemediaTreeSelection objectType='collection' node=$collection target='allParents' assign='allParents' skipRootNode=false}
    <div class=""simplemedia_collection_breadcrums">
        <a href="{modurl modname='SimpleMedia' type='user' func='view' ot='collection'}" title="{gt text='SimpleMedia Root'}">{gt text='Root'}</a>
        {if $allParents ne null && count($allParents) > 0}
        {foreach item='node' from=$allParents}
        > <a href="{modurl modname='SimpleMedia' type='user' func='display' ot='collection' id=$node.id}" title="{$node->getTitleFromDisplayPattern()|replace:'"':''}">{$node->getTitleFromDisplayPattern()}</a>
        {/foreach}
        {/if}
        > {$collection.title}
    </div>
    {/if}

    <div>{gt text='Description'} {$collection.description}</div>
    <div>Viewed: {$collection.viewsCount}</div>
    {include file='user/include_categories_display.tpl' obj=$collection}

    {* show parent collections in a breadcrumb view, only for non-root collections *}
    {if $collection.lvl gt 0}
        {if !isset($allParents) || $allParents eq true}
            {simplemediaTreeSelection objectType='collection' node=$collection target='allParents' assign='allParents'}
            {if $allParents ne null && count($allParents) gt 0}
                <div class=""simplemedia_collection_breadcrums">
                    <a href="{modurl modname='SimpleMedia' type='user' func='view' ot='collection'}" title="{gt text='SimpleMedia Root'}">{gt text='Root'}</a>
                    {foreach item='node' from=$allParents}
                        > <a href="{modurl modname='SimpleMedia' type='user' func='display' ot='collection' id=$node.id}" title="{$node->getTitleFromDisplayPattern()|replace:'"':''}">{$node->getTitleFromDisplayPattern()}</a>
                    {/foreach}
                    > {$collection->getTitle()}
                </div>
            {/if}
        {/if}
    {/if}

    {* include all the media here *}
    {if isset($collection.media) && $collection.media ne null}
        {include file='user/medium/include_displayItemGrid.tpl' items=$collection.media}
    {/if}

    {* include the direct child collections here *}
    {if !isset($directChildren) || $directChildren eq true}
        {simplemediaTreeSelection objectType='collection' node=$collection target='directChildren' assign='directChildren'}
        {if $directChildren ne null && count($directChildren) gt 0}
            {include file='user/collection/view_items.tpl' collections=$directChildren gridLevel=$collection.lvl+1}
        {/if}
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
