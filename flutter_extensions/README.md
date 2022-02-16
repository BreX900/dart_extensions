# Flutter Extensions

| Widgets            | Description                                                          |
|--------------------|----------------------------------------------------------------------|
| AspectRatioBuilder | Build the widget with the dimension from an aspect ratio             |
| FixedIndexedStack  | Build the child only when the index is selected                      |
| InkStack           | Add [InkWell] on image                                               |
| KeyboardRemover    | Close the keyboard when use press on the screen                      |
| SizeCopier         | Copy the widget size into `SizeCopierController`                     |
| SizeCopy           | Read the widget size into `SizeCopierController` and build the child |

| Enums             |
|-------------------|
| TargetPlatform    |
 | AppLifecycleState |

### BuildContext
| Command          | Description                                               |
|------------------|-----------------------------------------------------------|
| theme            | The [ThemeData] instance from the closest context.        |
| defaultTextStyle | The [DefaultTextStyle] instance from the closest context. |
| iconTheme        | The [IconThemeData] instance from the closest context.    |
| localizations    | The [Localizations] instance from the closest context.    |
| locale           | The [Locale] instance from the closest context.           |
| navigator        | The [Navigator] instance from the closest context.        |
| tryRead          | Returns the read value if it exists otherwise null.       |
| tryWatch         | Returns the watch value if it exists otherwise null.      |

### DateTime - Time

| Command                    | Description               |
|----------------------------|---------------------------|
| DateTime.toTimeOfDay       | Convert it ot [TimeOfDay] |
| DateTime.copyWithTimeOfDay | Copy with [timeOfDay]     |

### Size
| Command  | Description           |
|----------|-----------------------|
| copyWith | Copy with new values. |

### InputDecoration
| Command                           | Description                                                              |
|-----------------------------------|--------------------------------------------------------------------------|
| InputDecoration.completeWith(...) | returns a copy of `InputDecoration` by completing it with the attributes |

### Table
| Command                    | Description                                                       |
|----------------------------|-------------------------------------------------------------------|
| DataRow.copyWith(...)      | returns a copy of `DataRow` with the new attributes               |
| DataRow.completeWith(...)  | returns a copy of `DataRow` by completing it with the attributes  |
| DataCell.copyWith(...)     | returns a copy of `DataCell` with the new attributes              |
| DataCell.completeWith(...) | returns a copy of `DataCell` by completing it with the attributes |

## Widgets

| Widget                    | Description                                         |
|---------------------------|-----------------------------------------------------|
| FillSingleChildScrollView | Allows you to use flex widgets within a scroll view |

#### Listenable - ChangeNotifier

| Widget                  | Description                                                                                                                          |
|-------------------------|--------------------------------------------------------------------------------------------------------------------------------------|
| ChangeableProvider      | ...                                                                                                                                  |
| ChangeableBuilder       | listen to a `Listenable` and construct the ui based on the changes                                                                   |
| ChangeableListener      | ...                                                                                                                                  |
| ChangeableConsumer      | to do...                                                                                                                             |
| ChangeableValueBuilder  | listen to a `Listenable` and construct the ui based on the changes only if they respect the 'condition' or the value does not change |
| ChangeableValueListener | to do...                                                                                                                             |
| ChangeableValueConsumer | to do...                                                                                                                             |

#### RxStream
Listen to a `Stream` or `StreamValue` and filtering by previous e current state
Not repeat data or `AsyncSnapshot`

| Widget              | Description                                                                           |
|---------------------|---------------------------------------------------------------------------------------|
| RxStreamConsumer    | Construct the `Widget` based on the `AsyncSnapshot` and notify change `AsyncSnapshot` |
| RxStreamBuilder     | Construct the `Widget` based on the `AsyncSnapshot`                                   |
| RxStreamListener    | Notify change `AsyncSnapshot`                                                         |
| ValueStreamConsumer | Construct the `Widget` based on the data and notify change data                       |
| ValueStreamBuilder  | Construct the `Widget` based on the data                                              |
| ValueStreamListener | Notify change data                                                                    |


