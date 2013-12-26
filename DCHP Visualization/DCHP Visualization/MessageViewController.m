//
//  MessageViewController.m
//  DCHP Visualization
//
//  Created by Nikolay Shatilo on 26.12.13.
//  Copyright (c) 2013 Nikolay Shatilo. All rights reserved.
//

#import "MessageViewController.h"
#import "OtherMessageViewController.h"

@interface MessageViewController ()

@property (strong, nonatomic) IBOutlet UILabel *messageLabel;
@property (strong, nonatomic) IBOutlet UILabel *srcdestLabel;
@property (strong, nonatomic) IBOutlet UILabel *opLabel;
@property (strong, nonatomic) IBOutlet UILabel *htypeLabel;
@property (strong, nonatomic) IBOutlet UILabel *hlenLabel;
@property (strong, nonatomic) IBOutlet UILabel *hopsLabel;
@property (strong, nonatomic) IBOutlet UILabel *xidLabel;
@property (strong, nonatomic) IBOutlet UILabel *secsLabel;
@property (strong, nonatomic) IBOutlet UILabel *flagsLabel;
@property (strong, nonatomic) IBOutlet UILabel *ciaddrLabel;
@property (strong, nonatomic) IBOutlet UILabel *yiaddrLabel;
@property (strong, nonatomic) IBOutlet UILabel *siaddrLabel;
@property (strong, nonatomic) IBOutlet UILabel *giaddrLabel;
@property (strong, nonatomic) IBOutlet UILabel *chaddrLabel;
@property (strong, nonatomic) IBOutlet UILabel *snameLabel;
@property (strong, nonatomic) IBOutlet UILabel *fileLabel;
@property (strong, nonatomic) IBOutlet UILabel *option1Label;
@property (strong, nonatomic) IBOutlet UILabel *option2Label;
@property (strong, nonatomic) IBOutlet UILabel *option3Label;
@property (strong, nonatomic) IBOutlet UILabel *option4Label;
@property (strong, nonatomic) IBOutlet UILabel *option5Label;

@end

@implementation MessageViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Сообщение";

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Другие сообщения" style:UIBarButtonItemStyleDone target:self action:@selector(showOtherMessages)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showOtherMessages
{
    OtherMessageViewController *viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"OtherMessagesView"];
    
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    switch (self.stepNumber) {
        case 1: {
            self.messageLabel.text = @"DISCOVER";
            self.srcdestLabel.text = @"UDP Src=0.0.0.0 Dest=255.255.255.255";
            self.opLabel.text = @"0x01";
            self.htypeLabel.text = @"0x01";
            self.hlenLabel.text = @"0x06";
            self.hopsLabel.text = @"0x00";
            self.xidLabel.text = @"0x3903F326";
            self.secsLabel.text = @"0x0000";
            self.flagsLabel.text = @"0x0000";
            self.ciaddrLabel.text = @"0x00000000";
            self.yiaddrLabel.text = @"0x00000000";
            self.siaddrLabel.text = @"0x00000000";
            self.giaddrLabel.text = @"0x00000000";
            self.chaddrLabel.text = @"0x00000001d6057ed80";
            self.snameLabel.text = @"пустое поле";
            self.fileLabel.text = @"пустое поле";
            self.option1Label.text = @"Опция DHCP 53: обнаружение DHCP";
            self.option2Label.text = @"Опция DHCP 50: запросс адресса 192.168.0.2";
            self.option3Label.hidden = YES;
            self.option4Label.hidden = YES;
            self.option5Label.hidden = YES;
            

        } break;
            
        case 2: {
            self.messageLabel.text = @"OFFER";
            self.srcdestLabel.text = @"UDP Src=192.168.0.1 Dest=255.255.255.255";
            self.opLabel.text = @"0x02";
            self.htypeLabel.text = @"0x01";
            self.hlenLabel.text = @"0x06";
            self.hopsLabel.text = @"0x00";
            self.xidLabel.text = @"0x3903F326";
            self.secsLabel.text = @"0x0000";
            self.flagsLabel.text = @"0x0000";
            self.ciaddrLabel.text = @"0x00000000";
            self.yiaddrLabel.text = @"0xC0A80164";
            self.siaddrLabel.text = @"0xC0A80101";
            self.giaddrLabel.text = @"0x00000000";
            self.chaddrLabel.text = @"0x00000001d6057ed80";
            self.snameLabel.text = @"пустое поле";
            self.fileLabel.text = @"пустое поле";
            self.option1Label.text = @"Опция DHCP 53: предложение DHCP";
            self.option2Label.text = @"Опция DHCP  1: маска подсети 255.255.255.0";
            self.option3Label.text = @"Опция DHCP  3: маршрутизатор";
            self.option4Label.text = @"Опция DHCP 51: сроки оренды IP адресса - 1 день";
            self.option5Label.text = @"Опция DHCP 54: DCHP сервер 192.168.0.1";

        } break;
            
        case 4:
        case 7:
        {
            self.messageLabel.text = @"REQUEST";
            self.srcdestLabel.text = @"UDP Src=0.0.0.0 Dest=255.255.255.255";
            self.opLabel.text = @"0x01";
            self.htypeLabel.text = @"0x01";
            self.hlenLabel.text = @"0x06";
            self.hopsLabel.text = @"0x00";
            self.xidLabel.text = @"0x3903F326";
            self.secsLabel.text = @"0x0000";
            self.flagsLabel.text = @"0x0000";
            self.ciaddrLabel.text = @"0x00000000";
            self.yiaddrLabel.text = @"0x00000000";
            self.siaddrLabel.text = @"0x00000000";
            self.giaddrLabel.text = @"0x00000000";
            self.chaddrLabel.text = @"0x00000001d6057ed80";
            self.snameLabel.text = @"пустое поле";
            self.fileLabel.text = @"пустое поле";
            self.option1Label.text = @"Опция DHCP 53: запрос DHCP";
            self.option2Label.text = @"Опция DHCP 50: запрос адресса 192.168.0.2";
            self.option3Label.text = @"Опция DHCP 54: DCHP сервер 192.168.0.1";
            self.option4Label.hidden = YES;
            self.option5Label.hidden = YES;

        } break;
            
        case 5:
        case 8:
        {
            self.messageLabel.text = @"ACK";
            self.srcdestLabel.text = @"UDP Src=192.168.0.1 Dest=255.255.255.255";
            self.opLabel.text = @"0x02";
            self.htypeLabel.text = @"0x01";
            self.hlenLabel.text = @"0x06";
            self.hopsLabel.text = @"0x00";
            self.xidLabel.text = @"0x3903F326";
            self.secsLabel.text = @"0x0000";
            self.flagsLabel.text = @"0x0000";
            self.ciaddrLabel.text = @"0x00000000";
            self.yiaddrLabel.text = @"0xC0A80164";
            self.siaddrLabel.text = @"0x00000000";
            self.giaddrLabel.text = @"0x00000000";
            self.chaddrLabel.text = @"0x00000001d6057ed80";
            self.snameLabel.text = @"пустое поле";
            self.fileLabel.text = @"пустое поле";
            self.option1Label.text = @"Опция DHCP 53: подтверждение DHCP";
            self.option2Label.text = @"Опция DHCP  1: маска подсети 255.255.255.0";
            self.option3Label.text = @"Опция DHCP  3: маршрутизатор 192.168.0.1";
            self.option4Label.text = @"Опция DHCP 51: сроки оренды IP адресса - 1 день";
            self.option5Label.text = @"Опция DHCP 54: DCHP сервер 192.168.0.1";
        } break;
            
        default:
            break;
    }
}


@end
