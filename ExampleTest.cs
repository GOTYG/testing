using GdUnit4;

namespace Broad;

[TestSuite]
public class ExampleTest
{
   [TestCase]
   public static void TestFoo()
   {
	  Assertions.AssertThat(5).IsEqual(5);
   } 
}
