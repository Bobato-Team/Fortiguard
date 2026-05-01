vdom_settings = {
  {
    ['engref'] = 0,
    ['vfid'] = 0,
    ['name'] = 'root',
    ['fwpolicy-implicit-log'] = true,
    ['fwpolicy6-implicit-log'] = true,
    ['report-source'] = 0,
    ['ngfw'] = false,
    ['sig-hold-time'] = 24,
    ['override-sig-hold'] = true,
    ['report-source'] = 0,
  },
}

views = {
  {
    ['engref'] = 1,
    ['policy-id'] = 1,
    ['type'] = 0,
    ['logopt'] = 'utm',
    ['ngfw'] = false,
    ['ssl-enable'] = false,
    ['protocol-options'] = {
        ['antivirus-heuristic-mode'] = 'block',
        ['strip-xff'] = false,
        ['http-range-block'] = false,
        ['oversize-log'] = true,
        ['ssl-offload'] = {
            ['http'] = true,
        },
        ['flowav-maxfilesz'] = 1024 * 1024 * 10,
        ['flowav-oversize'] = {
            ['http'] = true,
        },
    },
    ['ssl'] = 0,
    ['appctrl'] = 0,
    ['ips'] = 0,
    ['av'] = 0,
    ['webf'] = 0,
    ['vdom'] = 0,
  },
}

av_profiles = {
}


app_lists = {
  {
    ['engref'] = 0,
    ['vdom'] = 0,
    ['other-log'] = true,
    ['other-act'] = 'pass',
    ['unknown-log'] = false,
    ['unknown-act'] = 'pass',
    ['block-page'] = true,
    ['deep-appctrl'] = true,
    ['enforce-app-def-port'] = false,
    ['control-def-services'] = false,
    ['extended-log'] = true,
    ['options'] = {
        'allow-dns', 'allow-ssl', 'allow-quic',
    },
    ['entries'] = {
      {
        ['application'] = {

          },
          ['log'] = true,
          ['logpkt'] = false,
          ['action'] = 'pass',
      },
    },
  },
}
ips_sensors = {
  {
    ['engref'] = 0,
    ['vdom'] = 0,
    ['block-malicious-url'] = true,
    ['scan-botnet-connections'] = 'block',
    ['entries'] = {
    },
  },
}
ssl_cfgs = {}
webf_profiles = {}
dnsf_profiles = {}
spamf_profiles = {}
dlp_sensors = {}
gtp_profiles = {}
filefilter_profiles = {}
voip_profiles = {}
urlfilter_tables = {}
domain_filter_tables = {}
web_bword_tables = {}
web_content_header_tables = {}
spfbword_tables = {}
spfbwl_tables = {}
spfmheader_tables = {}
spfrpl_tables = {}
spfiptrust_tables = {}
dlp_filepattern_tables = {}
fw_vip = {}
fw_vip6 = {}
fw_vipgrp = {}
fw_vipgrp6 = {}
sched_recurring = {}
sched_onetime = {}
sched_group = {}
fw_addr4 = {}
fw_addr6 = {}
fw_addr6_templ = {}
fw_addrgrp4 = {}
fw_addrgrp6 = {}
ext_resources = {}
prematch_policy = {}
shaping_policy = {}
isdb_custom = {}
isdb_entry = {};
