Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62ED1FFC48;
	Fri, 14 Aug 2026 13:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786715655; cv=pass; b=OIQpF7WBYG4O1ot4FUILTZdHZrAk0F7/o30ZHpnVTVo04LK08oFjVvnLJsB2q9Q8tNmk5gR9Ysa+hYema8MDYw5ek1u2SR9P2THvA2hTNFW8NruwjMXB1fyP/JCHjwm4MYpvPpzpn/7a2F5TpOEdUWJ0BALLgIq1TdOYM8Jyt/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786715655; c=relaxed/simple;
	bh=4AXP2+OkprJUve1iYDS9YrLv440AxChxSDvxDKele4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CZevEUc/UaIa4ohWLwYwKHlRQSZqvrkALP0Z8uoMDSsfq3KUvoz9UldgzuGjvbSgrIDdkm2BIrBdXOu8iwN7TnHBngxup93ONAkgZyDqihyWpre7Dz3Y5z77X2rgn6l504et7XioCIna33ekE6fYisKIWe7rEldPoSD5IJoOx4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=G/YrGkan; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=tlnkIMDC; arc=pass smtp.client-ip=85.215.255.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="G/YrGkan";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="tlnkIMDC"
ARC-Seal: i=1; a=rsa-sha256; t=1786714563; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Hav7v0jLmLu9cy8K6ZpOluAOzTQNf/prPsDrHgwfq4faVWL4lU+TbB8sN20W2FB92X
    EyKHr+EGB4CntYjKcNuA8QmVQ1ToERJBMGadynJGgqNhnSOmUozL8a2GFpcsZFhTmTtT
    zyRUNTsUlXXvFTNlE3F6s+wsqjCF9n+iKD0snkcSIrNpHVnxO1KNmcNwZ6qeiWQQSqHg
    MzGN3161X4l7A1WPRzjjeJhks+atHcXsrXRIR+AOWIVyQxYMutzC5H5mw0S0zOC+fUxN
    p9DJpXLkDpaDeRx+2o20iw0R/axCUXZCACeybpSFf5ip9mg2vSWAbOW1+ycsSv5UVOA8
    1+Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1786714563;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=hr+aMNWKJoREzo4OF4q9BuzkD2Fr6e4mGC16w8/z45Y=;
    b=DzTbmLzm33I8zGy58I9nXdU3cX1v9Ds0z57BRLukeNx5ZRHW6u+21/roY5VAB0HaCo
    I1RXh1Ml8bTNr0JdrybJmcD7OgTAwzdN/CXaBh1Or8LxLPjx43RSoQJJ4wh+xtBuddgj
    3pDvF9NrOxB8lIRPlEnO6jGqOzi+SN6vlKa9D5y9fmPp2D20baF8xaH2TpTYKWv5DFXv
    VklS0JsMWlrhgSdc7ESs0u4bSuRCpL4flam2NNayarnfw9upaZ2c1QiKehrtI1+jctss
    uJ/bYPBvsbJqiyMU0OVmVgaU7dMsO+MGYO4jf1DKGHhn0XwKeUjpEcSVyNKbiBtjdiHL
    kBQQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1786714563;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=hr+aMNWKJoREzo4OF4q9BuzkD2Fr6e4mGC16w8/z45Y=;
    b=G/YrGkanNVa76/+P5B6uA2Iv7nGlJ5EY8nghg/lhwkRsffuP793PvD/V8kySaW+/Pb
    vb/VEEq+Gm/EFbjk0Dqaxw0ZNse5J5ofdbm+EGKEoC6r3v6OvSajx+3JtI7boMAA7DC7
    YOcD91TFEuaCg7OKENya5vTBoEi/SegeZOMAKlc5HTEzvWLM6WSRhPx+3DTfOl238rrU
    aH0JlQlB9qbj6GEIk6x+avDG1nuxI6hlQzZaY3oRSgfzBYrpfRWoWITzFPCd53F8p/IF
    CT7EIU2J+L1Koy9wUxwhQdiqBxzVOqjAEFEIP93ewXb8xkfa6yk3BOALY2xdI+QrxIwl
    yaFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1786714563;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=hr+aMNWKJoREzo4OF4q9BuzkD2Fr6e4mGC16w8/z45Y=;
    b=tlnkIMDCymr7f/1//woW+JyHigWbmBaq+NqkmO/P/m2zJ6QREnbpPMr13oQumvf3hA
    BfMnic1ZkFkaBS/MPPCw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K171b727EDa33Pc
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 14 Aug 2026 15:36:03 +0200 (CEST)
Message-ID: <7b538342-0914-409c-a679-87a567d4150e@hartkopp.net>
Date: Fri, 14 Aug 2026 15:36:03 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [can-next] can: proc: remove pointers from CAN specific proc
 output
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org
References: <20260814105438.49657-1-socketcan@hartkopp.net>
 <20260814123141.opZ1ZwYC@linutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260814123141.opZ1ZwYC@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 14.08.26 14:31, Sebastian Andrzej Siewior wrote:
> On 2026-08-14 12:54:38 [+0200], Oliver Hartkopp wrote:
> …
>> function names and sock inode numbers when available. As there's no known
>> tooling around the CAN specific proc output breaking the ABI with this
>> rework creates no issue.
> 
> I let you be the judge of that.
> 
> …
>> --- a/Documentation/networking/can.rst
>> +++ b/Documentation/networking/can.rst
>> @@ -1040,19 +1040,19 @@ As described in :ref:`socketcan-receive-lists` the SocketCAN core uses several f
>>   lists to deliver received CAN frames to CAN protocol modules. These
>>   receive lists, their filters and the count of filter matches can be
>>   checked in the appropriate receive list. All entries contain the
>>   device and a protocol module identifier::
>>   
>> -    foo@bar:~$ cat /proc/net/can/rcvlist_all
>> +    foo@bar:~$ cat /proc/net/can/rcvlist_fil
> 
> Is this _fil a typo?

No, it's a slightly different example.

>> -    receive list 'rx_all':
>> -      (vcan3: no entry)
>> -      (vcan2: no entry)
>> -      (vcan1: no entry)
>> -      device   can_id   can_mask  function  userdata   matches  ident
>> -       vcan0     000    00000000  f88e6370  f6c6f400         0  raw
>> +    receive list 'rx_fil':
>>         (any: no entry)
>> +      device   can_id   can_mask   matches     sock_inode     function
>> +       vcan0  80000123  c00007ff         0  000000000000f862  raw_rcv [can_raw]
>> +      (vcan1: no entry)
>> +      (vcan2: no entry)
>> +      (vcan3: no entry)
>>   
>>   In this example an application requests any CAN traffic from vcan0::
>>   
>>       rcvlist_all - list for unfiltered entries (no filter operations)
>>       rcvlist_eff - list for single extended frame (EFF) entries
> …
>> --- a/net/can/bcm.c
>> +++ b/net/can/bcm.c
>> @@ -2039,11 +2038,11 @@ static int bcm_connect(struct socket *sock, struct sockaddr_unsized *uaddr, int
>>   	}
>>   
>>   #if IS_ENABLED(CONFIG_PROC_FS)
>>   	if (net->can.bcmproc_dir) {
>>   		/* unique socket address as filename */
>> -		sprintf(bo->procname, "%llu", sock_i_ino(sk));
>> +		sprintf(bo->procname, "%016llx", sock_i_ino(sk));
> 
> snprintf() would be a bit bulletproof
> 

Will change that in v2

>>   		bo->bcm_proc_read = proc_create_net_single(bo->procname, 0644,
>>   						     net->can.bcmproc_dir,
>>   						     bcm_proc_show, sk);
>>   		if (!bo->bcm_proc_read) {
>>   			ret = -ENOMEM;
> …
>> diff --git a/net/can/proc.c b/net/can/proc.c
>> index de4d05ae3459..b7858fb66178 100644
>> --- a/net/can/proc.c
>> +++ b/net/can/proc.c
>> @@ -189,30 +189,35 @@ static void can_print_rcvlist(struct seq_file *m, struct hlist_head *rx_list,
>>   			      struct net_device *dev)
>>   {
>>   	struct receiver *r;
>>   
>>   	hlist_for_each_entry_rcu(r, rx_list, list) {
>> -		char *fmt = (r->can_id & CAN_EFF_FLAG)?
>> -			"   %-5s  %08x  %08x  %pK  %pK  %8ld  %s\n" :
>> -			"   %-5s     %03x    %08x  %pK  %pK  %8ld  %s\n";
>> +		char *fmt;
>>   
>> +#if IS_ENABLED(CONFIG_KALLSYMS)
> 
> Please don't. I fix %ps and then there is no leak. There will be then
> the 0 and everything will be fine.
> 

I can wait for your changes before the v2 posting.

Btw. do you think "0" is a good return value, when people expect a 
function name?

What about "(unknown)" or something similar?

>> +		fmt = (r->can_id & CAN_EFF_FLAG)?
>> +			"  %6s  %08x  %08x  %8ld  %016llx  %ps\n" :
>> +			"  %6s     %03x    %08x  %8ld  %016llx  %ps\n";
>>   		seq_printf(m, fmt, DNAME(dev), r->can_id, r->mask,
>> -			   r->func, r->data, atomic_long_read(&r->matches),
>> -			   r->ident);
>> +			   atomic_long_read(&r->matches), r->ino, r->func);
>> +#else
>> +		fmt = (r->can_id & CAN_EFF_FLAG)?
>> +			"  %6s  %08x  %08x  %8ld  %016llx  (unknown)\n" :
>> +			"  %6s     %03x    %08x  %8ld  %016llx  (unknown)\n";
>> +		seq_printf(m, fmt, DNAME(dev), r->can_id, r->mask,
>> +			   atomic_long_read(&r->matches), r->ino);
>> +#endif
>>   	}
>>   }
> …
> 
> So if you do this now, then I probably should remove that hunk from my
> patch.

IMHO these /proc/net/can changes go far beyond replacing the pointer 
values with "0".

I hope the
Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
is ok for your attribution?!?

Best regards,
Oliver

