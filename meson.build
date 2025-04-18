project(
    'granite-7',
    'vala', 'c',
    meson_version: '>= 0.57.0',
    version: '7.7.0'
)

if meson.get_compiler('vala').version().version_compare('<0.48.0')
    error('vala compiler version 0.48.0 or newer is required.')
endif

add_project_arguments(
    '-DGETTEXT_PACKAGE="@0@"'.format(meson.project_name()),
    language: ['c']
)

if build_machine.system() == 'linux'
    vala_os_arg = ['--define=LINUX']
elif build_machine.system() == 'dragonfly'
    vala_os_arg = ['--define=DRAGON_FLY']
elif build_machine.system() == 'freebsd'
    vala_os_arg = ['--define=FREE_BSD']
elif build_machine.system() == 'netbsd'
    vala_os_arg = ['--define=NET_BSD']
elif build_machine.system() == 'windows'
    vala_os_arg = ['--define=WINDOWS']
else
    vala_os_arg = []
endif

glib_min_version = '2.50'
if build_machine.system() == 'windows'
    gio_os_dep = dependency('gio-windows-2.0', version: '>=' + glib_min_version)
else
    gio_os_dep = dependency('gio-unix-2.0', version: '>=' + glib_min_version)
endif

add_project_arguments(
    vala_os_arg,
    '--abi-stability',
    '--hide-internal',
    '--target-glib=' + glib_min_version,
    language: ['vala']
)

if get_option('gtk-stylesheets')
    add_project_arguments(
        '-D',
        'INCLUDE_GTK_STYLESHEETS',
        language: ['vala']
    )
endif

libgranite_deps = [
    dependency('gee-0.8'),
    dependency('gio-2.0', version: '>=' + glib_min_version),
    gio_os_dep,
    dependency('glib-2.0', version: '>=' + glib_min_version),
    dependency('gobject-2.0', version: '>=' + glib_min_version),
    dependency('gtk4', version: '>=4.12'),
]

pkgconfig = import('pkgconfig')
gnome = import('gnome')
i18n = import('i18n')

subdir('lib')
subdir('data')
subdir('po')

if get_option('documentation')
    subdir('doc')
endif

if get_option('demo')
    subdir('demo')
endif

gnome.post_install(
    gtk_update_icon_cache: true
)
