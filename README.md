#  JxbFramework
#### 此框架是用于iOS开发的框架，依赖于多个开发框架（AFNetworking、ReactiveCocoa、jastor、TouchJSON、fmdb、MBProgressHUD）。主要是搭建了Http的接口框架，并集合了多个工具类、category等（此类会进行版本迭代），同时也集成了UI的Base类，方便使用。


##支持CocoaPods引入（依赖的6个库会自动pods下载）
`pod 'JxbFramework'`

##头部引入（引入以下h即可调用所有）
`#import "XBFramework.h"`

##Framework的结构
     - JxbFramework/XBHeader 
     - JxbFramework/XBUtils 
     - JxbFramework/XBDbHelper 
     - JxbFramework/XBParser 
     - JxbFramework/XBHttp 
     - JxbFramework/XBApi 
     - JxbFramework/XBCategory 
     - JxbFramework/XBCategory/UIAlertView 
     - JxbFramework/XBUi 
     - JxbFramework/XBUi/XBBaseTabVC 
     - JxbFramework/XBUi/XBBaseVC 
     - JxbFramework/XBUi/XBBaseVC/BaseView 
     
#如何使用
### Base UI
``` object-c
    //tab1
    XBHomePageVC* homeVc = [[XBHomePageVC alloc] init];
    XBBaseTabItem* itemHome = [[XBBaseTabItem alloc] init];
    itemHome.title = @"tab1";
    itemHome.selectedImage = @"icon_tab_home_select";
    itemHome.unselectedImage = @"icon_tab_home_unselect";
    itemHome.rootVC = homeVc;
    
    //tab2
    XBCollectPageVC* collectVc = [[XBCollectPageVC alloc] init];
    XBBaseTabItem* itemCollect = [[XBBaseTabItem alloc] init];
    itemCollect.title = @"tab2";
    itemCollect.selectedImage = @"icon_tab_collect_select";
    itemCollect.unselectedImage = @"icon_tab_collect_unselect";
    itemCollect.rootVC = collectVc;
    
    //tab3
    XBBaseTabItem* itemEmpty = [[XBBaseTabItem alloc] init];
    
    //tab4
    XBShengCiVC* scVc = [[XBShengCiVC alloc] init];
    XBBaseTabItem* itemSC = [[XBBaseTabItem alloc] init];
    itemSC.title = @"tab4";
    itemSC.selectedImage = @"icon_tab_shengci_select";
    itemSC.unselectedImage = @"icon_tab_shengci_unselect";
    itemSC.rootVC = scVc;
    
    //tab5
    XBDownloadPageVC* downVc = [[XBDownloadPageVC alloc] init];
    XBBaseTabItem* itemDown = [[XBBaseTabItem alloc] init];
    itemDown.title = @"tab5";
    itemDown.selectedImage = @"icon_tab_down_select";
    itemDown.unselectedImage = @"icon_tab_down_unselect";
    itemDown.rootVC = downVc;
    
    //中间凸起圆按钮
    UIButton* btnMid = [[UIButton alloc] initWithFrame:CGRectMake(mainWidth / 2 - 36, - 15, 72, 72)];
    [btnMid setImage:[UIImage imageNamed:@"icon_tab_big"] forState:UIControlStateNormal];
    [btnMid setImage:[UIImage imageNamed:@"icon_tab_big"] forState:UIControlStateHighlighted];
    [btnMid addTarget:self action:@selector(btnMidAction) forControlEvents:UIControlEventTouchUpInside];
    
    OVATabVC* tabVC = [[OVATabVC alloc] initWithItems:@[itemHome,itemCollect,itemEmpty,itemSC,itemDown] btnMiddle:btnMid];
    
    //设置root vc
    self.window.rootViewController = tabVC;
``` 

### Http 请求
``` object-c
///model，继承Jastor
@interface TempModel : Jastor 
@property(nonatomic,copy)NSString*      item;
@end

///调用接口
[XXX method1:@"xxx" success:^(AFHTTPRequestOperation* operation, NSObject *resultObject){
     //此处利用Jastor框架将NSDictionary反射到相应的对象中
     VOASearchResult* model = [[VOASearchResult alloc] initWithDictionary:(NSDictionary*)resultObject];
} failure:^(NSError* error){
     //error
}];

///（异步）一个成功请求的block，一个失败请求的block，根据结果自行处理逻辑
+ (void)method1:(NSString*)param success:(void (^)(AFHTTPRequestOperation* operation, NSObject *resultObject))success failure:(void (^)(NSError* error))failure {
    [[XBApi SharedXBApi:nil] requestWithURL:url<NSString> paras:<NSDictionary> type:XBHttpResponseType_Json success:success failure:failure];
}
``` 

#ReactiveCoaoa框架的使用请百度
