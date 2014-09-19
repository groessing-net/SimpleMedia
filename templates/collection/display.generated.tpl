{* purpose of this template: collections display view *}
{assign var='lct' value='user'}
{if isset($smarty.get.lct) && $smarty.get.lct eq 'admin'}
    {assign var='lct' value='admin'}
{/if}
{include file="`$lct`/header.tpl"}
<div class="simplemedia-collection simplemedia-display with-rightbox">
    {gt text='Collection' assign='templateTitle'}
    {assign var='templateTitle' value=$collection->getTitleFromDisplayPattern()|default:$templateTitle}
    {pagesetvar name='title' value=$templateTitle|@html_entity_decode}
    {if $lct eq 'admin'}
        <div class="z-admin-content-pagetitle">
            {icon type='display' size='small' __alt='Details'}
            <h3>{$templateTitle|notifyfilters:'simplemedia.filter_hooks.collections.filter'}{icon id="itemActions`$collection.id`Trigger" type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}
            </h3>
        </div>
    {else}
        <h2>{$templateTitle|notifyfilters:'simplemedia.filter_hooks.collections.filter'}{icon id="itemActions`$collection.id`Trigger" type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}
        </h2>
    {/if}

    {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
        <div class="simplemedia-rightbox">
            {if $lct eq 'admin'}
                <h4>{gt text='Media'}</h4>
            {else}
                <h3>{gt text='Media'}</h3>
            {/if}
            
            {if isset($collection.media) && $collection.media ne null}
                {include file='medium/include_displayItemListMany.tpl' items=$collection.media}
            {/if}
            
            {assign var='permLevel' value='ACCESS_EDIT'}
            {if $lct eq 'admin'}
                {assign var='permLevel' value='ACCESS_ADMIN'}
            {/if}
            {checkpermission component='SimpleMedia:Collection:' instance="`$collection.id`::" level=$permLevel assign='mayManage'}
            {if $mayManage || (isset($uid) && isset($collection.createdUserId) && $collection.createdUserId eq $uid)}
            <p class="managelink">
                {gt text='Create medium' assign='createTitle'}
                <a href="{modurl modname='SimpleMedia' type=$lct func='edit' ot='medium' collection="`$collection.id`" returnTo="`$lct`DisplayCollection"'}" title="{$createTitle}" class="z-icon-es-add">{$createTitle}</a>
            </p>
            {/if}
        </div>
    {/if}

    <dl>
        <dt>{gt text='Title'}</dt>
        <dd>{$collection.title}</dd>
        <dt>{gt text='Description'}</dt>
        <dd>{$collection.description}</dd>
        <dt>{gt text='Preview image'}</dt>
        <dd>{$collection.previewImage}</dd>
        <dt>{gt text='Views count'}</dt>
        <dd>{$collection.viewsCount}</dd>
        <dt>{gt text='Sort value'}</dt>
        <dd>{$collection.sortValue}</dd>
        
    </dl>
    {include file='helper/include_categories_display.tpl' obj=$collection}
    <h3 class="relatives">{gt text='Relatives'}</h3>
            {include file='collection/display_treeRelatives.tpl' allParents=true directParent=true allChildren=true directChildren=true predecessors=true successors=true preandsuccessors=true}
    {include file='helper/include_standardfields_display.tpl' obj=$collection}

    {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
        {* include display hooks *}
        {notifydisplayhooks eventname='simplemedia.ui_hooks.collections.display_view' id=$collection.id urlobject=$currentUrlObject assign='hooks'}
        {foreach name='hookLoop' key='providerArea' item='hook' from=$hooks}
            {$hook}
        {/foreach}
        {if count($collection._actions) gt 0}
            <p id="itemActions{$collection.id}">
                {foreach item='option' from=$collection._actions}
                    <a href="{$option.url.type|simplemediaActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}" class="z-icon-es-{$option.icon}">{$option.linkText|safetext}</a>
                {/foreach}
            </p>
        
            <script type="text/javascript">
            /* <![CDATA[ */
                document.observe('dom:loaded', function() {
                    simmedInitItemActions('collection', 'display', 'itemActions{{$collection.id}}');
                });
            /* ]]> */
            </script>
        {/if}
        <br style="clear: right" />
    {/if}
</div>
{include file="`$lct`/footer.tpl"}
