{* Purpose of this template: Display media within an external context *}
<dl>
    {foreach item='medium' from=$items}
        <dt>{$medium->getTitleFromDisplayPattern()}</dt>
        {if $medium.description}
            <dd>{$medium.description|strip_tags|truncate:200:'&hellip;'}</dd>
        {/if}
        <dd><a href="{modurl modname='SimpleMedia' type='user' ot='medium' func='display'  id=$$objectType.id slug=$$objectType.slug}">{gt text='Read more'}</a>
        </dd>
    {foreachelse}
        <dt>{gt text='No entries found.'}</dt>
    {/foreach}
</dl>
