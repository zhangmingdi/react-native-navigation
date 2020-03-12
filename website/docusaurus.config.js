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
    sidebarCollapsible: false,
    footer: {
      style: 'dark',
      links: [
        {
          title: 'Docs',
          items: [
            {
              label: 'Style Guide',
              to: 'docs/doc1',
            },
            {
              label: 'Second Doc',
              to: 'docs/doc2',
            },
          ],
        },
        {
          title: 'Community',
          items: [
            {
              label: 'Stack Overflow',
              href: 'https://stackoverflow.com/questions/tagged/docusaurus',
            },
            {
              label: 'Discord',
              href: 'https://discordapp.com/invite/docusaurus',
            },
          ],
        },
        {
          title: 'Social',
          items: [
            {
              label: 'Blog',
              to: 'blog',
            },
            {
              label: 'GitHub',
              href: 'https://github.com/facebook/docusaurus',
            },
            {
              label: 'Twitter',
              href: 'https://twitter.com/docusaurus',
            },
          ],
        },
      ],
      copyright: `Copyright © ${new Date().getFullYear()} My Project, Inc. Built with Docusaurus.`,
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
