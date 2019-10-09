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


//Tests
method testFirst3()
{
  ////////////////
  /// isPrefix ///
  ////////////////
  var str1 := "pre";
  var str2 := "prefix";
  var result := isPrefix(str1, str2);
  print "Expected true got:";
  print result;

  str1 := "ppre";
  result := isPrefix(str1, str2);
  print "Expected false got:";
  print result;

  str1 := "fix";
  result := isPrefix(str1, str2);
  print "Expected false got:";
  print result;

  ///////////////////
  /// isSubstring ///
  ///////////////////

  str1 := "";
  result := isSubstring(str1, str2);
  print "Expected true got:";
  print result;

  str1 := "pre";
  result := isSubstring(str1, str2);
  print "Expected true got:";
  print result;

  str1 := "ix";
  result := isSubstring(str1, str2);
  print "Expected true got:";
  print result;

  str1 := "f";
  result := isSubstring(str1, str2);
  print "Expected true got:";
  print result;

  str1 := "efi";
  result := isSubstring(str1, str2);
  print "Expected true got:";
  print result;

  str1 := "ppre";
  result := isSubstring(str1, str2);
  print "Expected false got:";
  print result;

  ////////////////////////////
  /// haveCommonKSubstring ///
  ////////////////////////////

  str1 := "ppre";
  result := haveCommonKSubstring(0, str1, str2);
  print "Expected true got:";
  print result;

  str1 := "";
  result := haveCommonKSubstring(0, str1, str2);
  print "Expected true got:";
  print result;

  str1 := "ppre";
  result := haveCommonKSubstring(3, str1, str2);
  print "Expected true got:";
  print result;

  str1 := "ppre";
  result := haveCommonKSubstring(4, str1, str2);
  print "Expected false got:";
  print result;

  str1 := "pppppp";
  result := haveCommonKSubstring(1, str1, str2);
  print "Expected true got:";
  print result;

  str1 := "xiferp";
  result := haveCommonKSubstring(1, str1, str2);
  print "Expected true got:";
  print result;

  str1 := "xiferp";
  result := haveCommonKSubstring(2, str1, str2);
  print "Expected false got:";
  print result;

  ///// SWITCHING STR1 and STR2 /////////////

  str1 := "ppre";
  result := haveCommonKSubstring(0, str2, str1);
  print "Expected true got:";
  print result;

  str1 := "";
  result := haveCommonKSubstring(0, str2, str1);
  print "Expected true got:";
  print result;

  str1 := "ppre";
  result := haveCommonKSubstring(3, str2, str1);
  print "Expected true got:";
  print result;

  str1 := "ppre";
  result := haveCommonKSubstring(4, str2, str1);
  print "Expected false got:";
  print result;

  str1 := "pppppp";
  result := haveCommonKSubstring(1, str2, str1);
  print "Expected true got:";
  print result;

  str1 := "xiferp";
  result := haveCommonKSubstring(1, str2, str1);
  print "Expected true got:";
  print result;

  str1 := "xiferp";
  result := haveCommonKSubstring(2, str2, str1);
  print "Expected false got:";
  print result;
}

method testLastMethod()
{
  ////////////////////////////////
  /// maxCommonSubstringLength ///
  ////////////////////////////////

  var str1 := "ppre";
  var str2 := "prefix";
  var result := maxCommonSubstringLength(str1, str2);
  print "Expected 3 got:";
  print result;

  str1 := "ppre";
  str2 := "nothing";
  result := maxCommonSubstringLength(str1, str2);
  print "Expected 0 got:";
  print result;

  str1 := "fix";
  str2 := "prefix";
  result := maxCommonSubstringLength(str1, str2);
  print "Expected 3 got:";
  print result;

  str1 := "sebfikfix";
  str2 := "prefix";
  result := maxCommonSubstringLength(str1, str2);
  print "Expected 3 got:";
  print result;

  str1 := "jvcjsereficjawbd";
  str2 := "prefix";
  result := maxCommonSubstringLength(str1, str2);
  print "Expected 4 got:";
  print result;

  str1 := "prefix";
  str2 := "prefix";
  result := maxCommonSubstringLength(str1, str2);
  print "Expected 6 got:";
  print result;

  str1 := "";
  str2 := "prefix";
  result := maxCommonSubstringLength(str1, str2);
  print "Expected 0 got:";
  print result;

  str1 := "";
  str2 := "";
  result := maxCommonSubstringLength(str1, str2);
  print "Expected 4 got:";
  print result;

  //// SWITHCING PARAMS ////

  str1 := "ppre";
  str2 := "prefix";
  result := maxCommonSubstringLength(str2, str1);
  print "Expected 3 got:";
  print result;

  str1 := "ppre";
  str2 := "nothing";
  result := maxCommonSubstringLength(str2, str1);
  print "Expected 0 got:";
  print result;

  str1 := "fix";
  str2 := "prefix";
  result := maxCommonSubstringLength(str2, str1);
  print "Expected 3 got:";
  print result;

  str1 := "sebfikfix";
  str2 := "prefix";
  result := maxCommonSubstringLength(str2, str1);
  print "Expected 3 got:";
  print result;

  str1 := "jvcjsereficjawbd";
  str2 := "prefix";
  result := maxCommonSubstringLength(str2, str1);
  print "Expected 4 got:";
  print result;

  str1 := "prefix";
  str2 := "prefix";
  result := maxCommonSubstringLength(str2, str1);
  print "Expected 6 got:";
  print result;

  str1 := "";
  str2 := "prefix";
  result := maxCommonSubstringLength(str2, str1);
  print "Expected 0 got:";
  print result;

  str1 := "";
  str2 := "";
  result := maxCommonSubstringLength(str2, str1);
  print "Expected 4 got:";
  print result;
}
