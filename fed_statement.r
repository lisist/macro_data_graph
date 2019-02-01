library(rvest)
library(stringr)

statement_download <- function(urls_,k_){
	word_count <- NULL
	for (i in 1:length(urls_)){
		statementRaw <- read_html(links_url[i])
		statement <- html_nodes(statementRaw,"p")
		statement <- gsub("\t","",gsub("\n","",gsub("\r","",statement %>% html_text())))
		write.csv(statement,paste0("statement200",k_,"-",i,".csv"))
	}
}


for (k in 1:9){
	url <- paste0("https://www.federalreserve.gov/monetarypolicy/fomchistorical200",k,".htm")
	data <- read_html(url)
	extract <- html_nodes(data,"div.panel.panel-default")

	find_statement <- extract %>% html_nodes("a") %>% html_text()
	links <- extract %>% html_nodes("a") %>% html_attr("href")
	
	links <- links[find_statement == "Statement"]

	links_url <- paste0("https://www.federalreserve.gov",links)

	statement_download(links_url,k)
}

