#!/bin/bash
aws s3 cp s3://jacob-pqe/${1}_1/relative-relative_expression.tsv relative/${1}_1.tsv;
aws s3 cp s3://jacob-pqe/${1}_2/relative-relative_expression.tsv relative/${1}_2.tsv;
aws s3 cp s3://jacob-pqe/${1}_3/relative-relative_expression.tsv relative/${1}_3.tsv;
aws s3 cp s3://jacob-pqe/${1}_4/relative-relative_expression.tsv relative/${1}_4.tsv;
aws s3 cp s3://jacob-pqe/${1}_1/relative-smoothed_rna.tsv rna/${1}_1.tsv;
aws s3 cp s3://jacob-pqe/${1}_2/relative-smoothed_rna.tsv rna/${1}_2.tsv;
aws s3 cp s3://jacob-pqe/${1}_3/relative-smoothed_rna.tsv rna/${1}_3.tsv;
aws s3 cp s3://jacob-pqe/${1}_4/relative-smoothed_rna.tsv rna/${1}_4.tsv;
