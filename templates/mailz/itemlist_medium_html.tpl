{* Purpose of this template: Display media in html mailings *}
{*
<ul>
{foreach item='medium' from=$items}
    <li>
        <a href="{modurl modname='SimpleMedia' type='user' func='display' ot='medium'  id=$$objectType.id slug=$$objectType.slug fqurl=true}
        ">{$medium->getTitleFromDisplayPattern()}
        </a>
    </li>
{foreachelse}
    <li>{gt text='No media found.'}</li>
{/foreach}
</ul>
*}

{include file='contenttype/itemlist_medium_display_description.tpl'}
