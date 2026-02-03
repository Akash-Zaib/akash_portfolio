class Experience {
  final String titleKey;
  final String companyKey;
  final String periodKey;
  final String descriptionKey;
  final List<String> responsibilitiesKeys;
  final bool isCurrent;

  const Experience({
    required this.titleKey,
    required this.companyKey,
    required this.periodKey,
    required this.descriptionKey,
    required this.responsibilitiesKeys,
    this.isCurrent = false,
  });
}

const List<Experience> workExperiences = [
  Experience(
    titleKey: 'expConvoTitle',
    companyKey: 'expConvoCompany',
    periodKey: 'expConvoPeriod',
    descriptionKey: 'expConvoDescription',
    responsibilitiesKeys: [
      'expConvoResp1',
      'expConvoResp2',
      'expConvoResp3',
      'expConvoResp4',
      'expConvoResp5',
    ],
    isCurrent: true,
  ),
  Experience(
    titleKey: 'expTerabitTitle',
    companyKey: 'expTerabitCompany',
    periodKey: 'expTerabitPeriod',
    descriptionKey: 'expTerabitDescription',
    responsibilitiesKeys: [
      'expTerabitResp1',
      'expTerabitResp2',
      'expTerabitResp3',
      'expTerabitResp4',
    ],
  ),
  Experience(
    titleKey: 'expVohTitle',
    companyKey: 'expVohCompany',
    periodKey: 'expVohPeriod',
    descriptionKey: 'expVohDescription',
    responsibilitiesKeys: [
      'expVohResp1',
      'expVohResp2',
      'expVohResp3',
      'expVohResp4',
    ],
  ),
];
