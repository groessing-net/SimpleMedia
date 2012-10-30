{* purpose of this template: collections display view in user area *}
{include file='user/header.tpl'}
<div class="simplemedia-collection simplemedia-display withrightbox">
{gt text='Collection' assign='templateTitle'}
{assign var='templateTitle' value=$collection.title|default:$templateTitle}
{pagesetvar name='title' value=$templateTitle|@html_entity_decode}
<div class="z-frontendcontainer">
    <h2>{$templateTitle|notifyfilters:'simplemedia.filter_hooks.collections.filter'}{icon id='itemactionstrigger' type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}</h2>

{if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
    <div class="simplemediarightbox">
        <h3>{gt text='Media'}</h3>
        
        {if isset($collection.media) && $collection.media ne null}
            {include file='user/medium/include_displayItemListMany.tpl' items=$collection.media}
        {/if}
        
    </div>
{/if}

<dl>
    <dt>{gt text='Description'}</dt>
    <dd>{$collection.description}</dd>
    
</dl>
{include file='user/include_categories_display.tpl' obj=$collection}
<h3 class="relatives">{gt text='Relatives'}</h3>
        {include file='user/collection/display_treeRelatives.tpl' allParents=true directParent=true allChildren=true directChildren=true predecessors=true successors=true preandsuccessors=true}
{include file='user/include_standardfields_display.tpl' obj=$collection}

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
</div>
{include file='user/footer.tpl'}

