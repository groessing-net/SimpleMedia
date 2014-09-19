{* Purpose of this template: Display media in text mailings *}
{foreach item='medium' from=$items}
{$medium->getTitleFromDisplayPattern()}
{modurl modname='SimpleMedia' type='user' func='display' ot='medium'  id=$$objectType.id slug=$$objectType.slug fqurl=true}
-----
{foreachelse}
{gt text='No media found.'}
{/foreach}
