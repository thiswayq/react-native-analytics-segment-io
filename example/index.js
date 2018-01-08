import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View
} from 'react-native';
import Analytics, { AnalyticsConstants } from 'react-native-analytics-segment-io';

class example extends Component {
  componentDidMount() {
    Analytics.setup('add-segment-key-here', { [AnalyticsConstants.enableAdvertisingTracking]: true, [AnalyticsConstants.debug]: true })
      .then(() => {
        Analytics.track('test', {'foo': 'bar'}, {'ref': '123'})
      })
  }

  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>
          {`React Native Analytics Segment IO`}
        </Text>
        <Text style={styles.instructions}>
          {`Remember to add your own segment key, before running this example.`}
        </Text>
      </View>
    )
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    margin: 10,
  },
})

AppRegistry.registerComponent('example', () => example)
