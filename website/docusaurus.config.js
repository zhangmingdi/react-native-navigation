module.exports = {
  title: 'React Native Navigation',
  tagline: '',
  url: 'https://your-docusaurus-test-site.com',
  baseUrl: '/',
  favicon: 'img/favicon.ico',
  organizationName: 'wix', // Usually your GitHub org/user name.
  projectName: 'react-native-navigation', // Usually your repo name.
  themeConfig: {
    prism: {
      // theme: require('prism-react-renderer/themes/vsDark'),
      theme: require('prism-react-renderer/themes/nightOwl'),
      // theme: require('prism-react-renderer/themes/dracula'),
    },
    navbar: {
      title: 'React Native Navigation',
      logo: {
        alt: 'React Native Navigation Logo',
        src: 'img/logo.png',
      },
      links: [
        {to: 'docs/installing', label: 'Docs', position: 'left'},
        {to: 'docs/modal-api', label: 'API', position: 'left'},
        {
          href: 'https://github.com/wix/react-native-navigation',
          label: 'GitHub',
          position: 'right',
        },
      ],
    },
    algolia: {
      appId: '1SHXNOQYNQ',
      apiKey: '185e6a838e4ddf712a214e740ebb2a0d',
      indexName: 'react-native-navigation'
    },
    sidebarCollapsible: false,
    footer: {
      style: 'dark',
      links: [
        {
          title: 'Docs',
          items: [
            {
              label: 'Installation',
              to: 'docs/installing',
            },
            {
              label: 'Basic Navigation',
              to: 'docs/basic-navigation',
            },
            {
              label: 'Contributing',
              to: 'docs/contributing',
            }
          ],
        },
        {
          title: 'Support',
          items: [
            {
              label: 'Ask a question on Stack Overflow',
              href: 'https://stackoverflow.com/questions/tagged/wix-react-native-navigation',
            },
            {
              label: 'Community chat on Discord',
              href: 'https://discord.gg/DhkZjq2',
            },
            {
              label: 'Submit on issue on GitHub',
              href: 'https://github.com/wix/react-native-navigation/issues/new/choose',
            }
          ],
        },
        {
          title: 'Social',
          items: [
            {
              label: 'GitHub',
              href: 'https://github.com/wix/react-native-navigation',
            },
            // {
            //   label: 'Twitter',
            //   href: 'https://twitter.com/docusaurus',
            // },
          ],
        },
      ]
    },
  },
  presets: [
    [
      '@docusaurus/preset-classic',
      {
        docs: {
          sidebarPath: require.resolve('./sidebars.js'),
          editUrl:
            'https://github.com/facebook/docusaurus/edit/master/website/',
        },
        theme: {
          customCss: require.resolve('./src/css/custom.css'),
        },
      },
    ],
  ],
};
