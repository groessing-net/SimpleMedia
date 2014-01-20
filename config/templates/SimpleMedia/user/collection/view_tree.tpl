{* purpose of this template: collections tree view in user area *}
{include file='user/header.tpl'}
<div class="simplemedia-collection simplemedia-viewhierarchy">
    {gt text='Collection hierarchy' assign='templateTitle'}
    {pagesetvar name='title' value=$templateTitle}
    <h2>{$templateTitle}</h2>

    <p class="z-informationmsg">Collections are nested trees that can contain media items and sub-collections.</p>

    <p>
        {gt text='Switch to table view' assign='switchTitle'}
        <a href="{modurl modname='SimpleMedia' type='user' func='view' ot='collection'}" title="{$switchTitle}" class="z-icon-es-view">{$switchTitle}</a>
    </p>

    {foreach key='rootId' item='treeNodes' from=$trees}
        {include file='user/collection/view_tree_items.tpl' rootId=$rootId items=$treeNodes}
    {foreachelse}
        {include file='user/collection/view_tree_items.tpl' rootId=1 items=null}
    {/foreach}

    <br style="clear: left" />
</div>
{include file='user/footer.tpl'}
