{* purpose of this template: collections tree items *}
{assign var='hasNodes' value=false}
{if isset($items) && (is_object($items) && $items->count() gt 0) || (is_array($items) && count($items) gt 0)}
    {assign var='hasNodes' value=true}
{/if}
{assign var='idPrefix' value="collectionTree`$rootId`"}

<div id="{$idPrefix}" class="z-tree-container">
    <div id="collectionTreeItems{$rootId}" class="z-tree-items">
    {if $hasNodes}
        {simplemediaTreeData objectType='collection' tree=$items controller=$lct root=$rootId sortable=true}
    {/if}
    </div>
</div>

{pageaddvar name='javascript' value='modules/SimpleMedia/javascript/SimpleMedia_tree.js'}
{if $hasNodes}
    <script type="text/javascript">
    /* <![CDATA[ */
        document.observe('dom:loaded', function() {
            simmedInitTreeNodes('collection', '{{$rootId}}', true, true);
            Zikula.TreeSortable.trees.itemTree{{$rootId}}.config.onSave = simmedTreeSave;
        });
    /* ]]> */
    </script>
    <noscript><p>{gt text='This function requires JavaScript activated!'}</p></noscript>
{/if}
