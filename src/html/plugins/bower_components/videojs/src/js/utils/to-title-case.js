/**
 * Uppercase the first letter of a string
 * @param  {String} string String to be uppercased
 * @return {String}
 * @private
 */
function toTitleCase(string){
  return string.charAt(0).toUpperCase() + string.slice(1);
}

export default toTitleCase;
