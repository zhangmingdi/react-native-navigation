const React = require('react');
const { PureComponent } = require('react');
const { View, Text } = require('react-native');

class ToolbarComponent extends PureComponent {
    render() {
      return (
        <View style={styles.root}>
          <Text style={styles.h1}>Top bar</Text>
        </View>
      );
    }
}

module.exports = ToolbarComponent;

const styles = {
    root: {
        flexGrow: 1,
        justifyContent: 'center',
        alignItems: 'center',
        // backgroundColor: '#f5fcff'
    },
    h1: {
        fontSize: 24,
        textAlign: 'center',
        // margin: 10
    }
}; 
