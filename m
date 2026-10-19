Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792433243;
	b=EhqeP+R89VIJh3qCfUSaXfMiXacLYQ4Wfu5l50l5FhztJMfyYnKH7FvIjUQHKg4tQEyb
	 RWfiZ5o5VCXVaTYNq7s2XpeqY235Wo2/bRbQvCCZy+wuwGm7xEPrVN93cIWOE4o+omLtl
	 0bNlvq2WxSQY5/0wIxJ4rTOkSaaaEGflLwgrazzSPEsawlOHeNo42CXslBVMf3EzgHjnh
	 D09DcqgUrXkocfwfOGTvu68gNOWZigR+9SjTcgqks1eI5UljxyeN5hVduiENcLlz8xTfd
	 1X7MRonLVDm6i9h6qLz0mIEXcWu76w+O1JXSbBWI1wUbw7MUFEOG0T/ocTKRaa0gF1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792433243;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=yTloSTIq141siQFxXy/W3MLDXGT0LmR8JLJY2rpySeA=;
	b=VR75ZZoysfpzRqbvUQ3CkClKyu5ubR2fxNOQ009eMGZ4SL9jwKfZznMmwpqeYhC9mwOY
	 AP4Q96sFEL71eJp94uC/X3ZReOYUQ/py6ff/HWimC1dB8VJ8vrcDPahV8SiR0EMcVgECC
	 3ZTYR2/bPFUStdhHPHu1pVM5W+NhFFHrsoVBCns925dcOz6NNWuxzd2gH29MPVmfcYc+d
	 /KFCDJh0UaXpgrUwJt5pFjX2MVuTnqMy/Gz6wUULxBisUr4usp3olAbkmDWZwF4iEqNUg
	 rpiY51emKPaClDtxIODmvcfRFf8x+KEC6XcxCz1mv1Y29m8anJwcwMfhknSM/BScPHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AkUqR6O0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BDC606A31E;
	Mon, 19 Oct 2026 18:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AkUqR6O0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B681F000C4;
	Mon, 19 Oct 2026 18:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792433243;
	bh=yTloSTIq141siQFxXy/W3MLDXGT0LmR8JLJY2rpySeA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AkUqR6O0kP4Ct6wTAsl/sGUYQInzfx/2v7KmCXWZX/Mdd7rZ/n07xfa2UVCPkQq0Z
	 iaUAxG4PEK7ZdwQKMgVd9Rk4fTZG4ppB4XyREXdRL/GFp8cIf6IJAtXkUCTuymEHsG
	 zrOMkXXxDwMl5FNBPmCUNLJt/9HLatz8OpA1jTMg8VCYvsSjXSEUfNISTGuUYX+6E6
	 I7PMKuldz/QDhXsl7lSal4bThnyEb1PT0as/gkgHWYDhJ38mltSYSCMH7MigEG2fyX
	 LWz7a+e3Bp3OdhamBIsEZpi2RFeCDRrEhJ42tEbwLOaEG8Yq18Lv+MvWacjdwdPVku
	 2PTafUbK4uHLA==
Subject: Re: [PATCH net-next 06/12] can: bcm: fix filter removal race between
 release and netns change
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de
Date: Mon, 19 Oct 2026 18:07:22 +0000
Message-ID: <179243324213.3135.7191257485543672135@kernel.org>
In-Reply-To: <20261018164417.1540449-7-mkl@pengutronix.de>
References: <20261018164417.1540449-7-mkl@pengutronix.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] bcm_release() now holds the global RTNL mutex while it walks
  every device-specific rx_op of the closing socket and calls…

Pre-existing issues:
- [High] bcm_notify() in net/can/bcm.c still calls remove_proc_entry()
  for the socket's procfs entry when the bound device sends…

--

can: bcm: fix filter removal race between release and netns change

This patch takes rtnl_lock() in bcm_release() before the socket is
removed from bcm_notifier_list. The device specific CAN filters are
then removed while RTNL is held, and the busy-wait on bcm_busy_notifier
becomes a WARN_ON_ONCE(). The procfs entry, the tx_ops and the 'any'
device filters are released after RTNL has been dropped.

Link: https://lore.kernel.org/linux-can/CEA6A38A-2646-4ADA-95B4-CBAE2F301A8E@doyensec.com/
Link: https://patch.msgid.link/20261016091128.325332-3-socketcan@hartkopp.net

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 60406439a13f7..37babc3218e47 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -1927,17 +1927,30 @@ static int bcm_release(struct socket *sock)
>  
>  	/* remove bcm_ops, timer, rx_unregister(), etc. */
>  
> +	rtnl_lock();
> +

[ ... ]

>  	lock_sock(sk);
>  
> +	/* Remove the device specific subscriptions under RTNL */
> +	list_for_each_entry(op, &bo->rx_ops, list)
> +		if (op->ifindex && op->rx_reg_dev)
> +			bcm_rx_unreg(op->rx_reg_dev, op);
> +
> +	rtnl_unlock();

[Severity: Medium]
Can an unprivileged user make this loop hold RTNL for a long time?

Only memory limits how many rx_ops a socket can have. bcm_rx_setup()
allocates a new op for each distinct can_id/ifindex and adds it with
list_add_rcu(&op->list, &bo->rx_ops).

Each bcm_rx_unreg() then calls can_rx_unregister(), which searches the
per-device bucket linearly:

net/can/af_can.c:can_rx_unregister() {
    ...
	hlist_for_each_entry_rcu(rcv, rcv_list, list) {
		if (rcv->can_id == can_id && rcv->mask == mask &&
		    rcv->func == func && rcv->data == data)
			break;
	}
    ...
}

Exact-mask EFF ids go into rx_eff[effhash(id)], which has only 1024
buckets, so it is easy to pick colliding ids. can_rx_register() inserts
at the head of the bucket. Entries that a second socket registers later
(BCM, or CAN_RAW with exact EFF filters) therefore sit in front of every
entry of the socket being closed.

With n ops on socket A and m colliding entries from socket B, close(A)
does O(n * m) list traversal while RTNL is held:

close(A)
  bcm_release()
    rtnl_lock()
    n x bcm_rx_unreg()->can_rx_unregister()   /* each walks m entries */
    rtnl_unlock()

Before this patch, bcm_release() ran this loop without RTNL. It only ran
under RTNL from bcm_notify(), which needs a NETDEV_UNREGISTER. Creating
a CAN_BCM socket needs no capability.

The commit message keeps the RTNL section short by moving the 'any'
device filter removal out of it. Could the device specific part also be
bounded, or done without holding RTNL across a loop whose length the
user controls?

> +
> +	/* bcm_notify() can not access this socket anymore. Release the other
> +	 * resources without holding RTNL, e.g. remove_proc_entry() waits for
> +	 * concurrent readers of the procfs entry.
> +	 */

[Severity: High]
This is a pre-existing issue and was not introduced by this patch. Still,
bcm_notify() removes the same procfs entry with RTNL held, and the
commit message says:

    This way a stalled reader of the world-readable procfs entry can not
    hold up RTNL

When the bound device sends NETDEV_UNREGISTER, bcm_notify() runs from
the netdev notifier chain under RTNL, with lock_sock(sk) held:

net/can/bcm.c:bcm_notify() {
    ...
		if (bo->bound && bo->ifindex == dev->ifindex) {
#if IS_ENABLED(CONFIG_PROC_FS)
			if (sock_net(sk)->can.bcmproc_dir && bo->bcm_proc_read) {
				remove_proc_entry(bo->procname, sock_net(sk)->can.bcmproc_dir);
				bo->bcm_proc_read = NULL;
			}
#endif
    ...
}

remove_proc_entry() calls proc_entry_rundown(), which waits
uninterruptibly in wait_for_completion() until in-flight readers are
done. proc_reg_read_iter() holds use_pde() across seq_read_iter(), and
that includes the copy to the user buffer.

A reader of /proc/net/can-bcm/<ino> can stall in that copy, for example
when its buffer is backed by a FUSE mapping whose daemon never answers.
Can the device unregister then hold RTNL indefinitely?

Unprivileged FUSE is available through fusermount or a user namespace.
With vcan in a user namespace, the same user can also trigger the
unregister with ip link del.

This code came in with commit 76fe372ccb81 ("can: bcm: Remove proc entry
when dev is unregistered."). No later patch in this series changes
bcm_notify().

Should the remove_proc_entry() in bcm_notify() also move out of the RTNL
section, so the goal stated in the commit message holds for both
removal sites?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261018164417.1540449-2-mkl%40pengutronix.de
