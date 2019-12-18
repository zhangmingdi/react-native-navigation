const React = require('react');
const {Component} = require('react');
const {View, TouchableOpacity, Image, Text ,SafeAreaView} = require('react-native');
const {Navigation} = require('react-native-navigation');
import ViewOverflow from 'react-native-view-overflow';
const Root = require('../components/Root');

class CustomTransitionDestination extends Component {
  constructor(props) {
    super(props);
    this.pop = this.pop.bind(this);
    this.push = this.push.bind(this);
  }

  static options() {
    return {
      topBar: {
        title: {
          text: 'Shared Element Transition',
          fontFamily: 'HelveticaNeue-Italic'
        },
        backButton: {
          transition: 'custom'
        },
        largeTitle: {
          visible: false
        }
      },
      animations: {
        pop: {
          content: {
            alpha: {
              from: 1,
              to: 0,
              duration: 250
            }
          }
        }
      }
    };
  }
  push() {
    Navigation.push(this.props.componentId, {
      component: {
        name: 'navigation.playground.OptionsScreen'
      }
    });
  }
  pop() {
    Navigation.pop(this.props.componentId, {
      customTransition: {
        animations: [
          {type: 'sharedElement', fromId: 'title2', toId: 'title1', startDelay: 0, springVelocity: 0.2, duration: 0.5},
          {type: 'sharedElement', toId: 'image1', fromId: 'customDestinationImage', startDelay: 0, springVelocity: 0.2, duration: 0.5}
        ],
        duration: 0.8
      }
    });
  }
  render() {
    return (
      <SafeAreaView style={styles.root}>
        <View>
          <Navigation.Element resizeMode={'cover'} elementId={'customDestinationImage'}>
            <Image resizeMode='cover' source={require('../../img/400.jpeg')} />
          </Navigation.Element>

          <Navigation.Element elementId={'title2'}>
              <Text style={[styles.h1]}>{`Custom Transition Screen`}</Text>
            </Navigation.Element>

        </View>
      </SafeAreaView>
    );
  }
}
module.exports = CustomTransitionDestination;

const styles = {
  root: {
    backgroundColor: '#ff00ff',
    flex: 1,
    alignItems: 'center',
  },
  h1: {
    fontSize: 24,
    textAlign: 'center',
    color: '#00ff00'
  },
  p: {
    fontSize: 14,
    textAlign: 'left'
  },
  footer: {
    fontSize: 10,
    color: '#888'
  }
};
