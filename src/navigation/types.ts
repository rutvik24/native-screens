/**
 * Param list for the root native stack navigator.
 * Add params for each screen here to get type-safe navigation.navigate() and route.params.
 */
export type RootStackParamList = {
  Home: undefined;
  Details: { itemId?: string };
};

/**
 * Global type augmentation so useNavigation() and useRoute() are typed
 * without passing generics in every component.
 * @see https://reactnavigation.org/docs/typescript#specifying-default-types-for-usenavigation-link-ref-etc
 */
declare global {
  namespace ReactNavigation {
    interface RootParamList extends RootStackParamList {}
  }
}
