{* purpose of this template: collections tree view in admin area *}
{include file='admin/header.tpl'}
<div class="simplemedia-collection simplemedia-viewhierarchy">
{gt text='Collection hierarchy' assign='templateTitle'}
{pagesetvar name='title' value=$templateTitle}
<div class="z-admin-content-pagetitle">
    {icon type='view' size='small' alt=$templateTitle}
    <h3>{$templateTitle}</h3>
</div>

<p class="sectiondesc">Collections form a nested tree that contain one or more media items and nested collections.</p>

<p>
    {checkpermissionblock component='SimpleMedia:Collection:' instance='.*' level='ACCESS_ADD'}
        {gt text='Add root node' assign='addRootTitle'}
        <a id="z-tree-addroot" href="javascript:void(0)" title="{$addRootTitle}" class="z-icon-es-add z-hide">{$addRootTitle}</a>

        <script type="text/javascript">
    /* <![CDATA[ */
    document.observe('dom:loaded', function() {
           $('z-tree-addroot').observe('click', function(event) {
               simmedPerformTreeOperation('collection', 1, 'addRootNode');
               Event.stop(event);
           }).removeClassName('z-hide');
    });
    /* ]]> */
    </script>
    <noscript><p>{gt text='This function requires JavaScript activated!'}</p></noscript>

    {*
        {gt text='Create collection' assign='createTitle'}
        <a href="{modurl modname='SimpleMedia' type='admin' func='edit' ot='collection'}" title="{$createTitle}" class="z-icon-es-add">
            {$createTitle}
        </a>
    *}
    {/checkpermissionblock}
    {gt text='Switch to table view' assign='switchTitle'}
    <a href="{modurl modname='SimpleMedia' type='admin' func='view' ot='collection'}" title="{$switchTitle}" class="z-icon-es-view">
        {$switchTitle}
    </a>
</p>

{foreach key='rootId' item='treeNodes' from=$trees}
    {include file='admin/collection/view_tree_items.tpl' rootId=$rootId items=$treeNodes}
{foreachelse}
    {include file='admin/collection/view_tree_items.tpl' rootId=1 items=null}
{/foreach}

<br style="clear: left" />

</div>
{include file='admin/footer.tpl'}
