local utils = import 'utils.libsonnet';

{
  regexManagers: [
    {
      fileMatch: ['{{arg0}}'],
      matchStrings: [
        'raw\\.githubusercontent\\.com/khulnasoftproj/khulnasoft-installer/%s/khulnasoft-installer' % utils.currentValue,
      ],
      datasourceTemplate: 'github-releases',
      depNameTemplate: 'khulnasoftproj/khulnasoft-installer',
    },
    {
      fileMatch: ['{{arg0}}'],
      matchStrings: [
        'khulnasoft-installer +(\\| +(ba|z)?sh +-s +-- +)?(-i +\\S+ +)?-v +%s\\s' % utils.currentValue,
        "khulnasoft-installer +(\\| +(ba|z)?sh +-s +-- +)?(-i +\\S+ +)?-v +'%s'\\s" % utils.currentValue,
        'khulnasoft-installer +(\\| +(ba|z)?sh +-s +-- +)?(-i +\\S+ +)?-v +"%s"\\s' % utils.currentValue,
      ],
      datasourceTemplate: 'github-releases',
      depNameTemplate: 'khulnasoftproj/khulnasoft',
    },
  ],
}
