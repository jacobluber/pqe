#include <Rcpp.h>
#include <algorithm>

using namespace Rcpp;

// [[Rcpp::export]]
NumericMatrix bray_curtis(NumericMatrix inputdata, const int colsize){
	NumericMatrix bc_score_mat(colsize, colsize);
	for(int i = 0;i<colsize-1;i++){
		for(int j =0;j<colsize-1;j++){
			Rcout << i << "," << j << '\n';
			NumericMatrix::Row samp1 = inputdata( i, _);
			NumericMatrix::Row samp2 = inputdata( j, _);
			double S = 0;
			double Cij = 0;
			for(int k=0;k<samp1.size()-1;k++){
				double s1 = samp1[k];
				double s2 = samp2[k];
				if(s1 > 0 && s2 > 0){
					Cij+=std::max(s1,s2)-std::min(s1,s2);		
				}
				S+=s1;
				S+=s2;	
			}
			double new_entry = ((Cij)/S);
			bc_score_mat(i,j) = new_entry;
		}
	}	
        Rcout << bc_score_mat(6,6);
	return bc_score_mat;
}


