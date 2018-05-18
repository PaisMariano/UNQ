opts_list = {
  'General' : { 'description' : "This page contains general parameters for the MySQL server.",
                   'position' : 1,
                   'groups':(  {'caption' : "Networking",
                                'controls':
                                  (
                                    {
                                      'description' : "Port number to use for connections.",
                                      'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                      'default' : "3306",
                                      'caption' : "TCP Port:",
                                      'type' : "numeric",
                                      'name' : "port"
                                    },
                                    {
                                      'description' : "Don't allow connections via TCP/IP.",
                                      'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                      'default' : "Unchecked",
                                      'caption' : "Disable networking",
                                      'type' : "boolean",
                                      'name' : "skip-networking"
                                    },
                                    {
                                      'description' : "Enable support for named pipes.",
                                      'versions' : ((5, 0), (5, 1), (5, 4), (6, 0)),
                                      'default' : "",
                                      'caption' : "Enable named pipes:",
                                      'type' : "boolean",
                                      'name' : "enable-named-pipe"
                                    }
                                  ) #End of controls list in group Networking
                                } #End of group Networking
                              ,{'caption' : "Directories",
                                'controls':
                                  (
                                    {
                                      'description' : "Path to installation directory. All paths are usually resolved relative to this.",
                                      'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                      'default' : "",
                                      'caption' : "Base directory:",
                                      'type' : "filename",
                                      'name' : "basedir"
                                    },
                                    {
                                      'description' : "Path to the database root",
                                      'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                      'default' : "",
                                      'caption' : "Data directory:",
                                      'type' : "filename",
                                      'name' : "datadir"
                                    },
                                    {
                                      'description' : "Path to the temporary directory.",
                                      'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (6, 0)),
                                      'default' : "",
                                      'caption' : "Temp directory:",
                                      'type' : "filename",
                                      'name' : "tmpdir"
                                    }
                                  ) #End of controls list in group Directories
                                } #End of group Directories
                              ,{'caption' : "Memory usage",
                                'controls':
                                  (
                                    {
                                      'name' : "sort_buffer_size",
                                      'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                      'default' : "2M",
                                      'bitsize' : "32",
                                      'maximum' : "4294967295",
                                      'unitcontrol' : " ;K;M;G",
                                      'caption' : "Sort buffer size",
                                      'type' : "numeric",
                                      'description' : "Each thread that needs to do a sort allocates a buffer of this size."
                                    }
                                   ,
                                  ) #End of controls list in group Memory usage
                                } #End of group Memory usage
                              ,{'caption' : "General",
                                'controls':
                                  (
                                    {
                                      'name' : "console",
                                      'caption' : "console",
                                      'default' : "OFF",
                                      'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                      'type' : "boolean",
                                      'description' : "console"
                                    },
                                    {
                                      'description' : "datetime_format",
                                      'caption' : "datetime_format",
                                      'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                      'type' : "string",
                                      'name' : "datetime_format"
                                    },
                                    {
                                      'description' : "debug-sync-timeout",
                                      'caption' : "debug-sync-timeout",
                                      'versions' : ((5, 1, 41), (5, 5), (6, 0, 6)),
                                      'type' : "numeric",
                                      'name' : "debug-sync-timeout"
                                    },
                                    {
                                      'description' : "If no specific storage engine/table type is defined in an SQL-Create statement the default type will be used.",
                                      'versions' : ((4, 1, 2), (5, 0), (5, 1), (5, 4), (6, 0)),
                                      'default' : "myisam",
                                      'choices' : "engine-list",
                                      'caption' : "Default storage engine:",
                                      'type' : "dropdownboxentry",
                                      'name' : "default-storage-engine"
                                    },
                                    {
                                      'name' : "partition",
                                      'caption' : "partition",
                                      'default' : "ON",
                                      'versions' : ((5, 1), (5, 4), (5, 5), (6, 0)),
                                      'type' : "boolean",
                                      'description' : "partition"
                                    },
                                    {
                                      'name' : "plugin_dir",
                                      'caption' : "plugin_dir",
                                      'default' : "/usr/local/mysql/lib/mysql",
                                      'versions' : ((4, 1, 25), (5, 0, 67), (5, 1, 2), (5, 4), (5, 5), (6, 0)),
                                      'type' : "filename",
                                      'description' : "plugin_dir"
                                    },
                                    {
                                      'description' : "plugin-load",
                                      'caption' : "plugin-load",
                                      'versions' : ((5, 1, 18), (5, 4), (5, 5), (6, 0)),
                                      'type' : "string",
                                      'name' : "plugin-load"
                                    },
                                    {
                                      'name' : "port-open-timeout",
                                      'caption' : "port-open-timeout",
                                      'default' : "0",
                                      'versions' : ((5, 0, 19), (5, 1, 5), (5, 4), (5, 5), (6, 0)),
                                      'type' : "numeric",
                                      'description' : "port-open-timeout"
                                    },
                                    {
                                      'caption' : "skip-character-set-client-handshake",
                                      'description' : "skip-character-set-client-handshake",
                                      'type' : "string",
                                      'name' : "skip-character-set-client-handshake",
                                      'versions' : ((4, 1, 15), (5, 0, 13), (5, 1), (5, 4), (6, 0))
                                    },
                                    {
                                      'description' : "time_format",
                                      'caption' : "time_format",
                                      'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (6, 0)),
                                      'type' : "string",
                                      'name' : "time_format"
                                    },
                                    {
                                      'caption' : "verbose",
                                      'description' : "verbose",
                                      'type' : "string",
                                      'name' : "verbose",
                                      'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (6, 0))
                                    },
                                    {
                                      'caption' : "standalone",
                                      'description' : "standalone",
                                      'type' : "string",
                                      'name' : "standalone",
                                      'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (6, 0))
                                    },
                                    {
                                      'description' : "Cause the server to revert to certain behaviors present in older versions.",
                                      'versions' : ((5, 1, 18), (5, 4), (5, 5), (6, 0)),
                                      'default' : "Unchecked",
                                      'caption' : "Old behavior:",
                                      'type' : "boolean",
                                      'name' : "old"
                                    },
                                    {
                                      'description' : "lower_case_file_system",
                                      'caption' : "lower_case_file_system",
                                      'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                      'type' : "boolean",
                                      'name' : "lower_case_file_system"
                                    }
                                  ) #End of controls list in group General
                                } #End of group General
                            ) # end of groups in tab General
                 } # end of tab General
  ,  'Advanced' : { 'description' : "You will find all advanced settings here.",
                    'position' : 2,
                    'groups':(  {'caption' : "Localization",
                                 'controls':
                                   (
                                     {
                                       'description' : "Set the default character set.",
                                       'versions' : ((4, 1, 3), (5, 0)),
                                       'default' : "",
                                       'caption' : "Def. Char Set:",
                                       'type' : "filename",
                                       'name' : "default-character-set"
                                     },
                                     {
                                       'description' : "default-time-zone",
                                       'caption' : "default-time-zone",
                                       'versions' : ((4, 1, 3), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'type' : "string",
                                       'name' : "default-time-zone"
                                     },
                                     {
                                       'description' : "Client error messages in given language. May be given as a full path.",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'default' : "",
                                       'caption' : "Language:",
                                       'type' : "filename",
                                       'name' : "language"
                                     }
                                   ) #End of controls list in group Localization
                                 } #End of group Localization
                               ,{'caption' : "General",
                                 'controls':
                                   (
                                     {
                                       'name' : "default_week_format",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'default' : "",
                                       'maximum' : "7",
                                       'minimum' : "0",
                                       'caption' : "Default week format:",
                                       'type' : "filename",
                                       'description' : "The default week format used by WEEK() functions."
                                     },
                                     {
                                       'description' : "Print a symbolic stack trace on failure.",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'default' : "Unchecked",
                                       'caption' : "Print stack trace",
                                       'type' : "boolean",
                                       'name' : "enable-pstack"
                                     },
                                     {
                                       'description' : "Flush tables to disk between SQL commands.",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'default' : "Unchecked",
                                       'caption' : "Flush tables",
                                       'type' : "boolean",
                                       'name' : "flush"
                                     },
                                     {
                                       'name' : "flush_time",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'default' : "0",
                                       'minimum' : "0",
                                       'caption' : "Flush time",
                                       'type' : "numeric",
                                       'description' : "A dedicated thread is created to flush all tables at the given interval."
                                     },
                                     {
                                       'description' : "Set up signals usable for debugging",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'default' : "Unchecked",
                                       'caption' : "Set up for GDB",
                                       'type' : "boolean",
                                       'name' : "gdb"
                                     },
                                     {
                                       'description' : "INSERT/DELETE/UPDATE has lower priority than selects.",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'default' : "Unchecked",
                                       'caption' : "Low priority updates",
                                       'type' : "boolean",
                                       'name' : "low-priority-updates"
                                     },
                                     {
                                       'name' : "max_error_count",
                                       'versions' : ((4, 1, 0), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'default' : "64",
                                       'maximum' : "65535",
                                       'minimum' : "0",
                                       'caption' : "Maximum error count",
                                       'type' : "numeric",
                                       'description' : "Max number of errors/warnings to store for a statement."
                                     },
                                     {
                                       'name' : "max_prepared_stmt_count",
                                       'versions' : ((4, 1, 19), (5, 0, 21), (5, 1, 10), (5, 4), (5, 5), (6, 0)),
                                       'default' : "16382",
                                       'maximum' : "1048576",
                                       'minimum' : "0",
                                       'caption' : "max_prepared_stmt_count",
                                       'type' : "numeric",
                                       'description' : "max_prepared_stmt_count"
                                     },
                                     {
                                       'name' : "max_sp_recursion_depth",
                                       'versions' : ((5, 0, 17), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'default' : "0",
                                       'maximum' : "255",
                                       'caption' : "max_sp_recursion_depth",
                                       'type' : "numeric",
                                       'description' : "max_sp_recursion_depth"
                                     },
                                     {
                                       'description' : "Lock mysqld in memory.(=Don't swap.)",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'default' : "Unchecked",
                                       'caption' : "Memory lock",
                                       'type' : "boolean",
                                       'name' : "memlock"
                                     },
                                     {
                                       'name' : "old-alter-table",
                                       'caption' : "old-alter-table",
                                       'default' : "OFF",
                                       'versions' : ((5, 1), (5, 4), (5, 5), (6, 0)),
                                       'type' : "boolean",
                                       'description' : "old-alter-table"
                                     },
                                     {
                                       'name' : "old-style-user-limits",
                                       'caption' : "old-style-user-limits",
                                       'default' : "FALSE",
                                       'versions' : ((5, 0, 3), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'type' : "boolean",
                                       'description' : "old-style-user-limits"
                                     },
                                     {
                                       'name' : "open-files-limit",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'default' : "0",
                                       'maximum' : "65535",
                                       'minimum' : "0",
                                       'caption' : "open-files-limit",
                                       'type' : "numeric",
                                       'description' : "open-files-limit"
                                     },
                                     {
                                       'caption' : "skip-event-scheduler",
                                       'description' : "skip-event-scheduler",
                                       'type' : "string",
                                       'name' : "skip-event-scheduler",
                                       'versions' : ((5, 1), (5, 4), (5, 5), (6, 0))
                                     },
                                     {
                                       'caption' : "skip-external-locking",
                                       'description' : "skip-external-locking",
                                       'type' : "string",
                                       'name' : "skip-external-locking",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0))
                                     },
                                     {
                                       'description' : "Don't print a stack trace on failure",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'default' : "Unchecked",
                                       'caption' : "Disable stack trace",
                                       'type' : "boolean",
                                       'name' : "skip-stack-trace"
                                     },
                                     {
                                       'name' : "sync_frm",
                                       'caption' : "sync_frm",
                                       'default' : "TRUE",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'type' : "boolean",
                                       'description' : "sync_frm"
                                     },
                                     {
                                       'name' : "sysdate-is-now",
                                       'caption' : "sysdate-is-now",
                                       'default' : "FALSE",
                                       'versions' : ((5, 0, 20), (5, 1, 8), (5, 4), (5, 5), (6, 0)),
                                       'type' : "boolean",
                                       'description' : "sysdate-is-now"
                                     },
                                     {
                                       'name' : "tc-heuristic-recover",
                                       'caption' : "tc-heuristic-recover",
                                       'versions' : ((5, 0, 3), (5, 1), (5, 4), (6, 0)),
                                       'items' : {"COMMIT":"COMMIT", "RECOVER":"RECOVER"},
                                       'type' : "dropdownbox",
                                       'description' : "tc-heuristic-recover"
                                     },
                                     {
                                       'name' : "updatable_views_with_limit",
                                       'caption' : "updatable_views_with_limit",
                                       'default' : "1",
                                       'versions' : ((5, 0, 2), (5, 1), (5, 4), (6, 0)),
                                       'type' : "boolean",
                                       'description' : "updatable_views_with_limit"
                                     },
                                     {
                                       'name' : "use-symbolic-links",
                                       'caption' : "use-symbolic-links",
                                       'default' : "TRUE",
                                       'versions' : ((5, 1), (5, 4), (6, 0)),
                                       'type' : "boolean",
                                       'description' : "use-symbolic-links"
                                     },
                                     {
                                       'caption' : "skip-safemalloc",
                                       'description' : "skip-safemalloc",
                                       'type' : "string",
                                       'name' : "skip-safemalloc",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (6, 0))
                                     }
                                   ) #End of controls list in group General
                                 } #End of group General
                               ,{'caption' : "Thread specific settings",
                                 'controls':
                                   (
                                     {
                                       'description' : "Don't give threads different priorities.",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'default' : "Unchecked",
                                       'caption' : "Deactivate thread priority",
                                       'type' : "boolean",
                                       'name' : "skip-thread-priority"
                                     },
                                     {
                                       'description' : "If creating the thread takes longer than this value (in seconds), the Slow_launch_threads counter will be incremented.",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'default' : "2",
                                       'caption' : "Slow launch time",
                                       'type' : "numeric",
                                       'name' : "slow_launch_time"
                                     },
                                     {
                                       'name' : "thread_cache_size",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (6, 0)),
                                       'default' : "0",
                                       'maximum' : "16384",
                                       'minimum' : "0",
                                       'caption' : "Thread cache size",
                                       'type' : "numeric",
                                       'description' : "How many threads we should keep in a cache for reuse."
                                     },
                                     {
                                       'name' : "thread_concurrency",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (6, 0)),
                                       'default' : "10",
                                       'maximum' : "512",
                                       'minimum' : "1",
                                       'caption' : "Thread concurrency",
                                       'type' : "numeric",
                                       'description' : "Permits the application to give the threads system a hint for the desired number of threads that should be run at the same time"
                                     },
                                     {
                                       'outversion' : "6.0.3",
                                       'name' : "thread_handling",
                                       'versions' : ((5, 1, 17), (5, 4), (6, 0)),
                                       'items' : {"no-threads":"no-threads", "one-thread-per-connection":"one-thread-per-connection"},
                                       'caption' : "thread_handling",
                                       'type' : "dropdownbox",
                                       'description' : "thread_handling"
                                     },
                                     {
                                       'name' : "thread_stack",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (6, 0)),
                                       'default' : "192k",
                                       'blocksize' : "1024",
                                       'maximum' : "4294967295",
                                       'minimum' : "131072",
                                       'bitsize' : "32",
                                       'unitcontrol' : " ;K;M;G",
                                       'caption' : "Thread stack size",
                                       'type' : "numeric",
                                       'description' : "The stack size for each thread."
                                     },
                                     {
                                       'caption' : "one-thread",
                                       'description' : "one-thread",
                                       'type' : "string",
                                       'name' : "one-thread",
                                       'versions' : ((5, 0), (5, 1), (5, 4), (5, 5), (6, 0))
                                     }
                                   ) #End of controls list in group Thread specific settings
                                 } #End of group Thread specific settings
                               ,{'caption' : "Insert delayed settings",
                                 'controls':
                                   (
                                     {
                                       'name' : "delayed_insert_limit",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'default' : "100",
                                       'bitsize' : "32",
                                       'maximum' : "4294967295",
                                       'minimum' : "1",
                                       'caption' : "Insert delayed Limit",
                                       'type' : "numeric",
                                       'description' : "After inserting delayed_insert_limit rows, the INSERT DELAYED handler will check if there are any SELECT statements pending. If so, it allows these to execute before continuing."
                                     },
                                     {
                                       'description' : "How long a INSERT DELAYED thread should wait for INSERT statements before terminating.",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'default' : "300",
                                       'caption' : "Insert delayed Timeout",
                                       'type' : "numeric",
                                       'name' : "delayed_insert_timeout"
                                     },
                                     {
                                       'name' : "delayed_queue_size",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'default' : "1k",
                                       'bitsize' : "32",
                                       'maximum' : "4294967295",
                                       'minimum' : "1",
                                       'unitcontrol' : " ;K;M;G",
                                       'caption' : "Insert delayed queue size",
                                       'type' : "numeric",
                                       'description' : "What size queue (in rows) should be allocated for handling INSERT DELAYED. If the queue becomes full, any client that does INSERT DELAYED will wait until there is room in the queue again."
                                     },
                                     {
                                       'name' : "max_delayed_threads",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'default' : "20",
                                       'maximum' : "16384",
                                       'minimum' : "0",
                                       'caption' : "Maximum Threads",
                                       'type' : "numeric",
                                       'description' : "Don't start more than this number of threads to handle INSERT DELAYED statements. If set to zero, which means INSERT DELAYED is not used."
                                     }
                                   ) #End of controls list in group Insert delayed settings
                                 } #End of group Insert delayed settings
                               ,{'caption' : "Various",
                                 'controls':
                                   (
                                     {
                                       'description' : "Use ANSI SQL syntax instead of MySQL syntax.",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'default' : "Unchecked",
                                       'caption' : "Use ANSI SQL",
                                       'type' : "boolean",
                                       'name' : "ansi"
                                     },
                                     {
                                       'name' : "back_log",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'default' : "50",
                                       'maximum' : "65535",
                                       'minimum' : "1",
                                       'caption' : "Back log size",
                                       'type' : "numeric",
                                       'description' : "The number of outstanding connection requests MySQL can have. This comes into play when the main MySQL thread gets very many connection requests in a very short time."
                                     },
                                     {
                                       'description' : "Allow big result sets by saving all temporary sets on file (Solves most 'table full' errors).",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'default' : "Unchecked",
                                       'caption' : "Big Tables",
                                       'type' : "boolean",
                                       'name' : "big-tables"
                                     },
                                     {
                                       'name' : "bind-address",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'default' : "",
                                       'maximum' : "255.255.255.255",
                                       'minimum' : "0.0.0.0",
                                       'caption' : "Bind to IP:",
                                       'type' : "filename",
                                       'description' : "IP address to bind to."
                                     },
                                     {
                                       'name' : "binlog_cache_size",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'default' : "32k",
                                       'bitsize' : "32",
                                       'maximum' : "4294967295",
                                       'minimum' : "4096",
                                       'unitcontrol' : " ;K;M;G",
                                       'caption' : "Binlog cache size",
                                       'type' : "numeric",
                                       'description' : "The size of the cache to hold the SQL statements for the binary log during a transaction. If you often use big, multi-statement transactions you can increase this to get more performance."
                                     },
                                     {
                                       'name' : "bulk_insert_buffer_size",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'default' : "8M",
                                       'bitsize' : "32",
                                       'maximum' : "4294967295",
                                       'minimum' : "0",
                                       'unitcontrol' : " ;K;M;G",
                                       'caption' : "Bulk insert buffer size",
                                       'type' : "numeric",
                                       'description' : "Size of tree cache used in bulk insert optimisation. Note that this is a limit per thread!"
                                     },
                                     {
                                       'description' : "Chroot mysqld daemon during startup.",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'default' : "",
                                       'caption' : "Chroot:",
                                       'type' : "filename",
                                       'name' : "chroot"
                                     },
                                     {
                                       'description' : "Write core on errors.",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'default' : "Unchecked",
                                       'caption' : "Write core file",
                                       'type' : "boolean",
                                       'name' : "core-file"
                                     },
                                     {
                                       'name' : "delay-key-write",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'default' : "0",
                                       'items' : {"On":"ON", "Off":"OFF", "All":"ALL"},
                                       'caption' : "Delay key write:",
                                       'type' : "dropdownbox",
                                       'description' : "Type of DELAY_KEY_WRITE."
                                     },
                                     {
                                       'name' : "group_concat_max_len",
                                       'versions' : ((4, 1, 10), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'default' : "1k",
                                       'bitsize' : "32",
                                       'maximum' : "4294967295",
                                       'minimum' : "4",
                                       'unitcontrol' : " ;K;M;G",
                                       'caption' : "Group concat max len",
                                       'type' : "numeric",
                                       'description' : "The maximum length of the result of function  group_concat."
                                     },
                                     {
                                       'outversion' : "6.0.8",
                                       'name' : "join_buffer_size",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'default' : "128k",
                                       'bitsize' : "32",
                                       'maximum' : "4294967295",
                                       'minimum' : "8200",
                                       'unitcontrol' : " ;K;M;G",
                                       'caption' : "Join buffer size:",
                                       'type' : "numeric",
                                       'description' : "The size of the buffer that is used for full joins."
                                     },
                                     {
                                       'name' : "key_cache_block_size",
                                       'versions' : ((4, 1, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'default' : "1k",
                                       'maximum' : "16384",
                                       'minimum' : "512",
                                       'unitcontrol' : " ;K;M;G",
                                       'caption' : "Key cache block size",
                                       'type' : "numeric",
                                       'description' : "The default size of key cache blocks"
                                     },
                                     {
                                       'name' : "key_cache_division_limit",
                                       'versions' : ((4, 1, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'default' : "100",
                                       'maximum' : "100",
                                       'minimum' : "1",
                                       'caption' : "Key cache division limit",
                                       'type' : "numeric",
                                       'description' : "The minimum percentage of warm blocks in key cache"
                                     },
                                     {
                                       'name' : "lower_case_table_names",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'default' : "1",
                                       'maximum' : "2",
                                       'items' : {"0- Store as Created, Case Sensitive":"0", "1- Store in Lowercase, Case Insensitive":"1", "2- Store as Created, Case Insensitive":"2"},
                                       'minimum' : "0",
                                       'caption' : "Make table names case insensitive",
                                       'type' : "dropdownbox",
                                       'description' : "If set to 0, table and db names are stored with the lettercase specified during creation and comparisons are case sensitive. If set to 1 table names are stored in lowercase on disk and table names will be case-insensitive. If set to 2, names are stored as specified during creation but are compared case-insensitively (Only works on case-insensitive filesystems, starting from MySQL 4.1.8)."
                                     },
                                     {
                                       'outversion' : "5.1.35",
                                       'name' : "max_binlog_cache_size",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'default' : "4095M",
                                       'maximum' : "4294967295",
                                       'minimum' : "4096",
                                       'unitcontrol' : " ;K;M;G",
                                       'caption' : "Maximum binlog cache size:",
                                       'type' : "numeric",
                                       'description' : "Can be used to restrict the total size used to cache a multi-transaction query."
                                     },
                                     {
                                       'name' : "max_heap_table_size",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'default' : "16M",
                                       'maximum' : "4294967295",
                                       'minimum' : "16384",
                                       'unitcontrol' : " ;K;M;G",
                                       'caption' : "Max heap table size",
                                       'type' : "numeric",
                                       'description' : "Don't allow creation of heap tables bigger than this."
                                     },
                                     {
                                       'name' : "max_join_size",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'default' : "4095M",
                                       'maximum' : "4294967295",
                                       'minimum' : "1",
                                       'unitcontrol' : " ;K;M;G",
                                       'caption' : "Max join size",
                                       'type' : "numeric",
                                       'description' : "Joins that are probably going to read more than max_join_size records return an error"
                                     },
                                     {
                                       'name' : "max_length_for_sort_data",
                                       'versions' : ((4, 1, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'default' : "1k",
                                       'maximum' : "8388608",
                                       'minimum' : "4",
                                       'unitcontrol' : " ;K;M;G",
                                       'caption' : "Max length for sort data",
                                       'type' : "numeric",
                                       'description' : "Max number of bytes in sorted records."
                                     },
                                     {
                                       'name' : "max_seeks_for_key",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'default' : "",
                                       'bitsize' : "32",
                                       'maximum' : "4294967295",
                                       'minimum' : "1",
                                       'caption' : "Max seeks for key",
                                       'type' : "filename",
                                       'description' : "Limit assumed max number of seeks when looking up rows based on a key"
                                     },
                                     {
                                       'name' : "max_sort_length",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'default' : "1k",
                                       'maximum' : "8388608",
                                       'minimum' : "4",
                                       'unitcontrol' : " ;K;M;G",
                                       'caption' : "Max sort length",
                                       'type' : "numeric",
                                       'description' : "The number of bytes to use when sorting BLOB or TEXT values (only the first max_sort_length bytes of each value are used; the rest are ignored)."
                                     },
                                     {
                                       'name' : "max_tmp_tables",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'default' : "32",
                                       'bitsize' : "32",
                                       'maximum' : "4294967295",
                                       'minimum' : "1",
                                       'caption' : "Max temporary tables:",
                                       'type' : "numeric",
                                       'description' : "Maximum number of temporary tables a client can keep open at a time."
                                     },
                                     {
                                       'name' : "max_write_lock_count",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'default' : "",
                                       'bitsize' : "32",
                                       'maximum' : "4294967295",
                                       'minimum' : "1",
                                       'caption' : "Max write lock count",
                                       'type' : "filename",
                                       'description' : "After this many write locks, allow some read locks to run in between"
                                     },
                                     {
                                       'description' : "Pid file used by safe_mysqld.",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'default' : "",
                                       'caption' : "Pid filename:",
                                       'type' : "filename",
                                       'name' : "pid-file"
                                     },
                                     {
                                       'name' : "preload_buffer_size",
                                       'versions' : ((4, 1, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'default' : "32k",
                                       'maximum' : "1073741824",
                                       'minimum' : "1024",
                                       'unitcontrol' : " ;K;M;G",
                                       'caption' : "Preload buffer size",
                                       'type' : "numeric",
                                       'description' : "The size of the buffer that is allocated when preloading                      indexes"
                                     },
                                     {
                                       'name' : "query_alloc_block_size",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'default' : "8k",
                                       'blocksize' : "1024",
                                       'maximum' : "4294967295",
                                       'minimum' : "1024",
                                       'bitsize' : "32",
                                       'unitcontrol' : " ;K;M;G",
                                       'caption' : "Query alloc block size:",
                                       'type' : "numeric",
                                       'description' : "Allocation block size for query parsing and execution"
                                     },
                                     {
                                       'name' : "query_prealloc_size",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'default' : "8k",
                                       'blocksize' : "1024",
                                       'maximum' : "4294967295",
                                       'minimum' : "8192",
                                       'bitsize' : "32",
                                       'unitcontrol' : " ;K;M;G",
                                       'caption' : "Query prealloc size",
                                       'type' : "numeric",
                                       'description' : "Persistent buffer for query parsing and execution"
                                     },
                                     {
                                       'name' : "range_alloc_block_size",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'default' : "2k",
                                       'blocksize' : "1024",
                                       'maximum' : "4294967295",
                                       'minimum' : "2048",
                                       'bitsize' : "32",
                                       'unitcontrol' : " ;K;M;G",
                                       'caption' : "Range alloc block size",
                                       'type' : "numeric",
                                       'description' : "Allocation block size for storing ranges during optimization"
                                     },
                                     {
                                       'name' : "read_buffer_size",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'default' : "128k",
                                       'maximum' : "2147479552",
                                       'minimum' : "8200",
                                       'unitcontrol' : " ;K;M;G",
                                       'caption' : "Read buffer size",
                                       'type' : "numeric",
                                       'description' : "Each thread that does a sequential scan allocates a buffer of this size for each table it scans. If you do many sequential scans, you may want to increase this value."
                                     },
                                     {
                                       'name' : "read_rnd_buffer_size",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'default' : "256k",
                                       'maximum' : "4294967295",
                                       'minimum' : "8200",
                                       'unitcontrol' : " ;K;M;G",
                                       'caption' : "Read rnd buffer size",
                                       'type' : "numeric",
                                       'description' : "When reading rows in sorted order after a sort, the rows are read through this buffer to avoid a disk seeks. If not set, then it's set to the value of record_buffer."
                                     },
                                     {
                                       'description' : "Syntax: sql-mode=option[,option[,option...]] where option can be one of: REAL_AS_FLOAT, PIPES_AS_CONCAT,ANSI_QUOTES, IGNORE_SPACE, ONLY_FULL_GROUP_BY,NO_UNSIGNED_SUBTRACTION.",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'default' : "",
                                       'caption' : "SQL Mode:",
                                       'type' : "filename",
                                       'name' : "sql-mode"
                                     },
                                     {
                                       'description' : "N/A",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'default' : "Unchecked",
                                       'caption' : "Enable symbolic link support",
                                       'type' : "boolean",
                                       'name' : "symbolic-links"
                                     },
                                     {
                                       'name' : "table_cache",
                                       'versions' : ((4, 1), (5, 0), (5, 1)),
                                       'default' : "64",
                                       'maximum' : "524288",
                                       'minimum' : "1",
                                       'caption' : "Table cache:",
                                       'type' : "numeric",
                                       'description' : "The number of open tables for all threads."
                                     },
                                     {
                                       'description' : "Using this option will cause most temporary files created to use a small set of names, rather than a unique name for each new file.",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (6, 0)),
                                       'default' : "Unchecked",
                                       'caption' : "Use pool for temporary files",
                                       'type' : "boolean",
                                       'name' : "temp-pool"
                                     },
                                     {
                                       'name' : "tmp_table_size",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (6, 0)),
                                       'default' : "32M",
                                       'maximum' : "4294967295",
                                       'minimum' : "1024",
                                       'unitcontrol' : " ;K;M;G",
                                       'caption' : "Temporary table size",
                                       'type' : "numeric",
                                       'description' : "If an in-memory temporary table exceeds this size, MySQL will automatically convert it to an on-disk MyISAM table."
                                     },
                                     {
                                       'description' : "Default transaction isolation level",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (6, 0)),
                                       'default' : "REPEATABLE-READ",
                                       'items' : {"REPEATABLE-READ":"REPEATABLE-READ", "READ-UNCOMMITTED":"READ-UNCOMMITTED", "SERIALIZABLE":"SERIALIZABLE", "READ-COMMITTED":"READ-COMMITTED"},
                                       'caption' : "Default transaction isolation level:",
                                       'type' : "dropdownbox",
                                       'name' : "transaction-isolation"
                                     },
                                     {
                                       'name' : "transaction_alloc_block_size",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (6, 0)),
                                       'default' : "8k",
                                       'blocksize' : "1024",
                                       'maximum' : "4294967295",
                                       'minimum' : "1024",
                                       'bitsize' : "32",
                                       'unitcontrol' : " ;K;M;G",
                                       'caption' : "Transaction alloc block size",
                                       'type' : "numeric",
                                       'description' : "Allocation block size for transactions to be stored in binary log"
                                     },
                                     {
                                       'name' : "transaction_prealloc_size",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (6, 0)),
                                       'default' : "4k",
                                       'blocksize' : "1024",
                                       'maximum' : "4294967295",
                                       'minimum' : "1024",
                                       'bitsize' : "32",
                                       'unitcontrol' : " ;K;M;G",
                                       'caption' : "Transaction prealloc size",
                                       'type' : "numeric",
                                       'description' : "Persistent buffer for transactions to be stored in binary log"
                                     },
                                     {
                                       'description' : "Run mysqld daemon as user.",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (6, 0)),
                                       'default' : "",
                                       'caption' : "Run as User:",
                                       'type' : "filename",
                                       'name' : "user"
                                     }
                                   ) #End of controls list in group Various
                                 } #End of group Various
                             ) # end of groups in tab Advanced
                  } # end of tab Advanced
  ,  'MyISAM Parameters' : { 'description' : "Edit MyISAM specific parameters on this page.",
                             'position' : 3,
                             'groups':(  {'caption' : "General",
                                          'controls':
                                            (
                                              {
                                                'outversion' : "5.0.5",
                                                'name' : "concurrent_insert",
                                                'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                                'default' : "TRUE",
                                                'caption' : "concurrent_insert",
                                                'type' : "boolean",
                                                'description' : "concurrent_insert"
                                              },
                                              {
                                                'description' : "Use system (external) locking. With this option enabled you can run myisamchk to test (not repair) tables while the MySQL server is running.",
                                                'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                                'default' : "Unchecked",
                                                'caption' : "Use external locking",
                                                'type' : "boolean",
                                                'name' : "external-locking"
                                              },
                                              {
                                                'name' : "keep_files_on_create",
                                                'caption' : "keep_files_on_create",
                                                'default' : "OFF",
                                                'versions' : ((5, 0, 48), (5, 1, 21), (5, 4), (5, 5), (6, 0)),
                                                'type' : "boolean",
                                                'description' : "keep_files_on_create"
                                              },
                                              {
                                                'outversion' : "5.1.22",
                                                'name' : "key_buffer_size",
                                                'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                                'default' : "8192k",
                                                'maximum' : "4294967295",
                                                'minimum' : "8",
                                                'unitcontrol' : " ;K;M;G",
                                                'caption' : "Key buffer:",
                                                'type' : "numeric",
                                                'description' : "The size of the buffer used for index blocks. Increase this to get better index handling (for all reads and multiple writes) to as much as you can afford; 64M on a 256M machine that mainly runs MySQL is quite common."
                                              },
                                              {
                                                'name' : "key_cache_age_threshold",
                                                'versions' : ((4, 1, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                                'default' : "300",
                                                'bitsize' : "32",
                                                'maximum' : "4294967295",
                                                'minimum' : "100",
                                                'caption' : "key_cache_age_threshold",
                                                'type' : "numeric",
                                                'description' : "key_cache_age_threshold"
                                              },
                                              {
                                                'description' : "Do not use system (external) locking. With locking enabled you can run myisamchk to test (not repair) tables while the MySQL server is running.",
                                                'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                                'default' : "Unchecked",
                                                'caption' : "Disable external locking",
                                                'type' : "boolean",
                                                'name' : "skip-locking"
                                              }
                                            ) #End of controls list in group General
                                          } #End of group General
                                        ,{'caption' : "Fulltext search",
                                          'controls':
                                            (
                                              {
                                                'description' : "The maximum length of the word to be included in a FULLTEXT index. Note: FULLTEXT indexes must be rebuilt after changing this variable.",
                                                'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                                'default' : "84",
                                                'minimum' : "10",
                                                'caption' : "Maximum word length:",
                                                'type' : "numeric",
                                                'name' : "ft_max_word_len"
                                              },
                                              {
                                                'name' : "ft_min_word_len",
                                                'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                                'default' : "4",
                                                'minimum' : "1",
                                                'caption' : "Minimum word length:",
                                                'type' : "numeric",
                                                'description' : "The minimum length of the word to be included in a FULLTEXT index. Note: FULLTEXT indexes must be rebuilt after changing this variable."
                                              },
                                              {
                                                'name' : "ft_query_expansion_limit",
                                                'versions' : ((4, 1, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                                'default' : "4",
                                                'maximum' : "1000",
                                                'minimum' : "0",
                                                'caption' : "Query expansion limit:",
                                                'type' : "numeric",
                                                'description' : "Number of best matches to use for query expansion."
                                              },
                                              {
                                                'description' : "Use stopwords from this file instead of built-in list.",
                                                'versions' : ((4, 1, 10), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                                'default' : "",
                                                'caption' : "Stopword file:",
                                                'type' : "filename",
                                                'name' : "ft_stopword_file"
                                              }
                                            ) #End of controls list in group Fulltext search
                                          } #End of group Fulltext search
                                        ,{'caption' : "Advanced Settings",
                                          'controls':
                                            (
                                              {
                                                'name' : "myisam-block-size",
                                                'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                                'default' : "1024",
                                                'maximum' : "16384",
                                                'minimum' : "1024",
                                                'caption' : "myisam-block-size",
                                                'type' : "numeric",
                                                'description' : "myisam-block-size"
                                              },
                                              {
                                                'outversion' : "5.0.5",
                                                'name' : "myisam_data_pointer_size",
                                                'versions' : ((4, 1, 2), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                                'default' : "4",
                                                'maximum' : "8",
                                                'minimum' : "2",
                                                'caption' : "myisam_data_pointer_size",
                                                'type' : "numeric",
                                                'description' : "myisam_data_pointer_size"
                                              },
                                              {
                                                'outversion' : "5.0.6",
                                                'name' : "myisam_max_extra_sort_file_size",
                                                'versions' : ((4, 1), (5, 0)),
                                                'default' : "256M",
                                                'unitcontrol' : " ;K;M;G",
                                                'caption' : "Extra sort file size:",
                                                'type' : "numeric",
                                                'description' : "Used to help MySQL to decide when to use the slow but safe key cache index create method."
                                              },
                                              {
                                                'description' : "Don't use the fast sort index method to created index if the temporary file would get bigger than this.",
                                                'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                                'default' : "2047M",
                                                'unitcontrol' : " ;K;M;G",
                                                'caption' : "Max sort file size:",
                                                'type' : "numeric",
                                                'name' : "myisam_max_sort_file_size"
                                              },
                                              {
                                                'name' : "myisam-recover",
                                                'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                                'default' : "OFF",
                                                'items' : {"DEFAULT":"DEFAULT", "BACKUP":"BACKUP", "FORCE":"FORCE", "QUICK":"QUICK"},
                                                'caption' : "myisam-recover",
                                                'type' : "dropdownbox",
                                                'description' : "myisam-recover"
                                              },
                                              {
                                                'name' : "myisam_repair_threads",
                                                'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                                'default' : "1",
                                                'bitsize' : "32",
                                                'maximum' : "4294967295",
                                                'minimum' : "1",
                                                'caption' : "Number of repair threads:",
                                                'type' : "numeric",
                                                'description' : "Number of threads to use when repairing MyISAM tables.The value of 1 disables parallel repair."
                                              },
                                              {
                                                'name' : "myisam_sort_buffer_size",
                                                'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                                'default' : "8192k",
                                                'bitsize' : "32",
                                                'maximum' : "4294967295",
                                                'minimum' : "4",
                                                'unitcontrol' : " ;K;M;G",
                                                'caption' : "MyIsam Sort buffer size:",
                                                'type' : "numeric",
                                                'description' : "The buffer that is allocated when sorting the index when doing a REPAIR or when creating indexes with CREATE INDEX or ALTER TABLE."
                                              },
                                              {
                                                'inversion' : "4.1",
                                                'name' : "myisam_stats_method",
                                                'versions' : ((4, 1, 15), (5, 0, 14), (5, 1), (5, 4), (5, 5), (6, 0)),
                                                'default' : "nulls_unequal",
                                                'items' : {},
                                                'caption' : "myisam_stats_method",
                                                'type' : "dropdownbox",
                                                'description' : "myisam_stats_method"
                                              },
                                              {
                                                'name' : "myisam_use_mmap",
                                                'caption' : "myisam_use_mmap",
                                                'default' : "FALSE",
                                                'versions' : ((5, 1, 4), (5, 4), (5, 5), (6, 0)),
                                                'type' : "boolean",
                                                'description' : "myisam_use_mmap"
                                              },
                                              {
                                                'caption' : "skip-concurrent-insert",
                                                'description' : "skip-concurrent-insert",
                                                'type' : "string",
                                                'name' : "skip-concurrent-insert",
                                                'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0))
                                              }
                                            ) #End of controls list in group Advanced Settings
                                          } #End of group Advanced Settings
                                      ) # end of groups in tab MyISAM Parameters
                           } # end of tab MyISAM Parameters
  ,  'Performance' : { 'description' : "You can configure performance and caching related options here.",
                       'position' : 4,
                       'groups':(  {'caption' : "General",
                                    'controls':
                                      (
                                        {
                                          'name' : "safe-mode",
                                          'caption' : "safe-mode",
                                          'default' : "OFF",
                                          'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                          'type' : "boolean",
                                          'description' : "safe-mode"
                                        },
                                        {
                                          'outversion' : "5.1.24",
                                          'name' : "table_definition_cache",
                                          'versions' : ((5, 1, 3), (5, 4), (6, 0)),
                                          'default' : "128",
                                          'maximum' : "524288",
                                          'minimum' : "1",
                                          'caption' : "table_definition_cache",
                                          'type' : "numeric",
                                          'description' : "table_definition_cache"
                                        },
                                        {
                                          'name' : "table_open_cache",
                                          'versions' : ((5, 1, 3), (5, 4), (6, 0)),
                                          'default' : "64",
                                          'maximum' : "524288",
                                          'minimum' : "64",
                                          'caption' : "table_open_cache",
                                          'type' : "numeric",
                                          'description' : "table_open_cache"
                                        }
                                      ) #End of controls list in group General
                                    } #End of group General
                                  ,{'caption' : "Query cache",
                                    'controls':
                                      (
                                        {
                                          'name' : "query_cache_limit",
                                          'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                          'default' : "1M",
                                          'bitsize' : "32",
                                          'maximum' : "4294967295",
                                          'minimum' : "0",
                                          'unitcontrol' : " ;K;M;G",
                                          'caption' : "Query cache limit",
                                          'type' : "numeric",
                                          'description' : "Don't cache results that are bigger than this."
                                        },
                                        {
                                          'name' : "query_cache_min_res_unit",
                                          'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                          'default' : "4096k",
                                          'bitsize' : "32",
                                          'maximum' : "4294967295",
                                          'minimum' : "512",
                                          'unitcontrol' : " ;K;M;G",
                                          'caption' : "Minimal size of result unit",
                                          'type' : "numeric",
                                          'description' : "minimal size of unit in wich space for results is allocated (last unit will be trimed after writing all result data"
                                        },
                                        {
                                          'name' : "query_cache_size",
                                          'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                          'default' : "0",
                                          'bitsize' : "32",
                                          'maximum' : "4294967295",
                                          'minimum' : "0",
                                          'unitcontrol' : " ;K;M;G",
                                          'caption' : "Cache Size",
                                          'type' : "numeric",
                                          'description' : "The memory allocated to store results from old queries."
                                        },
                                        {
                                          'name' : "query_cache_type",
                                          'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                          'default' : "1",
                                          'items' : {"Don't cache or retrieve results":"0", "Cache all queries except SELECT SQL_NO_CACHE":"1", "Cache only SELECT SQL_CACHE queries":"2"},
                                          'caption' : "Cache type",
                                          'type' : "dropdownbox",
                                          'description' : "Query cache type to use."
                                        },
                                        {
                                          'name' : "query_cache_wlock_invalidate",
                                          'caption' : "query_cache_wlock_invalidate",
                                          'default' : "FALSE",
                                          'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                          'type' : "boolean",
                                          'description' : "query_cache_wlock_invalidate"
                                        },
                                        {
                                          'name' : "replicate-same-server-id",
                                          'caption' : "replicate-same-server-id",
                                          'default' : "FALSE",
                                          'versions' : ((4, 1), (5, 0, 1), (5, 1), (5, 4), (5, 5), (6, 0)),
                                          'type' : "boolean",
                                          'description' : "replicate-same-server-id"
                                        }
                                      ) #End of controls list in group Query cache
                                    } #End of group Query cache
                                  ,{'caption' : "Optimize",
                                    'controls':
                                      (
                                        {
                                          'name' : "optimizer_prune_level",
                                          'caption' : "optimizer_prune_level",
                                          'default' : "1",
                                          'versions' : ((5, 0, 1), (5, 1), (5, 4), (5, 5), (6, 0)),
                                          'type' : "boolean",
                                          'description' : "optimizer_prune_level"
                                        },
                                        {
                                          'name' : "optimizer_search_depth",
                                          'caption' : "optimizer_search_depth",
                                          'default' : "62",
                                          'versions' : ((5, 0, 1), (5, 1), (5, 4), (5, 5), (6, 0)),
                                          'type' : "numeric",
                                          'description' : "optimizer_search_depth"
                                        },
                                        {
                                          'caption' : "optimizer_switch",
                                          'description' : "optimizer_switch",
                                          'type' : "string",
                                          'name' : "optimizer_switch",
                                          'versions' : ((5, 1, 34), (5, 2, 4), (5, 4, 2), (5, 5), (6, 0))
                                        }
                                      ) #End of controls list in group Optimize
                                    } #End of group Optimize
                                ) # end of groups in tab Performance
                     } # end of tab Performance
  ,  'Log Files' : { 'description' : "You can configure all log files options here.",
                     'position' : 5,
                     'groups':(  {'caption' : "Activate Logging",
                                  'controls':
                                    (
                                      {
                                        'description' : "Specifies the initial general query log state.",
                                        'versions' : ((5, 1, 12), (5, 4), (5, 5), (6, 0)),
                                        'default' : "Unchecked",
                                        'caption' : "Enable General Log",
                                        'type' : "boolean",
                                        'name' : "general-log"
                                      },
                                      {
                                        'description' : "Enter a name for the query log file. Otherwise a default name will be used.",
                                        'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                        'default' : "",
                                        'caption' : "Query Logfile Name:",
                                        'type' : "filename",
                                        'name' : "log"
                                      },
                                      {
                                        'description' : "Enter a name for the binary log. Otherwise a default name will be used.",
                                        'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                        'default' : "",
                                        'caption' : "Binary Logfile Name:",
                                        'type' : "filename",
                                        'name' : "log-bin"
                                      },
                                      {
                                        'description' : "Enter a name for the error log file. Otherwise a default name will be used.",
                                        'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                        'default' : "",
                                        'caption' : "Error Logfile Name:",
                                        'type' : "filename",
                                        'name' : "log-error"
                                      },
                                      {
                                        'description' : "Enter a name for the isam logfile. Otherwise a default name will be used.",
                                        'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                        'default' : "",
                                        'caption' : "Isam Logfile Name:",
                                        'type' : "filename",
                                        'name' : "log-isam"
                                      },
                                      {
                                        'description' : "Enter a name for the slow query log. Otherwise a default name will be used.",
                                        'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                        'default' : "",
                                        'caption' : "Slow Queries Log:",
                                        'type' : "filename",
                                        'name' : "log-slow-queries"
                                      }
                                    ) #End of controls list in group Activate Logging
                                  } #End of group Activate Logging
                                ,{'caption' : "Binlog Options",
                                  'controls':
                                    (
                                      {
                                        'description' : "Tells the master it should log updates for the specified database, and exclude all others not explicitly mentioned.",
                                        'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                        'default' : "",
                                        'caption' : "Log updates for these databases only",
                                        'type' : "filename",
                                        'name' : "binlog-do-db"
                                      },
                                      {
                                        'description' : "Tells the master that updates to the given database should not be logged to the binary log.",
                                        'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                        'default' : "",
                                        'caption' : "Ignore updates for these databases",
                                        'type' : "filename",
                                        'name' : "binlog-ignore-db"
                                      },
                                      {
                                        'name' : "binlog-row-event-max-size",
                                        'versions' : ((5, 1, 5), (5, 4), (5, 5), (6, 0)),
                                        'default' : "1024",
                                        'bitsize' : "32",
                                        'maximum' : "4294967295",
                                        'minimum' : "256",
                                        'caption' : "binlog-row-event-max-size",
                                        'type' : "numeric",
                                        'description' : "binlog-row-event-max-size"
                                      },
                                      {
                                        'inversion' : "5.1.5",
                                        'name' : "binlog-format",
                                        'versions' : ((5, 1, 5), (5, 4), (5, 5), (6, 0)),
                                        'default' : "STATEMENT",
                                        'outversion' : "5.1.7",
                                        'items' : {"ROW":"ROW", "STATEMENT":"STATEMENT"},
                                        'caption' : "binlog-format",
                                        'type' : "dropdownbox",
                                        'description' : "binlog-format"
                                      },
                                      {
                                        'description' : "File that holds the names for last binary log files.",
                                        'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                        'default' : "",
                                        'caption' : "Filename of the index for binary logfiles",
                                        'type' : "filename",
                                        'name' : "log-bin-index"
                                      },
                                      {
                                        'name' : "log-bin-trust-function-creators",
                                        'caption' : "log-bin-trust-function-creators",
                                        'default' : "FALSE",
                                        'versions' : ((5, 0, 16), (5, 1), (5, 4), (5, 5), (6, 0)),
                                        'type' : "boolean",
                                        'description' : "log-bin-trust-function-creators"
                                      },
                                      {
                                        'name' : "log-bin-trust-routine-creators",
                                        'caption' : "log-bin-trust-routine-creators",
                                        'default' : "FALSE",
                                        'versions' : ((5, 0, 6), (5, 1), (5, 2), (5, 4)),
                                        'type' : "boolean",
                                        'description' : "log-bin-trust-routine-creators"
                                      },
                                      {
                                        'name' : "max-binlog-dump-events",
                                        'caption' : "max-binlog-dump-events",
                                        'default' : "0",
                                        'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                        'type' : "numeric",
                                        'description' : "max-binlog-dump-events"
                                      },
                                      {
                                        'name' : "max_binlog_size",
                                        'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                        'default' : "1024M",
                                        'minimum' : "4096",
                                        'unitcontrol' : " ;K;M;G",
                                        'caption' : "Maximum binary log size",
                                        'type' : "numeric",
                                        'description' : "Binary log will be rotated automatically when the size exceeds this value. Will also apply to relay logs if max_relay_log_size is 0. The minimum value for this variable is 4096."
                                      },
                                      {
                                        'name' : "sporadic-binlog-dump-fail",
                                        'caption' : "sporadic-binlog-dump-fail",
                                        'default' : "FALSE",
                                        'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                        'type' : "boolean",
                                        'description' : "sporadic-binlog-dump-fail"
                                      },
                                      {
                                        'name' : "sync_binlog",
                                        'versions' : ((4, 1, 3), (5, 0, 1), (5, 1), (5, 4), (5, 5), (6, 0)),
                                        'default' : "0",
                                        'bitsize' : "32",
                                        'maximum' : "4294967295",
                                        'minimum' : "0",
                                        'caption' : "sync_binlog",
                                        'type' : "numeric",
                                        'description' : "sync_binlog"
                                      }
                                    ) #End of controls list in group Binlog Options
                                  } #End of group Binlog Options
                                ,{'caption' : "Slow query log options",
                                  'controls':
                                    (
                                      {
                                        'name' : "log-slow-admin-statements",
                                        'caption' : "log-slow-admin-statements",
                                        'default' : "FALSE",
                                        'versions' : ((4, 1, 13), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                        'type' : "boolean",
                                        'description' : "log-slow-admin-statements"
                                      },
                                      {
                                        'name' : "log-slow-slave-statements",
                                        'caption' : "log-slow-slave-statements",
                                        'default' : "off",
                                        'versions' : ((5, 1, 21), (5, 4), (5, 5), (6, 0, 4)),
                                        'type' : "boolean",
                                        'description' : "log-slow-slave-statements"
                                      },
                                      {
                                        'outversion' : "5.0.20",
                                        'name' : "long_query_time",
                                        'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                        'default' : "2",
                                        'minimum' : "1",
                                        'caption' : "Long query time",
                                        'type' : "numeric",
                                        'description' : "Log all queries that have taken more than long_query_time seconds to execute to file."
                                      },
                                      {
                                        'name' : "slow-query-log",
                                        'caption' : "slow-query-log",
                                        'default' : "OFF",
                                        'versions' : ((5, 1, 12), (5, 4), (5, 5), (6, 0)),
                                        'type' : "boolean",
                                        'description' : "slow-query-log"
                                      },
                                      {
                                        'description' : "slow_query_log_file",
                                        'caption' : "slow_query_log_file",
                                        'versions' : ((5, 1, 12), (5, 4), (5, 5), (6, 0)),
                                        'type' : "filename",
                                        'name' : "slow_query_log_file"
                                      }
                                    ) #End of controls list in group Slow query log options
                                  } #End of group Slow query log options
                                ,{'caption' : "Advanced log options",
                                  'controls':
                                    (
                                      {
                                        'name' : "expire_logs_days",
                                        'versions' : ((4, 1, 0), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                        'default' : "0",
                                        'maximum' : "99",
                                        'minimum' : "0",
                                        'caption' : "Expire log days",
                                        'type' : "numeric",
                                        'description' : "Logs will be rotated after expire-log-days days"
                                      },
                                      {
                                        'name' : "general_log_file",
                                        'caption' : "general_log_file",
                                        'default' : "host_name.log",
                                        'versions' : ((5, 1, 12), (5, 4), (5, 5), (6, 0)),
                                        'type' : "filename",
                                        'description' : "general_log_file"
                                      },
                                      {
                                        'name' : "log-output",
                                        'versions' : ((5, 1, 6), (5, 4), (5, 5), (6, 0)),
                                        'default' : "FILE",
                                        'items' : {"Files":"FILE", "Tables":"TABLE", "Disable Logging":"NONE"},
                                        'caption' : "Write Logs to:",
                                        'type' : "dropdownbox",
                                        'description' : "This option determines the destination for general query log and slow query log output. Table selects logging to tables in the MySQL Database, File selects logging to the filesystem."
                                      },
                                      {
                                        'description' : "Log queries that are executed without benefit of any index.",
                                        'versions' : ((4, 1, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                        'default' : "Unchecked",
                                        'caption' : "Log queries that don't use indexes",
                                        'type' : "boolean",
                                        'name' : "log-queries-not-using-indexes"
                                      },
                                      {
                                        'description' : "Don't log extra information to update and slow-query logs.",
                                        'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                        'default' : "Unchecked",
                                        'caption' : "Log only in short format",
                                        'type' : "boolean",
                                        'name' : "log-short-format"
                                      },
                                      {
                                        'name' : "log-tc",
                                        'caption' : "log-tc",
                                        'default' : "tc.log",
                                        'versions' : ((5, 0, 3), (5, 1), (5, 4), (5, 5), (6, 0)),
                                        'type' : "filename",
                                        'description' : "log-tc"
                                      },
                                      {
                                        'name' : "log-tc-size",
                                        'versions' : ((5, 0, 3), (5, 1), (5, 4), (5, 5), (6, 0)),
                                        'default' : "24576",
                                        'bitsize' : "32",
                                        'maximum' : "4294967295",
                                        'caption' : "log-tc-size",
                                        'type' : "numeric",
                                        'description' : "log-tc-size"
                                      },
                                      {
                                        'inversion' : "4.1.3",
                                        'name' : "log-warnings",
                                        'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                        'default' : "Unchecked",
                                        'bitsize' : "32",
                                        'maximum' : "4294967295",
                                        'minimum' : "0",
                                        'caption' : "Log warnings",
                                        'type' : "boolean",
                                        'description' : "Log some not critical warnings to the log file."
                                      },
                                      {
                                        'name' : "min-examined-row-limit",
                                        'versions' : ((5, 1, 21), (5, 4), (5, 5), (6, 0, 4)),
                                        'default' : "0",
                                        'bitsize' : "32",
                                        'maximum' : "4294967295",
                                        'minimum' : "0",
                                        'caption' : "min-examined-row-limit",
                                        'type' : "numeric",
                                        'description' : "min-examined-row-limit"
                                      }
                                    ) #End of controls list in group Advanced log options
                                  } #End of group Advanced log options
                              ) # end of groups in tab Log Files
                   } # end of tab Log Files
  ,  'Security' : { 'description' : "This page contains general parameters for the MySQL server.",
                    'position' : 6,
                    'groups':(  {'caption' : "Security",
                                 'controls':
                                   (
                                     {
                                       'name' : "allow-suspicious-udfs",
                                       'caption' : "allow-suspicious-udfs",
                                       'default' : "FALSE",
                                       'versions' : ((4, 1, 10), (5, 0, 3), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'type' : "boolean",
                                       'description' : "allow-suspicious-udfs"
                                     },
                                     {
                                       'caption' : "des-key-file",
                                       'description' : "des-key-file",
                                       'type' : "string",
                                       'name' : "des-key-file",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0))
                                     },
                                     {
                                       'description' : "Enable/disable LOAD DATA LOCAL INFILE",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'default' : "Unchecked",
                                       'caption' : "Enable load data local infile",
                                       'type' : "boolean",
                                       'name' : "local-infile"
                                     },
                                     {
                                       'description' : "Use old password encryption method (needed for 4.0 and older clients).",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'default' : "Unchecked",
                                       'caption' : "Use old passwords",
                                       'type' : "boolean",
                                       'name' : "old-passwords"
                                     },
                                     {
                                       'description' : "Make all tables read-only, with the exception of replication (slave) threads and users with the SUPER privilege.",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'default' : "Unchecked",
                                       'caption' : "Make all tables read-only",
                                       'type' : "boolean",
                                       'name' : "read_only"
                                     },
                                     {
                                       'description' : "safe-show-database",
                                       'caption' : "safe-show-database",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'type' : "boolean",
                                       'name' : "safe-show-database"
                                     },
                                     {
                                       'description' : "Don't allow new user creation by the user who has no write privileges to the mysql.user table.",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'default' : "Unchecked",
                                       'caption' : "Safe User Create",
                                       'type' : "boolean",
                                       'name' : "safe-user-create"
                                     },
                                     {
                                       'description' : "safemalloc-mem-limit",
                                       'caption' : "safemalloc-mem-limit",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'type' : "numeric",
                                       'name' : "safemalloc-mem-limit"
                                     },
                                     {
                                       'description' : "Disallow authentication for accounts that have old (pre-4.1) passwords.",
                                       'versions' : ((4, 1, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'default' : "Unchecked",
                                       'caption' : "Secure authentication",
                                       'type' : "boolean",
                                       'name' : "secure-auth"
                                     },
                                     {
                                       'description' : "secure-file-priv",
                                       'caption' : "secure-file-priv",
                                       'versions' : ((5, 0, 38), (5, 1, 17), (5, 4), (5, 5), (6, 0)),
                                       'type' : "string",
                                       'name' : "secure-file-priv"
                                     },
                                     {
                                       'description' : "Start without grant tables. This gives all users FULL ACCESS to all tables!",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'default' : "Unchecked",
                                       'caption' : "Disable grant tables",
                                       'type' : "boolean",
                                       'name' : "skip-grant-tables"
                                     },
                                     {
                                       'description' : "Don't allow 'SHOW DATABASE' commands",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'default' : "Unchecked",
                                       'caption' : "Deactivate show database",
                                       'type' : "boolean",
                                       'name' : "skip-show-database"
                                     }
                                   ) #End of controls list in group Security
                                 } #End of group Security
                               ,{'caption' : "SSL",
                                 'controls':
                                   (
                                     {
                                       'name' : "ssl",
                                       'caption' : "ssl",
                                       'default' : "FALSE",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                       'type' : "boolean",
                                       'description' : "SSL"
                                     },
                                     {
                                       'description' : "ssl-ca",
                                       'caption' : "ssl-ca",
                                       'versions' : ((4, 0), (4, 1), (5, 0, 23), (5, 1, 11), (5, 4), (5, 5), (6, 0)),
                                       'type' : "filename",
                                       'name' : "ssl-ca"
                                     },
                                     {
                                       'description' : "ssl-capath",
                                       'caption' : "ssl-capath",
                                       'versions' : ((4, 0), (4, 1), (5, 0, 23), (5, 1, 11), (5, 4), (5, 5), (6, 0)),
                                       'type' : "filename",
                                       'name' : "ssl-capath"
                                     },
                                     {
                                       'description' : "ssl-cert",
                                       'caption' : "ssl-cert",
                                       'versions' : ((4, 0), (4, 1), (5, 0, 23), (5, 1, 11), (5, 4), (5, 5), (6, 0)),
                                       'type' : "filename",
                                       'name' : "ssl-cert"
                                     },
                                     {
                                       'description' : "ssl-cipher",
                                       'caption' : "ssl-cipher",
                                       'versions' : ((4, 0), (4, 1), (5, 0, 23), (5, 1, 11), (5, 4), (5, 5), (6, 0)),
                                       'type' : "filename",
                                       'name' : "ssl-cipher"
                                     },
                                     {
                                       'description' : "ssl-key",
                                       'caption' : "ssl-key",
                                       'versions' : ((4, 0), (4, 1), (5, 0, 23), (5, 1, 11), (5, 4), (5, 5), (6, 0)),
                                       'type' : "string",
                                       'name' : "ssl-key"
                                     },
                                     {
                                       'description' : "ssl-verify-server-cert",
                                       'caption' : "ssl-verify-server-cert",
                                       'versions' : ((5, 1, 11), (5, 4), (5, 5), (6, 0)),
                                       'type' : "boolean",
                                       'name' : "ssl-verify-server-cert"
                                     },
                                     {
                                       'caption' : "skip-ssl",
                                       'description' : "skip-ssl",
                                       'type' : "string",
                                       'name' : "skip-ssl",
                                       'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (6, 0))
                                     }
                                   ) #End of controls list in group SSL
                                 } #End of group SSL
                             ) # end of groups in tab Security
                  } # end of tab Security
  ,  'InnoDB Parameters' : { 'description' : "All relevant InnoDB Parameters.",
                             'position' : 7,
                             'groups':(  {'caption' : "General",
                                          'controls':
                                            (
                                              {
                                                'description' : "ignore_builtin_innodb",
                                                'caption' : "ignore_builtin_innodb",
                                                'versions' : ((5, 1, 33), (5, 4), (5, 5)),
                                                'type' : "boolean",
                                                'name' : "ignore_builtin_innodb"
                                              },
                                              {
                                                'name' : "innodb_adaptive_flushing",
                                                'caption' : "innodb_adaptive_flushing",
                                                'default' : "ON",
                                                'versions' : ((5, 1, 38), (5, 4, 2), (5, 5)),
                                                'type' : "boolean",
                                                'description' : "innodb_adaptive_flushing"
                                              },
                                              {
                                                'name' : "innodb_adaptive_hash_index",
                                                'caption' : "innodb_adaptive_hash_index",
                                                'default' : "ON",
                                                'versions' : ((5, 0, 52), (5, 1, 24), (5, 4), (5, 5), (6, 0, 5)),
                                                'type' : "boolean",
                                                'description' : "innodb_adaptive_hash_index"
                                              },
                                              {
                                                'name' : "innodb_autoextend_increment",
                                                'versions' : ((4, 1, 5), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                                'default' : "8",
                                                'maximum' : "1000",
                                                'minimum' : "1",
                                                'caption' : "innodb_autoextend_increment",
                                                'type' : "numeric",
                                                'description' : "innodb_autoextend_increment"
                                              },
                                              {
                                                'name' : "innodb_autoinc_lock_mode",
                                                'caption' : "innodb_autoinc_lock_mode",
                                                'default' : "1",
                                                'versions' : ((5, 1, 22), (5, 4), (5, 5), (6, 0)),
                                                'type' : "numeric",
                                                'description' : "innodb_autoinc_lock_mode"
                                              },
                                              {
                                                'name' : "innodb_change_buffering",
                                                'versions' : ((5, 1, 38), (5, 4, 2), (5, 5)),
                                                'default' : "inserts",
                                                'items' : {"inserts":"inserts", "none":"none"},
                                                'caption' : "innodb_change_buffering",
                                                'type' : "dropdownbox",
                                                'description' : "innodb_change_buffering"
                                              },
                                              {
                                                'name' : "innodb_checksums",
                                                'caption' : "innodb_checksums",
                                                'default' : "ON",
                                                'versions' : ((5, 0, 3), (5, 1), (5, 4), (5, 5), (6, 0)),
                                                'type' : "boolean",
                                                'description' : "innodb_checksums"
                                              },
                                              {
                                                'name' : "innodb_commit_concurrency",
                                                'versions' : ((5, 0, 12), (5, 1), (5, 4), (5, 5), (6, 0)),
                                                'default' : "0",
                                                'maximum' : "100",
                                                'minimum' : "0",
                                                'caption' : "innodb_commit_concurrency",
                                                'type' : "numeric",
                                                'description' : "innodb_commit_concurrency"
                                              },
                                              {
                                                'name' : "innodb_concurrency_tickets",
                                                'versions' : ((5, 0, 3), (5, 1), (5, 4), (5, 5), (6, 0)),
                                                'default' : "500",
                                                'maximum' : "4294967295",
                                                'minimum' : "1",
                                                'caption' : "innodb_concurrency_tickets",
                                                'type' : "numeric",
                                                'description' : "innodb_concurrency_tickets"
                                              },
                                              {
                                                'description' : "innodb_doublewrite",
                                                'caption' : "innodb_doublewrite",
                                                'versions' : ((5, 0, 3), (5, 1), (5, 4), (5, 5), (6, 0)),
                                                'type' : "numeric",
                                                'name' : "innodb_doublewrite"
                                              },
                                              {
                                                'name' : "innodb_file_format",
                                                'caption' : "innodb_file_format",
                                                'default' : "Antelope",
                                                'versions' : ((5, 1, 38), (5, 4, 2), (5, 5)),
                                                'type' : "string",
                                                'description' : "innodb_file_format"
                                              },
                                              {
                                                'name' : "innodb_file_format_check",
                                                'caption' : "innodb_file_format_check",
                                                'default' : "Antelope",
                                                'versions' : ((5, 1, 38), (5, 4, 2), (5, 5)),
                                                'type' : "string",
                                                'description' : "innodb_file_format_check"
                                              },
                                              {
                                                'name' : "innodb_io_capacity",
                                                'caption' : "innodb_io_capacity",
                                                'default' : "200",
                                                'versions' : ((5, 1, 38), (5, 4), (5, 5)),
                                                'type' : "numeric",
                                                'description' : "innodb_io_capacity"
                                              },
                                              {
                                                'name' : "innodb_locks_unsafe_for_binlog",
                                                'caption' : "innodb_locks_unsafe_for_binlog",
                                                'default' : "FALSE",
                                                'versions' : ((4, 1, 4), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                                'type' : "boolean",
                                                'description' : "innodb_locks_unsafe_for_binlog"
                                              },
                                              {
                                                'name' : "innodb_max_purge_lag",
                                                'versions' : ((4, 1, 6), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                                'default' : "0",
                                                'maximum' : "4294967295",
                                                'minimum' : "0",
                                                'caption' : "innodb_max_purge_lag",
                                                'type' : "numeric",
                                                'description' : "innodb_max_purge_lag"
                                              },
                                              {
                                                'name' : "innodb_old_blocks_pct",
                                                'versions' : ((5, 1, 41), (5, 5)),
                                                'default' : "37",
                                                'maximum' : "95",
                                                'minimum' : "5",
                                                'caption' : "innodb_old_blocks_pct",
                                                'type' : "numeric",
                                                'description' : "innodb_old_blocks_pct"
                                              },
                                              {
                                                'name' : "innodb_old_blocks_time",
                                                'caption' : "innodb_old_blocks_time",
                                                'default' : "0",
                                                'versions' : ((5, 1, 41), (5, 5)),
                                                'type' : "numeric",
                                                'description' : "innodb_old_blocks_time"
                                              },
                                              {
                                                'name' : "innodb_read_ahead_threshold",
                                                'caption' : "innodb_read_ahead_threshold",
                                                'default' : "56",
                                                'versions' : ((5, 1, 38), (5, 4, 2), (5, 5)),
                                                'type' : "numeric",
                                                'description' : "innodb_read_ahead_threshold"
                                              },
                                              {
                                                'outversion' : "5.4.2",
                                                'name' : "innodb_read_io_threads",
                                                'versions' : ((5, 1, 38), (5, 4), (5, 5)),
                                                'default' : "8",
                                                'caption' : "innodb_read_io_threads",
                                                'type' : "numeric",
                                                'description' : "innodb_read_io_threads"
                                              },
                                              {
                                                'name' : "innodb_replication_delay",
                                                'caption' : "innodb_replication_delay",
                                                'default' : "0",
                                                'versions' : ((5, 1, 38), (5, 4, 2), (5, 5)),
                                                'type' : "numeric",
                                                'description' : "innodb_replication_delay"
                                              },
                                              {
                                                'caption' : "innodb_rollback_on_timeout",
                                                'description' : "innodb_rollback_on_timeout",
                                                'type' : "string",
                                                'name' : "innodb_rollback_on_timeout",
                                                'versions' : ((5, 0, 32), (5, 1, 15), (5, 4), (5, 5), (6, 0))
                                              },
                                              {
                                                'name' : "innodb_stats_on_metadata",
                                                'caption' : "innodb_stats_on_metadata",
                                                'default' : "ON",
                                                'versions' : ((5, 1, 17), (5, 4), (5, 5), (6, 0)),
                                                'type' : "boolean",
                                                'description' : "innodb_stats_on_metadata"
                                              },
                                              {
                                                'name' : "innodb_status_file",
                                                'caption' : "innodb_status_file",
                                                'default' : "FALSE",
                                                'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                                'type' : "boolean",
                                                'description' : "innodb_status_file"
                                              },
                                              {
                                                'name' : "innodb_support_xa",
                                                'caption' : "innodb_support_xa",
                                                'default' : "TRUE",
                                                'versions' : ((5, 0, 3), (5, 1), (5, 4), (5, 5), (6, 0)),
                                                'type' : "boolean",
                                                'description' : "innodb_support_xa"
                                              },
                                              {
                                                'outversion' : "5.4.1",
                                                'name' : "innodb_sync_spin_loops",
                                                'versions' : ((5, 0, 3), (5, 1), (5, 4), (5, 5), (6, 0)),
                                                'default' : "20",
                                                'maximum' : "4294967295",
                                                'minimum' : "0",
                                                'caption' : "innodb_sync_spin_loops",
                                                'type' : "numeric",
                                                'description' : "innodb_sync_spin_loops"
                                              },
                                              {
                                                'name' : "innodb_spin_wait_delay",
                                                'caption' : "innodb_spin_wait_delay",
                                                'default' : "6",
                                                'versions' : ((5, 1, 38), (5, 4, 2), (5, 5)),
                                                'type' : "numeric",
                                                'description' : "innodb_spin_wait_delay"
                                              },
                                              {
                                                'name' : "innodb_stats_sample_pages",
                                                'caption' : "innodb_stats_sample_pages",
                                                'default' : "8",
                                                'versions' : ((5, 1, 38), (5, 4, 2), (5, 5)),
                                                'type' : "numeric",
                                                'description' : "innodb_stats_sample_pages"
                                              },
                                              {
                                                'name' : "innodb_strict_mode",
                                                'caption' : "innodb_strict_mode",
                                                'default' : "ON",
                                                'versions' : ((5, 1, 38), (5, 4, 2), (5, 5)),
                                                'type' : "boolean",
                                                'description' : "innodb_strict_mode"
                                              },
                                              {
                                                'name' : "innodb_table_locks",
                                                'caption' : "innodb_table_locks",
                                                'default' : "TRUE",
                                                'versions' : ((4, 1, 2), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                                'type' : "boolean",
                                                'description' : "innodb_table_locks"
                                              },
                                              {
                                                'inversion' : "5.0.8",
                                                'name' : "innodb_thread_sleep_delay",
                                                'versions' : ((5, 0, 3), (5, 1), (5, 4), (5, 5), (6, 0)),
                                                'default' : "0",
                                                'outversion' : "5.0.18",
                                                'maximum' : "4294967295",
                                                'minimum' : "1000",
                                                'caption' : "innodb_thread_sleep_delay",
                                                'type' : "numeric",
                                                'description' : "innodb_thread_sleep_delay"
                                              },
                                              {
                                                'name' : "innodb_use_legacy_cardinality_algorithm",
                                                'caption' : "innodb_use_legacy_cardinality_algorithm",
                                                'default' : "ON",
                                                'versions' : ((5, 0, 82), (5, 1, 35)),
                                                'type' : "boolean",
                                                'description' : "innodb_use_legacy_cardinality_algorithm"
                                              },
                                              {
                                                'name' : "innodb_use_sys_malloc",
                                                'caption' : "innodb_use_sys_malloc",
                                                'default' : "ON",
                                                'versions' : ((5, 1, 38), (5, 4, 2), (5, 5)),
                                                'type' : "boolean",
                                                'description' : "innodb_use_sys_malloc"
                                              },
                                              {
                                                'outversion' : "5.4.2",
                                                'name' : "innodb_write_io_threads",
                                                'versions' : ((5, 1, 38), (5, 4), (5, 5)),
                                                'default' : "8",
                                                'caption' : "innodb_write_io_threads",
                                                'type' : "numeric",
                                                'description' : "innodb_write_io_threads"
                                              },
                                              {
                                                'name' : "skip-innodb",
                                                'caption' : "skip-innodb",
                                                'default' : "OFF",
                                                'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                                'type' : "boolean",
                                                'description' : "skip-innodb"
                                              },
                                              {
                                                'name' : "skip-innodb-checksums",
                                                'caption' : "skip-innodb-checksums",
                                                'default' : "OFF",
                                                'versions' : ((5, 0, 3), (5, 1), (5, 4), (5, 5), (6, 0)),
                                                'type' : "boolean",
                                                'description' : "skip-innodb-checksums"
                                              },
                                              {
                                                'name' : "timed_mutexes",
                                                'caption' : "timed_mutexes",
                                                'default' : "OFF",
                                                'versions' : ((5, 0, 3), (5, 1), (5, 4), (6, 0)),
                                                'type' : "boolean",
                                                'description' : "timed_mutexes"
                                              }
                                            ) #End of controls list in group General
                                          } #End of group General
                                        ,{'caption' : "Activate InnoDB",
                                          'controls':
                                            (
                                              {
                                                'outversion' : "5.1.35",
                                                'description' : "Enable this option only if you would like to use InnoDB tables.",
                                                'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                                'default' : "Checked",
                                                'caption' : "Activate InnoDB",
                                                'type' : "boolean",
                                                'name' : "innodb"
                                              }
                                             ,
                                            ) #End of controls list in group Activate InnoDB
                                          } #End of group Activate InnoDB
                                        ,{'caption' : "Memory",
                                          'controls':
                                            (
                                              {
                                                'name' : "innodb_additional_mem_pool_size",
                                                'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                                'default' : "2M",
                                                'maximum' : "4294967295",
                                                'minimum' : "524288",
                                                'unitcontrol' : " ;K;M;G",
                                                'caption' : "Add. mem Pool Size:",
                                                'type' : "numeric",
                                                'description' : "Size of a memory pool InnoDB uses to store data dictionary information and other internal data structures. A sensible value for this might be 2M, but the more tables you have in your application the more you will need to allocate here. If InnoDB runs out of memory in this pool, it will start to allocate memory from the operating system, and write warning messages to the MySQL error log."
                                              },
                                              {
                                                'name' : "innodb_buffer_pool_awe_mem_mb",
                                                'versions' : ((4, 1, 0), (5, 0), (5, 1)),
                                                'default' : "0",
                                                'maximum' : "63000",
                                                'minimum' : "0",
                                                'caption' : "AWE mem Pool Size:",
                                                'type' : "numeric",
                                                'description' : "You can allocate the InnoDB buffer pool into the AWE physical memory using this parameter."
                                              },
                                              {
                                                'name' : "innodb_buffer_pool_size",
                                                'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                                'default' : "16M",
                                                'maximum' : "4294967295",
                                                'minimum' : "1048576",
                                                'unitcontrol' : " ;K;M;G",
                                                'caption' : "Buffer Pool Size:",
                                                'type' : "numeric",
                                                'description' : "The bigger you set this the less disk I/O is needed to access data in tables. On a dedicated database server you may set this parameter up to 80% of the machine physical memory size. Do not set it too large, though, because competition of the physical memory may cause paging in the operating system."
                                              }
                                            ) #End of controls list in group Memory
                                          } #End of group Memory
                                        ,{'caption' : "Datafiles",
                                          'controls':
                                            (
                                              {
                                                'description' : "Paths to individual datafiles and their sizes.",
                                                'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                                'default' : "",
                                                'caption' : "Data File Path:",
                                                'type' : "filename",
                                                'name' : "innodb_data_file_path"
                                              },
                                              {
                                                'description' : "The common part of the directory path for all InnoDB datafiles. Leave this empty if you want to split the data files onto different drives.",
                                                'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                                'default' : "",
                                                'caption' : "Data directory:",
                                                'type' : "filename",
                                                'name' : "innodb_data_home_dir"
                                              },
                                              {
                                                'description' : "This option makes InnoDB to store each created table into its own .ibd file.",
                                                'versions' : ((4, 1, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                                'default' : "Unchecked",
                                                'caption' : "One File per Table",
                                                'type' : "boolean",
                                                'name' : "innodb_file_per_table"
                                              }
                                            ) #End of controls list in group Datafiles
                                          } #End of group Datafiles
                                        ,{'caption' : "Logfiles",
                                          'controls':
                                            (
                                              {
                                                'name' : "innodb_flush_log_at_trx_commit",
                                                'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                                'default' : "0",
                                                'value' : "2",
                                                'items' : {"Write to Log and flush every second":"0", "Write Log at commit, flush every second":"2", "Transaction commit flushes logs":"1"},
                                                'caption' : "Flush Log at:",
                                                'type' : "dropdownbox",
                                                'description' : "Specifies when log files are flushed to disk."
                                              },
                                              {
                                                'name' : "innodb_flush_method",
                                                'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                                'default' : "fdatasync",
                                                'items' : {"nosync (not for production systems)":"nosync", "O_DSYNC (faster, but relies on OS/drv/hdw)":"O_DSYNC", "fdatasync (safe, recommended)":"fdatasync"},
                                                'caption' : "Flush Method:",
                                                'type' : "dropdownbox",
                                                'description' : "Method used for flushing the log files to disk."
                                              },
                                              {
                                                'description' : "Directory path where log archives should be stored.",
                                                'versions' : ((4, 1), (5, 0), (5, 1)),
                                                'default' : "",
                                                'caption' : "Log Archive Dir:",
                                                'type' : "filename",
                                                'name' : "innodb_log_arch_dir"
                                              },
                                              {
                                                'description' : "This value should currently be disabled.",
                                                'versions' : ((4, 1), (5, 0), (5, 1)),
                                                'default' : "0",
                                                'items' : {"InnoDB log archive disabled":"0", "InnoDB log archive enabled":"1"},
                                                'caption' : "Log archive",
                                                'type' : "dropdownbox",
                                                'name' : "innodb_log_archive"
                                              },
                                              {
                                                'name' : "innodb_log_buffer_size",
                                                'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                                'default' : "2M",
                                                'maximum' : "4294967295",
                                                'minimum' : "1048576",
                                                'unitcontrol' : " ;K;M;G",
                                                'caption' : "Log Buffer Size:",
                                                'type' : "numeric",
                                                'description' : "The size of the buffer which InnoDB uses to write log to the log files on disk. Sensible values range from 1M to 8M. A big log buffer allows large transactions to run without a need to write the log to disk until the transaction commit. Thus, if you have big transactions, making the log buffer big will save disk I/O."
                                              },
                                              {
                                                'name' : "innodb_log_file_size",
                                                'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                                'default' : "5M",
                                                'maximum' : "4294967295",
                                                'minimum' : "1048576",
                                                'unitcontrol' : " ;K;M;G",
                                                'caption' : "Log File Size:",
                                                'type' : "numeric",
                                                'description' : "Size of each log file in a log group in megabytes. Sensible values range from 1M to 1/n-th of the size of the buffer pool specified below, where n is the number of log files in the group. The larger the value, the less checkpoint flush activity is needed in the buffer pool, saving disk I/O. But larger log files also mean that recovery will be slower in case of a crash. The combined size of log files must be less than 4 GB on 32-bit computers. The default is 5M."
                                              },
                                              {
                                                'name' : "innodb_log_files_in_group",
                                                'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                                'default' : "2",
                                                'maximum' : "100",
                                                'minimum' : "2",
                                                'caption' : "Log Files in Group:",
                                                'type' : "numeric",
                                                'description' : "Number of log files in the log group. InnoDB writes to the files in a circular fashion. Value 2 is recommended here. The default is 2."
                                              },
                                              {
                                                'description' : "Directory path to InnoDB log files.",
                                                'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                                'default' : "",
                                                'caption' : "Log Group Dir:",
                                                'type' : "filename",
                                                'name' : "innodb_log_group_home_dir"
                                              },
                                              {
                                                'name' : "innodb_mirrored_log_groups",
                                                'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                                'default' : "1",
                                                'maximum' : "10",
                                                'minimum' : "1",
                                                'caption' : "Mirrored Log Groups:",
                                                'type' : "numeric",
                                                'description' : "Number of identical copies of log groups we keep for the database. Currently this should be set to 1."
                                              }
                                            ) #End of controls list in group Logfiles
                                          } #End of group Logfiles
                                        ,{'caption' : "Various",
                                          'controls':
                                            (
                                              {
                                                'name' : "innodb_fast_shutdown",
                                                'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                                'default' : "Checked",
                                                'value' : "2",
                                                'caption' : "Fast shutdown",
                                                'type' : "boolean",
                                                'description' : "Speeds up server shutdown process."
                                              },
                                              {
                                                'name' : "innodb_file_io_threads",
                                                'versions' : ((4, 1), (5, 0), (5, 1), (6, 0)),
                                                'default' : "4",
                                                'maximum' : "64",
                                                'minimum' : "4",
                                                'caption' : "File IO Threads:",
                                                'type' : "numeric",
                                                'description' : "Number of file I/O threads in InnoDB. Normally, this should be 4, but on Windows disk I/O may benefit from a larger number."
                                              },
                                              {
                                                'name' : "innodb_force_recovery",
                                                'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                                'default' : "0",
                                                'caption' : "Force recovery",
                                                'type' : "numeric",
                                                'description' : "Helps to save your data in case the disk image of the database becomes corrupt."
                                              },
                                              {
                                                'name' : "innodb_lock_wait_timeout",
                                                'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                                'default' : "2",
                                                'maximum' : "1073741824",
                                                'minimum' : "1",
                                                'caption' : "Lock Wait Timeout:",
                                                'type' : "numeric",
                                                'description' : "Timeout in seconds InnoDB transaction may wait for a lock before being rolled back. InnoDB automatically detects transaction deadlocks in its own lock table and rolls back the transaction. If you use the LOCK TABLES command, or other transaction-safe storage engines than InnoDB in the same transaction, then a deadlock may arise which InnoDB cannot notice. In cases like this the timeout is useful to resolve the situation."
                                              },
                                              {
                                                'name' : "innodb_max_dirty_pages_pct",
                                                'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                                'default' : "90",
                                                'maximum' : "100",
                                                'minimum' : "0",
                                                'caption' : "Max Dirty Pages",
                                                'type' : "numeric",
                                                'description' : "Percentage of dirty pages allowed in bufferpool"
                                              },
                                              {
                                                'name' : "innodb_open_files",
                                                'versions' : ((4, 1, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                                'default' : "300",
                                                'maximum' : "4294967295",
                                                'minimum' : "10",
                                                'caption' : "Open Files:",
                                                'type' : "numeric",
                                                'description' : "This is relevant only if you use multiple tablespaces in InnoDB. This specifies the maximum how many .ibd files InnoDB can keep open at one time. The minimum value for this is 10. The default is 300."
                                              },
                                              {
                                                'name' : "innodb_thread_concurrency",
                                                'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                                'default' : "8",
                                                'maximum' : "1000",
                                                'minimum' : "1",
                                                'caption' : "Thread concurrency",
                                                'type' : "numeric",
                                                'description' : "Helps in performance tuning in heavily concurrent environments."
                                              }
                                            ) #End of controls list in group Various
                                          } #End of group Various
                                      ) # end of groups in tab InnoDB Parameters
                           } # end of tab InnoDB Parameters
  ,  'NDB Parameters' : { 'description' : "All relevant NDB Parameters.",
                          'position' : 8,
                          'groups':(  {'caption' : "General",
                                       'controls':
                                         (
                                           {
                                             'outversion' : "5.0.54",
                                             'name' : "ndb_autoincrement_prefetch_sz",
                                             'versions' : ((4, 1, 8), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                             'default' : "32",
                                             'maximum' : "256",
                                             'minimum' : "1",
                                             'caption' : "ndb_autoincrement_prefetch_sz",
                                             'type' : "numeric",
                                             'description' : "ndb_autoincrement_prefetch_sz"
                                           },
                                           {
                                             'name' : "ndb-batch-size",
                                             'versions' : ((5, 1, 23),),
                                             'default' : "32768",
                                             'maximum' : "31536000",
                                             'minimum' : "0",
                                             'caption' : "ndb-batch-size",
                                             'type' : "numeric",
                                             'description' : "ndb-batch-size"
                                           },
                                           {
                                             'name' : "ndb_cache_check_time",
                                             'caption' : "ndb_cache_check_time",
                                             'default' : "0",
                                             'versions' : ((4, 1), (5, 0), (5, 1)),
                                             'type' : "numeric",
                                             'description' : "ndb_cache_check_time"
                                           },
                                           {
                                             'name' : "ndb-cluster-connection-pool",
                                             'versions' : ((5, 1, 19),),
                                             'default' : "1",
                                             'maximum' : "63",
                                             'minimum' : "1",
                                             'caption' : "ndb-cluster-connection-pool",
                                             'type' : "numeric",
                                             'description' : "ndb-cluster-connection-pool"
                                           },
                                           {
                                             'description' : "ndb-connectstring",
                                             'caption' : "ndb-connectstring",
                                             'versions' : ((5, 1),),
                                             'type' : "string",
                                             'name' : "ndb-connectstring"
                                           },
                                           {
                                             'name' : "ndb_extra_logging",
                                             'caption' : "ndb_extra_logging",
                                             'default' : "0",
                                             'versions' : ((5, 1, 6),),
                                             'type' : "numeric",
                                             'description' : "ndb_extra_logging"
                                           },
                                           {
                                             'name' : "ndb_force_send",
                                             'caption' : "ndb_force_send",
                                             'default' : "TRUE",
                                             'versions' : ((4, 1, 8), (5, 0), (5, 1)),
                                             'type' : "boolean",
                                             'description' : "ndb_force_send"
                                           },
                                           {
                                             'name' : "ndb_log_updated_only",
                                             'caption' : "ndb_log_updated_only",
                                             'default' : "ON",
                                             'versions' : ((5, 1, 19),),
                                             'type' : "boolean",
                                             'description' : "ndb_log_updated_only"
                                           },
                                           {
                                             'name' : "ndb-log-update-as-write",
                                             'caption' : "ndb-log-update-as-write",
                                             'default' : "ON",
                                             'versions' : ((5, 1, 19), (5, 1, 22)),
                                             'type' : "boolean",
                                             'description' : "ndb-log-update-as-write"
                                           },
                                           {
                                             'name' : "ndb_log_empty_epochs",
                                             'caption' : "ndb_log_empty_epochs",
                                             'default' : "OFF",
                                             'versions' : ((5, 1, 31), (5, 1, 31)),
                                             'type' : "boolean",
                                             'description' : "ndb_log_empty_epochs"
                                           },
                                           {
                                             'inversion' : "5.0.45",
                                             'name' : "ndb-nodeid",
                                             'versions' : ((5, 0, 45), (5, 1, 15)),
                                             'maximum' : "63",
                                             'minimum' : "1",
                                             'caption' : "ndb-nodeid",
                                             'type' : "numeric",
                                             'description' : "ndb-nodeid"
                                           },
                                           {
                                             'name' : "ndb-mgmd-host",
                                             'caption' : "ndb-mgmd-host",
                                             'default' : "localhost:1186",
                                             'versions' : ((5, 0), (5, 1)),
                                             'type' : "string",
                                             'description' : "ndb-mgmd-host"
                                           },
                                           {
                                             'name' : "ndb_wait_connected",
                                             'versions' : ((5, 1, 16),),
                                             'default' : "0",
                                             'maximum' : "31536000",
                                             'minimum' : "0",
                                             'caption' : "ndb_wait_connected",
                                             'type' : "numeric",
                                             'description' : "ndb_wait_connected"
                                           },
                                           {
                                             'name' : "ndb-wait-setup",
                                             'versions' : ((5, 1, 39), (5, 1, 39), (5, 1, 39)),
                                             'default' : "15",
                                             'maximum' : "31536000",
                                             'minimum' : "0",
                                             'caption' : "ndb-wait-setup",
                                             'type' : "numeric",
                                             'description' : "ndb-wait-setup"
                                           },
                                           {
                                             'name' : "ndbcluster",
                                             'caption' : "ndbcluster",
                                             'default' : "FALSE",
                                             'versions' : ((4, 1), (5, 0), (5, 1)),
                                             'type' : "boolean",
                                             'description' : "ndbcluster"
                                           },
                                           {
                                             'name' : "ndb_index_stat_cache_entries",
                                             'versions' : ((4, 1), (5, 0), (5, 1), (6, 0)),
                                             'default' : "32",
                                             'maximum' : "4294967295",
                                             'minimum' : "0",
                                             'caption' : "ndb_index_stat_cache_entries",
                                             'type' : "numeric",
                                             'description' : "ndb_index_stat_cache_entries"
                                           },
                                           {
                                             'name' : "ndb_index_stat_enable",
                                             'caption' : "ndb_index_stat_enable",
                                             'default' : "ON",
                                             'versions' : ((4, 1), (5, 0), (5, 1), (6, 0)),
                                             'type' : "boolean",
                                             'description' : "ndb_index_stat_enable"
                                           },
                                           {
                                             'name' : "ndb_index_stat_update_freq",
                                             'versions' : ((4, 1), (5, 0), (5, 1), (6, 0)),
                                             'default' : "20",
                                             'maximum' : "4294967295",
                                             'minimum' : "0",
                                             'caption' : "ndb_index_stat_update_freq",
                                             'type' : "numeric",
                                             'description' : "ndb_index_stat_update_freq"
                                           },
                                           {
                                             'inversion' : "4.1.9",
                                             'name' : "ndb_optimized_node_selection",
                                             'versions' : ((4, 1, 9), (5, 0), (5, 1)),
                                             'default' : "ON",
                                             'caption' : "ndb_optimized_node_selection",
                                             'type' : "boolean",
                                             'description' : "ndb_optimized_node_selection"
                                           },
                                           {
                                             'name' : "ndb_report_thresh_binlog_epoch_slip",
                                             'versions' : ((4, 1), (5, 0), (5, 1), (6, 0)),
                                             'default' : "3",
                                             'maximum' : "256",
                                             'minimum' : "0",
                                             'caption' : "ndb_report_thresh_binlog_epoch_slip",
                                             'type' : "numeric",
                                             'description' : "ndb_report_thresh_binlog_epoch_slip"
                                           },
                                           {
                                             'name' : "ndb_report_thresh_binlog_mem_usage",
                                             'versions' : ((4, 1), (5, 0), (5, 1), (6, 0)),
                                             'default' : "10",
                                             'maximum' : "10",
                                             'minimum' : "0",
                                             'caption' : "ndb_report_thresh_binlog_mem_usage",
                                             'type' : "numeric",
                                             'description' : "ndb_report_thresh_binlog_mem_usage"
                                           },
                                           {
                                             'name' : "ndb_use_transactions",
                                             'caption' : "ndb_use_transactions",
                                             'default' : "ON",
                                             'versions' : ((4, 1, 18), (5, 0), (5, 1), (6, 0)),
                                             'type' : "boolean",
                                             'description' : "ndb_use_transactions"
                                           },
                                           {
                                             'caption' : "skip-ndbcluster",
                                             'description' : "skip-ndbcluster",
                                             'type' : "string",
                                             'name' : "skip-ndbcluster",
                                             'versions' : ((5, 1), (6, 0))
                                           }
                                         ) #End of controls list in group General
                                       } #End of group General
                                     ,                                   ) # end of groups in tab NDB Parameters
                        } # end of tab NDB Parameters
  ,  'Transactions' : { 'description' : "Transactions parameters.",
                        'position' : 9,
                        'groups':(  {'caption' : "Misc",
                                     'controls':
                                       (
                                         {
                                           'name' : "completion_type",
                                           'versions' : ((5, 0, 3), (5, 1), (5, 4), (5, 5), (6, 0)),
                                           'default' : "0",
                                           'value' : "2",
                                           'caption' : "completion_type",
                                           'type' : "numeric",
                                           'description' : "completion_type"
                                         }
                                        ,
                                       ) #End of controls list in group Misc
                                     } #End of group Misc
                                   ,                                 ) # end of groups in tab Transactions
                      } # end of tab Transactions
  ,  'Networking' : { 'description' : "All non-basic network settings",
                      'position' : 10,
                      'groups':(  {'caption' : "General",
                                   'controls':
                                     (
                                       {
                                         'description' : "Name of the socket file (Unix) or named pipe (Windows) to use.",
                                         'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                         'default' : "",
                                         'caption' : "Socket/pipe name:",
                                         'type' : "filename",
                                         'name' : "socket"
                                       }
                                      ,
                                     ) #End of controls list in group General
                                   } #End of group General
                                 ,{'caption' : "Data / Memory size",
                                   'controls':
                                     (
                                       {
                                         'name' : "max_allowed_packet",
                                         'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                         'default' : "1M",
                                         'maximum' : "1073741824",
                                         'minimum' : "1024",
                                         'unitcontrol' : " ;K;M;G",
                                         'caption' : "Max. packet size:",
                                         'type' : "numeric",
                                         'description' : "Max packetlength to send/receive from to server."
                                       },
                                       {
                                         'name' : "net_buffer_length",
                                         'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                         'default' : "16",
                                         'maximum' : "1048576",
                                         'minimum' : "1024",
                                         'unitcontrol' : " ;K;M;G",
                                         'caption' : "Net buffer length",
                                         'type' : "numeric",
                                         'description' : "Buffer length for TCP/IP and socket communication."
                                       }
                                     ) #End of controls list in group Data / Memory size
                                   } #End of group Data / Memory size
                                 ,{'caption' : "Timeout Settings",
                                   'controls':
                                     (
                                       {
                                         'outversion' : "5.0.51",
                                         'name' : "connect_timeout",
                                         'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                         'default' : "0",
                                         'minimum' : "2",
                                         'caption' : "Connection timeout",
                                         'type' : "numeric",
                                         'description' : "The number of seconds the mysqld server is waiting for a connect packet before responding with 'Bad handshake'"
                                       },
                                       {
                                         'name' : "interactive_timeout",
                                         'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                         'default' : "28800",
                                         'minimum' : "1",
                                         'caption' : "Interactive timeout",
                                         'type' : "numeric",
                                         'description' : "The number of seconds the server waits for activity on an interactive connection before closing it."
                                       },
                                       {
                                         'name' : "net_read_timeout",
                                         'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                         'default' : "30",
                                         'minimum' : "1",
                                         'caption' : "Read timeout",
                                         'type' : "numeric",
                                         'description' : "Number of seconds to wait for more data from a connection before aborting the read"
                                       },
                                       {
                                         'name' : "net_write_timeout",
                                         'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                         'default' : "60",
                                         'minimum' : "1",
                                         'caption' : "Write timeout",
                                         'type' : "numeric",
                                         'description' : "Number of seconds to wait for a block to be written to a connection  before aborting the writ"
                                       },
                                       {
                                         'name' : "wait_timeout",
                                         'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (6, 0)),
                                         'default' : "28800",
                                         'maximum' : "31536000",
                                         'minimum' : "1",
                                         'caption' : "Wait timeout",
                                         'type' : "numeric",
                                         'description' : "The number of seconds the server waits for activity on a connection before closing it"
                                       }
                                     ) #End of controls list in group Timeout Settings
                                   } #End of group Timeout Settings
                                 ,{'caption' : "Advanced",
                                   'controls':
                                     (
                                       {
                                         'name' : "max_connect_errors",
                                         'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                         'default' : "10",
                                         'bitsize' : "32",
                                         'maximum' : "4294967295",
                                         'minimum' : "1",
                                         'caption' : "Max Conn Errors:",
                                         'type' : "numeric",
                                         'description' : "If there is more than this number of interrupted connections from a host this host will be blocked from further connections."
                                       },
                                       {
                                         'outversion' : "5.1.14",
                                         'name' : "max_connections",
                                         'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                         'default' : "100",
                                         'caption' : "Max Connections:",
                                         'type' : "numeric",
                                         'description' : "The number of simultaneous clients allowed."
                                       },
                                       {
                                         'name' : "max_user_connections",
                                         'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                         'default' : "0",
                                         'maximum' : "4294967295",
                                         'minimum' : "0",
                                         'caption' : "Max Conn per User:",
                                         'type' : "numeric",
                                         'description' : "The maximum number of active connections for a single user (0 = no limit)."
                                       },
                                       {
                                         'name' : "net_retry_count",
                                         'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                         'default' : "10",
                                         'bitsize' : "32",
                                         'maximum' : "4294967295",
                                         'minimum' : "1",
                                         'caption' : "Retry count:",
                                         'type' : "numeric",
                                         'description' : "If a read on a communication port is interrupted, retry this many times before giving up."
                                       }
                                     ) #End of controls list in group Advanced
                                   } #End of group Advanced
                                 ,{'caption' : "Naming",
                                   'controls':
                                     (
                                       {
                                         'description' : "Don't cache host names.",
                                         'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                         'default' : "Unchecked",
                                         'caption' : "Disable caching of host-names",
                                         'type' : "boolean",
                                         'name' : "skip-host-cache"
                                       },
                                       {
                                         'description' : "Don't resolve hostnames. All hostnames are IP's or 'localhost'.",
                                         'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                         'default' : "Unchecked",
                                         'caption' : "Disable name resolving",
                                         'type' : "boolean",
                                         'name' : "skip-name-resolve"
                                       }
                                     ) #End of controls list in group Naming
                                   } #End of group Naming
                               ) # end of groups in tab Networking
                    } # end of tab Networking
  ,  'Replication' : { 'description' : "All replication options",
                       'position' : 11,
                       'groups':(  {'caption' : "General",
                                    'controls':
                                      (
                                        {
                                          'name' : "server-id",
                                          'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                          'default' : "0",
                                          'maximum' : "4294967295",
                                          'minimum' : "0",
                                          'caption' : "Server Id",
                                          'type' : "numeric",
                                          'description' : "Uniquely identifies the server instance in the community of replication partners."
                                        }
                                       ,
                                      ) #End of controls list in group General
                                    } #End of group General
                                  ,{'caption' : "Master",
                                    'controls':
                                      (
                                        {
                                          'name' : "auto_increment_increment",
                                          'versions' : ((5, 0, 2), (5, 1), (5, 4), (5, 5), (6, 0)),
                                          'default' : "1",
                                          'maximum' : "65535",
                                          'minimum' : "1",
                                          'caption' : "auto_increment_increment",
                                          'type' : "numeric",
                                          'description' : "auto_increment_increment"
                                        },
                                        {
                                          'name' : "auto_increment_offset",
                                          'versions' : ((5, 0, 2), (5, 1), (5, 4), (5, 5), (6, 0)),
                                          'default' : "1",
                                          'maximum' : "65535",
                                          'minimum' : "1",
                                          'caption' : "auto_increment_offset",
                                          'type' : "numeric",
                                          'description' : "auto_increment_offset"
                                        },
                                        {
                                          'description' : "master-bind",
                                          'caption' : "master-bind",
                                          'versions' : ((5, 1, 22), (5, 4), (5, 5), (6, 0)),
                                          'type' : "string",
                                          'name' : "master-bind"
                                        },
                                        {
                                          'description' : "If set, allows showing user and password via SHOW SLAVE HOSTS on master.",
                                          'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                          'default' : "Unchecked",
                                          'caption' : "Show Slave authentication Info",
                                          'type' : "boolean",
                                          'name' : "show-slave-auth-info"
                                        }
                                      ) #End of controls list in group Master
                                    } #End of group Master
                                  ,{'caption' : "General slave",
                                    'controls':
                                      (
                                        {
                                          'name' : "abort-slave-event-count",
                                          'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                          'default' : "0",
                                          'minimum' : "0",
                                          'caption' : "abort-slave-event-count",
                                          'type' : "numeric",
                                          'description' : "abort-slave-event-count"
                                        },
                                        {
                                          'name' : "disconnect-slave-event-count",
                                          'caption' : "disconnect-slave-event-count",
                                          'default' : "0",
                                          'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                          'type' : "numeric",
                                          'description' : "disconnect-slave-event-count"
                                        },
                                        {
                                          'description' : "Tells the slave to log the updates from the slave thread to the binary log. You will need to turn it on if you plan to daisy-chain the slaves.",
                                          'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                          'default' : "Unchecked",
                                          'caption' : "Log slave updates",
                                          'type' : "boolean",
                                          'name' : "log-slave-updates"
                                        },
                                        {
                                          'description' : "If set, slave is not autostarted.",
                                          'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                          'default' : "Unchecked",
                                          'caption' : "Do not start slave automaticaly",
                                          'type' : "boolean",
                                          'name' : "skip-slave-start"
                                        },
                                        {
                                          'name' : "slave-allow-batching",
                                          'caption' : "slave-allow-batching",
                                          'default' : "off",
                                          'versions' : ((5, 1, 19),),
                                          'type' : "boolean",
                                          'description' : "slave-allow-batching"
                                        },
                                        {
                                          'description' : "The location where the slave should put its temporary files when replicating a LOAD DATA INFILE command.",
                                          'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                          'default' : "",
                                          'caption' : "Temporary Directory",
                                          'type' : "filename",
                                          'name' : "slave-load-tmpdir"
                                        },
                                        {
                                          'description' : "Tells the slave thread to continue replication when a query returns an error from the provided list.",
                                          'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                          'default' : "",
                                          'caption' : "Skip the following errors:",
                                          'type' : "filename",
                                          'name' : "slave-skip-errors"
                                        },
                                        {
                                          'description' : "Use compression on master/slave protocol.",
                                          'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                          'default' : "Unchecked",
                                          'caption' : "Use compression",
                                          'type' : "boolean",
                                          'name' : "slave_compressed_protocol"
                                        },
                                        {
                                          'name' : "slave-net-timeout",
                                          'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                          'default' : "3600",
                                          'minimum' : "1",
                                          'caption' : "Slave timeout",
                                          'type' : "numeric",
                                          'description' : "Number of seconds to wait for more data from a master/slave connection before aborting the read"
                                        },
                                        {
                                          'name' : "slave_transaction_retries",
                                          'versions' : ((4, 1, 11), (5, 0, 3), (5, 1), (5, 4), (5, 5), (6, 0)),
                                          'default' : "10",
                                          'bitsize' : "32",
                                          'maximum' : "4294967295",
                                          'minimum' : "0",
                                          'caption' : "slave_transaction_retries",
                                          'type' : "numeric",
                                          'description' : "slave_transaction_retries"
                                        }
                                      ) #End of controls list in group General slave
                                    } #End of group General slave
                                  ,{'caption' : "Slave replication objects",
                                    'controls':
                                      (
                                        {
                                          'description' : "Tells the slave thread to restrict replication to the specified schemata. Note that this will only work if you do not use cross-database queries such as UPDATE some_db.some_table SET foo='bar' while having selected a different or no database. If you need cross database updates to work, make sure you have 3.23.28 or later, and use replicate-wild-do-table=db_name.%",
                                          'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                          'default' : "",
                                          'caption' : "Replicate these databases:",
                                          'type' : "filename",
                                          'name' : "replicate-do-db"
                                        },
                                        {
                                          'description' : "Tells the slave thread to restrict replication to the specified table. To specify more than one table, use the directive multiple times, once for each table. This will work for cross-database updates, in contrast to replicate-do-db.",
                                          'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                          'default' : "",
                                          'caption' : "Replicate these tables:",
                                          'type' : "filename",
                                          'name' : "replicate-do-table"
                                        },
                                        {
                                          'description' : "Tells the slave thread to not replicate to the specified database. To specify more than one database to ignore,use the directive multiple times, once for each database. This option will not work if you use cross databaseupdates. If you need cross database updates to work, make sure you have 3.23.28 or later, and use replicate-wild-ignore-table=db_name.%",
                                          'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                          'default' : "",
                                          'caption' : "Ignore DBs:",
                                          'type' : "filename",
                                          'name' : "replicate-ignore-db"
                                        },
                                        {
                                          'description' : "Tells the slave thread to not replicate to the specified table. To specify more than one table to ignore, use the directive multiple times, once for each table. This will work for cross-datbase updates, in contrast to replicate-ignore-db.",
                                          'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                          'default' : "",
                                          'caption' : "Ignore tables:",
                                          'type' : "filename",
                                          'name' : "replicate-ignore-table"
                                        },
                                        {
                                          'description' : "Updates to a database with a different name than the original. Example:replicate-rewrite-db=master_db_name->slave_db_name.",
                                          'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                          'default' : "",
                                          'caption' : "Rewrite DB names:",
                                          'type' : "filename",
                                          'name' : "replicate-rewrite-db"
                                        },
                                        {
                                          'description' : "Tells the slave thread to restrict replication to the tables that match the specified wildcard pattern. Tospecify more than one table, use the directive multiple times, once for each table. This will work for cross-database updates. Example: replicate-wild-do-table=foo%.bar% will replicate only updates to tables in all databases that start with foo and whose table names start with bar",
                                          'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                          'default' : "",
                                          'caption' : "Replicate wild these tables:",
                                          'type' : "filename",
                                          'name' : "replicate-wild-do-table"
                                        },
                                        {
                                          'description' : "Tells the slave thread to not replicate to the tables that match the given wildcard pattern. To specify more than one table to ignore, use the directive multiple times, once for each table. This will work for cross-database updates. Example: replicate-wild-ignore-table=foo%.bar% will not do updates to tables in databases that start with foo and whose table names start with bar.",
                                          'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                          'default' : "",
                                          'caption' : "Wild ignore tables:",
                                          'type' : "filename",
                                          'name' : "replicate-wild-ignore-table"
                                        }
                                      ) #End of controls list in group Slave replication objects
                                    } #End of group Slave replication objects
                                  ,{'caption' : "Slave Identification",
                                    'controls':
                                      (
                                        {
                                          'description' : "Hostname or IP of the slave to be reported to to the master during slave registration. Will appear in the output of SHOW SLAVE HOSTS. Leave unset if you do not want the slave to register itself with the master. Note that it is not sufficient for the master to simply read the IP of the slave off the socket once the slave connects. Due to NAT and other routing issues, that IP may not be valid for connecting to the slave from the master or other hosts.",
                                          'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                          'default' : "",
                                          'caption' : "Report Host:",
                                          'type' : "filename",
                                          'name' : "report-host"
                                        },
                                        {
                                          'description' : "This password will be displayed in the output of 'SHOW SLAVE HOSTS'.",
                                          'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                          'default' : "",
                                          'caption' : "Report Password:",
                                          'type' : "filename",
                                          'name' : "report-password"
                                        },
                                        {
                                          'description' : "Port for connecting to slave reported to the master during slave registration. Set it only if the slave is listening on a non-default port or if you have a special tunnel from the master or other clients to the slave. If not sure, leave this option unset.",
                                          'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                          'default' : "3306",
                                          'caption' : "Report Port",
                                          'type' : "numeric",
                                          'name' : "report-port"
                                        },
                                        {
                                          'description' : "This username will be displayed in the output of 'SHOW SLAVE HOSTS'.",
                                          'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                          'default' : "",
                                          'caption' : "Report User:",
                                          'type' : "filename",
                                          'name' : "report-user"
                                        }
                                      ) #End of controls list in group Slave Identification
                                    } #End of group Slave Identification
                                  ,{'caption' : "Relay Log",
                                    'controls':
                                      (
                                        {
                                          'name' : "max_relay_log_size",
                                          'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                          'default' : "0",
                                          'maximum' : "1073741824",
                                          'minimum' : "0",
                                          'caption' : "Maximum relay log size",
                                          'type' : "numeric",
                                          'description' : "If non-zero: relay log will be rotated automatically when the size exceeds this value; if zero (the default): when the size exceeds max_binlog_size. 0 expected, the minimum value for this variable is 4096."
                                        },
                                        {
                                          'description' : "The location and name to use for relay logs.",
                                          'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                          'default' : "",
                                          'caption' : "Relay log filename:",
                                          'type' : "filename",
                                          'name' : "relay-log"
                                        },
                                        {
                                          'description' : "The location and name to use for the file that keeps a list of the last relay logs.",
                                          'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                          'default' : "",
                                          'caption' : "Relay log index filename:",
                                          'type' : "filename",
                                          'name' : "relay-log-index"
                                        },
                                        {
                                          'description' : "The location and name of the file that remembers where the SQL replication thread is in the relay logs.",
                                          'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                          'default' : "",
                                          'caption' : "Relay log info filename:",
                                          'type' : "filename",
                                          'name' : "relay-log-info-file"
                                        },
                                        {
                                          'description' : "0 = do not purge relay logs. 1 = purge them as soon as they are no more needed.",
                                          'versions' : ((4, 1, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                          'default' : "Unchecked",
                                          'caption' : "Purge relay logs",
                                          'type' : "boolean",
                                          'name' : "relay_log_purge"
                                        },
                                        {
                                          'name' : "relay_log_space_limit",
                                          'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                          'default' : "0",
                                          'bitsize' : "32",
                                          'maximum' : "4294967295",
                                          'minimum' : "0",
                                          'caption' : "Maximum size for all relay logs together:",
                                          'type' : "numeric",
                                          'description' : "Maximum space to use for all relay logs."
                                        }
                                      ) #End of controls list in group Relay Log
                                    } #End of group Relay Log
                                  ,{'caption' : "Slave default connection values",
                                    'controls':
                                      (
                                        {
                                          'description' : "The number of seconds the slave thread will sleep before retrying to connect to the master in case the master goes down or the connection is lost.",
                                          'versions' : ((4, 1), (5, 0), (5, 1), (5, 4)),
                                          'default' : "60",
                                          'caption' : "Master connect retry",
                                          'type' : "numeric",
                                          'name' : "master-connect-retry"
                                        },
                                        {
                                          'description' : "Master hostname or IP address for replication. If not set, the slave thread will not be started. Note that the setting of master-host will be ignored if there exists a valid master.info file.",
                                          'versions' : ((4, 1), (5, 0), (5, 1), (5, 4)),
                                          'default' : "",
                                          'caption' : "Master hostname:",
                                          'type' : "filename",
                                          'name' : "master-host"
                                        },
                                        {
                                          'description' : "The location and name of the file that remembers the master and where the I/O replication thread is in the master's binlogs.",
                                          'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                          'default' : "",
                                          'caption' : "Master info file name:",
                                          'type' : "filename",
                                          'name' : "master-info-file"
                                        },
                                        {
                                          'description' : "The password the slave thread will authenticate with when connecting to the master. If not set, an empty password is assumed.The value in master.info will take precedence if it can be read.",
                                          'versions' : ((4, 1), (5, 0), (5, 1), (5, 4)),
                                          'default' : "",
                                          'caption' : "Master password:",
                                          'type' : "filename",
                                          'name' : "master-password"
                                        },
                                        {
                                          'description' : "The port the master is listening on. If not set, the compiled setting of MYSQL_PORT is assumed. If you have not tinkered with configure options, this should be 3306. The value in master.info will take precedence if it can be read.",
                                          'versions' : ((4, 1), (5, 0), (5, 1), (5, 4)),
                                          'default' : "3306",
                                          'caption' : "Master port",
                                          'type' : "numeric",
                                          'name' : "master-port"
                                        },
                                        {
                                          'description' : "The number of tries the slave will make to connect to the master before giving up.",
                                          'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                          'default' : "",
                                          'caption' : "Master retry count",
                                          'type' : "filename",
                                          'name' : "master-retry-count"
                                        },
                                        {
                                          'description' : "Enable the slave to connect to the master using SSL.",
                                          'versions' : ((4, 1), (5, 0), (5, 1), (5, 4)),
                                          'default' : "Unchecked",
                                          'caption' : "Master ssl",
                                          'type' : "boolean",
                                          'name' : "master-ssl"
                                        },
                                        {
                                          'description' : "Master SSL CA file. Only applies if you have enabled master-ssl.",
                                          'versions' : ((4, 1), (5, 0), (5, 1), (5, 4)),
                                          'default' : "",
                                          'caption' : "Master SSL CA filename:",
                                          'type' : "filename",
                                          'name' : "master-ssl-ca"
                                        },
                                        {
                                          'description' : "Master SSL CA path. Only applies if you have enabled master-ssl.",
                                          'versions' : ((4, 1), (5, 0), (5, 1), (5, 4)),
                                          'default' : "",
                                          'caption' : "Master SSL CA-path:",
                                          'type' : "filename",
                                          'name' : "master-ssl-capath"
                                        },
                                        {
                                          'description' : "Master SSL certificate file name. Only applies if you have enabled master-ssl",
                                          'versions' : ((4, 1), (5, 0), (5, 1), (5, 4)),
                                          'default' : "",
                                          'caption' : "Master SSL Certificate filename:",
                                          'type' : "filename",
                                          'name' : "master-ssl-cert"
                                        },
                                        {
                                          'description' : "Master SSL cipher. Only applies if you have enabled master-ssl.",
                                          'versions' : ((4, 1), (5, 0), (5, 1), (5, 4)),
                                          'default' : "",
                                          'caption' : "Master SSL Cipher:",
                                          'type' : "filename",
                                          'name' : "master-ssl-cipher"
                                        },
                                        {
                                          'description' : "Master SSL keyfile name. Only applies if you have enabled master-ssl.",
                                          'versions' : ((4, 1), (5, 0), (5, 1), (5, 4)),
                                          'default' : "",
                                          'caption' : "Master SSL Key:",
                                          'type' : "filename",
                                          'name' : "master-ssl-key"
                                        },
                                        {
                                          'description' : "The username the slave thread will use for authentication when connecting to the master. The user must have FILE privilege. If the master user is not set, user test is assumed. The value in master.info will take precedence if it can be read.",
                                          'versions' : ((4, 1), (5, 0), (5, 1), (5, 4)),
                                          'default' : "",
                                          'caption' : "Master Username:",
                                          'type' : "filename",
                                          'name' : "master-user"
                                        }
                                      ) #End of controls list in group Slave default connection values
                                    } #End of group Slave default connection values
                                ) # end of groups in tab Replication
                     } # end of tab Replication
  ,  'Misc' : { 'description' : "Uncategorized",
                'position' : 12,
                'groups':(  {'caption' : "Misc",
                             'controls':
                               (
                                 {
                                   'description' : " ",
                                   'caption' : "federated",
                                   'versions' : ((5, 1, 26), (5, 4), (5, 5), (6, 0, 7)),
                                   'type' : "numeric",
                                   'name' : "federated"
                                 },
                                 {
                                   'name' : "backup_history_log",
                                   'caption' : "backup_history_log",
                                   'default' : "ON",
                                   'versions' : ((5, 6), (6, 0, 8)),
                                   'type' : "boolean",
                                   'description' : " "
                                 },
                                 {
                                   'name' : "backup_history_log_file",
                                   'caption' : "backup_history_log_file",
                                   'default' : "backup_history.log",
                                   'versions' : ((5, 6), (6, 0, 8)),
                                   'type' : "filename",
                                   'description' : " "
                                 },
                                 {
                                   'name' : "backup_progress_log",
                                   'caption' : "backup_progress_log",
                                   'default' : "ON",
                                   'versions' : ((5, 6), (6, 0, 8)),
                                   'type' : "boolean",
                                   'description' : " "
                                 },
                                 {
                                   'name' : "backup_progress_log_file",
                                   'caption' : "backup_progress_log_file",
                                   'default' : "backup_progress.log",
                                   'versions' : ((5, 6), (6, 0, 8)),
                                   'type' : "filename",
                                   'description' : " "
                                 },
                                 {
                                   'description' : " ",
                                   'caption' : "backupdir",
                                   'versions' : ((5, 6), (6, 0, 7)),
                                   'type' : "filename",
                                   'name' : "backupdir"
                                 },
                                 {
                                   'description' : " ",
                                   'caption' : "bdb-home",
                                   'versions' : ((4, 1), (5, 0)),
                                   'type' : "filename",
                                   'name' : "bdb-home"
                                 },
                                 {
                                   'name' : "bdb-lock-detect",
                                   'caption' : "bdb-lock-detect",
                                   'versions' : ((4, 1), (5, 0)),
                                   'items' : {"DEFAULT":"DEFAULT", "OLDEST":"OLDEST", "RANDOM":"RANDOM", "YOUNGEST":"YOUNGEST"},
                                   'type' : "dropdownbox",
                                   'description' : " "
                                 },
                                 {
                                   'description' : " ",
                                   'caption' : "bdb-logdir",
                                   'versions' : ((4, 1), (5, 0)),
                                   'type' : "filename",
                                   'name' : "bdb-logdir"
                                 },
                                 {
                                   'name' : "bdb-no-recover",
                                   'caption' : "bdb-no-recover",
                                   'default' : "OFF",
                                   'versions' : ((4, 1), (5, 0)),
                                   'type' : "boolean",
                                   'description' : " "
                                 },
                                 {
                                   'name' : "bdb-no-sync",
                                   'caption' : "bdb-no-sync",
                                   'default' : "OFF",
                                   'versions' : ((4, 1),),
                                   'type' : "boolean",
                                   'description' : " "
                                 },
                                 {
                                   'name' : "bdb-shared-data",
                                   'caption' : "bdb-shared-data",
                                   'default' : "OFF",
                                   'versions' : ((4, 1), (5, 0)),
                                   'type' : "boolean",
                                   'description' : " "
                                 },
                                 {
                                   'description' : " ",
                                   'caption' : "bdb-tmpdir",
                                   'versions' : ((4, 1), (5, 0)),
                                   'type' : "filename",
                                   'name' : "bdb-tmpdir"
                                 },
                                 {
                                   'name' : "bdb_cache_size",
                                   'caption' : "bdb_cache_size",
                                   'versions' : ((4, 1), (5, 0)),
                                   'minimum' : "20480 ",
                                   'type' : "numeric",
                                   'description' : " "
                                 },
                                 {
                                   'name' : "bdb_max_lock",
                                   'caption' : "bdb_max_lock",
                                   'default' : "10000",
                                   'versions' : ((4, 1), (5, 0)),
                                   'type' : "numeric",
                                   'description' : " "
                                 },
                                 {
                                   'name' : "bdb_log_buffer_size",
                                   'versions' : ((4, 1), (5, 0)),
                                   'maximum' : "4294967295",
                                   'minimum' : "262144",
                                   'caption' : "bdb_log_buffer_size",
                                   'type' : "numeric",
                                   'description' : " "
                                 },
                                 {
                                   'name' : "bootstrap",
                                   'caption' : "bootstrap",
                                   'default' : "OFF",
                                   'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                   'type' : "boolean",
                                   'description' : " "
                                 },
                                 {
                                   'name' : "character-set-client-handshake",
                                   'caption' : "character-set-client-handshake",
                                   'default' : "TRUE",
                                   'versions' : ((4, 1, 15), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                   'type' : "boolean",
                                   'description' : " "
                                 },
                                 {
                                   'description' : " ",
                                   'caption' : "character-set-filesystem",
                                   'versions' : ((5, 0, 19), (5, 1, 6), (5, 4), (5, 5), (6, 0)),
                                   'type' : "string",
                                   'name' : "character-set-filesystem"
                                 },
                                 {
                                   'description' : " ",
                                   'caption' : "character-set-server",
                                   'versions' : ((4, 1, 3), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                   'type' : "string",
                                   'name' : "character-set-server"
                                 },
                                 {
                                   'description' : " ",
                                   'caption' : "character-sets-dir",
                                   'versions' : ((4, 1, 2), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                   'type' : "filename",
                                   'name' : "character-sets-dir"
                                 },
                                 {
                                   'description' : " ",
                                   'caption' : "collation-server",
                                   'versions' : ((4, 1, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                   'type' : "string",
                                   'name' : "collation-server"
                                 },
                                 {
                                   'caption' : "crash_binlog_innodb",
                                   'description' : " ",
                                   'type' : "string",
                                   'name' : "crash_binlog_innodb",
                                   'versions' : ((4, 1),)
                                 },
                                 {
                                   'name' : "div_precision_increment",
                                   'versions' : ((5, 0, 6), (5, 1), (5, 4), (5, 5), (6, 0)),
                                   'default' : "4",
                                   'maximum' : "30",
                                   'minimum' : "0",
                                   'caption' : "div_precision_increment",
                                   'type' : "numeric",
                                   'description' : " "
                                 },
                                 {
                                   'name' : "enable-locking",
                                   'caption' : "enable-locking",
                                   'default' : "FALSE",
                                   'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                   'type' : "boolean",
                                   'description' : " "
                                 },
                                 {
                                   'inversion' : "5.0.3",
                                   'name' : "engine-condition-pushdown",
                                   'versions' : ((5, 0, 3), (5, 1), (5, 4), (5, 5), (6, 0)),
                                   'default' : "OFF",
                                   'caption' : "engine-condition-pushdown",
                                   'type' : "boolean",
                                   'description' : " "
                                 },
                                 {
                                   'name' : "event-scheduler",
                                   'versions' : ((5, 1, 6), (5, 4), (5, 5), (6, 0)),
                                   'default' : "OFF",
                                   'items' : {"ON":"ON", "OFF":"OFF", "DISABLED":"DISABLED"},
                                   'caption' : "event-scheduler",
                                   'type' : "dropdownbox",
                                   'description' : " "
                                 },
                                 {
                                   'description' : " ",
                                   'caption' : "exit-info",
                                   'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                   'type' : "numeric",
                                   'name' : "exit-info"
                                 },
                                 {
                                   'name' : "ft_boolean_syntax",
                                   'caption' : "ft_boolean_syntax",
                                   'default' : "+-><()~*:""&",
                                   'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                   'type' : "string",
                                   'description' : " "
                                 },
                                 {
                                   'caption' : "help",
                                   'description' : " ",
                                   'type' : "string",
                                   'name' : "help",
                                   'versions' : ((4, 0, 24), (4, 1, 10), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0))
                                 },
                                 {
                                   'description' : " ",
                                   'caption' : "init_connect",
                                   'versions' : ((4, 1, 2), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                   'type' : "string",
                                   'name' : "init_connect"
                                 },
                                 {
                                   'description' : " ",
                                   'caption' : "init-file",
                                   'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                   'type' : "filename",
                                   'name' : "init-file"
                                 },
                                 {
                                   'description' : " ",
                                   'caption' : "init_slave",
                                   'versions' : ((4, 1, 2), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                   'type' : "string",
                                   'name' : "init_slave"
                                 },
                                 {
                                   'name' : "innodb_extra_dirty_writes",
                                   'caption' : "innodb_extra_dirty_writes",
                                   'default' : "ON",
                                   'versions' : ((5, 4),),
                                   'type' : "boolean",
                                   'description' : " "
                                 },
                                 {
                                   'name' : "innodb_max_merged_io",
                                   'caption' : "innodb_max_merged_io",
                                   'default' : "64",
                                   'versions' : ((5, 4),),
                                   'type' : "numeric",
                                   'description' : " "
                                 },
                                 {
                                   'description' : " ",
                                   'caption' : "innodb_safe_binlog",
                                   'versions' : ((4, 1, 3), (5, 0)),
                                   'type' : "boolean",
                                   'name' : "innodb_safe_binlog"
                                 },
                                 {
                                   'name' : "innodb_thread_concurrency_timer_based",
                                   'caption' : "innodb_thread_concurrency_timer_based",
                                   'default' : "ON",
                                   'versions' : ((5, 4),),
                                   'type' : "boolean",
                                   'description' : " "
                                 },
                                 {
                                   'name' : "isam",
                                   'caption' : "isam",
                                   'default' : "FALSE",
                                   'versions' : ((4, 1),),
                                   'type' : "boolean",
                                   'description' : " "
                                 },
                                 {
                                   'name' : "join_cache_level",
                                   'versions' : ((6, 0, 9),),
                                   'default' : "1",
                                   'maximum' : "8",
                                   'minimum' : "0",
                                   'caption' : "join_cache_level",
                                   'type' : "numeric",
                                   'description' : " "
                                 },
                                 {
                                   'name' : "large-pages",
                                   'caption' : "large-pages",
                                   'default' : "FALSE",
                                   'versions' : ((5, 0, 3), (5, 1), (5, 4), (5, 5), (6, 0)),
                                   'type' : "boolean",
                                   'description' : " "
                                 },
                                 {
                                   'description' : " ",
                                   'caption' : "lc-messages",
                                   'versions' : ((5, 5),),
                                   'type' : "string",
                                   'name' : "lc-messages"
                                 },
                                 {
                                   'description' : " ",
                                   'caption' : "lc-messages-dir",
                                   'versions' : ((5, 5),),
                                   'type' : "string",
                                   'name' : "lc-messages-dir"
                                 },
                                 {
                                   'name' : "log-backup-output",
                                   'versions' : ((5, 6), (6, 0, 8)),
                                   'default' : "TABLE",
                                   'items' : {"TABLE":"TABLE", "FILE":"FILE", "NONE":"NONE"},
                                   'caption' : "log-backup-output",
                                   'type' : "dropdownbox",
                                   'description' : " "
                                 },
                                 {
                                   'caption' : "log-long-format",
                                   'description' : " ",
                                   'type' : "string",
                                   'name' : "log-long-format",
                                   'versions' : ((4, 1),)
                                 },
                                 {
                                   'name' : "merge",
                                   'caption' : "merge",
                                   'default' : "TRUE",
                                   'versions' : ((4, 1, 21), (5, 0, 24), (5, 1, 12)),
                                   'type' : "boolean",
                                   'description' : " "
                                 },
                                 {
                                   'name' : "skip-isam",
                                   'caption' : "skip-isam",
                                   'default' : "OFF",
                                   'versions' : ((4, 1, 1),),
                                   'type' : "boolean",
                                   'description' : " "
                                 },
                                 {
                                   'name' : "multi_range_count",
                                   'versions' : ((5, 0, 3), (5, 1), (5, 2)),
                                   'default' : "256",
                                   'maximum' : "4294967295",
                                   'minimum' : "1",
                                   'caption' : "multi_range_count",
                                   'type' : "numeric",
                                   'description' : " "
                                 },
                                 {
                                   'name' : "mutex-deadlock-detector",
                                   'caption' : "mutex-deadlock-detector",
                                   'default' : "TRUE",
                                   'versions' : ((6, 0, 9),),
                                   'type' : "boolean",
                                   'description' : " "
                                 },
                                 {
                                   'caption' : "mysql-backup",
                                   'description' : " ",
                                   'type' : "string",
                                   'name' : "mysql-backup",
                                   'versions' : ((5, 6),)
                                 },
                                 {
                                   'name' : "old-protocol",
                                   'caption' : "old-protocol",
                                   'default' : "FALSE",
                                   'versions' : ((4, 1),),
                                   'type' : "boolean",
                                   'description' : " "
                                 },
                                 {
                                   'description' : " ",
                                   'caption' : "plugin",
                                   'versions' : ((5, 1), (5, 4), (5, 5), (6, 0)),
                                   'type' : "string",
                                   'name' : "plugin"
                                 },
                                 {
                                   'name' : "record_buffer",
                                   'versions' : (),
                                   'default' : "131072",
                                   'maximum' : "4294967295",
                                   'minimum' : "8200",
                                   'caption' : "record_buffer",
                                   'type' : "numeric",
                                   'description' : " "
                                 },
                                 {
                                   'name' : "relay_log_recovery",
                                   'caption' : "relay_log_recovery",
                                   'default' : "FALSE",
                                   'versions' : ((5, 5), (6, 0, 11)),
                                   'type' : "boolean",
                                   'description' : " "
                                 },
                                 {
                                   'description' : " ",
                                   'caption' : "secure-backup-file-priv",
                                   'versions' : ((5, 6), (6, 0), (6, 1, 11)),
                                   'type' : "string",
                                   'name' : "secure-backup-file-priv"
                                 },
                                 {
                                   'description' : " ",
                                   'caption' : "set-variable",
                                   'versions' : ((4, 1), (5, 0)),
                                   'type' : "string",
                                   'name' : "set-variable"
                                 },
                                 {
                                   'name' : "skip-bdb",
                                   'caption' : "skip-bdb",
                                   'default' : "FALSE",
                                   'versions' : ((4, 1), (5, 0)),
                                   'type' : "boolean",
                                   'description' : " "
                                 },
                                 {
                                   'caption' : "skip-merge",
                                   'description' : " ",
                                   'type' : "string",
                                   'name' : "skip-merge",
                                   'versions' : ((5, 0, 24), (5, 1, 12))
                                 },
                                 {
                                   'caption' : "skip-new",
                                   'description' : " ",
                                   'type' : "string",
                                   'name' : "skip-new",
                                   'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0))
                                 },
                                 {
                                   'caption' : "skip-partition",
                                   'description' : " ",
                                   'type' : "string",
                                   'name' : "skip-partition",
                                   'versions' : ((5, 1), (5, 4), (5, 5), (6, 0))
                                 },
                                 {
                                   'caption' : "skip-symlink",
                                   'description' : " ",
                                   'type' : "string",
                                   'name' : "skip-symlink",
                                   'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0))
                                 },
                                 {
                                   'caption' : "skip-sync-bdb-logs",
                                   'description' : " ",
                                   'type' : "string",
                                   'name' : "skip-sync-bdb-logs",
                                   'versions' : ((4, 1), (5, 0))
                                 },
                                 {
                                   'name' : "sql-bin-update-same",
                                   'caption' : "sql-bin-update-same",
                                   'default' : "FALSE",
                                   'versions' : ((4, 1),),
                                   'type' : "boolean",
                                   'description' : " "
                                 },
                                 {
                                   'name' : "sync-bdb-logs",
                                   'caption' : "sync-bdb-logs",
                                   'default' : "TRUE",
                                   'versions' : ((4, 1), (5, 0)),
                                   'type' : "boolean",
                                   'description' : " "
                                 },
                                 {
                                   'name' : "sync_master_info",
                                   'versions' : ((5, 5), (6, 0, 11)),
                                   'default' : "0",
                                   'bitsize' : "32",
                                   'maximum' : "4294967295",
                                   'minimum' : "0",
                                   'caption' : "sync_master_info",
                                   'type' : "numeric",
                                   'description' : " "
                                 },
                                 {
                                   'name' : "sync_relay_log",
                                   'versions' : ((5, 5), (6, 0, 10)),
                                   'default' : "0",
                                   'bitsize' : "32",
                                   'maximum' : "4294967295",
                                   'minimum' : "0",
                                   'caption' : "sync_relay_log",
                                   'type' : "numeric",
                                   'description' : " "
                                 },
                                 {
                                   'name' : "sync_relay_log_info",
                                   'versions' : ((5, 5), (6, 0, 11)),
                                   'default' : "0",
                                   'bitsize' : "32",
                                   'maximum' : "4294967295",
                                   'minimum' : "0",
                                   'caption' : "sync_relay_log_info",
                                   'type' : "numeric",
                                   'description' : " "
                                 },
                                 {
                                   'name' : "table_lock_wait_timeout",
                                   'versions' : ((5, 0, 10), (5, 1), (5, 4), (6, 0)),
                                   'default' : "50",
                                   'maximum' : "1073741824",
                                   'minimum' : "1",
                                   'caption' : "table_lock_wait_timeout",
                                   'type' : "numeric",
                                   'description' : " "
                                 },
                                 {
                                   'name' : "thread_pool_size",
                                   'versions' : ((6, 0, 4),),
                                   'default' : "20",
                                   'maximum' : "16384",
                                   'minimum' : "1",
                                   'caption' : "thread_pool_size",
                                   'type' : "numeric",
                                   'description' : " "
                                 },
                                 {
                                   'caption' : "version",
                                   'description' : " ",
                                   'type' : "string",
                                   'name' : "version",
                                   'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (6, 0))
                                 },
                                 {
                                   'name' : "warnings",
                                   'versions' : ((4, 1), (5, 0)),
                                   'default' : "1",
                                   'bitsize' : "32",
                                   'maximum' : "4294967295",
                                   'minimum' : "0",
                                   'caption' : "warnings",
                                   'type' : "numeric",
                                   'description' : " "
                                 },
                                 {
                                   'name' : "debug",
                                   'caption' : "debug",
                                   'default' : "'d:t:o,/tmp/mysqld.trace'",
                                   'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (6, 0)),
                                   'type' : "string",
                                   'description' : " "
                                 },
                                 {
                                   'description' : " ",
                                   'caption' : "default_time_zone",
                                   'versions' : ((4, 1), (5, 0), (5, 1), (5, 4), (5, 5), (6, 0)),
                                   'type' : "string",
                                   'name' : "default_time_zone"
                                 },
                                 {
                                   'caption' : "skip-falcon",
                                   'description' : " ",
                                   'type' : "string",
                                   'name' : "skip-falcon",
                                   'versions' : ((6, 0, 0),)
                                 },
                                 {
                                   'name' : "falcon",
                                   'caption' : "falcon",
                                   'default' : "yes",
                                   'versions' : ((6, 0, 0),),
                                   'type' : "boolean",
                                   'description' : " "
                                 },
                                 {
                                   'name' : "falcon_checkpoint_schedule",
                                   'caption' : "falcon_checkpoint_schedule",
                                   'default' : "7 * * * * *",
                                   'versions' : ((6, 0, 2),),
                                   'type' : "string",
                                   'description' : " "
                                 },
                                 {
                                   'caption' : "falcon_debug_mask",
                                   'description' : " ",
                                   'type' : "string",
                                   'name' : "falcon_debug_mask",
                                   'versions' : ((6, 0, 2),)
                                 },
                                 {
                                   'name' : "falcon_debug_server",
                                   'caption' : "falcon_debug_server",
                                   'default' : "OFF",
                                   'versions' : ((6, 0, 2),),
                                   'type' : "boolean",
                                   'description' : " "
                                 },
                                 {
                                   'name' : "falcon_disable_fsync",
                                   'caption' : "falcon_disable_fsync",
                                   'default' : "OFF",
                                   'versions' : ((6, 0, 2),),
                                   'type' : "boolean",
                                   'description' : " "
                                 },
                                 {
                                   'name' : "falcon_checksums",
                                   'caption' : "falcon_checksums",
                                   'default' : "OFF",
                                   'versions' : ((6, 0, 6),),
                                   'type' : "boolean",
                                   'description' : " "
                                 },
                                 {
                                   'outversion' : "6.0.6",
                                   'name' : "falcon_index_chill_threshold",
                                   'versions' : ((6, 0, 2),),
                                   'default' : "4",
                                   'maximum' : "1024",
                                   'minimum' : "1",
                                   'caption' : "falcon_index_chill_threshold",
                                   'type' : "numeric",
                                   'description' : " "
                                 },
                                 {
                                   'name' : "falcon_initial_allocation",
                                   'versions' : ((6, 0, 2),),
                                   'default' : "0",
                                   'minimum' : "10",
                                   'caption' : "falcon_initial_allocation",
                                   'type' : "numeric",
                                   'description' : " "
                                 },
                                 {
                                   'name' : "falcon_max_transaction_backlog",
                                   'caption' : "falcon_max_transaction_backlog",
                                   'default' : "150",
                                   'versions' : ((6, 0, 2),),
                                   'type' : "numeric",
                                   'description' : " "
                                 },
                                 {
                                   'outversion' : "6.0.9",
                                   'name' : "falcon_page_cache_size",
                                   'versions' : ((6, 0, 2),),
                                   'default' : "4194304",
                                   'caption' : "falcon_page_cache_size",
                                   'type' : "numeric",
                                   'description' : " "
                                 },
                                 {
                                   'outversion' : "6.0.5",
                                   'name' : "falcon_page_size",
                                   'versions' : ((6, 0, 2),),
                                   'default' : "4096",
                                   'value' : "32768",
                                   'caption' : "falcon_page_size",
                                   'type' : "numeric",
                                   'description' : " "
                                 },
                                 {
                                   'outversion' : "6.0.6",
                                   'name' : "falcon_record_chill_threshold",
                                   'versions' : ((6, 0, 2),),
                                   'default' : "5",
                                   'maximum' : "1024",
                                   'minimum' : "1",
                                   'caption' : "falcon_record_chill_threshold",
                                   'type' : "numeric",
                                   'description' : " "
                                 },
                                 {
                                   'outversion' : "6.0.8",
                                   'name' : "falcon_record_memory_max",
                                   'versions' : ((6, 0, 2),),
                                   'default' : "20",
                                   'caption' : "falcon_record_memory_max",
                                   'type' : "numeric",
                                   'description' : " "
                                 },
                                 {
                                   'outversion' : "6.0.9",
                                   'name' : "falcon_record_scavenge_floor",
                                   'versions' : ((6, 0, 2),),
                                   'default' : "50",
                                   'maximum' : "90",
                                   'minimum' : "10",
                                   'caption' : "falcon_record_scavenge_floor",
                                   'type' : "numeric",
                                   'description' : " "
                                 },
                                 {
                                   'name' : "falcon_record_scavenge_threshold",
                                   'versions' : ((6, 0, 2),),
                                   'default' : "67",
                                   'maximum' : "100",
                                   'minimum' : "10",
                                   'caption' : "falcon_record_scavenge_threshold",
                                   'type' : "numeric",
                                   'description' : " "
                                 },
                                 {
                                   'name' : "falcon_scavenge_schedule",
                                   'caption' : "falcon_scavenge_schedule",
                                   'default' : "15,45 * * * * *",
                                   'versions' : ((6, 0, 2),),
                                   'type' : "string",
                                   'description' : " "
                                 },
                                 {
                                   'name' : "falcon_serial_log_buffers",
                                   'versions' : ((6, 0, 2),),
                                   'default' : "10",
                                   'maximum' : "1000",
                                   'minimum' : "10",
                                   'caption' : "falcon_serial_log_buffers",
                                   'type' : "numeric",
                                   'description' : " "
                                 },
                                 {
                                   'description' : " ",
                                   'caption' : "falcon_serial_log_dir",
                                   'versions' : ((6, 0, 2),),
                                   'type' : "filename",
                                   'name' : "falcon_serial_log_dir"
                                 },
                                 {
                                   'name' : "falcon_use_sectorcache",
                                   'caption' : "falcon_use_sectorcache",
                                   'default' : "off",
                                   'versions' : ((6, 0, 6),),
                                   'type' : "boolean",
                                   'description' : " "
                                 },
                                 {
                                   'name' : "falcon_use_supernodes",
                                   'caption' : "falcon_use_supernodes",
                                   'default' : "on",
                                   'versions' : ((6, 0, 5),),
                                   'type' : "boolean",
                                   'description' : " "
                                 },
                                 {
                                   'name' : "falcon_use_deferred_index_hash",
                                   'caption' : "falcon_use_deferred_index_hash",
                                   'default' : "OFF",
                                   'versions' : ((6, 0, 4),),
                                   'type' : "boolean",
                                   'description' : " "
                                 },
                                 {
                                   'name' : "falcon_consistent_read",
                                   'caption' : "falcon_consistent_read",
                                   'default' : "ON",
                                   'versions' : ((6, 0, 4),),
                                   'type' : "boolean",
                                   'description' : " "
                                 },
                                 {
                                   'name' : "falcon_gopher_threads",
                                   'versions' : ((6, 0, 4),),
                                   'default' : "5",
                                   'minimum' : "1",
                                   'caption' : "falcon_gopher_threads",
                                   'type' : "numeric",
                                   'description' : " "
                                 },
                                 {
                                   'name' : "falcon_io_threads",
                                   'caption' : "falcon_io_threads",
                                   'default' : "2",
                                   'versions' : ((6, 0, 3),),
                                   'type' : "numeric",
                                   'description' : " "
                                 },
                                 {
                                   'description' : " ",
                                   'caption' : "falcon_large_blob_threshold",
                                   'versions' : ((6, 0, 4),),
                                   'type' : "numeric",
                                   'name' : "falcon_large_blob_threshold"
                                 },
                                 {
                                   'name' : "falcon_lock_wait_timeout",
                                   'caption' : "falcon_lock_wait_timeout",
                                   'default' : "50",
                                   'versions' : ((6, 0, 4),),
                                   'type' : "numeric",
                                   'description' : " "
                                 },
                                 {
                                   'name' : "falcon_serial_log_priority",
                                   'caption' : "falcon_serial_log_priority",
                                   'default' : "1",
                                   'versions' : ((6, 0, 4),),
                                   'type' : "boolean",
                                   'description' : " "
                                 },
                                 {
                                   'caption' : "maria",
                                   'description' : " ",
                                   'type' : "string",
                                   'name' : "maria",
                                   'versions' : ((6, 0, 6),)
                                 },
                                 {
                                   'name' : "maria-block-size",
                                   'caption' : "maria-block-size",
                                   'default' : "8192",
                                   'versions' : ((6, 0, 6),),
                                   'type' : "numeric",
                                   'description' : " "
                                 },
                                 {
                                   'caption' : "maria-checkpoint-interval",
                                   'description' : " ",
                                   'type' : "string",
                                   'name' : "maria-checkpoint-interval",
                                   'versions' : ((6, 0, 6),)
                                 },
                                 {
                                   'caption' : "maria-log-dir-path",
                                   'description' : " ",
                                   'type' : "string",
                                   'name' : "maria-log-dir-path",
                                   'versions' : ((6, 0, 6),)
                                 },
                                 {
                                   'name' : "maria-log-file-size",
                                   'versions' : ((6, 0, 6),),
                                   'default' : "1073741824",
                                   'maximum' : "4294967296",
                                   'minimum' : "8388688",
                                   'caption' : "maria-log-file-size",
                                   'type' : "numeric",
                                   'description' : " "
                                 },
                                 {
                                   'name' : "maria-log-purge-type",
                                   'versions' : ((6, 0, 6),),
                                   'default' : "immediate",
                                   'items' : {"at_flush":"at_flush", "immediate":"immediate", "external":"external"},
                                   'caption' : "maria-log-purge-type",
                                   'type' : "dropdownbox",
                                   'description' : " "
                                 },
                                 {
                                   'caption' : "maria-max-sort-file-size",
                                   'description' : " ",
                                   'type' : "string",
                                   'name' : "maria-max-sort-file-size",
                                   'versions' : ((6, 0, 6),)
                                 },
                                 {
                                   'name' : "maria-page-checksum",
                                   'versions' : ((6, 0, 6),),
                                   'default' : "on",
                                   'items' : {"on":"on", "off":"off"},
                                   'caption' : "maria-page-checksum",
                                   'type' : "dropdownbox",
                                   'description' : " "
                                 },
                                 {
                                   'name' : "maria-pagecache-age-threshold",
                                   'caption' : "maria-pagecache-age-threshold",
                                   'default' : "300",
                                   'versions' : ((6, 0, 6),),
                                   'type' : "numeric",
                                   'description' : " "
                                 },
                                 {
                                   'name' : "maria-pagecache-buffer-size",
                                   'caption' : "maria-pagecache-buffer-size",
                                   'default' : "8388608",
                                   'versions' : ((6, 0, 6),),
                                   'type' : "numeric",
                                   'description' : " "
                                 },
                                 {
                                   'name' : "maria-pagecache-division-limit",
                                   'caption' : "maria-pagecache-division-limit",
                                   'default' : "100",
                                   'versions' : ((6, 0, 6),),
                                   'type' : "numeric",
                                   'description' : " "
                                 },
                                 {
                                   'name' : "maria-repair-threads",
                                   'caption' : "maria-repair-threads",
                                   'default' : "1",
                                   'versions' : ((6, 0, 6),),
                                   'type' : "numeric",
                                   'description' : " "
                                 },
                                 {
                                   'name' : "maria-sort-buffer-size",
                                   'caption' : "maria-sort-buffer-size",
                                   'default' : "8388608",
                                   'versions' : ((6, 0, 6),),
                                   'type' : "numeric",
                                   'description' : " "
                                 },
                                 {
                                   'name' : "maria-stats-method",
                                   'versions' : ((6, 0, 6),),
                                   'default' : "nulls_unequal",
                                   'items' : {"nulls_unequal":"nulls_unequal", "nulls_equal":"nulls_equal", "nulls_ignored":"nulls_ignored"},
                                   'caption' : "maria-stats-method",
                                   'type' : "dropdownbox",
                                   'description' : " "
                                 },
                                 {
                                   'name' : "maria-sync-log-dir",
                                   'versions' : ((6, 0, 6),),
                                   'default' : "newfile",
                                   'items' : {"never":"never", "newfile":"newfile", "always":"always"},
                                   'caption' : "maria-sync-log-dir",
                                   'type' : "dropdownbox",
                                   'description' : " "
                                 },
                                 {
                                   'name' : "maria-force-start-after-recovery-failures",
                                   'caption' : "maria-force-start-after-recovery-failures",
                                   'default' : "0",
                                   'versions' : ((6, 0, 6),),
                                   'type' : "numeric",
                                   'description' : " "
                                 },
                                 {
                                   'name' : "maria-recover",
                                   'caption' : "maria-recover",
                                   'default' : "off",
                                   'versions' : ((6, 0, 6),),
                                   'type' : "boolean",
                                   'description' : " "
                                 },
                                 {
                                   'description' : " ",
                                   'caption' : "falcon_support_xa",
                                   'versions' : ((6, 0, 4),),
                                   'type' : "boolean",
                                   'name' : "falcon_support_xa"
                                 }
                               ) #End of controls list in group Misc
                             } #End of group Misc
                           ,                         ) # end of groups in tab Misc
              } # end of tab Misc

} #End of opts_list
