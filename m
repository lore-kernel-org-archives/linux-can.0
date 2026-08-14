Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B753349B19;
	Fri, 14 Aug 2026 13:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786715865; cv=pass; b=LtJ/zlUGrFKavXAJZgQ36frOVjXHAzL4/OLjAccpcqpxtrn0g9DhZpsx7MiEYc3Vwyyaf+a0SqUC5VhfqiRBR2Mw28EoDgZsquRM8XyrmonsLa+sNbKz1CPZs4uUkjWhBljVS/uyitYZuLSiVnKRvWU4OxNvC2XqR22RVB/oUFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786715865; c=relaxed/simple;
	bh=o1Db18j81xA4/xwGnSukztQQZFiMVFxCTOZEv3/22u4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bTwCVBN0Yfy+WdSbkEVwVRHwFqPhXr6cIL6lRb5qdKEdmsijXaWp71Rp+AuSJuWAAMidL3RCN3XzBJn4aezBVfiPc7VZ3xdKxi4b0PCUqdxdvdpTfZWZOoENpa3Qk9byztXtzK0DrYuKQC6wCgjB0zFiubAX2IYIyuZYHhzyqCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=dekO12xW; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=9t0pH4d7; arc=pass smtp.client-ip=85.215.255.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="dekO12xW";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="9t0pH4d7"
ARC-Seal: i=1; a=rsa-sha256; t=1786715855; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=JvkAPr8+gnqAY3e3TkQIFX3/Y+80TJRpyCSNlTJMiMXw3lImY75T1yVdw7+GQNs2Gc
    7DJRIVmaW/6oTWonrIGzpeYhaXZ4dajsF2VGc3tHfxL5RjDb8adnl5YMpCWb/n06V+d8
    ZK4KuC6/j7RZRKj2defdUCZYvVqTtDLTK5z6CTpCq9W8Rukf2PpRmOZtMcgD8v4svLMB
    INmOCVSIn6pWx7SR22TmWqF0Y5puQH6X+CKCJZVu+5uejpfGumBPEnHLIceOStxnbbDe
    ZpGKyaAgMSKq9yaBz3G72t7+2dyVhqVs/wk5tTYgvNE106/ID8YIxaXCBAMAKKHT7mHG
    RQmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1786715855;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=cFE+OBmuV+KjANFVwFc82zAOyA8fBUyjee5TS9Uuotw=;
    b=cDc/id/CaZYIpZH2okQ99rl7x09p5wmixC8ljPy13kioaQo3qBb/OjhYSX5B6nBu4B
    mmOpMklcp6NUjZXCAWyaVESA97tFSoBr4fa6LyOnvAiEp6T9k3ffyGbvOrmzt9KdRZeg
    6lfKIUfN7FogXyb9HEOMB6EfBHgluCmFT8NF6iIbZ0Db2iL3/MCta84hC3mvw+VHtF1u
    u2/G6OxZDvYxczyGHwqENpSOZVngJXx9rh+vBq7MjduPRcXHmaXuloNgo9hJkaSlE9Q5
    /XcO1kl0d/rAHFLGGDCIGCElXbZpMR2Jm9xYH/7d/9T9pkDujZU8tNXH5xzSzMrVpWEz
    w73g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1786715855;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=cFE+OBmuV+KjANFVwFc82zAOyA8fBUyjee5TS9Uuotw=;
    b=dekO12xWtCc0NYaZSUce4qsa+jy0gcqkw99svupGfztNkNJ2fqEQkBaE0/lg+Y4PVS
    zIzBjFpVu5C1TDhtlQlK9OoHnnmezvtlBcdbXcYxCOkBQTnk2uwlNIbcB1Mv/An+hgVx
    To/w1S095IOjn9kTmQ40bl2WPS6LvTXmzXyPpKbCOyBgtGfhIFET00nkynB8CuE8cnMS
    NutJTXXI6KJ5gNOp+dR+VJ3rU7OErcxOHm+nZqO1u4KY3rJtf9swpXlo9E73dPA97YyZ
    /ZhFDPOxc7zc8Xvn/qseP3iwHHPVl/ZalLXmKZG4Ea+XoygZk0aMmpAdRH3rQVhMYrsm
    JOJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1786715855;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=cFE+OBmuV+KjANFVwFc82zAOyA8fBUyjee5TS9Uuotw=;
    b=9t0pH4d79/73TOkjylw/K0/R13FSuyWMQtkGT9lJfshIhTRiX4rZRv6Qyu3+S6Te2C
    6m/BBZsse5QCf1dQooCQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K171b727EDvZ3TC
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 14 Aug 2026 15:57:35 +0200 (CEST)
Message-ID: <23ad673f-9622-42c6-afcb-1aeacbe6d733@hartkopp.net>
Date: Fri, 14 Aug 2026 15:57:35 +0200
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
 <7b538342-0914-409c-a679-87a567d4150e@hartkopp.net>
 <20260814135248.OO4H1uIt@linutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260814135248.OO4H1uIt@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 14.08.26 15:52, Sebastian Andrzej Siewior wrote:
> On 2026-08-14 15:36:03 [+0200], Oliver Hartkopp wrote:
>>>> --- a/Documentation/networking/can.rst
>>>> +++ b/Documentation/networking/can.rst
>>>> @@ -1040,19 +1040,19 @@ As described in :ref:`socketcan-receive-lists` the SocketCAN core uses several f
>>>>    lists to deliver received CAN frames to CAN protocol modules. These
>>>>    receive lists, their filters and the count of filter matches can be
>>>>    checked in the appropriate receive list. All entries contain the
>>>>    device and a protocol module identifier::
>>>> -    foo@bar:~$ cat /proc/net/can/rcvlist_all
>>>> +    foo@bar:~$ cat /proc/net/can/rcvlist_fil
>>>
>>> Is this _fil a typo?
>>
>> No, it's a slightly different example.
> okay then.
> 
>>>> diff --git a/net/can/proc.c b/net/can/proc.c
>>>> index de4d05ae3459..b7858fb66178 100644
>>>> --- a/net/can/proc.c
>>>> +++ b/net/can/proc.c
>>>> @@ -189,30 +189,35 @@ static void can_print_rcvlist(struct seq_file *m, struct hlist_head *rx_list,
>>>>    			      struct net_device *dev)
>>>>    {
>>>>    	struct receiver *r;
>>>>    	hlist_for_each_entry_rcu(r, rx_list, list) {
>>>> -		char *fmt = (r->can_id & CAN_EFF_FLAG)?
>>>> -			"   %-5s  %08x  %08x  %pK  %pK  %8ld  %s\n" :
>>>> -			"   %-5s     %03x    %08x  %pK  %pK  %8ld  %s\n";
>>>> +		char *fmt;
>>>> +#if IS_ENABLED(CONFIG_KALLSYMS)
>>>
>>> Please don't. I fix %ps and then there is no leak. There will be then
>>> the 0 and everything will be fine.
>>>
>>
>> I can wait for your changes before the v2 posting.
>>
>> Btw. do you think "0" is a good return value, when people expect a function
>> name?
>>
>> What about "(unknown)" or something similar?
> 
> Yeah, that '(unknown)' looks slightly better.
> 
>>>> +		fmt = (r->can_id & CAN_EFF_FLAG)?
>>>> +			"  %6s  %08x  %08x  %8ld  %016llx  %ps\n" :
>>>> +			"  %6s     %03x    %08x  %8ld  %016llx  %ps\n";
>>>>    		seq_printf(m, fmt, DNAME(dev), r->can_id, r->mask,
>>>> -			   r->func, r->data, atomic_long_read(&r->matches),
>>>> -			   r->ident);
>>>> +			   atomic_long_read(&r->matches), r->ino, r->func);
>>>> +#else
>>>> +		fmt = (r->can_id & CAN_EFF_FLAG)?
>>>> +			"  %6s  %08x  %08x  %8ld  %016llx  (unknown)\n" :
>>>> +			"  %6s     %03x    %08x  %8ld  %016llx  (unknown)\n";
>>>> +		seq_printf(m, fmt, DNAME(dev), r->can_id, r->mask,
>>>> +			   atomic_long_read(&r->matches), r->ino);
>>>> +#endif
>>>>    	}
>>>>    }
>>> …
>>>
>>> So if you do this now, then I probably should remove that hunk from my
>>> patch.
>>
>> IMHO these /proc/net/can changes go far beyond replacing the pointer values
>> with "0".
>>
>> I hope the
>> Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> is ok for your attribution?!?
> 
> That is fine. I just mean I should drop that hunk and repost to avoid
> the pointless collision here.

Yep. Thanks!


