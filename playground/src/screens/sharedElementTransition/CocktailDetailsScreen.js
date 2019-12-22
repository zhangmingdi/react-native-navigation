const React = require('react');
const { Component } = require('react');
const { SafeAreaView, FlatList, View, Image, Text, StyleSheet } = require('react-native');

class CocktailDetailsScreen extends Component {
  static options(props) {
    return {
      animations: {
        pop: {
          elements: [
            {type: 'sharedElement', fromId: 'text2', toId: `${props.name}-text`},
            {type: 'sharedElement', fromId: 'image2', toId: `${props.name}-image`}
          ]
        },
        duration: 0.5
      }
    }
  }

  render() {
    return (
      <SafeAreaView style={styles.root}>
        <View style={[styles.header, {backgroundColor: this.props.color}]}>
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
  }
});