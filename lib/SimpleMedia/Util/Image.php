<?php
/**
 * SimpleMedia.
 *
 * @copyright Erik Spaan & Axel Guckelsberger (ESP)
 * @license http://www.gnu.org/licenses/lgpl.html GNU Lesser General Public License
 * @package SimpleMedia
 * @author Erik Spaan & Axel Guckelsberger <erik@zikula.nl>.
 * @link https://github.com/zikula-ev/SimpleMedia
 * @link http://zikula.org
 * @version Generated by ModuleStudio 0.6.1 (http://modulestudio.de).
 */

/**
 * Utility implementation class for image helper methods.
 */
class SimpleMedia_Util_Image extends SimpleMedia_Util_Base_Image
{
    // feel free to add your own convenience methods here
    
	// IPTC constants, see IPTC standards
    const OBJECT_NAME                     = '005';
    const EDIT_STATUS                     = '007';
    const PRIORITY                        = '010';
    const CATEGORY                        = '015';
    const SUPPLEMENTAL_CATEGORY           = '020';
    const FIXTURE_IDENTIFIER              = '022';
    const KEYWORDS                        = '025';
    const RELEASE_DATE                    = '030';
    const RELEASE_TIME                    = '035';
    const SPECIAL_INSTRUCTIONS            = '040';
    const REFERENCE_SERVICE               = '045';
    const REFERENCE_DATE                  = '047';
    const REFERENCE_NUMBER                = '050';
    const CREATED_DATE                    = '055';
    const CREATED_TIME                    = '060';
    const ORIGINATING_PROGRAM             = '065';
    const PROGRAM_VERSION                 = '070';
    const OBJECT_CYCLE                    = '075';
    const CITY                            = '090';
    const PROVINCE_STATE                  = '095';
    const COUNTRY_CODE                    = '100';
    const COUNTRY                         = '101';
    const ORIGINAL_TRANSMISSION_REFERENCE = '103';
    const HEADLINE                        = '105';
    const CREDIT                          = '110';
    const SOURCE                          = '115';
    const COPYRIGHT_STRING                = '116';
    const CAPTION                         = '120';
    const LOCAL_CAPTION                   = '121';
    const CAPTION_WRITER                  = '122';

	// EXIF IMAGETYPE constants 
	// see http://www.php.net/manual/en/function.exif-imagetype.php
    const IMAGETYPE_GIF                   = '1';
    const IMAGETYPE_JPEG                  = '2';
    const IMAGETYPE_PNG                   = '3';
    const IMAGETYPE_SWF                   = '4';
    const IMAGETYPE_PSD                   = '5';
    const IMAGETYPE_BMP                   = '6';
    const IMAGETYPE_TIFF_II               = '7'; //(intel byte order)
    const IMAGETYPE_TIFF_MM               = '8'; // (motorola byte order)
    const IMAGETYPE_JPC                   = '9';
    const IMAGETYPE_JP2                   = '10';
    const IMAGETYPE_JPX                   = '11';
    const IMAGETYPE_JB2                   = '12';
    const IMAGETYPE_SWC                   = '13';
    const IMAGETYPE_IFF                   = '14';
    const IMAGETYPE_WBMP                  = '15';
    const IMAGETYPE_XBM                   = '16';
    const IMAGETYPE_ICO                   = '17';

    // Integrate IPTC and EXIF methods here. See iptc.php
	// EXIF tags: http://www.sno.phy.queensu.ca/~phil/exiftool/TagNames/EXIF.html
    
    // Add watermarking of images here. Override getPreset possibly.
}
