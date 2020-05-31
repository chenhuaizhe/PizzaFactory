# PizzaFactory

## 功能
- 7个厨师代表7个生产线，7个独立的线程 ✅
- 最开始有1000个披萨，按间隔顺序分配给7个厨师 ✅
- 可以单独暂停/恢复某一个厨师的工作 ✅
- 可以一键添加10个或100个披萨，按间隔顺序分配给7个厨师 ✅
- 可以一键停止/恢复所有产线 ✅ 
- app被kill后，再次打开时能恢复上次的状态 ✅
- 可以修改某个披萨的大小和配料，如果修改过程中披萨已经被生产出来了，则提示不可修改 
- 可以将某个披萨发送到另一个披萨工厂（两台设备间的通信）

![app](https://github.com/chenhuaizhe/PizzaFactory/blob/master/img/IMG_9419E1467909-1.png)


## 技术说明

### 知识点
- MVVM 设计模式
- 多线程
- 定时器
- xib

### 第三方库
- FBKVOController
- GCD-programing
- Toast
- FMDB
