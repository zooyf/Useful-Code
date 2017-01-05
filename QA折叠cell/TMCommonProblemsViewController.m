//
//  TMCommonProblemsViewController.m
//  TravelMaster
//
//  Created by 澳达国际 on 17/1/4.
//  Copyright © 2017年 遨游大师. All rights reserved.
//

#import "TMCommonProblemsViewController.h"
#import "TMProblemCell.h"
#import <Masonry.h>

@interface TMCommonProblemsViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataList;

@property (nonatomic, strong) NSMutableArray *selectedIndexPaths;
@end

@implementation TMCommonProblemsViewController
static NSString *kTMCPVCHeaderID            = @"kTMCPHeaderID";
static NSString *kTMCommonProblemCellID     = @"kTMCommomProblemCellID";
static NSString *kTMCPVCFooterID            = @"kTMCPVCFooterID";

- (NSMutableArray *)selectedIndexPaths {
    if (!_selectedIndexPaths) {
        _selectedIndexPaths = [NSMutableArray array];
    }
    return _selectedIndexPaths;
}

- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"常见问题";
    self.tableView.allowsMultipleSelection = YES;
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"f3f3f3"];
    self.tableView.separatorColor = [UIColor colorWithHexString:@"b9b9b9"];
    [self requestData];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)requestData {
    
    NSString *jsonStr = @"[{\"title\":\"行前问题：\",\"content\":[{\"title\":\"品牌问题\",\"content\":[{\"Q\":\"遨游大师是做什么的？\",\"A\":\"遨游大师专注于连接人与旅行地资源，提供一站式的定制旅行解决方案。\"},{\"Q\":\"你们是旅行社还是网站？\",\"A\":\"我们是具有国家旅游局旅行社资质的在线旅游平台\"},{\"Q\":\"旅行品质如何保证？\",\"A\":\"对每一位出行的客人，遨游大师都会为您提供“一对一”的行程规划服务和7*24小时的在线管家式服务，不论您在哪儿，遇到哪些问题，只要一个电话，我们会即时为您服务。\"}]},{\"title\":\"定制服务问题\",\"content\":[{\"Q\":\"定制服务是怎么收费的？\",\"A\":\"定制线路是根据线路设计师的星级和报价收费的，但是根据主题线路的修改服务是完全免费的。\"},{\"Q\":\"看到某一条线路很好，但是行中的酒店星级和用车标准可以修改吗？怎么改？\",\"A\":\"可以的，对于线路中的餐住有问题的，可以直接联系页面下的线路设计师修改，修改后总的费用也会更改。\"},{\"Q\":\"网站上看到的价格和实际支付价格为什么会有变化？\",\"A\":\"因为不同的人数、车导、酒店等级、出发时间等都会对出行费用产生一定的影响，具体的可以跟行程设计师确定，并获得详细的行程清单再提交订单。提交订单后请尽快支付定金，以保证顺利预定。\"}]},{\"title\":\"订单支付问题\",\"content\":[{\"Q\":\"订购流程是什么样的？\",\"A\":\"查找旅行产品→填写订单→支付→行程单确认→快乐出行\"},{\"Q\":\"确认订单后怎么支付？\",\"A\":\"确认过订单后，您直接在线用微信或支付宝完成付款就可以。\"},{\"Q\":\"订单支付成功后，还有哪些问题需要注意吗？\",\"A\":\"我们会把出行小贴士以及注意事项等发送给您，记得查收哦。\"},{\"Q\":\"是否可以先旅游后付款？\",\"A\":\"很抱歉，我们不支持先旅游后付款。我们会严格按照国家旅游局相关规定和与您签署的旅游合同，并在旅行中一切以合同为准执行，切实保障您的权益。\"},{\"Q\":\"如果想修改订单、退订单、退款怎么解决？\",\"A\":\"联系我平台客服人员，或是和您对接的商家，来解决修改或是退订，申请通过后，退款会在7-15个工作日内退还至您的付款账户。\"}]},{\"title\":\"辅助问题\",\"content\":[{\"Q\":\"如果没有在遨游大师定制行程，可以用APP上的智能出行功能吗？\",\"A\":\"可以的，遨游大师智能出行功能没有任何准入门槛，只要下载APP登入就可以使用。\"},{\"Q\":\"单房差是什么？\",\"A\":\"旅行过程中的住宿一般是标准间，即两个床位，如果您的出游人数（成人）为单人时，需要补足另外一个床位的费用。如果您的出游人数（成人）为单数时，会尽量安排3人间或是加床，如果无法安排则需要拼房或是再补房差。\"},{\"Q\":\"签证能不能办，怎么收费？如果签证没通过，费用怎么算？\",\"A\":\"我平台可代办签证，并根据国家、地区的不同来收取相对应的费用，如果签证没有通过，费用不退还（签证费用都上交给使馆签证部门）\"}]}]},{\"title\":\"行中保障：\",\"content\":[{\"title\":\"航班延误\",\"content\":[{\"Q\":\"出行中遇到航班延误怎么办？\",\"A\":\"先跟机场工作人员确认延误时间，如果时间较长，线路设计师会帮您确认下一程的预定是否可以更改，并协助您选择其他方式抵达目的地。\"}]},{\"title\":\"行中线路或活动更改\",\"content\":[{\"Q\":\"如果原本订购的服务不想参加了，是否可以退费？\",\"A\":\"这个问题您可以先跟为您服务的线路设计师协调，具体退费数额依具体服务而定。\"},{\"Q\":\"如果在旅行目的地遇到恶劣天气，预定的活动无法正常进行怎么办？\",\"A\":\"一般而言，线路规划师都会为您留有一天的Plan B备用，或者退款（若不能退款预定时会与您沟通）。\"},{\"Q\":\"出发后对定制的线路不满意，可以在中途修改线路吗？\",\"A\":\"这个完全是可以的，如果您对线路不满意，请尽快与线路设计师或者是我们的旅行顾问沟通，我们会按照您的需求重新定制线路，如果产生额外费用，我们会跟您沟通解决。\"},{\"Q\":\"如果我们对行程中的服务不满意，可以换导游吗？\",\"A\":\"如果您对我们的服务不满意，确实是导游或是因为服务人员造成的不满意，我们会给您换服务人员，让您在接下来的旅行中更加舒心，再次对您表示道歉。\"}]},{\"title\":\"酒店入住\",\"content\":[{\"Q\":\"我需要携带哪些证件才能入住酒店？\",\"A\":\"到酒店前台后，出示您的护照和入住凭证（voucher），酒店工作人员核实与预定信息无误之后，支付住房押金，即可入住。\"}]},{\"title\":\"意外突发状况\",\"content\":[{\"Q\":\"如果在旅途中迷路怎么办？\",\"A\":\"首先查看路书，也可以打开“遨游大师”APP地图定位功能，确定您的大概位置，然后先向周围的人问路（遇到语言问题，记得打开app的人声翻译功能），或者是跟您专属的线路规划师或者是我们的24小时在线客服沟通。\"},{\"Q\":\"如果万一发生意外或是安全问题，怎么解决？\",\"A\":\"请第一时间联系接待人员，或是我们的客服人员，接待人员或是客服人员会根据情况来合理安排解决方案。\"},{\"Q\":\"出行中如果生病应该怎么办？\",\"A\":\"旅途中生病，很难得到及时而到位的救治，建议您随身带一些治疗感冒、止泻、止晕车呕吐的药片。病情严重的情况下，请立即联系当地医院或拨打120急救电话。在境外需要医疗救助时，可以联系领队或当地接待负责人，直接拨打当地急救电话，或联系中国驻所在国大使馆。对于年纪稍大的旅客，出国前一定要备齐日常服用的药物和急救药物；年过70岁的老人，在出国前，最好进行系统全面的全身检查，以减少境外旅游时生病的概率。\"},{\"Q\":\"出行中，如果遇到不专业的伴游或者是地接方，迟到、早退或者是被放鸽子等问题，平台会怎么解决？\",\"A\":\"首先，在线路设计师或者是地接资源入驻时，我们会有严格的筛选条例，保证服务质量。如果依然发生类似事件，我们先对您表示深深的抱歉，并根据情节与您协商退款并补偿。\"}]},{\"title\":\"注意事项\",\"content\":[{\"Q\":\"游玩时都有那些注意的事？\",\"A\":\"一、注意个人的人身安全\\n二、注意个人的财物安全\\n三、注意防寒保暖，严寒酷暑\\n四、听从导游的安排，不能擅自行动\\n五、在当地的人文文化，请入乡随俗，不要擅自做一些违反当地信仰的事\\n六、如果遇到突发状况，不要慌张，请您联系伴游或者是我们的24小时在线客服，我们会第一时间帮助您。\"}]}]},{\"title\":\"行后问题：\",\"content\":[{\"title\":\"发票问题\",\"content\":[{\"Q\":\"完成付款后，能否开发票，发票怎么开？\",\"A\":\"可以提供发票，严格按照国家税务标准提供发票，请您在出游归来后2个月内索要发票。\"},{\"Q\":\"一个订单可以开具多张发票吗？\",\"A\":\"可以，但是开具的发票张数不能超过出游的成人数，发票累计金额不能大于合同团款的金额。\"}]},{\"title\":\"其他问题\",\"content\":[{\"Q\":\"有旅游保险吗？保额是多少？\",\"A\":\"平台中有部分线路是包含保险的，在产品的介绍页您可以看到，如果费用包含里标示包含保险费用，则表示，保险已经在您下订单后，就已经购买。如果没有这样的提示，并且也自愿挑选或是购买其它保险，您可以向客服专员进行咨询。\"},{\"Q\":\"如何对行程中问题作出评价？\",\"A\":\"行程完成后，您可以在订单中心，根据实际问题对出行中的服务作出评价，评价可以获得红包哦。\"},{\"Q\":\"如何投诉？\",\"A\":\"直接拨打我们的投诉电话，或者发送邮件，讲明具体的投诉原由，我们会在三个工作日内告知您具体的处理意见，并对您行程中的问题进行赔付。\"}]}]}]";
    
    NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSArray *array = [YFUtils parseJSONData:data error:&error];
    for (NSDictionary *dict in array) {
        [self.dataList addObjectsFromArray: [dict valueForKey:@"content"]];
    }
    NSLog(@"%@", self.dataList);
    
}


#pragma mark --------------------- tableview datasource ---------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *contents = [self.dataList[section] valueForKey:@"content"];
    return contents ? contents.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TMProblemCell *cell = [tableView dequeueReusableCellWithIdentifier:kTMCommonProblemCellID];
    
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"TMProblemCell" bundle:nil] forCellReuseIdentifier:kTMCommonProblemCellID];
        cell = [tableView dequeueReusableCellWithIdentifier:kTMCommonProblemCellID];
    }
    NSDictionary *dict = [self.dataList[indexPath.section] valueForKey:@"content"][indexPath.row];
    [cell setDataDict:dict];
    [cell layoutSubviews];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.selectedIndexPaths addObject:indexPath];
    [tableView beginUpdates];
    [tableView endUpdates];
    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:YES];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.selectedIndexPaths removeObject:indexPath];
    [tableView beginUpdates];
    [tableView endUpdates];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 50;
    
    for (NSIndexPath *selectedIndexPath in self.selectedIndexPaths) {
        if (selectedIndexPath == indexPath) {
            TMProblemCell *cell = (TMProblemCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
            height += [cell.answerLb.attributedText boundingRectWithSize:CGSizeMake(cell.answerLb.width, 1000) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height + 20;
            break;
        }
    }
    
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kTMCPVCHeaderID];
    if (!view) {
        view = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:kTMCPVCHeaderID];
        UIView *contentView = view.contentView;
        contentView.backgroundColor = [UIColor whiteColor];
        UILabel *headerLb = [[UILabel alloc] init];
        headerLb.textColor = [UIColor colorWithHexString:@"333333"];
        headerLb.font = [UIFont systemFontOfSize:17];
        [contentView addSubview:headerLb];
        [headerLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(contentView);
        }];
        [headerLb mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(contentView.mas_left).with.offset(15);
        }];
        headerLb.tag = 1001;
        
    }
    UILabel *label = [view.contentView viewWithTag:1001];
    label.text = [self.dataList[section] valueForKey:@"title"];
    
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kTMCPVCFooterID];
    if (!view) {
        view = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:kTMCPVCFooterID];
        UIView *contentView = view.contentView;
        contentView.backgroundColor = [UIColor colorWithHexString:@"f3f3f3"];
    }
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 65;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

@end
