---
title: 1071 Speech Patterns (25)（25 分）
date: 2018-08-10 14:41:56
tags: PAT
categories: 题解集
---

1071 Speech Patterns (25)（25 分）
People often have a preference among synonyms of the same word. For example, some may prefer "the police", while others may prefer "the cops". Analyzing such patterns can help to narrow down a speaker's identity, which is useful when validating, for example, whether it's still the same person behind an online avatar.

Now given a paragraph of text sampled from someone's speech, can you find the person's most commonly used word?

Input Specification:

Each input file contains one test case. For each case, there is one line of text no more than 1048576 characters in length, terminated by a carriage return '\n'. The input contains at least one alphanumerical character, i.e., one character from the set [0-9 A-Z a-z].

Output Specification:

For each test case, print in one line the most commonly occurring word in the input text, followed by a space and the number of times it has occurred in the input. If there are more than one such words, print the lexicographically smallest one. The word should be printed in all lower case. Here a "word" is defined as a continuous sequence of alphanumerical characters separated by non-alphanumerical characters or the line beginning/end.

Note that words are case insensitive.

Sample Input:
```
Can1: "Can a can can a can?  It can!"
```
Sample Output:
```
can 5
```

题目大意：读入一行字符串，问出现次数最多的单词和出现次数，这个单词可以由大小写字母和数字组成。
```cpp

#include<iostream>
#include<string>
#include<map>
using namespace std;
map<string,int>cou;
int check(char c){
	if(c>='0'&&c<='9'){
		return 1;
	}
	if(c>='a'&&c<='z'){
		return 1;
	}
	if(c>='A'&&c<='Z'){
		return 1;
	}
	return 0;
}
int main(){
	int i=0;
	string str;
	getline(cin,str);
	int len=str.length();
	while(i<len){
		string word;
		while(i<len&&check(str[i])==0){//定位到有效单词 
			i++;
		}
		while(i<len&&check(str[i])==1){
			if(str[i]>='A'&&str[i]<='Z'){
				str[i]=str[i]+32;
			}
			word=word+str[i];
			i++;
		}
			if(cou.find(word)==cou.end()){
				cou[word]=1;
			}
			else{
				cou[word]++;
			}
	}
	map<string,int>::iterator it=cou.begin();
	int max=-1;
	string ans;
	for(;it!=cou.end();it++){
		if(it->second>max){
			max=it->second;
			ans=it->first;
		}
	}
	cout<<ans<<" "<<max<<endl;
	return 0;
}
```