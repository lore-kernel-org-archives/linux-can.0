Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EFA3B9D8C;
	Fri, 16 Oct 2026 10:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792147693; cv=pass; b=G/ty73Buk0/Klwg4/BoOBhYIkB2XQYk7r09hjtrUpiv1DF8CWWhqpyDbV8yfzGWxShn4wY8+nAkmP/6Viy4VO9IMCv9SCLQlGqDbs0+mXe+L9ns6F59SclTJ/ZW1tTy68WB++4+XLixreBHoklDNpk91nnxt46G1nCBIgeB1TIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792147693; c=relaxed/simple;
	bh=RroyDKk8sDGCxX5nQ0oVNqzrioUpDPA8SVdEHSeVpUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MHizXYTH59GTdNrkqvtlPsZwSzHTRn/JVqj9JGhpW4l+RAnvX/kPuyhxcCnm39dcrTE3wRV7q2x0KlUfrOlTZrUadJOuNRzx5qlWRR13dGcIPGp0A90CxcUqnZD4w7dw2stHVNLNAOT7Rj0V0dUH4vWU7SE/dYBB6EOuJEm/t3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=RyUOJVZj; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=w0kGioZz; arc=pass smtp.client-ip=85.215.255.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="RyUOJVZj";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="w0kGioZz"
ARC-Seal: i=1; a=rsa-sha256; t=1792147371; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=SdM5WUtFtFGk6ApXacebyRFMnm7XshpkuMaCgFW+N7I5Ef0sX0ph5bEWrbEfcyH+Fo
    zeNLSLnfSFvxdvBR0LUwGQrzRVyngXgakKIymi8couVTCUhJJ8lHDPy0+OFkbCJJhH6g
    eB4tfQKiZ5/rvsZBG7LVQv6phD2XN5y9AxwC3znVH8V+TSXfSIAKG8NA6ndolrtlxiT4
    6wIo4mgGdUhbAUzi/XNNsaakhaSqsXt0uDfd79HuCPczH+z+xRmi1W8LF6Ds1FG4v3Eu
    lel2Z8+56XGeJm8zmkb5/hpkStZ00+95+1kgnqd4rpI0TZwALvp+GTf9F23kUoqaTWbh
    zNOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792147371;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=nNjMM7OheUmGmImMBUZ9l53WpbVTAXpW9JyYf4yzsHM=;
    b=tIFk6FNOJXM04vyXPvzRE4Lx+5eDjhUnQtLmRoqky4za2hd5Z6MLGUijzYHJQJwWew
    DARAVOgYf/t0R4s0DPwYEwdwVV988+Q4WWV9lKYm1yVBmvchlXJZZFXM1rMG1G+mDJK/
    E9JzRtedIfnPX5UIncRQNmcxhhWAolQo678adUo/BigKu0eUaqSAef4PqqY/1GikmMyh
    XJHnS1ktL4qm9JYJsb5U/2BlVZ9lXso3CW0KuLAJ0WKftVqWqkErBx5r0ftdBew/GebZ
    iCI6CoyoyuYUjzMPQnMXoWhX1SH1rSSkxdz6oLpeXow0uLnLMzvqY9ala4TIvkAIzXNz
    ddAQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792147371;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=nNjMM7OheUmGmImMBUZ9l53WpbVTAXpW9JyYf4yzsHM=;
    b=RyUOJVZjsh0CsnXebpqBAowkgf8Gl2exFDkyGuwEICwq2CmvYTRbuoMmGKpukXKq/j
    PbMg6Guw4n5HkP5paXy50Xg8iq7OTItvqnUXiSb4nQrtjactnI1yzWHr5xizPGeCLZGC
    xihTpeloi5FTdn8DhMKiUSZ12+1DbGv1N48yYLIL8Frio6FHEImcSPxR3s9lXdGQUXlF
    Kg0iLH1kZj9oOfx+SuuFzzJel7WaPlmmESuOHxiGSkVSn6LuMbVmmUiRyeaQmTaFM8Yo
    yhDYNSklSXL8Tx/3a6K9ytM3bZKOQ1SFgq1JTmFSUbmMdH3t2g6OUwYcZNrmeXOIHw5s
    Y41A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792147371;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=nNjMM7OheUmGmImMBUZ9l53WpbVTAXpW9JyYf4yzsHM=;
    b=w0kGioZzmdpzF2BrJLePZ/gB0TERIqRztrre7gTF/qiKngN4hnL2URdLPlChjBRtFp
    fHxGwfgUXn0eY2sfQRCw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29GAgoLpc
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 16 Oct 2026 12:42:50 +0200 (CEST)
Message-ID: <c23ba59b-5261-4336-9712-995ed529da20@hartkopp.net>
Date: Fri, 16 Oct 2026 12:42:50 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 05/37] can: proc: remove pointers from CAN
 specific proc output
To: netdev-bot+sashiko@kernel.org, mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, kurt.van.dijck@eia.be
References: <20261015015336.816543-6-mkl@pengutronix.de>
 <179211822419.434549.2749733586204077125@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <179211822419.434549.2749733586204077125@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 16.10.26 04:37, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] The new CONFIG_KALLSYMS guard in can_print_rcvlist()
>    (net/can/proc.c) does not stop the receiver callback address from…
> - [Low] The updated text in Documentation/networking/can.rst says every
>    rcvlist entry contains 'the CAN network device and the subscribed…

Both fixed in

[PATCH can-next v3] can: proc: remove pointers from CAN specific proc output

https://lore.kernel.org/linux-can/20261016103706.410678-1-socketcan@hartkopp.net/

Thanks,
Oliver

> 
> --
> 
> can: proc: remove pointers from CAN specific proc output
> 
> This patch stops printing kernel pointers in the /proc/net/can/ and
> /proc/net/can-bcm/ output. The rcvlist entries now show the receiver
> callback name via %ps (or "(unknown)" when CONFIG_KALLSYMS=n) and the
> socket inode number. can_rx_register() now takes an inode number in
> place of the ident string.
> 
> Link: https://patch.msgid.link/20261012115851.3412-1-socketcan@hartkopp.net
> 
>> diff --git a/Documentation/networking/can.rst b/Documentation/networking/can.rst
>> index 536ff411da1d..908c199cf6ad 100644
>> --- a/Documentation/networking/can.rst
>> +++ b/Documentation/networking/can.rst
>> @@ -1040,17 +1040,17 @@ As described in :ref:`socketcan-receive-lists` the SocketCAN core uses several f
>>   lists to deliver received CAN frames to CAN protocol modules. These
>>   receive lists, their filters and the count of filter matches can be
>>   checked in the appropriate receive list. All entries contain the
>> -device and a protocol module identifier::
>> +CAN network device and the subscribed function name::
> 
> [Severity: Low]
> Is this sentence accurate for every configuration?
> 
> With CONFIG_KALLSYMS=n, can_print_rcvlist() prints the literal string
> "(unknown)" in place of the function name. The commit message mentions
> this, but the documentation does not.
> 
> The new sock_inode column is also not explained. Kernel-internal
> subscribers pass ino=0:
> 
> net/can/gw.c:cgw_register_filter()
>      gwj, 0, NULL);
> 
> net/can/j1939/main.c:j1939_can_rx_register()
>      j1939_can_recv, priv, 0, NULL);
> 
> Could the text mention the "(unknown)" case and say that a sock_inode of
> 0 means there is no associated socket?
> 
>>   
>>       foo@bar:~$ cat /proc/net/can/rcvlist_all
> 
> [ ... ]
> 
>> diff --git a/net/can/proc.c b/net/can/proc.c
>> index 64b3bdc2fa7e..64994ab48541 100644
>> --- a/net/can/proc.c
>> +++ b/net/can/proc.c
>> @@ -215,25 +215,27 @@ static void can_print_rcvlist(struct seq_file *m, struct hlist_head *rx_list,
>>   
>>   	hlist_for_each_entry_rcu(r, rx_list, list) {
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
>> +		/* without kallsyms %ps would print the raw text address */
>> +		if (IS_ENABLED(CONFIG_KALLSYMS))
>> +			seq_printf(m, "  %ps\n", r->func);
> 
> [Severity: Medium]
> Can %ps still print the raw callback address when CONFIG_KALLSYMS=y?
> 
> The IS_ENABLED() check covers only the config option. It does not check
> whether the symbol lookup succeeds. When kallsyms_lookup_buildid()
> fails, the %ps path falls back to an unhashed address:
> 
> symbol_string()
>    sprint_symbol_no_offset()
>      __sprint_symbol()
>        kallsyms_lookup_buildid()
>          module_address_lookup()
>            find_kallsyms_symbol()
> 
> kernel/module/kallsyms.c:find_kallsyms_symbol() {
>      ...
> 	if (!best)
> 		return NULL;
>      ...
> }
> 
> kernel/kallsyms.c:__sprint_symbol() {
>      ...
> 	if (!len)
> 		return sprintf(buffer, "0x%lx", address - symbol_offset);
>      ...
> }
> 
> The callbacks registered here are all static functions in modules:
> raw_rcv, bcm_rx_handler, isotp_rcv, isotp_rcv_echo, can_can_gw_rcv and
> j1939_can_recv.
> 
> scripts/Makefile.modinst passes custom INSTALL_MOD_STRIP values straight
> to strip, so a module installed with something like
> INSTALL_MOD_STRIP="--strip-unneeded" or "-x" can lose these local
> symbols. If no named symbol comes before the callback in that module's
> text, the lookup fails. This depends on section layout, which has not
> been fully confirmed.
> 
> The rcvlist files are created 0644 in can_init_proc(), so any local user
> can read them. The old %pK output applied kptr_restrict. In this
> configuration the new output would show the real module text address.
> 
> Would it be safer to resolve the name explicitly, for example with
> sprint_symbol_no_offset() or lookup_symbol_name(), check that the lookup
> succeeded, and print "(unknown)" on any failure? The commit message says
> the patch "removes the disclosure of pointers", so it seems worth closing
> this case too.
> 
>> +		else
>> +			seq_puts(m, "  (unknown)\n");
>>   	}
>>   }
> 
> [ ... ]
> 

