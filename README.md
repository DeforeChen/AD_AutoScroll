## 简书地址
 [简书](http://www.jianshu.com/p/1053ec04664f)

## 接口说明
```objc
/**
 初始化
 
 @param modelArray 传入的数据模型，必须遵循 bannerInfo 协议，至少包含图片和链接
 @param position 指出pageControl的位置
 @param time 每张图展示的时间
 @param blk 当且仅当图片有对应url时跳转到对应网页
 */
-(void)setParamsWithModel: (NSArray<id<bannerInfo>>*) modelArray ///
         pageCtrlPosition:(PAGE_CTRL_POS)position
          timeForEachPage:(NSTimeInterval)time
     tapBannerCompleteBlk:(BannerBtnCallback)blk;
```


## 使用说明
* 拖入两个类的四个文件
	* AD_AutoScrollCell
	* BannerWebViewController
* 导入头文件
```objc
AD_AutoScrollCell.h
```
* 因为接口中设置了`点击图片跳转到对应网页`，这里的`WebView`容器采用了`WKWebView`，因此需要导入系统的`WebKit.Framework`框架
* 将你的目标`cell`的类指定为`AD_AutoScrollCell`类

### 自定义部分
* 如果只是普通的跳转，不需要网址跳转到网页页面的话，那么不适合用本接口。因为要改的地方比较多。
* 如果你习惯了旧的`UIWebView`，那么建议你去`BannerWebViewController`类中将`webview`作修改

