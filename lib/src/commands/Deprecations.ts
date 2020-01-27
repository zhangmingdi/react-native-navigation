import isEqual from 'lodash/isEqual';
import once from 'lodash/once';

export class Deprecations {
  public onProcessOptions(key: string, parentOptions: Record<string, any>) {
    if (isEqual(key, 'drawBehind')) {
      this.deprecateDrawBehind(parentOptions)
    }
  }

  private deprecateDrawBehind = once((parentOptions: object) => {
    this.warnDeprecatedOption('drawBehind', 'Please use SafeAreaView, or ScrollView when appropriate.', parentOptions);
  })

  private warnDeprecatedOption(key: string, message: string, parentOptions: object) {
    console.warn(`${key} is deprecated. ${message}`, parentOptions);
  }
}
