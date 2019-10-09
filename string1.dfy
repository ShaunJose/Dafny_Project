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

method haveCommonKSubstring(k: nat, str1: string, str2: string) returns (found: bool)
{
  if |str1| < k || |str2| < k
  {
    return false;
  }

  var result := isSubstring(str1[0..k], str2);

  if result == true
  {
    return true;
  }
  else if |str1| >= 1
  {
    var result2 := haveCommonKSubstring(k, str1[1..], str2);

    if result2 == true
    {
      return true;
    }

  }

  //NOTE: don't really need this
  // var startIndex2 := 0;
  // if (startIndex2 + k) <= |str2|
  // {
  //   var result := isSubstring(str1, str2[startIndex2..(startIndex2+k)]);
  //
  //   if result == true
  //   {
  //     return true;
  //   }
  // }

  return false;
}

method maxCommonSubstringLength(str1: string, str2: string) returns (len:nat)
{
    len := 0;

    var i := 1;
    while(i <= |str1| && i <= |str2|)
    {
      var result := haveCommonKSubstring(i, str1, str2);

      if result == true
      {
        len := i;
      }

      i := i + 1;
    }

}
