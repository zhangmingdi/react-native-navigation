import isEqual from 'lodash/isEqual';
import once from 'lodash/once';
import { Platform } from 'react-native';

export class Deprecations {
  private deprecateDrawBehind = once((parentOptions: object) => {
    this.warnDeprecatedOption('drawBehind', 'Please use SafeAreaView, or ScrollView when appropriate.', parentOptions);
  });

  public onProcessOptions(key: string, parentOptions: Record<string, any>) {
    if (isEqual(key, 'drawBehind') && Platform.OS === 'ios') {
      this.deprecateDrawBehind(parentOptions);
    }
  }

  private warnDeprecatedOption(key: string, message: string, parentOptions: object) {
    // tslint:disable-next-line:no-console
    console.warn(`${key} is deprecated. ${message}`, parentOptions);
  }
}
