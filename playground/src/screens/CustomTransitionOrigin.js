const React = require('react');
const {Component} = require('react');
const {View, Text, Image, TouchableOpacity} = require('react-native');
const {Navigation} = require('react-native-navigation');
const Root = require('../components/Root');

import ViewOverflow from 'react-native-view-overflow';
import {SafeAreaView} from 'react-native';
class CustomTransitionOrigin extends Component {
  constructor(props) {
    super(props);
    this.onClickNavigationIcon = this.onClickNavigationIcon.bind(this);
  }
  static options() {
    return {
      topBar: {
        title: {
          fontFamily: 'HelveticaNeue-Italic',
          fontSize: 16
        },
        largeTitle: {
          visible: false
        },
        background: {
          translucent: true
        }
      }
    };
  }
  render() {
    return (
      <SafeAreaView style={styles.root}>
        <TouchableOpacity testID='shared_image1' activeOpacity={0.5} onPress={this.onClickNavigationIcon}>
          <Navigation.Element elementId='title1'>
            <Text style={[styles.h1]}>Custom Transition Screen</Text>
          </Navigation.Element>
        </TouchableOpacity>
        <View style={{flex: 1, justifyContent: 'flex-start'}}>
          <TouchableOpacity testID='shared_image1' activeOpacity={0.5} onPress={this.onClickNavigationIcon}>
            <Navigation.Element resizeMode='cover' elementId='image1'>
              <Image resizeMode='cover' style={styles.gyroImage} source={require('../../img/400.jpeg')} />
            </Navigation.Element>
          </TouchableOpacity>
        </View>
      </SafeAreaView>
    );
  }
  onClickNavigationIcon() {
    Navigation.push(this.props.componentId, {
      component: {
        name: 'navigation.playground.CustomTransitionDestination',
        options: {
          animations: {
            push: {
              waitForRender: true,
              content: {
                alpha: {
                  from: 0,
                  to: 1,
                  duration: 250
                }
              }
            }
          },
          customTransition: {
            animations: [
              {type: 'sharedElement', fromId: 'title1', toId: 'title2', startDelay: 0, springVelocity: 0.2, duration: 0.5},
              {
              type: 'sharedElement', fromId: 'image1', toId: 'customDestinationImage', startDelay: 0, springVelocity: 1,
              springDamping: 1, duration: 0.5, interactivePop: true
              },
              // { type: 'sharedElement', fromId: 'image2bg', toId: 'image2bgDestination', startDelay: 0, duration: 0.8 },
              // { type: 'sharedElement', fromId: 'image2', toId: 'customDestinationImage2', startDelay: 0, duration: 0.8 },
              // { fromId: 'image4', x: { to: 50 }, y: { to: 50 }, endAlpha: 0, startDelay: 0, duration: 0.8, springVelocity: 0.5 },
              // { fromId: 'customDestinationParagraph', startY: 50, startAlpha: 0, endAlpha: 1, startDelay: 0, duration: 0.8 }
            ],
            duration: 1
          }
        }
      }
    });
  }
}
module.exports = CustomTransitionOrigin;

const styles = {
  root: {
    alignItems: 'center',
    flex: 1,
    backgroundColor: '#f5fcff'
  },
  h1: {
    fontSize: 24,
    textAlign: 'center',
  },
  footer: {
    fontSize: 10,
    color: '#888'
  },
  gyroImage: {
    width: 100,
    height: 100
  }
};
