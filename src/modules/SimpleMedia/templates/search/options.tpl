{* Purpose of this template: Display search options *}
<input type="hidden" id="active_simplemedia" name="active[SimpleMedia]" value="1" checked="checked" />
<div>
    <input type="checkbox" id="active_simplemedia_media" name="search_simplemedia_types['medium']" value="1"{if $active_medium} checked="checked"{/if} />
    <label for="active_simplemedia_media">{gt text='Media' domain='module_simplemedia'}</label>
</div>
<div>
    <input type="checkbox" id="active_simplemedia_collections" name="search_simplemedia_types['collection']" value="1"{if $active_collection} checked="checked"{/if} />
    <label for="active_simplemedia_collections">{gt text='Collections' domain='module_simplemedia'}</label>
</div>
