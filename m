Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351E817A300
	for <linux-can@vger.kernel.org>; Tue, 14 Jul 2026 10:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784025694; cv=pass; b=hGO/sJIt71Hka23Wq1UnKLUkgo1vgMgQ2DlFDYhiSSOWFgJKedHDKTms2XAbvn2zmHpBs5P5OhQWs5MzYsw30w83dBl6wCM/8QAt5VS00WxzOWtaKZyw8CuZlU88sLnUEg6u01Mmw9xw4Lj8GXtSoCJwdiXOt2Zpm4GPgtym0eI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784025694; c=relaxed/simple;
	bh=+ls93YmnaiL8UFyVAe/eD/FA7CbjhyZf58l7Jk6gAZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JPzYrqqMrENWzu326EqOcn7pah27m5UZRIcTBuv5q0SOAAsLqdq8s2OeJmLys15p6c9S3QJQvXRqciLrtjQCrDWRLUvq4ixxzmOzu8Vj6oAA9dXjuvPV/ZneUGrd1NJoEd0x0uZfNG+cgs9YtF0z1oOyLA0CHUR9zMP0U6xhVBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=JJLxlGd4; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=csVpGV8F; arc=pass smtp.client-ip=85.215.255.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="JJLxlGd4";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="csVpGV8F"
ARC-Seal: i=1; a=rsa-sha256; t=1784025689; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=M2n7P+Dsv3FfV+jMKW9/3KcOyfbC6J243BDROqjfaXGY7XignECE7Vq8kgXy4fnGXg
    7/RrjHzrn+vEzsKXIw/00onda52JEVNpYtYwWPFpCg7hE+fre5VOnzhGPua5vcKhhI/L
    KTB2Cmn0bKVHh2V2hIhAaQWWYETw/vD83wC10Y7X7ZYJKDJ+Ir5TD6of0nCVVOH+tRxN
    epvNrZebD6PJgaanFCn4HkGl5kqyLtlMnBgf2RKg3SiwagLl2hfRyvTFqcFQr/PiXCPU
    nkFzE4GW+vjdgRa4pX1rkhuHPteRHB4uTjMGRGZH2xHJWuhCUNmtMP1XugkYB5KP7ylz
    EulA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1784025689;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Xu2eFAqzyC+xb3VATl6/FRzQNqiClEaa8gA+ypLC854=;
    b=i22tnZEO9aaLlaQIW1YLdOL+RHmFtsB5lCNzNlJZbnZGlVW+AKjkhJ3ezhOdTHk0vH
    3ehpkN3hLPPD1yq1o1GBUYhy67apQoRA8U++5nfaKAgMUyHvBUhFH8FLeyaTawknD3HJ
    oTRA8kPG9YnvKjnr6Tjv9SQVPdk2G2vTBpx9dlYiR/6zLlVRtAm1ink++4FoeyH4Uhl5
    Sg64xjB5jT4k8kyALI0kchm7TmzDVA5tCfVBzzVbXEyfCw42byev2kOplz9CYQzeWR/Z
    J6f8RcLd0innMA+og58YuD+qR7O9M+P00xpfEQQ1vCwUmWaeLJhcUr8+TjGkhSQJ57RO
    UZxg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1784025689;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Xu2eFAqzyC+xb3VATl6/FRzQNqiClEaa8gA+ypLC854=;
    b=JJLxlGd41gqAPBdPtv+0qUiH5UDKrAfzeJdo4A7VFKtn2hCL1ASwNwF+7DvitCUBEI
    BSXZIdTYGDY3DBfnvz6rzXfjr/9v5w6kLgfdolAg9js0P9kQA2h8ACLqMo2zCjpEpIQK
    Sg+Q4ruN0M1tcT8S3U75YazDCcftE3tgTRwByZ0Ukt3Fq1I1dnzCB9nraAGlR7r7KRuW
    rp78ODc/JPaqr29vOJ62OZMVnURz7AuoPOGwNgMtLF2/0fRAvozbZ+RAXX5FyJ/Gc3Jx
    Z4vWUM8GrizMfD3QR6BZkYTpHaHRUsbJAsBANbWddBTrji4uHs+2SUpLGU6CkTNVuOTK
    Ljbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1784025689;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Xu2eFAqzyC+xb3VATl6/FRzQNqiClEaa8gA+ypLC854=;
    b=csVpGV8FWxDx/14QlnOfoLSrkg4sFTun9LXgbodUF2LH7xl8HXmlQVNWqr06C7mBvH
    SNX5a+8L06PLyjZS1+Bw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.20.190]
    by smtp.strato.de (RZmta 55.5.6 DYNA|AUTH)
    with ESMTPSA id Ka9fdb26EAfTj9j
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 14 Jul 2026 12:41:29 +0200 (CEST)
Message-ID: <f16a7692-62ab-4c9b-a7b5-2382cb83219a@hartkopp.net>
Date: Tue, 14 Jul 2026 12:41:29 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 02/11] can: bcm: fix lockless bound/ifindex race and
 silent RX_SETUP failure
To: sashiko-reviews@lists.linux.dev
Cc: Vincent Mailhol <mailhol@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
References: <20260714-bcm_fixes-v13-0-fd667c61099a@hartkopp.net>
 <20260714-bcm_fixes-v13-2-fd667c61099a@hartkopp.net>
 <20260714103353.F0FEC1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260714103353.F0FEC1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14.07.26 12:33, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Unsafe lockless iteration of `bo->tx_ops` and `bo->rx_ops` in procfs, using `list_add()` instead of `list_add_rcu()` for list updates and `list_for_each_entry()` instead of `list_for_each_entry_rcu()`.
> - [High] `bcm_rx_setup()` modifies an active `rx_op`'s data and state from process context without any synchronization with `bcm_rx_handler()` running in softirq context.
> - [High] `bcm_tx_setup()` modifies an active `tx_op`'s frames and flags without holding `bcm_tx_lock`, racing with the softirq timer and transmission paths.
> --
> 

Fixed later.

> --- Patch [2]: [PATCH v13 02/11] can: bcm: fix lockless bound/ifindex race and silent RX_SETUP failure ---
> commit 79233a73945b83eac56e8c17536d2f019c104f50
> Author: Oliver Hartkopp <socketcan@hartkopp.net>
> 
>      can: bcm: fix lockless bound/ifindex race and silent RX_SETUP failure
>      
>      bcm_sendmsg() reads bo->ifindex and checks bo->bound before taking
>      lock_sock(), while bcm_notify(), bcm_connect() and bcm_release() all
>      mutate both fields under that same lock. Because the lockless reads
>      and the locked writes are unordered with respect to each other, a
>      racing bcm_notify() (device unregister) or bcm_connect() (concurrent
>      bind on another thread sharing the socket) can make bcm_sendmsg()
>      observe an inconsistent combination, e.g. a stale bound=1 together
>      with the now-cleared ifindex=0, silently turning a socket bound to a
>      specific CAN interface into one that also matches "any" interface.
> 
>      Link: https://lore.kernel.org/linux-can/CAGp+u1aBK8QVjsvAxM2Ldzep4rEbsP9x_pV3At4g=h1kVEtyhA@mail.gmail.com/
> 
>> diff --git a/net/can/bcm.c b/net/can/bcm.c
>> index bdf53241bd7b3..b612135b017d1 100644
>> --- a/net/can/bcm.c
>> +++ b/net/can/bcm.c
>> @@ -1323,6 +1323,11 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
>>   
>>   				op->rx_reg_dev = dev;
>>   				dev_put(dev);
>> +			} else {
>> +				/* the requested device is gone - do not
>> +				 * silently succeed without registering
>> +				 */
>> +				err = -ENODEV;
>>   			}
>>   
>>   		} else
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does bcm_rx_setup() safely
> modify an active rx_op's data and state from process context without
> synchronization with bcm_rx_handler() running in softirq context?
> 
> bcm_rx_setup() directly overwrites op->frames via memcpy_from_msg() and
> clears op->last_frames while only holding lock_sock(sk):
> 
> net/can/bcm.c:bcm_rx_setup() {
>      ...
>      err = memcpy_from_msg(op->frames, msg, msg_head->nframes * op->cfsiz);
>      ...
> }
> 
> Concurrently, bcm_rx_handler() executes locklessly in the softirq RX path
> and reads these frames:
> 
> net/can/bcm.c:bcm_rx_handler() {
>      ...
>      if ((get_u64(op->frames, 0) & get_u64(rxframe, 0)) == ...
>      ...
> }
> 
> Since memcpy_from_msg() copies from userspace and can block or be preempted,
> could the softirq observe partially updated frames, mismatched lengths, or
> torn flags, leading to incorrect CAN message filtering and potential data
> corruption?
> 
> [ ... ]
>> @@ -1436,20 +1463,21 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>>   			struct net_device *dev;
>>   
>>   			dev = dev_get_by_index(sock_net(sk), ifindex);
>> -			if (!dev)
>> -				return -ENODEV;
>> +			if (!dev) {
>> +				ret = -ENODEV;
>> +				goto out_release;
>> +			}
>>   
>>   			if (dev->type != ARPHRD_CAN) {
>>   				dev_put(dev);
>> -				return -ENODEV;
>> +				ret = -ENODEV;
>> +				goto out_release;
>>   			}
>>   
>>   			dev_put(dev);
>>   		}
>>   	}
>>   
>> -	lock_sock(sk);
>> -
>>   	switch (msg_head.opcode) {
>>   
>>   	case TX_SETUP:
> 
> [Severity: High]
> This is a pre-existing issue, but does bcm_tx_setup() modify an active
> tx_op's frames and flags without holding bcm_tx_lock, racing with the softirq
> timer and transmission paths?
> 
> When updating an existing tx op, bcm_tx_setup() calls memcpy_from_msg() to
> update op->frames before acquiring bcm_tx_lock:
> 
> net/can/bcm.c:bcm_tx_setup() {
>      ...
>      err = memcpy_from_msg((u8 *)cf, msg, op->cfsiz);
>      ...
> }
> 
> Meanwhile, bcm_can_tx() drops the lock and calls skb_put_data() to copy the
> frame into an skb:
> 
> net/can/bcm.c:bcm_can_tx() {
>      ...
>      skb_put_data(skb, cf, op->cfsiz);
>      ...
> }
> 
> Could this data race allow the softirq to transmit partially updated CAN
> frames onto the bus? Because memcpy_from_msg() accesses userspace and might
> block, the race window appears wide enough to result in deterministic
> corruption of transmitted frames under concurrent updates.
> 
> [Severity: High]
> This is also a pre-existing issue, but is it safe for bcm_proc_show() to
> iterate over bo->tx_ops and bo->rx_ops locklessly in procfs, while
> bcm_tx_setup() and bcm_rx_setup() use list_add() instead of list_add_rcu()?
> 
> bcm_tx_setup() and bcm_rx_setup() insert new operations using the plain
> list_add() macro, which lacks the smp_store_release() memory barrier:
> 
> net/can/bcm.c:bcm_tx_setup() {
>      ...
>      list_add(&op->list, &bo->tx_ops);
>      ...
> }
> 
> bcm_proc_show() traverses tx_ops locklessly under rcu_read_lock(), but uses
> the unsafe list_for_each_entry() macro entirely bypassing RCU read primitives:
> 
> net/can/bcm.c:bcm_proc_show() {
>      ...
>      list_for_each_entry(op, &bo->tx_ops, list) {
>      ...
> }
> 
> Could a concurrent procfs reader observe the list pointer before the bcm_op
> structure is fully visible in memory, causing a dereference of uninitialized
> memory or a crash?
> 
>>   		ret = bcm_tx_setup(&msg_head, msg, ifindex, sk);
>>   		break;
> 

