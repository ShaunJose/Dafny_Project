method isPrefix(pre: string, str: string) returns (res: bool)
  requires |pre| <= |str|
  ensures str == pre + str[|pre|..] ==> res == true
  ensures str != pre + str[|pre|..] ==> res == false
{
  if pre == str[0..|pre|]
  {
    return true;
  }

  return false;
}

method isSubstring(sub: string, str: string) returns (res: bool)
{
  if |sub| > |str| //substring cant be > than string
  {
    return false;
  }

  var prefResult := isPrefix(sub, str);

  if prefResult == true
  {
    return true;
  }
  else if(|str| >= 1) //if it has atleast 1 char
  {
    var subResult := isSubstring(sub, str[1..]);

    if subResult == true
    {
      return true;
    }
  }

  return false;
}

method haveCommonKSubstring(k: nat, str1: string, str2: string) returns (found: bool)
{
  if |str1| < k || |str2| < k //substring of length k cant be greater than string
  {
    return false;
  }

  var result := isSubstring(str1[0..k], str2);

  if result == true
  {
    return true;
  }
  else if |str1| >= 1 //if it has atleast one char
  {
    var result2 := haveCommonKSubstring(k, str1[1..], str2);

    if result2 == true
    {
      return true;
    }

  }

  return false;
}

method maxCommonSubstringLength(str1: string, str2: string) returns (len: nat)
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
