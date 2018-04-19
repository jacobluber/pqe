#include <iostream>
#include <vector>
#include <cstdlib>
#include <cmath>

using namespace std;

template<class T>
void comp(vector<T> v1, vector<T> v2){
	if(v1.size() != v2.size()){
		cout << "vectors not the same size\n";
		exit(1);
	}
}


template<class T>
double jaccard(vector<T> v1, vector<T> v2){
	comp(v1, v2);
	int f11 = 0;
	int count2 = 0;
	for (unsigned int i=0; i < v1.size(); i++){
		int count = 0;
		if(v1[i] > 0  && v2[i] > 0){
				f11++;
				count = 1;
		} 
		//if(v1[i] + v2[i] > 0.0001){
		//	f11--;
		//	count2++;
		//}
		if(v1[i] == v2[i] && count == 0){
			f11++;
		}
	}
	return double(f11) / double(v1.size()-count2);
}

