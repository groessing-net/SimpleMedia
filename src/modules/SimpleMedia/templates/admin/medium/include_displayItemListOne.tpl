{* purpose of this template: inclusion template for display of related media in admin area *}
{if !isset($nolink)}
    {assign var='nolink' value=false}
{/if}
<h4>
{if !$nolink}
    <a href="{modurl modname='SimpleMedia' type='admin' func='display' ot='medium' id=$item.id slug=$item.slug}" title="{$item.title|replace:"\"":""}">
{/if}
{$item.title}
{if !$nolink}
    </a>
    <a id="mediumItem{$item.id}Display" href="{modurl modname='SimpleMedia' type='admin' func='display' ot='medium' id=$item.id slug=$item.slug theme='Printer'}" title="{gt text='Open quick view window'}" class="z-hide">
        {icon type='view' size='extrasmall' __alt='Quick view'}
    </a>
{/if}
</h4>
{if !$nolink}
<script type="text/javascript">
/* <![CDATA[ */
    document.observe('dom:loaded', function() {
        simmedInitInlineWindow($('mediumItem{{$item.id}}Display'), '{{$item.title|replace:"'":""}}');
    });
/* ]]> */
</script>
{/if}
