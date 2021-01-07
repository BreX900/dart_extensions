# Flutter Extensions

Adds several extensions

### DateTime - Time

| Command | Description |
| ------- | ----------- |
| DateTime.toTimeOfDay | |
| DateTime.copyWithTimeOfDay | |

## Flutter

| Command | Description |
| ------- | ----------- |
| TargetPlatformExt.isMobile | returns bool |
| TargetPlatformExt.isDesktop | returns bool |
| InputDecoration.completeWith(...) | returns a copy of `InputDecoration` by completing it with the attributes |
| DataRow.copyWith(...) | returns a copy of `DataRow` with the new attributes |
| DataRow.completeWith(...) | returns a copy of `DataRow` by completing it with the attributes |
| DataCell.copyWith(...) | returns a copy of `DataCell` with the new attributes |
| DataCell.completeWith(...) | returns a copy of `DataCell` by completing it with the attributes |


### Widgets

#### Listenable - ChangeNotifier

| Widget | Description |
| ------- | ----------- |
| ChangeableProvider | ... |
| ChangeableBuilder | listen to a `Listenable` and construct the ui based on the changes |
| ChangeableListener | ... |
| ChangeableConsumer | to do... |
| ChangeableValueBuilder | listen to a `Listenable` and construct the ui based on the changes only if they respect the 'condition' or the value does not change |
| ChangeableValueListener | to do... |
| ChangeableValueConsumer | to do... |

#### RxStream
Listen to a `Stream` or `StreamValue` and filtering by previous e current state
Not repeat data or `AsyncSnapshot`
| Widget | Description |
| ------- | ----------- |
| RxStreamConsumer | Construct the `Widget` based on the `AsyncSnapshot` and notify change `AsyncSnapshot`  |
| RxStreamBuilder | Construct the `Widget` based on the `AsyncSnapshot` |
| RxStreamListener | Notify change `AsyncSnapshot` |
| ValueStreamConsumer | Construct the `Widget` based on the data and notify change data |
| ValueStreamBuilder | Construct the `Widget` based on the data |
| ValueStreamListener | Notify change data |

#### Basic

| Widget | Description |
| ------- | ----------- |
| FixedIndexedStack | Build the child only when the index is selected |
| SizeCopier | Update a `SizeCopierController` with the size of the child |
| SizeCopy | Create a SizedWidget taking inspiration from `SizeCopierController` |
| KeyboardRemover | Close the keyboard when use press on the screen |


