const React = require('react');
const { Component } = require('react');
const { SafeAreaView, TouchableOpacity, FlatList, View, Image, Text, StyleSheet } = require('react-native');
const Navigation = require('../../services/Navigation');
const { slice } = require('lodash');
const Screens = require('../Screens')
const data = require('../../assets/cocktails').default;

class CocktailsList extends Component {
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
      <FlatList
        style={styles.root}
        data={data}
        keyExtractor={this.keyExtractor}
        ItemSeparatorComponent={this.separatorComponent}
        renderItem={this.renderItem}
      />
    );
  }

  separatorComponent = () => <View style={styles.separator} />;

  renderItem = ({ item }) => (
    <TouchableOpacity
      activeOpacity={0.75}
      style={styles.itemContainer}
      onPress={() => Navigation.push(
        this,
        {
          component: {
            name: Screens.CocktailDetailsScreen,
            passProps: { ...item },
            options: {
              animations: {
                push: {
                  sharedElementTransitions: [
                    {
                      fromId: `image${item.id}`,
                      toId: `image${item.id}Dest`
                    },
                    {
                      fromId: `title${item.id}`,
                      toId: `title${item.id}Dest`
                    }
                  ],
                  elementTransitions: [
                    {
                      id: 'header',
                  //     alpha: {
                  //       fromValue: 0,
                  //       // to: 1, //
                  //       duration: 200,  // optional. Default value - alpha animation
                  //       startDelay: 50,  // optional. Default value - 0
                  //       interpolation: 'linear' | 'accelerateDecelerate' | 'decelerate' | 'accelerate' | 'decelerateAccelerate'
                  //     },
                      translationY: {
                        from: -150,
                        duration: 300,
                        interpolation: 'linear',
                      },
                  //     y: {
                  //       fromValue: -ALACHSON_HEIGHT,
                  //       duration: 300,
                  //       interpolation: 'linear',
                  //     }
                    }
                  ]
                }
              }
            }
          }
        }
      )}>
      <Image
        source={item.image}
        nativeID={`image${item.id}`}
        style={styles.image}
        resizeMode={'contain'}
      />
      <View style={styles.textContainer}>
        <Text style={styles.title} nativeID={`title${item.id}`}>{item.name}</Text>
        <View style={{ flexDirection: 'row' }}>
          <Text style={styles.ingredients}>{slice(item.ingredients, 0, 3).map(i => i.name).join(' • ')}</Text>
        </View>
      </View>
    </TouchableOpacity>
  )

  keyExtractor = item => item.id;
}
module.exports = CocktailsList;
const SIZE = 150;
const styles = StyleSheet.create({
  root: {
    paddingTop: 16
  },
  itemContainer: {
    backgroundColor: 'white',
    marginLeft: 16,
    marginRight: 16,
    height: SIZE,
    flexDirection: 'row',
    padding: 16,
    elevation: 4
  },
  image: {
    backgroundColor: 'white',
    height: '100%',
    width: 118,
  },
  textContainer: {
    flex: 1,
    marginLeft: 16,
  },
  title: {
    fontSize: 22
  },
  ingredients: {
    fontSize: 12,
    marginTop: 8
  },
  separator: {
    height: 16
  }
});
