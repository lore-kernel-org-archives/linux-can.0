Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792437648;
	b=jrhO9sSdjroBSD6V/BFuF+UjtVxDMmMVXd6GpBBNt8vQ+FoYjXSAwTVegcUuS3BV4Xe8
	 WNL6xFw5YHeYKaG1oMQamUTlM/gUfS5EDE+Of+j11G4RqvHyrjmjpM6Wc9bW2d2SZrVLq
	 2noVQcsvALg3Zl8TBNdmDQQJfvs8wq1VS3QTNCzDlMzPfm1AMbFZwa475zENFIAdsOzb5
	 eqaVEuSIRtR15HjvGrwMgNglvU/vSmSRMKspxFlzFcLjfUX8U+PQYA+zW6yCHkRosWOv3
	 n/K1OxUA3LIikDsb227wZFeW2pWxAVK22KfntOGGJjcsZW9S/1azSOHqTC1ywAJSASA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792437648;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=nai0BSIGWOpgnQlmI8Rcw5c9Fi7ECJW8ivW+ajF8SgQ=;
	b=ODHt8aB0WSa2phm+/DuNWPVSZCGSQTMCoZr31SSloqny6iSVE+ZgL2+JckXXYu69MzgF
	 m9RPHI1RN2bG83PHDd6iRAoplZ7LDValTKup1toB0bdYqEUvbk3EmDxfdBylH+V9xB0dG
	 yhy9FGMoZpJ+CPXN5PlTYgYJmX8N9epyX6fJDZRjAnrPeNVt1B1gqR1Ld4DWyWPkEwoaa
	 LwqHyUVFewdMVF37rx1t2U5clzO/1rGBaV1NEm/84MR1wBf0XWraLEiJsYw08tKtN4CBQ
	 zREJqMiQrIsab/kgnvdWSpXCojsQ4Jt51y40OOIKQhHcJKzMZ/g1NPcFdddMZFDcpgw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=cRM+RAni;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=zhWz3ZHO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.54
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F855606A31C;
	Mon, 19 Oct 2026 19:20:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F855606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=cRM+RAni;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=zhWz3ZHO
ARC-Seal: i=1; a=rsa-sha256; t=1792437636; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=if6DU+iZ2Ry+qo46YquFSVNr1is4lNSxN1BTmDDQ/HV/C0QAtfH2p336iuD+xiv8qc
    948zc6NEbX/UPLZez1NTdSDM0d2Qh2mk1fcmS/i3LRGWg0yIcekTDdjMYMAXBdEn08ql
    K4DnHIg66irTr1Qym4jeuQbb1bnaAH7DMAczoCmSMIG+EQ4vB+hJEtGjwhDZhtzFm/nt
    klhxBgLLW4vnmsaazlueG6MfS511DOt/aWxpotynAor3dCIXYNTp4/+8aAoNwT5KLYab
    MDeAdeynlxBmXSZ4GXjX0HpGvfAM7BgXe65hO7LsWTjcHGfFazE3ikqZv7ONgwDdgrbs
    Xehg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792437636;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=nai0BSIGWOpgnQlmI8Rcw5c9Fi7ECJW8ivW+ajF8SgQ=;
    b=tsnKwy1BNvJ6YGonGKsDRP2l0ahhLzGFZC6p1ZTDBHOk8QDUjghhjbcOYgUVvq1w7B
    BxRQoyMxCcm6uVEF7gmI7cV2rzxB5Hjly/14ybvnuXujSYWhZdHqe99kMovOlA/vswmx
    b2H/iXcY0J1os5AI+oNqeOeFaWok07WFkUSBbE+vu9L827JzyHGuccKjgBaT+/z8dUCU
    tWDDtdcndWUqP5cZCVMFrcFj+LSRLkcnHYUC05tRAp7FutN5D2fATB9ZekoOLMTl1QQQ
    x5iAqf2lAAbNPFOWE1LgYawDhG4rBoar3pJ3FDCNRVKx/CAycudkALLhGPT2q91Eoir0
    fwDA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792437636;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=nai0BSIGWOpgnQlmI8Rcw5c9Fi7ECJW8ivW+ajF8SgQ=;
    b=cRM+RAniKaYRZvk8KnZX9lsRzl7xM60p2x/takW7Ert3rj+0cKRfy9CDmjZTJtWr/T
    It9zKwVUm1sf+7WryD57xGktVGW3M//a8GDd1QF9N5IxO4NW8i3wdb8oxx9TReQ8LMHo
    mz62Qrah6/NlDQlh26x0WD+wPaTRM8ids0tN+/1TUnvokmIxKNAWXl/ksolgHwP5EdYu
    wQ+eA59KFLJAAeRBaj2t7iPTdN5rZNdgWJhV1jVwzWndMwB+LrdGDOvabH3X0cLIcEMM
    tzYSRF+uXiD4x94gcXpmYkAtYQGm2poezhde7SuoABxnmwMll3sDocpp98wb2u/F3iM8
    VoBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792437636;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=nai0BSIGWOpgnQlmI8Rcw5c9Fi7ECJW8ivW+ajF8SgQ=;
    b=zhWz3ZHO6cd8gfuAx/l/nZMUku4GmSFvH2PfmSjUCAUJVD3ssuhCvwZGYkvfiBNaTp
    YeyKJ1jqhSTFDkA5QoCw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29JJKZY85
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 19 Oct 2026 21:20:35 +0200 (CEST)
Message-ID: <b75fe782-85dc-4364-8a99-f3b153ae2f1e@hartkopp.net>
Date: Mon, 19 Oct 2026 21:20:35 +0200
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
Subject: Re: [PATCH net-next 06/12] can: bcm: fix filter removal race between
 release and netns change
To: netdev-bot+sashiko@kernel.org, mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de
References: <20261018164417.1540449-7-mkl@pengutronix.de>
 <179243324213.3135.7191257485543672135@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <179243324213.3135.7191257485543672135@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 19.10.26 20:07, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 (1) · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] bcm_release() now holds the global RTNL mutex while it walks
>    every device-specific rx_op of the closing socket and calls…
> 
> Pre-existing issues:
> - [High] bcm_notify() in net/can/bcm.c still calls remove_proc_entry()
>    for the socket's procfs entry when the bound device sends…
> 

This PR can-next 2026-10-18 is obsolete.

Updated PR can-next 2026-10-19 at

https://lore.kernel.org/linux-can/20261019170834.1727150-1-mkl@pengutronix.de/

which solves the remarked problems with a new per-device lock:

https://lore.kernel.org/linux-can/20261019170834.1727150-12-mkl@pengutronix.de/

Best regards,
Oliver

pw-bot: cr

> --
> 
> can: bcm: fix filter removal race between release and netns change
> 
> This patch takes rtnl_lock() in bcm_release() before the socket is
> removed from bcm_notifier_list. The device specific CAN filters are
> then removed while RTNL is held, and the busy-wait on bcm_busy_notifier
> becomes a WARN_ON_ONCE(). The procfs entry, the tx_ops and the 'any'
> device filters are released after RTNL has been dropped.
> 
> Link: https://lore.kernel.org/linux-can/CEA6A38A-2646-4ADA-95B4-CBAE2F301A8E@doyensec.com/
> Link: https://patch.msgid.link/20261016091128.325332-3-socketcan@hartkopp.net
> 
>> diff --git a/net/can/bcm.c b/net/can/bcm.c
>> index 60406439a13f7..37babc3218e47 100644
>> --- a/net/can/bcm.c
>> +++ b/net/can/bcm.c
>> @@ -1927,17 +1927,30 @@ static int bcm_release(struct socket *sock)
>>   
>>   	/* remove bcm_ops, timer, rx_unregister(), etc. */
>>   
>> +	rtnl_lock();
>> +
> 
> [ ... ]
> 
>>   	lock_sock(sk);
>>   
>> +	/* Remove the device specific subscriptions under RTNL */
>> +	list_for_each_entry(op, &bo->rx_ops, list)
>> +		if (op->ifindex && op->rx_reg_dev)
>> +			bcm_rx_unreg(op->rx_reg_dev, op);
>> +
>> +	rtnl_unlock();
> 
> [Severity: Medium]
> Can an unprivileged user make this loop hold RTNL for a long time?
> 
> Only memory limits how many rx_ops a socket can have. bcm_rx_setup()
> allocates a new op for each distinct can_id/ifindex and adds it with
> list_add_rcu(&op->list, &bo->rx_ops).
> 
> Each bcm_rx_unreg() then calls can_rx_unregister(), which searches the
> per-device bucket linearly:
> 
> net/can/af_can.c:can_rx_unregister() {
>      ...
> 	hlist_for_each_entry_rcu(rcv, rcv_list, list) {
> 		if (rcv->can_id == can_id && rcv->mask == mask &&
> 		    rcv->func == func && rcv->data == data)
> 			break;
> 	}
>      ...
> }
> 
> Exact-mask EFF ids go into rx_eff[effhash(id)], which has only 1024
> buckets, so it is easy to pick colliding ids. can_rx_register() inserts
> at the head of the bucket. Entries that a second socket registers later
> (BCM, or CAN_RAW with exact EFF filters) therefore sit in front of every
> entry of the socket being closed.
> 
> With n ops on socket A and m colliding entries from socket B, close(A)
> does O(n * m) list traversal while RTNL is held:
> 
> close(A)
>    bcm_release()
>      rtnl_lock()
>      n x bcm_rx_unreg()->can_rx_unregister()   /* each walks m entries */
>      rtnl_unlock()
> 
> Before this patch, bcm_release() ran this loop without RTNL. It only ran
> under RTNL from bcm_notify(), which needs a NETDEV_UNREGISTER. Creating
> a CAN_BCM socket needs no capability.
> 
> The commit message keeps the RTNL section short by moving the 'any'
> device filter removal out of it. Could the device specific part also be
> bounded, or done without holding RTNL across a loop whose length the
> user controls?
> 
>> +
>> +	/* bcm_notify() can not access this socket anymore. Release the other
>> +	 * resources without holding RTNL, e.g. remove_proc_entry() waits for
>> +	 * concurrent readers of the procfs entry.
>> +	 */
> 
> [Severity: High]
> This is a pre-existing issue and was not introduced by this patch. Still,
> bcm_notify() removes the same procfs entry with RTNL held, and the
> commit message says:
> 
>      This way a stalled reader of the world-readable procfs entry can not
>      hold up RTNL
> 
> When the bound device sends NETDEV_UNREGISTER, bcm_notify() runs from
> the netdev notifier chain under RTNL, with lock_sock(sk) held:
> 
> net/can/bcm.c:bcm_notify() {
>      ...
> 		if (bo->bound && bo->ifindex == dev->ifindex) {
> #if IS_ENABLED(CONFIG_PROC_FS)
> 			if (sock_net(sk)->can.bcmproc_dir && bo->bcm_proc_read) {
> 				remove_proc_entry(bo->procname, sock_net(sk)->can.bcmproc_dir);
> 				bo->bcm_proc_read = NULL;
> 			}
> #endif
>      ...
> }
> 
> remove_proc_entry() calls proc_entry_rundown(), which waits
> uninterruptibly in wait_for_completion() until in-flight readers are
> done. proc_reg_read_iter() holds use_pde() across seq_read_iter(), and
> that includes the copy to the user buffer.
> 
> A reader of /proc/net/can-bcm/<ino> can stall in that copy, for example
> when its buffer is backed by a FUSE mapping whose daemon never answers.
> Can the device unregister then hold RTNL indefinitely?
> 
> Unprivileged FUSE is available through fusermount or a user namespace.
> With vcan in a user namespace, the same user can also trigger the
> unregister with ip link del.
> 
> This code came in with commit 76fe372ccb81 ("can: bcm: Remove proc entry
> when dev is unregistered."). No later patch in this series changes
> bcm_notify().
> 
> Should the remove_proc_entry() in bcm_notify() also move out of the RTNL
> section, so the goal stated in the commit message holds for both
> removal sites?
> 

