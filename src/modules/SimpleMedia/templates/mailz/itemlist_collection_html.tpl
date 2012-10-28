{* Purpose of this template: Display collections in html mailings *}
{*
<ul>
{foreach item='item' from=$items}
    <li>
        <a href="{modurl modname='SimpleMedia' type='user' func='display' ot=$objectType id=$item.id fqurl=true}">{$item.title}
        </a>
    </li>
{foreachelse}
    <li>{gt text='No collections found.'}</li>
{/foreach}
</ul>
*}

{include file='contenttype/itemlist_Collection_display_description.tpl'}
