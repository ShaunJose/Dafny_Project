///////////////////////////////////////////////////////////////
//1: isPrefix

predicate isPrefixPred(pre:string, str:string)
{
	(|pre| <= |str|) &&
	pre == str[..|pre|]
}

predicate isNotPrefixPred(pre:string, str:string)
{
	(|pre| > |str|) ||
	pre != str[..|pre|]
}

lemma PrefixNegationLemma(pre:string, str:string)
	ensures  isPrefixPred(pre,str) <==> !isNotPrefixPred(pre,str)
	ensures !isPrefixPred(pre,str) <==>  isNotPrefixPred(pre,str)
{}

method isPrefix(pre: string, str: string) returns (res:bool)
	ensures !res <==> isNotPrefixPred(pre,str)
	ensures  res <==> isPrefixPred(pre,str)
{
	if pre == str[0..|pre|]
  {
    return true;
  }

  return false;
}

///////////////////////////////////////////////////////////////
//2: isSubstring

predicate isSubstringPred(sub:string, str:string)
{
	(exists i :: 0 <= i <= |str| &&  isPrefixPred(sub, str[i..]))
}

predicate isNotSubstringPred(sub:string, str:string)
{
	(forall i :: 0 <= i <= |str| ==> isNotPrefixPred(sub,str[i..]))
}

lemma SubstringNegationLemma(sub:string, str:string)
	ensures  isSubstringPred(sub,str) <==> !isNotSubstringPred(sub,str)
	ensures !isSubstringPred(sub,str) <==>  isNotSubstringPred(sub,str)
{}

method isSubstring(sub: string, str: string) returns (res:bool)
	ensures  res <==> isSubstringPred(sub, str)
	//ensures !res <==> isNotSubstringPred(sub, str) // This postcondition follows from the above lemma.
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

///////////////////////////////////////////////////////////////
//3: commonKSubstring

predicate haveCommonKSubstringPred(k:nat, str1:string, str2:string)
{
	exists i1, j1 :: 0 <= i1 <= |str1|- k && j1 == i1 + k && isSubstringPred(str1[i1..j1],str2)
}

predicate haveNotCommonKSubstringPred(k:nat, str1:string, str2:string)
{
	forall i1, j1 :: 0 <= i1 <= |str1|- k && j1 == i1 + k ==>  isNotSubstringPred(str1[i1..j1],str2)
}

lemma commonKSubstringLemma(k:nat, str1:string, str2:string)
	ensures  haveCommonKSubstringPred(k,str1,str2) <==> !haveNotCommonKSubstringPred(k,str1,str2)
	ensures !haveCommonKSubstringPred(k,str1,str2) <==>  haveNotCommonKSubstringPred(k,str1,str2)
{}

method haveCommonKSubstring(k: nat, str1: string, str2: string) returns (found: bool)
	ensures found  <==>  haveCommonKSubstringPred(k,str1,str2)
	//ensures !found <==> haveNotCommonKSubstringPred(k,str1,str2) // This postcondition follows from the above lemma.
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

///////////////////////////////////////////////////////////////
//4: maxCommonSubstringLength

method maxCommonSubstringLength(str1: string, str2: string) returns (len:nat)
	requires (|str1| <= |str2|)
	ensures (forall k :: len < k <= |str1| ==> !haveCommonKSubstringPred(k,str1,str2))
	ensures haveCommonKSubstringPred(len,str1,str2)
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


