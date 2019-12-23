const React = require('react');
const { Component } = require('react');
const { View, Image, Text, StyleSheet } = require('react-native');

class CocktailDetailsScreen extends Component {
  render() {
    return (
      <View style={styles.root}>
        <View style={[styles.header, {backgroundColor: this.props.color}]}>
          <Text style={styles.title} nativeID={`title${this.props.id}Dest`}>{this.props.name}</Text>
        </View>
        <Image
          source={this.props.image}
          nativeID={`image${this.props.id}Dest`}
          style={styles.image}
          />
      </View>
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