Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=81.169.146.221
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793728234;
	b=c4YiPt8AJsiDuokIRUqmMleBJ06SBYGuJntsRJxY9CYH54qfI3ScFrlxaA8gKKNcTfxl
	 1KJegBfZvgRseE+e435AWDOHT8TZx8AKkrv1LCnjbzAmTPANcVMiXbLAq3qM+n/U5iMy8
	 CwKUPRax27BALhaNMjhTlvqVwuqih1ocgzsQlCTeP2TP0Pq5WBXXLK6DmgoUUivW+lsZD
	 sbB7QfeQBRJpvR5RGdAGnIT0+2P/Pf/6G90/imYHwKqgyLQUL9lyMCE1e1U+fSAPaYI4c
	 FO50d3pGsLIs1sSgol74qHd5wMJQmnlgAQQt/JqahJ3GhbpyiEl1ItnuhnvmpQGMmGA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793728234;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=VpgGzYuc5l21cx5MPiSfq4p/4y6ufB55X4WYFaIBocc=;
	b=Xom5c5HXN+2Uas7/1pik3FFsUeOhmIwLLuKAiMDjv27RABaMHvcCUUhxTGjMa/aOOlWi
	 nrS+43oelZ7Vc5U2IIWbaw/G51fWHmA5K9wV++aN7HrRPiGpMrqZXIt8hzdf37TvD8qi+
	 lpBV7uq/lWb9cA/BGx0PeqgA2IYtCiQiKzL8K2Xyrm4c5fOZi6VcIOPlqRV1cKOTPy9lv
	 lyP3RotwFb3pzK3xlDO7tQqz8FrkJtHNaHXEw6U0HkTb67BkoB7HvDVfZlQkqCB2W7lnW
	 PUEMb9pq+i/bKGHhsyYNi9kV8/PeoCmv24754bBr8JFzhEa58qB3/1nuy79eN0jFjlA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=Q8RrzaBX;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b="78//bye5";
	arc=fail smtp.remote-ip=81.169.146.221
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B771606A328
	for <linux-can@vger.kernel.org>; Tue,  3 Nov 2026 17:50:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B771606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=Q8RrzaBX;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=78//bye5
ARC-Seal: i=1; a=rsa-sha256; t=1793728225; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=cAO12Ih+px3+BA2QbFrJzjvOJrNI+DixtrQV+2bqzdyLV177Gr4kHF0kcX8KwoqC/X
    zhgrF57imfLLVSkBpLsCzVlQmsTlvMsKZlf+U8SEhoPCH619a/h9MTR7rh54XQ/4rQz1
    Afonk/M4cy2kG863c04+HagoatniFfHpUW4Wkr/StwEHO1BnZ0MMnkQ88nQeBaHkEB3B
    hwmksi3rwbO8Zyg3UAoP1RjSPWnjv3ADvkPP20PtjsulHLhKVoGggBvaw+kvqA/wd5U+
    lA7vtwAG+RHw5sIw4YzOKQEIYLPYxaM4OWyIcmFj9tzAC1Fl/7QibAxs9QMmhF7KRrOj
    ASRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1793728225;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=VpgGzYuc5l21cx5MPiSfq4p/4y6ufB55X4WYFaIBocc=;
    b=tFApHn7PYxphShwRMpuNOEFDynG9Xjc3/wGlGeD9SQmiG7KubhUMT1UoIMXC1tbLoc
    De+shYQ5YNCPc1QtZN9dg14fRWaaVnHWwVjyI++7Ckvj4f2xQOWKqYLsYKEVEVuVp4zs
    XyOKXJfRsUGmjo0KmNRo/Dwa9r2SVGTWYoR79fv2gihCGBTxMB7ofFe45//L6tiQmWQx
    Fl/XdyC3G+i3G4ijD9T8LUxbsqXMex/FbnA5HPGmSdakNexgCjl1Ad9coB9EB6SxYBzW
    ++C9WBDiPNTELVexdndep64MSgiEUbxqrUL59AGHfX0jolBgALdMYtQiIVX+8BFfDhu/
    SBWg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793728225;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=VpgGzYuc5l21cx5MPiSfq4p/4y6ufB55X4WYFaIBocc=;
    b=Q8RrzaBXRKpNQ5uEfzqLs9fSap2t3mNbALQ7fnM7DVsyPGFWpBw+yQ/4cjPLwWzyo7
    G3jzgdPc6Vg4XQOm8v94ZYiMITDrDiFY5HQydBbW4xmlHYZDYUwSKa+X13DIHvO1yRHB
    nf1NCsWSmoBXvV2USbQMXWHYK4bHPBORVEA7UflrBCTdsT047QcLBAa7WvJn1+T2swFP
    Y/vNrV8dbziU42gRy0FeYjwuuPBj3x4bGHxYxVBrjN2sATjGdm/5BLz2+Qddbp6esqw5
    JJqChoSIU2WUhEDN1DIylDPXjZBF0v8fv+I7wl3sMF6ehNT5EU2+JZ6ehELIAj+CGwBc
    WgVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793728225;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=VpgGzYuc5l21cx5MPiSfq4p/4y6ufB55X4WYFaIBocc=;
    b=78//bye5DYjE0WDq6zUUQkp/DfiMs+K+1M8ewnJeqrmIgUDiscFg/VL5pO5o+quIUX
    +PYybWEgHsGtos+D66Bg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6800::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2A3HoPaST
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 3 Nov 2026 18:50:25 +0100 (CET)
Message-ID: <9667adde-87c2-4dfc-9517-e4db1613be92@hartkopp.net>
Date: Tue, 3 Nov 2026 18:50:20 +0100
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 7/7] can: proc: remove pointers from CAN specific proc
 output
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-can@vger.kernel.org, Petr Mladek <pmladek@suse.com>
References: <20261027-can-rx-lock-v12-0-eb5afc2d8b9b@hartkopp.net>
 <20261027-can-rx-lock-v12-7-eb5afc2d8b9b@hartkopp.net>
 <20261103160200.9JXGkEtP@linutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20261103160200.9JXGkEtP@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 03.11.26 17:02, Sebastian Andrzej Siewior wrote:
> my patch got merged in the meantime and should pop-up in -next tomorrow
>     https://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git/commit/?h=for-7.5-vsprintf-kallsyms&id=fd23f3c2a67c0a9d6fa78fb4f03b7d9c509984a8
> 
> This means, as of today, depending if aim for v7.4 or v7.5…

Great!

> On 2026-10-27 15:31:11 [+0100], Oliver Hartkopp wrote:
>> --- a/Documentation/networking/can.rst
>> +++ b/Documentation/networking/can.rst
>> @@ -1038,21 +1038,25 @@ procfs content
>>   
>>   As described in :ref:`socketcan-receive-lists` the SocketCAN core uses several filter
>>   lists to deliver received CAN frames to CAN protocol modules. These
>>   receive lists, their filters and the count of filter matches can be
>>   checked in the appropriate receive list. All entries contain the
>> -device and a protocol module identifier::
>> +CAN network device, the filter (can_id/can_mask), the number of filter
>> +matches, the inode number of the subscribing socket and the name of the
>> +receive function. A sock_inode of 0 denotes a kernel internal subscriber
>> +without a socket (e.g. CAN gateway or J1939). When the function name can
>> +not be resolved (e.g. with CONFIG_KALLSYMS=n) "(unknown)" is printed::
> 
> it will print a hashed pointer instead "(unknown)". I suggest you strip
> that sentence because you rely on %ps implementation (more later).
> …
>> --- a/net/can/proc.c
>> +++ b/net/can/proc.c
>> @@ -202,30 +202,36 @@ static void can_print_rcvlist(struct seq_file *m, struct hlist_head *rx_list,
>>   			      struct net_device *dev)
>>   {
>>   	struct receiver *r;
>>   
>>   	hlist_for_each_entry_rcu(r, rx_list, list) {
>> +		char symcheck[4];
>>   		char *fmt = (r->can_id & CAN_EFF_FLAG)?
>> -			"   %-5s  %08x  %08x  %pK  %pK  %8ld  %s\n" :
>> -			"   %-5s     %03x    %08x  %pK  %pK  %8ld  %s\n";
>> +			"  %6s  %08x  %08x  %8ld  %10llu" :
>> +			"  %6s     %03x    %08x  %8ld  %10llu";
>>   
>>   		seq_printf(m, fmt, DNAME(dev), r->can_id, r->mask,
>> -			   r->func, r->data, atomic_long_read(&r->matches),
>> -			   r->ident);
>> +			   atomic_long_read(&r->matches), r->ino);
>> +
>> +		/* %ps falls back to the raw text address when the symbol
>> +		 * can not be resolved (KALLSYMS=n, stripped module symbols)
>> +		 */
>> +		snprintf(symcheck, sizeof(symcheck), "%ps", r->func);
>> +		if (strncmp(symcheck, "0x", 2))
>> +			seq_printf(m, "  %ps\n", r->func);
>> +		else
>> +			seq_puts(m, "  (unknown)\n");
> 
> This can go and please just rely on %ps in the former seq_printf().
> 
> There was a discussion whether a function pointer should return
> "(unknown)", a hashed pointer or the actual pointer and in the end it
> was agreed that the hashed pointer wins because one can compare against
> other hashed pointer to check if it is the same function or not.
> I would appreciate if the behaviour is the same in the kernel and CAN is
> not an exception. If this is intended for v7.4 then keep it as is but
> please send a follow-up for v7.5.

@Marc: I won't re-spin the v12 series for this improvement from 
Sebastian intended for 7.5.

This patch is good as-is and solves the current problems.

I'll send another patch to reduce the code here in proc.c once 
Sebastians patch has finally landed in net/mainline.

Best regards,
Oliver

