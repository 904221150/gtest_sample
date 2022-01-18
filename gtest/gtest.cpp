#include<iostream>
#include<gtest/gtest.h>
#include<mockcpp/mockcpp.hpp>
#include"fun.h"


using namespace std;

class TestF : public testing::Test{
    public:
    virtual void SetUp()
    {
        printf("fun start test\n");
    }
    virtual void TearDown()
    {
        printf("fun end test\n");
    }
};

TEST_F(TestF, fun1)
{
    int ret = 0;
    MOCKER(fun_inside)
        .stubs() 
        .with(any())
        .will(returnValue(2));
    ret = fun(1);
    EXPECT_EQ(1, ret);
}

class FooEnvironment : public testing::Environment{
public:
    virtual void SetUp()
    {
        std::cout << "Foo FooEnvironment SetUP" << std::endl;
    }
    virtual void TearDown()
    {
        std::cout << "Foo FooEnvironment TearDown" << std::endl;
    }
};

int main(int argc, char** argv)
{
    testing::AddGlobalTestEnvironment(new FooEnvironment);
    testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
