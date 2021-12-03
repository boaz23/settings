class MyClass
{
    private int _field;

    public MyClass(int field, string prop)
    {
        _field = field;
        Prop = prop;
    }
    public string Prop { get; set; }

    public void Method(int myParam, DateTime dt1, MyEnum enum3)
    {
        // Comment
        myParam = 4;
        DateTime datetime = DateTime.Now;
        var dateTime2 = dt1;
        int a = 5 + -2 + 222222 + myParam;
        var c = datetime + TimeSpan.FromSeconds(1);
        IEnumerable<int> r = Enumerable.Select(Enumerable.Range(0, 5), x => x)
            .Where(x => x % 2 == 0)
            .ToList();
        int i = _field + 5;
        i *= 2;
        a += i;
        if (enum3 == MyEnum.Cond)
        {
            string bStr = "53525\\5";
            string aStr = @"wtff";
            string cStr = $"interpolated   {r}";
            string dStr = $@"interpolated 2 {r}";
            bStr += aStr;
            aStr = dStr;
        }
    }

    public void UnusedMethod() { }

    public event EventHandler<DateOnly>? HelloEvent;
}
record class MyClassRecord { }
record struct MyStructRecord { }
enum MyEnum
{
    Opt1,
    Cond,
    Loop,
}
struct MyStruct { }
interface IMyInterface { }
delegate void MyDelegate<T>(T obj);
