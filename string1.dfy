method isPrefix(pre: string, str: string) returns (res:bool)
{
  if |pre| > |str|
  {
    return false;
  }

  if pre == str[0..|pre|]
  {
    return true;
  }
}

method isSubstring(sub: string, str: string) returns (res:bool)
{
  if |sub| > |str|
  {
    return false;
  }

  var startIndex := 0;
  var prefResult := isPrefix(sub, str[startIndex..|sub|]);

  if prefResult == true
  {
    return true;
  }
  else if(startIndex < |str|)
  {
    startIndex := startIndex + 1;
    var subResult := isSubstring(sub, str[startIndex..]);

    if subResult == true
    {
      return true;
    }
  }

  return false;
}
