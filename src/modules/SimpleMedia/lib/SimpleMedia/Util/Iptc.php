<?php
/**
 * Class for manipulating EXIF and IPTC image
 *
 * PHP version 5
 *
 * @category Image
 * @package  Iptc
 * @author   Bruno Thiago Leite Agutoli <brunotla1@gmail.com>
 * @license  http://www.gnu.org/copyleft/gpl.html GNU General Public License
 * @link     https://github.com/agutoli
 */

/**
 * Class for manipulating EXIF and IPTC image
 *
 * Adjusted for use in Zikula Application Framework
 * Jan 2013, E.Spaan
 *
 * @category Image
 * @package  Iptc
 * @author   Bruno Thiago Leite Agutoli <brunotla1@gmail.com>
 * @license  http://www.gnu.org/copyleft/gpl.html GNU General Public License
 * @version  Release: 0.0.1
 * @link     https://github.com/agutoli
 * @link     https://github.com/zikula-ev/SimpleMedia
 */

class SimpleMedia_Util_Iptc extends Zikula_AbstractBase
{


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
    const BYLINE                          = '080';
    const BYLINE_TITLE                    = '085';
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

    /**
     * variable that stores the IPTC tags
     *
     * @var array
     */
    private $_iptc = array();
    
    /**
     * variable that stores the EXIF tags
     *
     * @var array
     */
    private $_exif = array();

    /**
     * variable that stores the EXIF ImageType
     *
     * @var array
     */
    private $_imageType = '';

    /**
     * This variable was checks whether any tag class setada
     *
     * @var boolean 
     */
    private $_hasIptc = false;

    /**
     * This variable was checks whether any tag class setada
     *
     * @var boolean 
     */
    private $_hasExif = false;

    /**
     * allowed extensions
     *
     * @var array
     */
    private $_allowedExt = array('jpg', 'jpeg', 'pjpeg', 'tif', 'tiff');

    /**
     * Image name ex. /home/user/image.jpg
     * 
     * @var String
     */
    private $_filename;
    
    /**
     * Constructor class
     *
     * @param string $filename - Name of file
     *
     * @throw Iptc_Exception
     * @see http://www.php.net/manual/pt_BR/book.image.php - PHP GD
     * @see iptcparse
     * @see getimagesize
     * @return void
     */ 
    public function __construct($filename) 
    {

        /**
         * Check PHP version
         * @since 2.0.1
         */
        if (version_compare(phpversion(), '5.1.0', '<') === true) {
            throw new Zikula_Exception(
                $this->__f('ERROR: Your PHP version is %s Iptc class requires PHP 5.1.0 or newer.', phpversion())
            );
        }

        if ( ! extension_loaded('gd') ) {
            throw new Zikula_Exception(
                $this->__('Since PHP 4.3 there is a bundled version of the GD lib.')
            );
        }
        
        if ( ! function_exists('exif_read_data') || ! function_exists('exif_imagetype')) {
            throw new Zikula_Exception(
                $this->__('PHP EXIF functions not available.')
            );
        }
       
        if ( ! file_exists($filename) ) {
            throw new Zikula_Exception(
                $this->__('Image not found!')
            );
        }
       
        if ( ! is_writable($filename) ) {
            throw new Zikula_Exception(
                $this->__f('File "%s" is not writable!', $filename)
            );
        }
        
        if ( ! in_array(end(explode('.', $filename)), $this->_allowedExt) ) {
            throw new Zikula_Exception(
                $this->__f('Support only for the following extensions: %s', implode(',', $this->_allowedExt))
            ); 
        }

        $size           = getimagesize($filename, $imageinfo);
        $this->_hasMeta = isset($imageinfo["APP13"]);
        if ($this->_hasMeta) {
            $this->_meta = iptcparse($imageinfo["APP13"]);
        }
        $this->_filename = $filename;

        $this->_imageType = exif_imagetype($filename);
        $exif = exif_read_data($filename, 0, true);
        $this->_hasExif = (bool)$exif && is_array($exif);
        if ($this->_hasExif) {
            $this->_exif = $exif;
        }

/*        $imagetype = exif_imagetype($filePath);
        echo $imagetype . "\n<br>";
        if ($imagetype == 2) {

            // EXIF
            $exif = exif_read_data($filePath, 0, true);
            if ($exif) {
                foreach ($exif as $key => $section) {
                    foreach ($section as $name => $val) {
                        echo "$key.$name: $val\n<br>";
                    }
                }
            }

            // IPTC
            $size = getimagesize($filePath, $info);
            if(is_array($info)) {
                $iptc = iptcparse($info["APP13"]);
                foreach (array_keys($iptc) as $s) {
                    $c = count ($iptc[$s]);
                    for ($i=0; $i <$c; $i++)
                    {
                        echo $s.' = '.$iptc[$s][$i].'<br>';
                    }
                }
            }

        }
*/

    }

    /**
     * Set parameters you want to record in a particular tag "IPTC"
     *
     * @param Integer|const $tag  - Code or const of tag
     * @param array|mixed   $data - Value of tag
     * 
     * @return Iptc object
     * @access public
     */
    public function set($tag, $data) 
    {
        $this->_meta["2#$tag"] = array($data);
        $this->_hasMeta        = true;
        return $this;
    }

    /**
     * adds an item at the beginning of the array
     *
     * @param Integer|const $tag  - Code or const of tag
     * @param array|mixed   $data - Value of tag
     *
     * @return Iptc object
     * @access public
     */
    public function prepend($tag, $data)
    {
        if ( ! empty($this->_meta["2#$tag"])) {
            array_unshift($this->_meta["2#$tag"], $data);
            $data = $this->_meta["2#$tag"];
        }
        $this->_meta["2#$tag"] = array( $data );
        $this->_hasMeta        = true;
        return $this;
    }

    /**
     * adds an item at the end of the array
     *
     * @param Integer|const $tag  - Code or const of tag
     * @param array|mixed   $data - Value of tag
     * 
     * @return Iptc object
     * @access public
     */
    public function append($tag, $data)
    {
        if ( ! empty($this->_meta["2#$tag"])) {
            array_push($this->_meta["2#$tag"], $data);
            $data = $this->_meta["2#$tag"];
        }
        $this->_meta["2#$tag"] = array( $data );
        $this->_hasMeta        = true;
        return $this;
    }

    /**
     * Return fisrt IPTC tag by tag name
     *
     * @param Integer|const $tag - Name of tag
     * 
     * @example $iptc->fetch(Iptc::KEYWORDS);
     *
     * @access public
     * @return mixed|false
     */
    public function fetch($tag) 
    {
        if (isset($this->_meta["2#$tag"])) {
            return $this->_meta["2#$tag"][0];
        }
        return false;
    }

    /**
     * Return all IPTC tags by tag name
     *
     * @param Integer|const $tag - Name of tag
     * 
     * @example $iptc->fetchAll(Iptc::KEYWORDS);
     *
     * @access public
     * @return mixed|false
     */
    public function fetchAll($tag) 
    {
        if (isset($this->_meta["2#$tag"])) {
            return $this->_meta["2#$tag"];
        }
        return false;
    }

    /**
     * debug that returns all the IPTC tags already in the image
     *
     * @access public
     * @return string
     */
    public function dump() 
    {
        return print_r(array($this->_meta, $this->_imageType, $this->_exif), true);
    }

    /**
     * returns a string with the binary code
     *
     * @access public
     * @return string
     */
    public function binary() 
    {
        $iptc = '';
        foreach (array_keys($this->_meta) as $key) {
            $tag   = str_replace("2#", "", $key);
            $iptc .= $this->iptcMakeTag(2, $tag, $this->_meta[$key][0]);
        }        
        return $iptc;    
    }

    /**
     * Assemble the tags "IPTC" in character "ascii"
     *
     * @param Integer $rec - Type of tag ex. 2
     * @param Integer $dat - code of tag ex. 025 or 000 etc
     * @param mixed   $val - any caracterer
     * 
     * @access public
     * @return binary source
     */
    public function iptcMakeTag($rec, $dat, $val) 
    {
        //beginning of the binary string
        $iptcTag = chr(0x1c).chr($rec).chr($dat);

        if (is_array($val)) {
            $src = '';
            foreach ($val as $item) {
                $len  = strlen($item);
                $src .= $iptcTag . $this->_testBitSize($len) . $item;
            }
            return $src;
        }

        $len = strlen($val);
        $src = $iptcTag . $this->_testBitSize($len) . $val;
        return $src;         
    }    

    /**
     * create the new image file already 
     * with the new "IPTC" recorded
     *
     * @access public
     * @return binary source
     */
    public function write() 
    {
        //@see http://php.net/manual/pt_BR/function.iptcembed.php 
        $content = iptcembed($this->binary(), $this->_filename, 0);    

        unlink($this->_filename);

        if ($file = fopen($this->_filename, "w")) {
            fwrite($file, $content);
            fclose($file);
            return true;
        }
        return false;
    }    
    
    /**
     * completely remove all tags "IPTC" image 
     *
     * @access public
     * @return binary source
     */
    public function removeAllTags() 
    {
        $this->_hasMeta = false;
        $this->_meta    = Array();
        $impl           = implode(file($this->_filename));
        $img            = imagecreatefromstring($impl);
        unlink($this->_filename);
        imagejpeg($img, $this->_filename, 100);
    }

    /**
     * It proper test to ensure that 
     * the size of the values are supported within the 
     *
     * @param Integer $len - size of the character
     *
     * @access public
     * @return binary source
     */
    private function _testBitSize($len) 
    {
        if ($len < 0x8000) {
            return
                chr($len >> 8) .
                chr($len & 0xff);
        }
        
        return
            chr(0x1c).chr(0x04) .
            chr(($len >> 24) & 0xff) .
            chr(($len >> 16) & 0xff) .
            chr(($len >> 8 ) & 0xff) .
            chr(($len ) & 0xff);
    }
    
    
    /**
    * Returns GPS latitude & longitude as decimal values
    **/	
    private function getGPS($image)
    {
        $exif = exif_read_data($image, 0, true);
        if ($exif) {
            $lat = $exif['GPS']['GPSLatitude']; 
            $log = $exif['GPS']['GPSLongitude'];
            if (!$lat || !$log) return null;
            // latitude values //
            $lat_degrees = $this->divide($lat[0]);
            $lat_minutes = $this->divide($lat[1]);
            $lat_seconds = $this->divide($lat[2]);
            $lat_hemi = $exif['GPS']['GPSLatitudeRef'];

            // longitude values //
            $log_degrees = $this->divide($log[0]);
            $log_minutes = $this->divide($log[1]);
            $log_seconds = $this->divide($log[2]);
            $log_hemi = $exif['GPS']['GPSLongitudeRef'];

            $lat_decimal = $this->toDecimal($lat_degrees, $lat_minutes, $lat_seconds, $lat_hemi);
            $log_decimal = $this->toDecimal($log_degrees, $log_minutes, $log_seconds, $log_hemi);

            return array($lat_decimal, $log_decimal);
        } else {
            return null;
        }
    }

    private function toDecimal($deg, $min, $sec, $hemi)
    {
        $d = $deg + $min/60 + $sec/3600;
        return ($hemi=='S' || $hemi=='W') ? $d*=-1 : $d;
    }

    private function divide($a)
    {
        // evaluate the string fraction and return a float //	
        $e = explode('/', $a);
        // prevent division by zero //
        if (!$e[0] || !$e[1]) {
            return 0;
        } else {
            return $e[0] / $e[1];
        }
    }    
}
