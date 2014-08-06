{* Purpose of this template: Display collections in text mailings *}
{foreach item='collection' from=$items}
{$collection->getTitleFromDisplayPattern()}
{modurl modname='SimpleMedia' type='user' func='display' ot='collection'  id=$$objectType.id fqurl=true}
-----
{foreachelse}
{gt text='No collections found.'}
{/foreach}
