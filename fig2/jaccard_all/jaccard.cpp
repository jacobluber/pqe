#include <Rcpp.h>
#include <jaccard.h>

using namespace Rcpp;

// [[Rcpp::export]]
NumericVector JaccardIndex(const NumericVector L1, const NumericVector L2){
	std::vector<double> L1C(L1.size(),0);
	std::vector<double> L2C(L2.size(),0);
	for(int i=0;i<L1.size();i++){
		L1C[i] = L1[i];
		L2C[i] = L2[i];	
	}
	double fun = jaccard(L1C,L2C);
        return NumericVector::create((double)fun);
}


