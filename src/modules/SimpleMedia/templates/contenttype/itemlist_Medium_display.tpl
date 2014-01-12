{* Purpose of this template: Display media within an external context *}
{foreach item='medium' from=$items}
    <h3>{$medium->getTitleFromDisplayPattern()}</h3>
    <p><a href="{modurl modname='SimpleMedia' type='user' func='display' ot=$objectType id=$medium.id slug=$medium.slug}">{gt text='Read more'}</a>
    </p>
{/foreach}
