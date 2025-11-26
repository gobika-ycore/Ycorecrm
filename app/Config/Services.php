<?php

namespace Config;

use CodeIgniter\Config\BaseService;

/**
 * Services Configuration file.
 *
 * Services are simply other classes/libraries that the system uses
 * to do its job. This is used by CodeIgniter to allow the core of the
 * framework to be swapped out easily without affecting the usage within
 * the rest of your application.
 *
 * This file holds any application-specific services, or service overrides
 * that you might need. An example has been included with the general
 * method format you should use for your service methods. For more examples,
 * see the core Services file at system/Config/Services.php.
 */
class Services extends BaseService
{
    /*
     * public static function example($getShared = true)
     * {
     *     if ($getShared) {
     *         return static::getSharedInstance('example');
     *     }
     *
     *     return new \CodeIgniter\Example();
     * }
     */

    // Workaround for environments where config('App') may return null.
    // Ensure the SiteURIFactory always receives a valid \Config\App instance.
    public static function siteurifactory(
        ?\Config\App $config = null,
        ?\CodeIgniter\Superglobals $superglobals = null,
        bool $getShared = true
    ) {
        if ($getShared) {
            return static::getSharedInstance('siteurifactory', $config, $superglobals);
        }

        $config = $config ?? new \Config\App();
        $superglobals = $superglobals ?? \CodeIgniter\Config\Services::get('superglobals');

        return new \CodeIgniter\HTTP\SiteURIFactory($config, $superglobals);
    }

    public static function uri(?string $uri = null, bool $getShared = true)
    {
        if ($getShared) {
            return static::getSharedInstance('uri', $uri);
        }

        if ($uri === null) {
            $appConfig = new \Config\App();
            $factory = static::siteurifactory($appConfig, \CodeIgniter\Config\Services::get('superglobals'));
            return $factory->createFromGlobals();
        }

        return new \CodeIgniter\HTTP\URI($uri);
    }
}
