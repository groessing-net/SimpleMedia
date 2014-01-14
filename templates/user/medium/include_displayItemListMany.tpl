{* purpose of this template: inclusion template for display of related media in user area *}
{if !isset($nolink)}
    {assign var='nolink' value=false}
{/if}
{if isset($items) && $items ne null && count($items) gt 0}
<ul class="simplemedia-related-item-list medium">
{foreach name='relLoop' item='item' from=$items}
    <li>
{strip}
{if !$nolink}
    <a href="{modurl modname='SimpleMedia' type='user' func='display' ot='medium' id=$item.id slug=$item.slug}" title="{$item->getTitleFromDisplayPattern()|replace:"\"":""}">
{/if}
    {$item->getTitleFromDisplayPattern()}
{if !$nolink}
    </a>
    <a id="mediumItem{$item.id}Display" href="{modurl modname='SimpleMedia' type='user' func='display' ot='medium' id=$item.id slug=$item.slug theme='Printer' forcelongurl=true}" title="{gt text='Open quick view window'}" class="z-hide">{icon type='view' size='extrasmall' __alt='Quick view'}</a>
{/if}
{/strip}
{if !$nolink}
<script type="text/javascript">
/* <![CDATA[ */
    document.observe('dom:loaded', function() {
        simmedInitInlineWindow($('mediumItem{{$item.id}}Display'), '{{$item->getTitleFromDisplayPattern()|replace:"'":""}}');
    });
/* ]]> */
</script>
{/if}
    </li>
{/foreach}
</ul>
{/if}
