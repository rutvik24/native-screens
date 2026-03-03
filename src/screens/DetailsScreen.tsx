import type { RouteProp } from '@react-navigation/native';
import { useNavigation, useRoute } from '@react-navigation/native';
import { Button, StyleSheet, Text, View } from 'react-native';
import type { RootStackParamList } from '../navigation/types';

export function DetailsScreen() {
  const navigation = useNavigation();
  const { params } = useRoute<RouteProp<RootStackParamList, 'Details'>>();
  const itemId = params?.itemId;

  return (
    <View style={styles.container}>
      <Text style={styles.title}>Details</Text>
      {itemId != null && <Text style={styles.subtitle}>Item ID: {itemId}</Text>}
      <Button title="Go back" onPress={() => navigation.goBack()} />
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
  subtitle: {
    fontSize: 16,
    marginBottom: 16,
  },
});
