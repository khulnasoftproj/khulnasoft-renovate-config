local utils = import 'utils.libsonnet';

{
  packageRules: [
    // Some packages are updated by github-tags datasource.
    // So disable github-releases against those packages.
    {
      matchPackageNames: utils.githubTagsPackages,
      matchPaths: utils.khulnasoftYAMLMatchPaths,
      matchDatasources: ['github-releases'],
      enabled: false,
    },
    // By default github-tags is disabled.
    {
      matchPaths: utils.khulnasoftYAMLMatchPaths,
      matchDatasources: ['github-tags'],
      enabled: false,
    },
    // github-tags is enabled against only those packages.
    {
      matchPackageNames: utils.githubTagsPackages,
      matchPaths: utils.khulnasoftYAMLMatchPaths,
      matchDatasources: ['github-tags'],
      enabled: true,
    },
  ],
  regexManagers: [
    {
      // Update khulnasoft-installer action
      fileMatch: [
        '^\\.github/.*\\.ya?ml$',
        '^\\.circleci/config\\.yml$',
      ],
      matchStrings: [
        ' +%s *: +%s' % [utils.wrapQuote('khulnasoft_version'), utils.currentValue],
        " +%s *: +'%s'" % [utils.wrapQuote('khulnasoft_version'), utils.currentValue],
        ' +%s *: +"%s"' % [utils.wrapQuote('khulnasoft_version'), utils.currentValue],
      ],
      depNameTemplate: 'khulnasoftproj/khulnasoft',
      datasourceTemplate: 'github-releases',
    },
    {
      // Update khulnasoft-renovate-config
      fileMatch: [
        '^renovate\\.json5?$',
        '^\\.github/renovate\\.json5?$',
        '^\\.gitlab/renovate\\.json5?$',
        '^\\.renovaterc\\.json$',
        '^\\.renovaterc$',
      ],
      matchStrings: [
        '"github>khulnasoftproj/khulnasoft-renovate-config#(?<currentValue>[^" \\n\\(]+)',
        '"github>khulnasoftproj/khulnasoft-renovate-config:.*#(?<currentValue>[^" \\n\\(]+)',
        '"github>khulnasoftproj/khulnasoft-renovate-config/.*#(?<currentValue>[^" \\n\\(]+)',
      ],
      datasourceTemplate: 'github-releases',
      depNameTemplate: 'khulnasoftproj/khulnasoft-renovate-config',
    },
    utils.packageRegexManager {
      datasourceTemplate: 'github-tags',
    },
  ] + utils.pkgManagers,
}
