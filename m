Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69D6469843;
	Mon, 12 Oct 2026 12:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791806745; cv=pass; b=lI7f/GxL88yfQCQiLpUdQEXYCMTOtlqaI57Td8xhQNyNUCaZFOh7GnzVerSAZFOwxKdU+bEm2dHMPcy3eKOS90Vl/xnnYcmDT51bY4gHMXx2r22NDJZKcTY4eFYVRInpk4IwA53IiuDqyRMcGvssGq6zR724zTrhyCurGKul91I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791806745; c=relaxed/simple;
	bh=ZdaWLGjj0j927i3ZlmQ/nvl2sv+OqepwgzTatYNlrqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BwGA9oc4h5ZV1WVcD2wgTqPFbitv/EDlGZDYHITN25vuI32KrakHIBHo0SpzN/cm3KSjK/DcOy4q+uRkttPq2S/8rIbao3YCChQYfbVcpty9nP5euIHK/lGSnV7qkfmuHTgWywnjd9nskMOQiM018Upn0bQI7C3tVQlMFbSqPIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=gXEw2o04; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=P/UB28fI; arc=pass smtp.client-ip=85.215.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="gXEw2o04";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="P/UB28fI"
ARC-Seal: i=1; a=rsa-sha256; t=1791806556; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=VeskxLpsCfSiDfJ4ir+17k7wOiZS06RHYGHNtbBjAIcL0NC8O7rwnYx2KVjeU4N8iS
    SSNh/flGWc2sXtANnzQUQmXs688itwTZSW9jtJWRvrz9eKsOlblwX9fXJCvoRR8C17sI
    QZgKZtETnCt+bUa5vUGT78k2wQTOhI4H4q4/urUhncqTb57Fv3XkwaC3XJXI+0sw/Swk
    w0jVXTj5AA4zLH3HJBcwDb1n2d597VB+RdWHgEfuLIsApLSu/Tk37bTcAuPR/i5gUcD9
    UmGF4ODbIAscjhC7HxLIOzkcoleCcfi/nL3mOtajPW/XqSVgvOQwq3VVDqsz8UK90+Ea
    /MHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1791806556;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=qCGVGbZ2bz6RgZqBwNPxwKhB503I0EyZMWKRFMFUhkQ=;
    b=gHJ7UCQdC67l+9MvYf+Hpc+2HASOgCKafjipzG/PNxxODjk2dg2PbDPtTP5Pvk2LA0
    wncPZO+36qSqA+tr4t6SkubgxW1B4CczYlLDr02w7db49+eNQoTnycDlQkz8yuLedG1Q
    /wN1xOQnH4hfsCg0p6wgsDFqNkhSBB1z08295Cic1oV2fzslbZzZ+7PehLaFSxICCcAz
    kECTFP4ljgcF5SWzJd+alRrNYIY37ShRbZN32y8cu1oqao9pP9f7CZY4a9dVq8YiLER1
    DfX0NEhd5/OS/TWNQg4Fj6lsY8CaLF1Oi7OJgXjo0NRjiLJzxojacS7GTv67XE0o2dZ3
    YWDQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1791806556;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=qCGVGbZ2bz6RgZqBwNPxwKhB503I0EyZMWKRFMFUhkQ=;
    b=gXEw2o04RkguMi9Ar8hynGNi6A9TDgPDfbOeXZr5qFvK6z28XGFKG5WLvn8EuYWgME
    8nT0Po2UwdmOU/KnvDuvMidqxdhEVZ1yXrlWM/tHqHD74cz2e8V/7U2N7E3Qxo0THHzJ
    uEGr9SG1Uqu3+7SeRq0qYqIXxNsqC14rsmRwUxDAKBObjpCMjjr1+6QoJVeNF/KXF7Jr
    +A/xnlLyJqXtqX+A4wMLO+P/DFLGR6MGxgk8LSKzUSCH72SIP74DGmAytInOmUTbQax5
    kQeHUdYEIZhkv8ZqtFZc+1C/G5FAVa5fHxvjuOxKIJ0qSuaBaqCdL2kM/ZzbSbuzwH8N
    L+8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1791806556;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=qCGVGbZ2bz6RgZqBwNPxwKhB503I0EyZMWKRFMFUhkQ=;
    b=P/UB28fI66JNvFSB8dVytx8yioIl0cYG/eGLfvQH8lVk2cptHfn3C384GK7+fE+Imv
    NbsqJtaUxFBeEJ3HByCg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K04b9a29CC2Zf1F
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 12 Oct 2026 14:02:35 +0200 (CEST)
Message-ID: <4dcf22bb-7d0b-444d-9449-e4bd3a3aab6b@hartkopp.net>
Date: Mon, 12 Oct 2026 14:02:30 +0200
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
 linux-can@vger.kernel.org, kernel@pengutronix.de, hemanth.selam@gmail.com
References: <20261009134323.64064-6-mkl@pengutronix.de>
 <179164096953.434549.17541028335124817965@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <179164096953.434549.17541028335124817965@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10.10.26 16:02, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 · Medium: 0 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] The commit says it stops /proc/net/can/ from leaking kernel
>    pointers, but on some builds it now leaks a raw kernel text address.
> - [Low] The procfs example in Documentation/networking/can.rst was
>    replaced, but the text around it was not updated.
> 
> --
> 
> can: proc: remove pointers from CAN specific proc output
> 
> This patch stops printing kernel pointers in /proc/net/can/rcvlist_* and
> /proc/net/can-bcm/. It prints socket inode numbers and %ps callback names
> instead. The ident string argument of can_rx_register() becomes a u64
> inode number, and the bcm proc file name is now the inode number in hex.
> 
> Link: https://patch.msgid.link/20260815103400.117175-1-socketcan@hartkopp.net
> 
>> diff --git a/Documentation/networking/can.rst b/Documentation/networking/can.rst
>> index 536ff411da1d1..7bdb27a22a0ea 100644
>> --- a/Documentation/networking/can.rst
>> +++ b/Documentation/networking/can.rst
>> @@ -1042,15 +1042,15 @@ receive lists, their filters and the count of filter matches can be
>>   checked in the appropriate receive list. All entries contain the
>>   device and a protocol module identifier::
>>   
>> -    foo@bar:~$ cat /proc/net/can/rcvlist_all
>> +    foo@bar:~$ cat /proc/net/can/rcvlist_fil
>>   
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
> 
> [Severity: Low]
> This isn't a bug, but the text around the new example still describes the
> old one. The sentence after the example says:
> 
>    In this example an application requests any CAN traffic from vcan0::
> 
> That matched the old rx_all entry, which had can_id 000 and mask 00000000.
> The new entry is in rx_fil with can_id 80000123 and can_mask c00007ff. It
> only matches non-RTR EFF frames whose low 11 ID bits are 0x123.
> 
> The sentence before the example also still says every entry contains "a
> protocol module identifier". The new function column is the %ps name of
> the callback. It only shows a "[can_raw]" style tag when the protocol is
> built as a module, and it is a plain number on !KALLSYMS builds.
> 
> Should this text be updated to match the new output?
> 
> [ ... ]
> 
>> diff --git a/net/can/proc.c b/net/can/proc.c
>> index 64b3bdc2fa7e0..33d99543e3fe2 100644
>> --- a/net/can/proc.c
>> +++ b/net/can/proc.c
>> @@ -215,25 +215,21 @@ static void can_print_rcvlist(struct seq_file *m, struct hlist_head *rx_list,
>>   
>>   	hlist_for_each_entry_rcu(r, rx_list, list) {
>>   		char *fmt = (r->can_id & CAN_EFF_FLAG)?
>> -			"   %-5s  %08x  %08x  %pK  %pK  %8ld  %s\n" :
>> -			"   %-5s     %03x    %08x  %pK  %pK  %8ld  %s\n";
>> +			"  %6s  %08x  %08x  %8ld  %016llx  %ps\n" :
>> +			"  %6s     %03x    %08x  %8ld  %016llx  %ps\n";
>>   
>>   		seq_printf(m, fmt, DNAME(dev), r->can_id, r->mask,
>> -			   r->func, r->data, atomic_long_read(&r->matches),
>> -			   r->ident);
>> +			   atomic_long_read(&r->matches), r->ino, r->func);
>>   	}
>>   }
> 
> [Severity: High]
> On CONFIG_KALLSYMS=n builds, does can_print_rcvlist() now print a raw
> kernel text address?
> 
> The old format printed r->func with %pK. %pK follows kptr_restrict, so
> unprivileged readers saw a hashed or zeroed value. With %ps, symbol_string()
> falls back to the raw value when kallsyms is not built in:
> 
> lib/vsprintf.c:symbol_string() {
>      ...
> #else
> 	return special_hex_number(buf, end, value, sizeof(void *));
> #endif
> }
> 
> In that case the plain address of raw_rcv, bcm_rx_handler, isotp_rcv,
> isotp_rcv_echo, can_can_gw_rcv or j1939_can_recv would be printed.
> 
> can_init_proc() creates the rcvlist_* files with mode 0644. An unprivileged
> user can also add an entry by opening a CAN_RAW socket, through
> raw_enable_filters()->can_rx_register(). CAN has no KALLSYMS dependency in
> net/can/Kconfig, and KALLSYMS can be turned off under EXPERT.
> 
> Those builds also lose the old r->ident string ("raw", "bcm", "isotp",
> "gw", "j1939"). The column then shows only a number, not a protocol
> identifier.
> 
> Would a fixed per-protocol name work better here? Another option is to
> print a placeholder, or keep %pK, when CONFIG_KALLSYMS is off.
> 
> [ ... ]
> 

Addressed all sashiko-bot findings in a v2 patch here:

https://lore.kernel.org/linux-can/20261012115851.3412-1-socketcan@hartkopp.net/

Best regards,
Oliver


