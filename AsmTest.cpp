// AsmTest.cpp : This file contains the 'main' function. Program execution begins and ends there.
// https://dennisbabkin.com/blog/?t=cpp-and-assembly-coding-in-x86-x64-assembly-language-in-visual-studio
//

#include <iostream>
#include <Windows.h>

extern "C" int __fastcall asm_func(const char* lpText);


int main()
{
    std::cout << "Welcome this is a ASM bootstrapper.!\n";
    int result= asm_func("Hello world!");

} 

extern "C" UINT GetMsgBoxType()
{
    return MB_YESNOCANCEL | MB_ICONINFORMATION;
}