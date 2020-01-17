const React = require('react');
const { Component } = require('react');
const { View, Image, Text, StyleSheet } = require('react-native');

class CocktailDetailsScreen extends Component {
  static options() {
    return {
      topBar: {
        title: {
          text: 'Cocktails'
        }
      }
    }
  }

  render() {
    return (
      <View style={styles.root}>
        <View nativeID={'header'} style={[styles.header, { backgroundColor: this.props.color }]}>
          <Text style={styles.title} nativeID={`title${this.props.id}Dest`}>{this.props.name}</Text>
        </View>
        <Image
          source={this.props.image}
          nativeID={`image${this.props.id}Dest`}
          style={styles.image}
        />
        <Text
          nativeID='description'
          style={styles.description}>
          {this.props.description}
        </Text>
      </View>
    );
  }
}

module.exports = CocktailDetailsScreen;
const SIZE = 120;
const HEADER = 150;
const IMAGE_OFFSET = 52
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
  description: {
    fontSize: 16,
    lineHeight: 22,
    marginTop: 32,
    marginHorizontal: 24
  },
  image: {
    height: SIZE,
    width: SIZE,
    position: 'absolute',
    right: 24,
    top: IMAGE_OFFSET
  }
});