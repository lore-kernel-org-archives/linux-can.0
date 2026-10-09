Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CE83C9456
	for <linux-can@vger.kernel.org>; Fri,  9 Oct 2026 16:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791564682; cv=pass; b=qC+09g+FnUIQCOqWa5VNDbeQ9B8yLqM7bQm7FupJX5jeushbx9JtYl6rN0EhIGN1ky1f3Zg+QdQ0G+tygGZHaA0sD9zFE3z4R3J3ZZXo6QMqVUlCt/3rDu47eNromosFdW9ZmOo5/S56natX+DgBKMlpOoGmZNH5TrshBt3W1kY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791564682; c=relaxed/simple;
	bh=qBoD5MRZt5BfucKSLIpvWsGHZG8rU8OW10rn/b+Cbfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TeFiAKJRZKkrh5B0debMtpKEiNIRjjrppUoamMChkaIxxBYrHdFHLzeVTUGncT/DUqglT0DZOlJm/zH/BH+/ao6h3luh4aXVdHO81CNgVuCML77bTtt4Jy90QDuqJwf9GxlpcgEWbdxZPqAMmWkTaQ+JkS8DjIngnHA+GopK4zY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=se3zznv5; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=rDaCTYY2; arc=pass smtp.client-ip=85.215.255.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="se3zznv5";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="rDaCTYY2"
ARC-Seal: i=1; a=rsa-sha256; t=1791564495; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=gw6wJEdfzc8jNifNYJmThTvYYjJ2ftiVE/laETmOviXaNsypKT9bORDb8UddeXmbc7
    q5g0bWr+hqduU3WQ4VDFRnIDB5ar3GXYGcCCd1dcfG3+GCEvlqlWpS+5FFZAr4QVrw3Q
    vmkx1A2xw5tGrZQrfMKxG2nPYFRmlQM0UUMzqKNLqOo6ZKYR3x8gOs4M9/N+n0gmjM9X
    JwANRAmWcbru5eQNcBkFW8RA6QOs/C2uOpBDF+ubhRD4csoZ9ww3gXGHTwF8RvrEnn+P
    eC0utVblB9jMwG0ZCz8cNE9nuyeKOOY4pFWypnIYYZe5ESdI59a3/QqeAcfxNVFC6mCv
    EdYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1791564495;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=WBByyuGxvakC8zzWlFpwdAAqkAMl7zpdK5tZUFip+DM=;
    b=Kj/RwRKojjBUtuXMnbWbEvA4PHoG88im2x/oNE083qPumJZCIBWFG4Q7H3iNCSvGFL
    SSwaWvr52w2xgpz5OlYB2nzrWUoYZMAZxYotRcSWBPejkhxT6zDCQCKMxkHqi5MxZiSi
    r/WTRGEMlIY1tIYqbDrkafFN34OH8QYwzpew5Ue7VVofp1ck3w33c4P/cOmkpA60sjse
    M++tiE/4NPVs/N96D/nuEbOz+BuECxaWUoH4gnFdT+RH9tLhax4O3zcnS5/bqL0hw/w+
    XPpGhttbd6my9A0hO4feBdGU/879ZPYplGHkeanylQkuUtLUbYK5q5n3fdvlYXyLVLfA
    dcZw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1791564495;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=WBByyuGxvakC8zzWlFpwdAAqkAMl7zpdK5tZUFip+DM=;
    b=se3zznv5y9fzTEI7Fwpl538U3TV6nd8AxqknWKcgls69gfZeVt9nOxSHZ/XfwISneg
    GKZA+3sl0VuQZhkhUBDZCBKl11X07zdKtehETwGR8FSAImkDE3oypSYACmj3worEfUIr
    QLXsDsvTi4dqtXKSyCu3LjQi0Q3pQ2nGNNzgcUDH9NfSM29/YAQ13pPE7EBsfvnkwsmR
    /k+Jr4ZX4zEjImDNcz4SNJ7m6jOXv+tQBLXzRuquWcoMehlxaL2WvJiOGvE9ISnVbyjo
    E2/G8VYbA/v2fyWt4kZIEgSrP4ENc9gEF6BQwy80+J+dkZ0SkFsGFPR+5CeoGJiAGQSi
    7CkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1791564495;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=WBByyuGxvakC8zzWlFpwdAAqkAMl7zpdK5tZUFip+DM=;
    b=rDaCTYY2CjyG0kbwWLq1naMBh1ckWxVxWHtrkELVEvno6x9A8imym/ejwUHmICfP6r
    kRASwkmff0RXkkNNJGBw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4Kp38="
Received: from [192.168.20.237]
    by smtp.strato.de (RZmta 55.6.2 SBL|AUTH)
    with ESMTPSA id K04b9a299GmFW7o
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 9 Oct 2026 18:48:15 +0200 (CEST)
Message-ID: <75ef350f-97a5-4b69-bc1d-d7152a7a1cbf@hartkopp.net>
Date: Fri, 9 Oct 2026 18:48:09 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/37] pull-request: can-next 2026-10-09
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <20261009134323.64064-1-mkl@pengutronix.de>
 <20261009-bulky-normal-collie-00a67a-mkl@pengutronix.de>
 <14f90123-382a-42fe-942a-b62f14307c85@hartkopp.net>
 <20261009-merciful-certain-dogfish-2c497c-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20261009-merciful-certain-dogfish-2c497c-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 09.10.26 18:32, Marc Kleine-Budde wrote:
> On 09.10.2026 16:46:39, Oliver Hartkopp wrote:
>> Can you please push the testing branch?
> 
> You could also use the tag mentioned in the PR, but I've force pushed
> the testing branch. Sorry for the delay.

No problem.
Btw. I've tried to click the tag in the web interface and then go 
through the commits via the "parent" URLs - which worked.

But I wasn't able to pull the entire code as the testing branch was not 
pushed.

Best regards,
Oliver

