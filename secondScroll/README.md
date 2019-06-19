#  中文介绍
我是一个来自贫困山区的iOS开发者，不会英文。
#  使用

1. 创建一个Indicator

   ```Swift
   private lazy var indicator: LSDPageIndicator = {
           let indicator = LSDPageIndicator(frame: CGRect(x: 50, y: 100, width: 300, height: 50))
           return indicator
       }()
   ```


2. 传建一个继承LSDInputView的类

   ```swift
   class MyInput: LSDInputView {
       override func getInputView(_ temp: Any, _ index: Int) -> UIView? {
           // 创建UIView
           // LSDDefaultView是默认的UIView，你也可以自定义UIView
           // 设置UIView的位置
           // temp是当前传入的数据
           // index是当前的UIView的下标
           let view = LSDDefaultView.init(size: CGSize(width: 100, height: 50), normalFont: 14, selectFont: 16, normalColor: UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1), selectColor: UIColor(red: 175/255.0, green: 0, blue: 23/255.0, alpha: 1))
           view.frame.origin = CGPoint(x: 100 * index, y: 0)
           view.setTitle(temp as! String)
           return view
       }
       /// 选中的方法
       override func select(_ view: UIView, _ temp: Any) {
           // view 当前的Uiview
           // temp 当前的数据
           // LSDDefaultView是默认View, 可以自己定义
           let view1 = view as! LSDDefaultView
           view1.selectStyle()
       }
       /// 未选中的方法
       override func unselect(_ view: UIView, _ temp: Any) {
           // view 当前的Uiview
           // temp 当前的数据
           // LSDDefaultView是默认View, 可以自己定义
           let view1 = view as! LSDDefaultView
           view1.unSelectStyle()
       }
       /// 拖拽时候的方法(你要是绑定了UIScrollView,就可以用这个方法)
       /// 要是没有绑定UIScrollView也可以用这个方法，你必须自己实现drag方法
       override func drag(_ view: UIView,_ offset: CGFloat, _ temp: Any) {
           // view 当前的Uiview
           // temp 当前的数据
           // offset 当前的view的偏移量(0-1)
           // LSDDefaultView是默认View, 可以自己定义
           let view1 = view as! LSDDefaultView
           view1.dragStyle(offset)
       }
   }
   ```

3. 创建一个继承LSDSliderView的类

   ```swift
   class MySlider: LSDSliderView  {
       /// 创建滑块
       override func getSlider() -> UIView? {
           // 设置滑块位置
           // LSDDefaultSlider是默认滑块，你可以自己定义
           return LSDDefaultSlider.init(frame: CGRect(x: 10, y: 0, width: 80, height: 2), bacColor: .red)
       }
       // 设置滑块的y轴的相对坐标
       override func getPoint() -> LSDSliderView.PositiveType {
           return .BOTTOM
       }
       // 设置滑块的移动
       override func move(_ index: Int, _ offset: CGFloat, _ slider: UIView, _ itemWidth: CGFloat) {
           // LSDDefaultSlider是默认滑块，你可以自己定义
           // index当前下标
           // offset偏移量
           // slider当前滑块
           // itemWidth滑块需要移动到下一个UIView的宽度
           let view = slider as! LSDDefaultSlider
           view.move(index, offset, itemWidth)
       }
   }
   ```

4. 设置LSDInputView的数据（Any类型），将设置好的input和slider绑定到Indicator。

   ```swift
   override func viewDidLoad() {
           // 设置数据源(我当前设置的是String数组)
           let item = MyInput(datas: ["item1","item2","item3"])
           indicator.show(inputView: item, slider: MySlider(), selectedIndex: 1)
       }
   ```

5. 如果你需要绑定UIScrollView

   ```swift
   /// 创建滚动视图
   private lazy var scr: UIScrollView = {
           let scroll = UIScrollView(frame: CGRect(x: 50, y: 150, width: 300, height: 400))
           scroll.backgroundColor = .black
           scroll.isPagingEnabled = true
           scroll.contentSize = CGSize(width: 900, height: 400)
           return scroll
       }()
   /// 绑定滚动视图
   override func viewDidLoad() {
           let item = MyInput(datas: ["item1","item2","item3"])
           indicator.show(inputView: item, slider: MySlider(), selectedIndex: 1)
           // 绑定代码
           indicator.bindingSV(sv: self.scr)
   }
   ```

6. 关键回调(没有绑定滚动视图的要用到) 

   ```swift
   indicator.selectCallBack { (index) in
        // index选中的UIView的下标
   }
   ```