#' Find and list untranscribed bundles
#'
#' @author Fredrik Karlsson
#'
#' @param emuDBhandle
#'
#' @return A vector of bundle names
#' @export
#'
#' @examples
#' \donotrun{
#' ## Just a precaution for changes in tempdir() behaviour
#' tmpD <- tempdir()
#' create_emuRdemoData(dir = tmpD)
#' path2folder = file.path(tmpD, "emuR_demoData", "ae_emuDB")
#' ae = load_emuDB(path2folder)
#' # Make a test case for this particular function
#' unlink(file.path(path2folder,"0000_ses//msajc012_bndl/msajc012_annot.json"))
#' print(list_untranscribedBundles(ae))
#' unlink(tmpD,recursive=TRUE)
#' }
#'
list_untranscribedBundles <- function(emuDBhandle){
  wavs <- list_files(emuDBhandle,fileExtension = "[.]wav$")$bundle
  transcriptions <- list_files(emuDBhandle,".*[.]json")$bundle
  untranscribed <- setdiff(wavs,transcriptions)
  return(untranscribed)
}
