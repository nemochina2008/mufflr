#' assignNewlineIndent
#' @description Call this function as an addin to insert an assignment (<-) and newline at the cursor position with an extra indent level.
#' @return NULL
#' @export
#'
assignNewlineIndent <- function(){
  SPACE_PREF <- .rs.readUiPref('num_spaces_for_tab')

  context <- rstudioapi::getActiveDocumentContext()
  context_row <- context$selection[[1]]$range$end["row"]
  indent_context <- regexec(pattern = "\\w", context$contents[context_row])[[1]][1]-1 #match pos of the first word -1
  if(indent_context < 0 )indent_context <- nchar(context$contents[context_row])
  if(sum(context$selection[[1]]$range$end -
         context$selection[[1]]$range$start) > 0){
    #Non-empy selection. Just insert the assign and newline.
    rstudioapi::insertText(paste0("<-\n", strrep(" ",indent_context+SPACE_PREF)))
  }else{
    if(grepl(pattern = '\\s$', context$contents[context_row])){
      #Empty selection. If the last char of the line is a space do not insert one.
      rstudioapi::insertText(paste0("<-\n", strrep(" ",indent_context+SPACE_PREF)))
    }
    else{
      #Insert a space
      rstudioapi::insertText(paste0(" <-\n", strrep(" ",indent_context+SPACE_PREF)))
    }
  }
}








