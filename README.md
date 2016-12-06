## 效果
￼
## 控件
前提：
整个滚动的效果是在一个自定义的`UITableViewCell`中实现的。
* Cell中拉入一个`ScrollView`填满
> * 注意，将Bounces都去掉，避免滑动过程的弹性效果
  * 去掉水平和竖直方向上的滚动提示，所以 show H/V indicator也去掉
  * 记住要勾选 `paging enabled`

* Cell中再拉入一个`UIPageControl`,注意这个`pageControl`不是`scrollview`的子类，且拉入的顺序，否则会被盖在`scrollview`底下不显示:
![2016-08-03 at 下午10.22.png]()(quiver-image-url/CB4D1C36FB2728726D4B22940913CC7B.png)
* 控件搭配的实现原理
`UIPageControl`的使用目的，主要是指示当前滑动到的页数。整个滑动效果的实现，主要是通过`UIScrollView`的`delegate`，在滑动结束的时候改变 `self.pageconrol.currentpage`的值来实现的。

## 具体实现：
* 通过AFNetworking+SDWebImage 申请到一组网络图片，存成一个NSArray。这里的实现过程不赘述，可参看另一篇笔记。
* 我们要解决的问题就是当按页滚动图片时，滚动到最左/最右时，再往左/右滚动，是要回到最初/最后一张的。假设我们一共有n张图片，pagecontrol中肯定要显示n个点，但是实际我们scrollView的contentSize宽度只要3倍的宽度就好了。
  * 我们假设每张图片都作为一个按键的背景图，那么其实有如下的设定：
![2016-08-03 at 下午8.44.png]()(quiver-image-url/D0D8534ED2C4D7623D7FDD38D30B20EE.png)
  * 每一次scrollview滚动结束，会调用delegate中的函数
  ```objc
`  -(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
  ```
`  滚动结束后要做的事包括：
  * 根据滑动的偏移量，改变 pagecontrol的currentpage
  * 重载图片
  将上面截图中的三个UIView(其实是UIButton)，removeFromSuperview,然后根据self.pagecontrol.currentpage作为下标，去传进来的model数组中找到相应的三个连号。如下图
  ![2016-08-03 at 下午10.37.png]()(quiver-image-url/578B032393FB319A765E493122BC77AE.png)

## 代码

