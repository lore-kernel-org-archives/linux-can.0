Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.165
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794211228;
	b=P2G+TB9xOksK6QqOMyjVyVPacRTncq4bdaOKAXx0dhTxHDM62Vha15Vx9sYveaWktqfU
	 jsCb3bkAdyyoHlAvUicETBwoOhMxb/OZTn+afVMn5YLHe2Y04nBhPbOKVGRcEhtFnNgud
	 RzZX8JCLrS95JvKW+04VHxgxGJtHZeiSxwYNueQwN1pxRVuBIUY7qx5Pe7hEmkv440Now
	 n7b9VqFSz9GNmDeJT5enhiOkOpbCPAWbvWP5QdXth1pRA69YH/5CMjtN4w4sXo99SnsVB
	 liGo4L6iToDE5BACm7tGuc9L0qaTsmKHdAXypijEuUysX2R//8MgHVVw/NDgn+Deo1g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794211228;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=LZmFD3PvdrgjPnyl3OLBNmIcdx6VnDLZ9YRSh0z1O6o=;
	b=Obq8846KWViExbHIReDwkN+YUqMYPhF68DZ+z1PP2X3BkZ31PO6nwZQ4dDTJ31ES3us0
	 LvDvIJO9ZsK04SmU9upCoziOM5+y9fDwV7l7ptzRgPNWI+yqItr9m/K3C4bePbo7cW6X4
	 vFQegta6fxqk9jJWx8RZV6YX9FHE89toTaK+UbAzbPlWx3gqX/J7i5L5nLK7shnQebVqb
	 pyC4vIaHPh3h3HptLhUrv3GEqOYQX9zqDWf28SBoYr/x2izPzWVoLSh7mKNXrgzGXaNwU
	 IpTHmgYf+z1s5IqciqQlof1Q2LDa3E2uFZ/qAMzLUfg+OA6rICMLlViWsRxc6Jp5sDQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=pPVEW0bz;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b="O/2ux7iW";
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.165
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9981606A31C
	for <linux-can@vger.kernel.org>; Mon,  9 Nov 2026 08:00:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9981606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=pPVEW0bz;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=O/2ux7iW
ARC-Seal: i=1; a=rsa-sha256; t=1794211216; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=CtsKWYM/aUqBxb3rjocEJGz7d/b7D9uKE89SZfNWNtDx2a1e3Cu5v5XETnGNxRzPOc
    r3Tb1Cgz6J37S3zwxL00sQY9B4rPlDBUtKZQctHtdGLi2/MIWPpFEp4qcwxxUIUjfsPx
    FBafTjbwkXK6E2YAjwKOqkI/MC/KJDBRxV8BC1PBBtXLJSW+PNq9gXtqPf+LbC0cCmb6
    +qtzReU6pK+pigfQdb24fs4qDymsNZui8T6uuyuNDmVSbMjPpvcm1/XhKzJoX2WAf1A+
    ckt3PYlQxk2+B8HrNqicw7r2IgWxfbIjthMyToiKyuKGs4qdJv596LkRhT22djPLsKUv
    gEtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794211216;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=LZmFD3PvdrgjPnyl3OLBNmIcdx6VnDLZ9YRSh0z1O6o=;
    b=r0BguAk6UHTmw727r3lvcdAv17aBX6w1jPcHIN+4kr44zKDmjCzYJ7tCoHdYjk3nGO
    D65lzXXh06JwTMCYaTiUvaKhsrXzz06V3vaTjmcx7NXo83kjooQuTQYVhjPdDV/mpObA
    kO5pl4NFebKeuvYJ54r4LMfPhAM3hQAYd0UQHe/qX5peaOYOQhZk2+Fyq9ZENuVwFjae
    YtbIUxJEklkAIMyuSMhVu9FWnjIzNaHK1g4Dsbv3iyppp4+EOt5vsSD6gCeWjMIEXVRu
    1jJTCrEE7j6shWgpmpHC4Oo+p5Lqx76Tc06YfXUQUrWgi5FVC2LmOOasaBumWmnyzthV
    czSg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794211216;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=LZmFD3PvdrgjPnyl3OLBNmIcdx6VnDLZ9YRSh0z1O6o=;
    b=pPVEW0bzX2BrGR+oXCriciwkswOKMTO9uYPRl0tRCDh1sXEm+5sTpTO/N5hhw1Nfuu
    mRCFeF6e0mD8zN10YjXcbjVoIHeHcnxxIIyoYHNB6r00STroWrq9xyOQbwj7khZigxwW
    qiN1PLMZhkEYFuLhuKalxB0/qdkD2JW81f8L3pYE8ECHcHldTNdXPnbIVGHvIKZk02xE
    mbKHMvDKIoxULAfcCRn9XeOgP5KeJV1ij8lAWb8WioXQdUv3YG1BDKCc0BinrVncitIW
    jqnfjS9HpE30+LxAnHotDUdaXL6fCXosxbF7TSAi+5havzAhdO7cTsefJuf8N9gAtQSq
    iBZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794211216;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=LZmFD3PvdrgjPnyl3OLBNmIcdx6VnDLZ9YRSh0z1O6o=;
    b=O/2ux7iWe+v71mkmPbCqREt89QFDvhRH9dWCeS9bMTYfbDZWfW7CAsX4yKxF3St0M0
    GLyh5/DxCxirUSM4JeBQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2A980Gql1
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 9 Nov 2026 09:00:16 +0100 (CET)
Message-ID: <5192f954-7ab8-43c0-9e38-9e23d4710f54@hartkopp.net>
Date: Mon, 9 Nov 2026 09:00:16 +0100
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
Subject: Re: [PATCH 2/3] can: bcm: do not remove the procfs entry in
 bcm_notify()
To: netdev-bot+sashiko@kernel.org
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, o.rempel@pengutronix.de,
 sashiko-bot@kernel.org, zihanx@nebusec.ai, kuba@kernel.org
References: <20261107-can-bcmlock-memcg-v1-2-482d9f5be1fd@hartkopp.net>
 <179419070881.488853.11899058559222233626@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <179419070881.488853.11899058559222233626@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 09.11.26 03:18, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] The procfs reader now races with bind and unbind.

Addressed in v2:

https://lore.kernel.org/linux-can/20261108-can-bcmlock-memcg-v2-2-19fafdfc9d12@hartkopp.net/

As bcm_proc_show() can now run while the socket is bound or unbound, it
reads bo->ifindex locklessly with READ_ONCE() and the writers use
WRITE_ONCE(). bo->ifindex is still only modified under lock_sock(). A
concurrent bind or unbind may show an intermediate state in the procfs
output, which is acceptable for this debug information.

pw-bot: cr
> 
> --
> 
> can: bcm: do not remove the procfs entry in bcm_notify()
> 
> bcm_notify() no longer calls remove_proc_entry() while holding RTNL.
> The entry now lives from the first bcm_connect() until bcm_release().
> bcm_connect() creates the entry only if it does not exist yet, and
> bcm_proc_show() reports an unbound socket as "unbound".
> 
>> diff --git a/net/can/bcm.c b/net/can/bcm.c
>> index 9c39f7363ca59..0631293a8b54a 100644
>> --- a/net/can/bcm.c
>> +++ b/net/can/bcm.c
>> @@ -223,7 +223,11 @@ static int bcm_proc_show(struct seq_file *m, void *v)
>>   
>>   	seq_printf(m, ">>> sock inode %s", bo->procname);
>>   	seq_printf(m, " / dropped %lu", bo->dropped_usr_msgs);
>> -	seq_printf(m, " / bound %s", bcm_proc_getifname(net, ifname, bo->ifindex));
>> +	if (READ_ONCE(bo->bound))
>> +		seq_printf(m, " / bound %s",
>> +			   bcm_proc_getifname(net, ifname, bo->ifindex));
> 
> [Severity: Medium]
> 
> Can bcm_proc_show() now race with bcm_notify() and bcm_connect() on
> bo->bound and bo->ifindex?
> 
> Before this patch, bcm_notify() called remove_proc_entry() before it
> cleared bo->bound and bo->ifindex. remove_proc_entry() waits for running
> readers. bcm_connect() also created a fresh entry only after it had
> assigned bo->ifindex. So bcm_proc_show() never ran while bo->ifindex was
> being written.
> 
> The entry now stays from the first connect() until bcm_release(). That
> means these writers can run while a reader is inside bcm_proc_show():
> 
> bcm_notify() NETDEV_UNREGISTER:
>      WRITE_ONCE(bo->bound, 0);
>      bo->ifindex = 0;
> 
> bcm_connect():
>      bo->ifindex = dev->ifindex;
>      ...
>      WRITE_ONCE(bo->bound, 1);
> 
> Take the unbind case: the reader loads bound == 1, then bcm_notify()
> clears both fields, then the reader loads ifindex == 0. In that case
> bcm_proc_getifname() returns "any" and the output is "bound any". Isn't
> that the output the commit message says this patch removes?
> 
> For the rebind case, WRITE_ONCE() and READ_ONCE() don't give
> release/acquire ordering. Could a reader see bound == 1 together with
> the stale ifindex == 0, and print "any" for a socket bound to a specific
> device?
> 
> The plain store to bo->ifindex and the plain load in bcm_proc_show()
> also look like a data race that KCSAN would report.
> 
> The comment this patch keeps in bcm_notify() no longer seems accurate:
> 
>      /* Paired with the lockless fast-path check in
>       * bcm_sendmsg(); bo->ifindex itself is only ever
>       * accessed under lock_sock() so it needs no
>       * annotation.
>       */
> 
> The comment in bcm_sendmsg() relies on the same assumption, that
> bo->ifindex is only mutated under lock_sock().
> 
> Taking lock_sock() in bcm_proc_show() would not fix this.
> bcm_release() calls remove_proc_entry() while holding lock_sock(sk),
> and that call waits for active readers:
> 
> bcm_release()
>      lock_sock(sk);
>      ...
>      remove_proc_entry(bo->procname, net->can.bcmproc_dir);
> 
> Would it work to use WRITE_ONCE()/READ_ONCE() on bo->ifindex and
> smp_store_release()/smp_load_acquire() on bo->bound? bcm_proc_show()
> could then read one snapshot of ifindex into a local variable.
> 
>> +	else
>> +		seq_puts(m, " / unbound");
>>   	seq_printf(m, " <<<\n");
>>   
>>   	rcu_read_lock();
> 
> [ ... ]
> 

