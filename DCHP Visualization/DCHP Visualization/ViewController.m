//
//  ViewController.m
//  DCHP Visualization
//
//  Created by Nikolay Shatilo on 22.12.13.
//  Copyright (c) 2013 Nikolay Shatilo. All rights reserved.
//

#import "ViewController.h"
#import "CloudView.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *server;
@property (strong, nonatomic) IBOutlet UILabel *stepDescriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *clientIpLabel;
@property (strong, nonatomic) IBOutlet UIButton *startButton;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startClick:(id)sender
{
    NSString *title = @"Реализация программного комплекса визуализации работы протокола DHCP";
    CGPoint startPoint = CGPointMake(150, 250);
    CGPoint endPoint = CGPointMake(850, 250);
    NSTimeInterval timeInterfal = 5.0f;
    __block CloudView *myCloud;
    
    self.startButton.enabled = NO;
    self.clientIpLabel.text = @"IP: 192.168.0.2 MASK: 255.255.255.0 DHCP: 192.168.0.1";
    
    // step 1
    myCloud = [CloudView createInstanceWithPoint:endPoint];
    myCloud.text = @"discover";
    [self.view addSubview:myCloud];
    
    [UIView animateWithDuration:timeInterfal animations:^{
        self.stepDescriptionLabel.text = @"1.	Компьютер-клиент посылает сообщение discover, которое широковещательно распространяется по локальной сети и передается всем DHCP-серверам частной интерсети";
        
        myCloud.center = startPoint;
    } completion:^(BOOL finished) {
        if(finished) {
            myCloud.center = startPoint;
            myCloud.text = @"offer: 192.168.0.2";
            // step 2
            [UIView animateWithDuration:timeInterfal animations:^{
                self.stepDescriptionLabel.text = @"2.	DHCP-сервер, получивший это сообщение, отвечает на него сообщением offer, содержащее IP-адрес и конфигурационную информацию";
                
                myCloud.center = endPoint;
            } completion:^(BOOL finished) {
                if(finished) {
                    // step 3
                    [UIView animateWithDuration:timeInterfal animations:^{
                        self.stepDescriptionLabel.text = @"3.	Компьютер-клиент переходит в состояние select и собирает конфигурационные предложения от DHCP-серверов";
                        
                        myCloud.text = @"select";
                        myCloud.transform = CGAffineTransformScale(myCloud.transform, 1.1, 1.1);
                    } completion:^(BOOL finished) {
                        if(finished) {
                            myCloud.transform = CGAffineTransformScale(myCloud.transform, 1, 1);
                            
                            // step 4
                            [UIView animateWithDuration:timeInterfal animations:^{
                                self.stepDescriptionLabel.text = @"4.	Клиент выбирает одно из этих предложений и отправляет сообщение request тому DHCP-серверу, чье предложение было выбрано";
                                
                                myCloud.text = @"request";
                                myCloud.center = startPoint;
                            } completion:^(BOOL finished) {
                                if(finished) {
                                    // step 5
                                    [UIView animateWithDuration:timeInterfal animations:^{
                                        self.stepDescriptionLabel.text = @"5.	Выбранный DHCP-сервер посылает сообщение DHCP acknowledgment, содержащее IP-адрес и параметры сетевой конфигурации";
                                        myCloud.text = @"ack: 192.168.0.2";
                                        myCloud.center = endPoint;
                                    } completion:^(BOOL finished) {
                                        if(finished) {
                                            self.clientIpLabel.hidden = NO;
                                            
                                            // step 6
                                            [UIView animateWithDuration:timeInterfal animations:^{
                                                self.stepDescriptionLabel.text = @"6.	Клиент переходит в состояние link, находясь в котором он может принимать участие в работе сети TCP/IP";
                                                
                                                myCloud.text = @"link";
                                                myCloud.transform = CGAffineTransformScale(myCloud.transform, 1.1, 1.1);
                                            } completion:^(BOOL finished) {
                                                if(finished) {
                                                    myCloud.transform = CGAffineTransformScale(myCloud.transform, 1, 1);
                                                    
                                                    // step 7
                                                    [UIView animateWithDuration:timeInterfal animations:^{
                                                        self.stepDescriptionLabel.text = @"7.	При приближении момента истечения срока аренды адреса компьютер пытается обновить параметры аренды у DHCP-сервера";
                                                        
                                                        myCloud.text = @"request";
                                                        myCloud.center = startPoint;
                                                    } completion:^(BOOL finished) {
                                                        if(finished) {
                                                            // step 8
                                                            [UIView animateWithDuration:timeInterfal animations:^{
                                                                self.stepDescriptionLabel.text = @"8.	Если этот IP-адрес не может быть выделен снова, то ему возвращается другой IP-адрес";
                                                                
                                                                myCloud.text = @"ack: 192.168.0.3";
                                                                myCloud.center = endPoint;
                                                            } completion:^(BOOL finished) {
                                                                if(finished) {
                                                                    self.clientIpLabel.text = @"IP: 192.168.0.3 MASK: 255.255.255.0 DHCP: 192.168.0.1";
                                                                    myCloud.text = @"link";
                                                                    
                                                                    [UIView animateWithDuration:timeInterfal animations:^{
                                                                        myCloud.transform = CGAffineTransformScale(myCloud.transform, 1.1, 1.1);
                                                                    } completion:^(BOOL finished) {
                                                                        if(finished) {
                                                                            myCloud.transform = CGAffineTransformScale(myCloud.transform, 1, 1);
                                                                            
                                                                            // step 9
                                                                            [UIView animateWithDuration:timeInterfal animations:^{
                                                                                self.stepDescriptionLabel.text = @"9.	Если клиент удаляется из подсети, назначенный ему IP-адрес автоматически освобождается";
                                                                                myCloud.text = @"offline";self.clientIpLabel.hidden = YES;
                                                                                myCloud.transform = CGAffineTransformScale(myCloud.transform, 1.1, 1.1);
                                                                            } completion:^(BOOL finished) {
                                                                                if(finished) {
                                                                                    [myCloud removeFromSuperview];
                                                                                    self.startButton.enabled = YES;
                                                                                    self.stepDescriptionLabel.text = title;
                                                                                }
                                                                            }];
                                                                        }
                                                                    }];
                                                                }
                                                            }];
                                                        }
                                                    }];
                                                }
                                            }];
                                        }
                                    }];
                                }
                            }];
                        }
                    }];
                }
            }];
        }
    }];
    
    
}

@end
