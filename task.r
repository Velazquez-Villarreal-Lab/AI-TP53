library(stringr)
#step 1 merge sample and pt level metadata. 

pt_df = read.csv( 
    file = "tp53_dataset.tsv",
    sep = "\t",
    # skip = 4,
    # row.names =1,
    header = T,
    na.strings=c("","NA"),
    stringsAsFactors = FALSE
    ) 

print(head(pt_df) )
pt_df$PFS_STATUS = pt_df$OS_STATUS 
pt_df$PFS_MONTHS = pt_df$OS_MONTHS 
for (cn in c("Biologic_AGENTS",	"Bone_Treatment_AGENTS",	"Chemo_AGENTS",	"Hormone_AGENTS",	"Immuno_AGENTS",	"Investigational_AGENTS",	"Other_AGENTS",	"Targeted_AGENTS")){
  pt_df[,cn] = gsub(",", "|", pt_df[,cn]) 
}
pt_df$OS_STATUS <- ifelse(pt_df$OS_STATUS == "0:LIVING", 0, ifelse(pt_df$OS_STATUS == "1:DECEASED", 1, pt_df$OS_STATUS))
pt_df$PFS_STATUS <- ifelse(pt_df$PFS_STATUS == "0:LIVING", 0, ifelse(pt_df$PFS_STATUS == "1:DECEASED", 1, pt_df$PFS_STATUS))
# pt_df$PFS_STATUS <- ifelse(pt_df$PFS_STATUS == "0:CENSORED", 0, ifelse(pt_df$PFS_STATUS == "1:PROGRESSION", 1, pt_df$PFS_STATUS))

write.table( 
    pt_df,
    file = "pt_updated_metadata.tsv" ,
    quote = F,
    sep = "\t",
    row.names = F
  )


# pt_df[] <- lapply(pt_df, function(column) {
#   if (is.character(column)) { # Check if the column is character
#     gsub(" ", "_", column)    # Replace " " with "_"
#     gsub(";", "", column)
#     gsub(",", "", column)
#   } else {
#     column  # Return unchanged if it's not a character column
#   }
# })
# Function to replace spaces with underscores



# pt_df$OS_STATUS <- ifelse(pt_df$OS_STATUS == "0:LIVING", 0, ifelse(pt_df$OS_STATUS == "1:DECEASED", 1, pt_df$OS_STATUS))
# pt_df$PFS_STATUS <- ifelse(pt_df$PFS_STATUS == "0:CENSORED", 0, ifelse(pt_df$PFS_STATUS == "1:PROGRESSION", 1, pt_df$PFS_STATUS))


# replace_spaces <- function(x) {
#   gsub(" ", "_", x)
# #   gsub(";", "", x)
# #   gsub(",", "", x)
# }

# # Loop over each column
# for (col in names(pt_df)) {
#   if (is.character(pt_df[[col]]) || is.factor(pt_df[[col]])) {
#     print(col)
#     print(pt_df[[col]] )
#     pt_df[[col]] <- replace_spaces(as.character(pt_df[[col]]))
#     print(pt_df[[col]] )
#   }
# }

# remove_non_alphanum <- function(x) {
#   gsub("[^A-Za-z0-9]", "_", x)
# }

# # Apply to all character and factor columns
# for (col in names(pt_df)) {
#   if (is.character(pt_df[[col]]) || is.factor(pt_df[[col]])) {
#     pt_df[[col]] <- remove_non_alphanum(as.character(pt_df[[col]]))
#   }
# }


# sample_df = read.csv( 
#     file = "data/TCGA_COAD/data_clinical_sample.txt",
#     sep = "\t",
#     skip = 4,
#     row.names =1,
#     header = T,
#     na.strings=c("","NA"),
#     stringsAsFactors = FALSE
#     )

# sample_df[] <- lapply(sample_df, function(column) {
#   if (is.character(column)) { # Check if the column is character
#     gsub(",", " ", column)    # Replace "," with "_"
#   } else {
#     column  # Return unchanged if it's not a character column
#   }
# })


# print(head(sample_df))
# r_list = intersect(rownames(pt_df),rownames(sample_df) )

# out_df = cbind(pt_df[r_list,], sample_df[r_list,])
# out_df$PATIENT_ID = rownames(out_df)
# rownames(out_df) = make.names(out_df$SAMPLE_ID)
# ### rename key attributes
# colnames(out_df)[21] = "TUMOR_STAGE"

# out_df <- ifelse(is.na(out_df), "none", out_df)
# out_df = pt_df 
# out_df[is.na(out_df)] <- "none"

# # print(head(out_df))

# write.table( 
#     out_df,
#     file = "data/COAD_WNT/pt_metadata.tsv" ,
#     quote = F,
#     sep = "\t",
#     row.names = T
#   )
