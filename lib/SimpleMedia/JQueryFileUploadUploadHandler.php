<?php

require(__DIR__ . '/../vendor/jQuery-File-Upload-9.7.0/server/php/UploadHandler.php');

class SimpleMedia_JQueryFileUploadUploadHandler extends UploadHandler
{
    public function __construct($options = null, $initialize = true, $error_messages = null)
    {
        $tmpDir = CacheUtil::getLocalDir('SimpleMedia/multiupload');

        if (!is_readable($tmpDir) || 1) {
            CacheUtil::createLocalDir('SimpleMedia/multiupload');
            file_put_contents("$tmpDir/.htaccess", <<< EOF
order allow,deny
allow from all
EOF
            );
        }

        $allowedExtensions = ModUtil::getVar('SimpleMedia', 'allowedExtensions', '');
        $allowedExtensions = explode(', ', $allowedExtensions);
        $allowedExtensions = "/\\.(" . implode('|', $allowedExtensions) . ")$/i";

        $maxFileSize = ModUtil::getVar('SimpleMedia', 'maxUploadFileSize');

        $defaultOptions = array(
            'upload_dir' => "$tmpDir/",
            'user_dirs' => true,
            'upload_url' => System::getBaseUrl() . "$tmpDir/",
            'script_url' => ModUtil::url('SimpleMedia', 'medium', 'multiuploadsave'),
            'accept_file_types' => $allowedExtensions,
            'max_file_size' => $maxFileSize * 1024 * 1024
        );

        if ($options === null) {
            $options = array();
        }

        $options = array_merge($options, $defaultOptions);

        parent::__construct($options, $initialize, $error_messages);
    }

    protected function get_user_id()
    {
        return UserUtil::getVar('uid');
    }

    protected function get_file_object($file_name)
    {
        $file = parent::get_file_object($file_name);

        if ($file !== null && !isset($file->path)) {
            $file->path = $this->get_upload_path($file_name);
        }

        return $file;
    }
} 
