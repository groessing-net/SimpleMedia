{* purpose of this template: media view kml view in user area *}
{simplemediaTemplateHeaders contentType='application/vnd.google-earth.kml+xml'}
<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2">
<Document>
{foreach item='item' from=$items}
    <Placemark>
        <name>{$item->getTitle()}</name>
        <Point>
            <coordinates>{$item->getLongitude()}, {$item->getLatitude()}, 0</coordinates>
        </Point>
    </Placemark>
{/foreach}
</Document>
</kml>
