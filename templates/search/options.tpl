{* Purpose of this template: Display search options *}
<input type="hidden" id="simpleMediaActive" name="active[SimpleMedia]" value="1" checked="checked" />
<div>
    <input type="checkbox" id="active_simpleMediaMedia" name="simpleMediaSearchTypes[]" value="medium"{if $active_medium} checked="checked"{/if} />
    <label for="active_simpleMediaMedia">{gt text='Media' domain='module_simplemedia'}</label>
</div>
<div>
    <input type="checkbox" id="active_simpleMediaCollections" name="simpleMediaSearchTypes[]" value="collection"{if $active_collection} checked="checked"{/if} />
    <label for="active_simpleMediaCollections">{gt text='Collections' domain='module_simplemedia'}</label>
</div>
