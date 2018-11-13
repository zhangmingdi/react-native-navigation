const React = require('react');
const { View } = require('react-native');

module.exports = (props) => {
  return (
    <View style={{
      borderWidth: 1,
      borderColor: 'red',
      flex: 1
    }}>
      {props.children}
    </View>
  );
};
