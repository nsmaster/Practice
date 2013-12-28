//
//  ViewController.m
//  DCHP Visualization
//
//  Created by Nikolay Shatilo on 22.12.13.
//  Copyright (c) 2013 Nikolay Shatilo. All rights reserved.
//

#import "ViewController.h"
#import "CloudView.h"
#import "MessageViewController.h"

@interface ViewController ()
{
    CGPoint startPoint;
    CGPoint endPoint;
    NSTimeInterval timeInterfal;

}
@property (strong, nonatomic) IBOutlet UIImageView *serverImage;
@property (strong, nonatomic) IBOutlet UIImageView *clientImage;
@property (strong, nonatomic) IBOutlet UILabel *stepDescriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *clientIpLabel;
@property (strong, nonatomic) IBOutlet UIButton *startButton;
@property (strong, nonatomic) IBOutlet UIButton *messageButton;

@property (nonatomic, strong) CloudView *cloudView;

@end

@implementation ViewController

NSString * const firstIpAddressText = @"IP: 192.168.0.2 MASK: 255.255.255.0 DHCP: 192.168.0.1";

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    timeInterfal = 5.0f;
    
    if(self.stepNumber != 0) {
        [self.startButton setTitle:@"Далее" forState:UIControlStateNormal];
        
        self.cloudView = [CloudView createInstance];
        [self.view addSubview:self.cloudView];
    }
    
    if(self.stepNumber == 9) {
        [self.startButton setTitle:@"К началу" forState:UIControlStateNormal];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    if(self.cloudView) {
        startPoint = CGPointMake(self.serverImage.center.x + 140, 250);
        endPoint = CGPointMake(self.clientImage.center.x + 140, 250);
        
        self.cloudView.hidden = NO;
    }
    
    switch (self.stepNumber) {
        case 0:
            self.title = @"Главная";
            self.stepDescriptionLabel.text = @"Реализация программного комплекса визуализации работы протокола DHCP";
            break;
            
        case 1:
            self.title = @"Шаг 1";
            self.stepDescriptionLabel.text = @"1.	Компьютер-клиент посылает сообщение discover, которое широковещательно распространяется по локальной сети и передается всем DHCP-серверам частной интерсети";
            self.cloudView.text = @"discover";
            self.cloudView.center = endPoint;
            self.messageButton.hidden = NO;
            break;
            
        case 2:
            self.title = @"Шаг 2";
            self.stepDescriptionLabel.text = @"2.	DHCP-сервер, получивший это сообщение, отвечает на него сообщением offer, содержащее IP-адрес и конфигурационную информацию";
            self.cloudView.center = startPoint;
            self.cloudView.text = @"offer: 192.168.0.2";
            self.messageButton.hidden = NO;
            break;
            
        case 3:
            self.title = @"Шаг 3";
            self.stepDescriptionLabel.text = @"3.	Компьютер-клиент переходит в состояние select и собирает конфигурационные предложения от DHCP-серверов";
            self.cloudView.center = endPoint;
            self.cloudView.text = @"select";
            break;
            
        case 4:
            self.title = @"Шаг 4";
            self.stepDescriptionLabel.text = @"4.	Клиент выбирает одно из этих предложений и отправляет сообщение request тому DHCP-серверу, чье предложение было выбрано";
            self.cloudView.center = endPoint;
            self.cloudView.text = @"request";
            self.messageButton.hidden = NO;
            break;
            
        case 5:
            self.title = @"Шаг 5";
            self.stepDescriptionLabel.text = @"5.	Выбранный DHCP-сервер посылает сообщение DHCP acknowledgment, содержащее IP-адрес и параметры сетевой конфигурации";
            self.cloudView.center = startPoint;
            self.cloudView.text = @"ack: 192.168.0.2";
            self.messageButton.hidden = NO;
            break;
            
        case 6:
            self.title = @"Шаг 6";
            self.stepDescriptionLabel.text = @"6.	Клиент переходит в состояние link, находясь в котором он может принимать участие в работе сети TCP/IP";
            self.cloudView.center = endPoint;
            self.cloudView.text = @"link";
            self.clientIpLabel.text = firstIpAddressText;
            self.clientIpLabel.hidden = NO;
            break;
            
        case 7:
            self.title = @"Шаг 7";
            self.stepDescriptionLabel.text = @"7.	При приближении момента истечения срока аренды адреса компьютер пытается обновить параметры аренды у DHCP-сервера";
            self.cloudView.center = endPoint;
            self.cloudView.text = @"request";
            self.clientIpLabel.text = firstIpAddressText;
            self.clientIpLabel.hidden = NO;
            self.messageButton.hidden = NO;
            break;
            
        case 8:
            self.title = @"Шаг 8";
            self.stepDescriptionLabel.text = @"8.	Если этот IP-адрес не может быть выделен снова, то ему возвращается другой IP-адрес";
            self.cloudView.center = startPoint;
            self.cloudView.text = @"ack: 192.168.0.3";
            self.clientIpLabel.text = firstIpAddressText;
            self.clientIpLabel.hidden = NO;
            self.messageButton.hidden = NO;
            break;
            
        case 9:
            self.title = @"Шаг 9";
            self.stepDescriptionLabel.text = @"9.	Если клиент удаляется из подсети, назначенный ему IP-адрес автоматически освобождается";
            self.cloudView.center = endPoint;
            self.cloudView.text = @"offline";
            break;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    switch (self.stepNumber) {
        case 1:
        case 4:
        case 7:
            [self animationToPoint:startPoint];
            break;
            
        case 2:
            [self animationToPoint:endPoint];
            break;
        
        case 5: {
            
            [self animationToPoint:endPoint withCompletion:^{
                self.clientIpLabel.text = firstIpAddressText;
                self.clientIpLabel.hidden = NO;
            }];
        } break;
            
        case 8: {
            [self animationToPoint:endPoint withCompletion:^{
                self.clientIpLabel.text = @"IP: 192.168.0.3 MASK: 255.255.255.0 DHCP: 192.168.0.1";
                self.clientIpLabel.hidden = NO;
            }];
        } break;
            
    }
}

- (IBAction)startClick:(id)sender
{
    if(self.stepNumber != 9) {
        ViewController *viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"MainView"];
        viewController.stepNumber = self.stepNumber + 1;
    
        [self.navigationController pushViewController:viewController animated:YES];
    } else {
        [self.navigationController popToRootViewControllerAnimated:TRUE];
    }
}

- (void)animationToPoint:(CGPoint)point
{
    [self animationToPoint:point withCompletion:nil];
}

- (void)animationToPoint:(CGPoint)point withCompletion:(void (^)(void))complitionBlock
{
    [UIView animateWithDuration:timeInterfal animations:^{
        self.cloudView.center = point;
    } completion:^(BOOL finished) {
        if(finished) {
            if(complitionBlock) {
                complitionBlock();
            }
            self.cloudView.hidden = YES;
        }
    }];
}

- (IBAction)messageButtonClick:(id)sender
{
    MessageViewController *viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"MessageView"];
    viewController.stepNumber = self.stepNumber;
    
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
