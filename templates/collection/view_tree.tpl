{* purpose of this template: collections tree view *}
{assign var='lct' value='user'}
{if isset($smarty.get.lct) && $smarty.get.lct eq 'admin'}
    {assign var='lct' value='admin'}
{/if}
{include file="`$lct`/header.tpl"}
<div class="simplemedia-collection simplemedia-viewhierarchy">
    {gt text='Collection hierarchy' assign='templateTitle'}
    {pagesetvar name='title' value=$templateTitle}
    {if $lct eq 'admin'}
        <div class="z-admin-content-pagetitle">
            {icon type='view' size='small' alt=$templateTitle}
            <h3>{$templateTitle}</h3>
        </div>
    {else}
        <h2>{$templateTitle}</h2>
    {/if}

    <p class="z-informationmsg">Collections are nested trees that can contain media items and sub-collections.</p>

    <p>
    {checkpermissionblock component='SimpleMedia:Collection:' instance='::' level='ACCESS_EDIT'}
        {gt text='Add root node' assign='addRootTitle'}
        <a id="treeAddRoot" href="javascript:void(0)" title="{$addRootTitle}" class="z-icon-es-add z-hide">{$addRootTitle}</a>

        <script type="text/javascript">
        /* <![CDATA[ */
        document.observe('dom:loaded', function() {
            $('treeAddRoot').observe('click', function(event) {
                simmedPerformTreeOperation('collection', 1, 'addRootNode');
                Event.stop(event);
            }).removeClassName('z-hide');
        });
        /* ]]> */
        </script>
        <noscript><p>{gt text='This function requires JavaScript activated!'}</p></noscript>
    {/checkpermissionblock}
        {gt text='Switch to table view' assign='switchTitle'}
        <a href="{modurl modname='SimpleMedia' type=$lct func='view' ot='collection'}" title="{$switchTitle}" class="z-icon-es-view">{$switchTitle}</a>
    </p>

    {foreach key='rootId' item='treeNodes' from=$trees}
        {include file='collection/view_tree_items.tpl' lct=$lct rootId=$rootId items=$treeNodes}
    {foreachelse}
        {include file='collection/view_tree_items.tpl' lct=$lct rootId=1 items=null}
    {/foreach}

    <br style="clear: left" />
</div>
{include file="`$lct`/footer.tpl"}
