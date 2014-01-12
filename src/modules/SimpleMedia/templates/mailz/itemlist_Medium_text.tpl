{* Purpose of this template: Display media in text mailings *}
{foreach item='medium' from=$items}
{$medium->getTitleFromDisplayPattern()}
{modurl modname='SimpleMedia' type='user' func='display' ot=$objectType id=$medium.id slug=$medium.slug fqurl=true}
-----
{foreachelse}
{gt text='No media found.'}
{/foreach}
