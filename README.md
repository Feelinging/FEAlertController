# FEAlertController

build a wheel for FeelingV2

![screenshot](https://raw.github.com/Feelinging/FEAlertController/master/screenshot.png)

### Features

- Easy to use
- Full customization

### Useage

##### import

```
#import "FEAlertController.h"
```

##### init

- title can be nil
- image can be nil
- description can be nil
- buttons maximum of 2

```
FEAlertController *alertController = [FEAlertController alertWithTitle:@"What are you doing?"
                                                                 image:[UIImage imageNamed:@"ahopps"]
                                                           description:@"Can you guess what I\'m going to do?"
                                                               buttons:@[@"Read book",@"Coding"]
                                                  highlightButtonIndex:1
                                                              callback:^(FEAlertController *alertController, NSInteger buttonIndex) {
                                                                  NSLog(@"click button index : %@", @(buttonIndex));
                                                                  [alertController dismiss];
}];
```

##### show

```
[alertController showInViewController:self];
```

##### dismiss

```
[alertController dismiss];
```

##### About these properties

![screenshot](https://raw.github.com/Feelinging/FEAlertController/master/properties.png)

### Customiz

you can use `alertController.contentView.` control all of ui elements. eg.

```
alertController.contentView.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
alertController.contentView.descriptionLabel.textColor = [UIColor redColor];
```

### CocoaPods

Will be soon...

### Licence

MIT
