{* purpose of this template: collections display view in admin area *}
{include file='admin/header.tpl'}
<div class="simplemedia-collection simplemedia-display withrightbox">
{gt text='Collection' assign='templateTitle'}
{assign var='templateTitle' value=$collection.title|default:$templateTitle}
{pagesetvar name='title' value=$templateTitle|@html_entity_decode}
<div class="z-admin-content-pagetitle">
    {icon type='display' size='small' __alt='Details'}
    <h3>{$templateTitle|notifyfilters:'simplemedia.filter_hooks.collections.filter'}{icon id='itemactionstrigger' type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}</h3>
</div>

{if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
    <div class="simplemediarightbox">
        <h3>{gt text='Media'}</h3>
        
        {if isset($collection.media) && $collection.media ne null}
            {include file='admin/medium/include_displayItemListMany.tpl' items=$collection.media}
        {/if}
        
        {checkpermission component='SimpleMedia:Collection:' instance="`$collection.id`::" level='ACCESS_ADMIN' assign='authAdmin'}
        {if $authAdmin || (isset($uid) && isset($collection.createdUserId) && $collection.createdUserId eq $uid)}
        <p class="manageLink">
            {gt text='Create medium' assign='createTitle'}
            <a href="{modurl modname='SimpleMedia' type='admin' func='edit' ot='medium' collection="`$collection.id`" returnTo='adminDisplayCollection'}" title="{$createTitle}" class="z-icon-es-add">
                {$createTitle}
            </a>
        </p>
        {/if}
    </div>
{/if}

<dl>
    <dt>{gt text='Description'}</dt>
    <dd>{$collection.description}</dd>
    <dt>{gt text='Preview image'}</dt>
    <dd>{$collection.previewImage}</dd>
    <dt>{gt text='Sort value'}</dt>
    <dd>{$collection.sortValue}</dd>
    
</dl>
{include file='admin/include_categories_display.tpl' obj=$collection}
<h3 class="relatives">{gt text='Relatives'}</h3>
        {include file='admin/collection/display_treeRelatives.tpl' allParents=true directParent=true allChildren=true directChildren=true predecessors=true successors=true preandsuccessors=true}
{include file='admin/include_standardfields_display.tpl' obj=$collection}

{if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
    {* include display hooks *}
    {notifydisplayhooks eventname='simplemedia.ui_hooks.collections.display_view' id=$collection.id urlobject=$currentUrlObject assign='hooks'}
    {foreach key='providerArea' item='hook' from=$hooks}
        {$hook}
    {/foreach}
    {if count($collection._actions) gt 0}
        <p id="itemactions">
        {foreach item='option' from=$collection._actions}
            <a href="{$option.url.type|simplemediaActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}" class="z-icon-es-{$option.icon}">{$option.linkText|safetext}</a>
        {/foreach}
        </p>
        <script type="text/javascript">
        /* <![CDATA[ */
            document.observe('dom:loaded', function() {
                simmedInitItemActions('collection', 'display', 'itemactions');
            });
        /* ]]> */
        </script>
    {/if}
    <br style="clear: right" />
{/if}

</div>
{include file='admin/footer.tpl'}

