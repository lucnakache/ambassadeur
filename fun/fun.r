# install et load les needed librairies
FUN_install_and_load_packages=function(needed_libraries){
  not_yet_installed_libraries=needed_libraries[!needed_libraries %in% rownames(installed.packages())]
  if (length(not_yet_installed_libraries)>0) install.packages(not_yet_installed_libraries)
  lapply(needed_libraries, require, character.only = TRUE)
}


# Fonction qui convertit un ?l?ment de la liste en dataframe
FUN_get_matrix=function(item){
  
  item_temp_p=item[names(item)=="p" | names(item)=="P"]
  item_temp_att=t(data.frame(item[names(item)==".attrs"][[1]]))
  check_matrix=do.call(rbind,lapply(item_temp_p,names))
  index_to_keep = check_matrix[,1]=="text" & check_matrix[,2]==".attrs"
  item_temp_p=item_temp_p[index_to_keep]
  temp_item=lapply(X = item_temp_p,FUN = function(x) do.call(cbind,x))
  temp_item=as.data.frame(do.call(rbind,temp_item))
  row.names(temp_item)=NULL
  temp_item = cbind(temp_item,item_temp_att )
  
  return(temp_item)
}



# convertit un xml document en dataframe
FUN_xml_to_dataframe=function(xml_data) {
mon_dataframe=do.call(rbind,lapply(X = xml_data,FUN =get_matrix ))
row.names(mon_dataframe)=NULL
return(mon_dataframe)
}