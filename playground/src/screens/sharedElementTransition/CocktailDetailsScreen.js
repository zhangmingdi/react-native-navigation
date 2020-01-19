const React = require('react');
const {Component} = require('react');
const {SafeAreaView, FlatList, View, Image, Text, StyleSheet} = require('react-native');

class CocktailDetailsScreen extends Component {
  static options(props) {
    return {
      animations: {
        pop: {
          content: {
            alpha: {
              from: 0,
              to: 1,
              duration: 1000
            },
            // x: {
            //   from: 450,
            //   to: 0,
            //   duration: 1000
            // }
          },
          sharedElementTransitions: [
            {fromId: 'text2', toId: `${props.name}-text`, duration: 1000},
            {fromId: 'image2', toId: `${props.name}-image`, duration: 1000, startDelay: 500}
          ],
          elementTransitions: [
            {id: `redbox`, y: {to: -150, duration: 300}}
          ]
        }
      }
    }
  }

  render() {
    return (
      <SafeAreaView>
        <View style={styles.header}>
          <View nativeID={'redbox'} style={[styles.redBackground]}>
          </View>
          <Text nativeID={'text2'} style={styles.title}>{this.props.name}</Text>
          <Image
            nativeID={'image2'}
            source={this.props.image}
            style={styles.image}
          />
        </View>
      </SafeAreaView>
    );
  }
}

module.exports = CocktailDetailsScreen;
const SIZE = 120;
const HEADER = 150;
const styles = StyleSheet.create({
  root: {

  },
  header: {
    height: HEADER,
    width: '100%',
    flexDirection: 'column-reverse'
  },
  title: {
    fontSize: 32,
    color: 'whitesmoke',
    marginLeft: 24,
    marginBottom: 16
  },
  image: {
    height: SIZE,
    width: SIZE,
    position: 'absolute',
    right: 24,
    top: HEADER / 2
  },
  redBackground: {
    height: '100%',
    width: '100%',
    position: 'absolute',
    backgroundColor: 'red'
  }
});