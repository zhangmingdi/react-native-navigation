module.exports = {
  docs: {
    'Getting Started': [
      'before-you-start',
      'installing',
      'playground-app',
      'showcases'
    ],
    'Using the app': [
      'app-launch',
      'basic-navigation',
      'advanced-navigation',
      'screen-lifecycle',
      'passing-data-to-components',
    ],
    Layouts: [
      'docs-stack',
      'docs-bottomTabs',
      'docs-sideMenu',
      'docs-externalComponent',
    ],
    Hierarchy: [
      'docs-root',
      'docs-modal',
      'docs-overlay'
    ],
    Styling: [
      'theme',
      'statusBar-docs',
      'orientation',
      'docs-animations',
      'fonts',
      'constants-docs'
    ],
    Meta: [
      'meta-contributing'
    ]
  },
  api: [
    {
      type: 'category',
      label: 'Navigation',
      items: [
        'component-api',
        'root-api',
        'stack-api',
        'modal-api',
        'overlay-api'
      ]
    },
    {
      type: 'category',
      label: 'Layouts',
      items: [
        'layout',
        'component-layout',
        'stack-layout',
        'bottomTabs-layout',
        'sideMenu-layout',
        'splitView'
      ]
    },
    {
      type: 'category',
      label: 'Options',
      items: [
        'options-api',
        'options-root',
        'bottomTabs-options',
        'bottomTab-options',
        {
          'type': 'category',
          'label': 'Stack',
          'items': [
            'stack-options',
            'title-options',
            'subtitle-options',
            'background-options',
            'backButton-options',
            'button-options',
            'iconInsets-options',
            'largeTitle-options'
          ]
        },
        'statusBar-options',
        'layout-options',
        'overlay-options',
        'sideMenu-options',
        'sideMenuSide-options',
        'splitView-options'
      ]
    },
    'events-api'
  ]
};