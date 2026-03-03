import { useNavigation } from '@react-navigation/native';
import { Button, Platform, StyleSheet, Text, View } from 'react-native';
import {
  openNativeComposeScreen,
  openNativeModalScreen,
  openNativeScreen,
  openNativeSwiftUIModalScreen,
  openNativeSwiftUIScreen,
} from '../native/NativeScreenModule';

const title = 'Native Screen (bridged)';

export function HomeScreen() {
  const navigation = useNavigation();

  const openNative = (open: (t: string, onClose: () => void) => void) => {
    open(title, () => {});
  };

  return (
    <View style={styles.container}>
      <Text style={styles.title}>Home</Text>
      <Button
        title="Go to Details"
        onPress={() => navigation.navigate('Details', { itemId: '1' })}
      />
      <Button
        title="Open Native (UIKit)"
        onPress={() => openNative(openNativeScreen)}
      />
      {Platform.OS === 'ios' && (
        <>
          <Button
            title="Open Native (SwiftUI)"
            onPress={() => openNative(openNativeSwiftUIScreen)}
          />
          <Button
            title="Open Native Modal (UIKit)"
            onPress={() => openNative(openNativeModalScreen)}
          />
          <Button
            title="Open Native Modal (SwiftUI)"
            onPress={() => openNative(openNativeSwiftUIModalScreen)}
          />
        </>
      )}
      {Platform.OS === 'android' && (
        <Button
          title="Open Native (Compose)"
          onPress={() => openNative(openNativeComposeScreen)}
        />
      )}
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    padding: 20,
  },
  title: {
    fontSize: 24,
    marginBottom: 20,
  },
});
