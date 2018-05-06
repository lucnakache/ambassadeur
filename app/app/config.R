# config.R
rm(list=ls())

filename="basic_stats.RDS"
basic_stats=readRDS(file = filename)

filename="basic_stats_t.RDS"
basic_stats_t=readRDS(file = filename)

auteurs_list=unique(basic_stats$author)
