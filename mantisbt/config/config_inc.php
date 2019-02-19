<?php
$g_hostname               = 'mantisbt-db';
$g_db_type                = 'pgsql';
$g_database_name          = 'mantisbt';
$g_db_username            = 'mantisbt';
$g_db_password            = 'changeit';

$g_default_timezone       = 'UTC';
$g_long_process_timeout   = 0;

# --- Email Configuration ---
$g_phpMailer_method           = PHPMAILER_METHOD_SENDMAIL; #PHPMAILER_METHOD_MAIL or PHPMAILER_METHOD_SMTP, PHPMAILER_METHOD_SENDMAIL
#$g_smtp_host                  = '';                       # used with PHPMAILER_METHOD_SMTP
#$g_smtp_username              = '';                       # used with PHPMAILER_METHOD_SMTP
#$g_smtp_password              = '';                       # used with PHPMAILER_METHOD_SMTP
$g_enable_email_notification  = ON;
$g_webmaster_email            = 'mantis@example.com';
$g_from_email                 = 'mantis@example.com';
$g_return_path_email          = 'mantis@example.com';
$g_smtp_port                  = 25 ;