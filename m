Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795071561;
	b=ZXz+yJjYavmWSfZtCwWk6DRhMDLsmg8hlyJRI3IL1FGRsvNebDatYo4Ip3hsDlzMD1Qr
	 9+sJSSuCYl51uxK6/RgVZKnDnJC9ONQlhzJPoGrMSsAKnXKgJLYhAZnp+ZgnonvvKNxjZ
	 MUAofnXNZMbmHPgYAxl3RKiPf9dBydVdyZKz3cMuB0381YxHMOjGu9SXzoIHIQcMuUl/Q
	 LEvZ9dVEWEwptYiVrXRZseQrudN/5KCc2T6IqXF07zwVTYjWKqHp2taeiwUv6zLATttOx
	 TNgvAi5LrlEHXFTLy+VJ6Mrg4/XzW+8EpzxlsmRf/A5qcB6hA14Ab6XMRpky46PJghQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795071561;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=e4/qEN4i2qxPwHE9ZghQjXcfxzO9APrc050SDuM3VEw=;
	b=4yVPb8eaWoCt3CpSNAfuyHQ4+MB8VoJp9OFH6SIAel0qoyoqrUG606Bfk933CnT/OMMB
	 Na+QyfRrFtXxL3sbb3wfi6Vs0N5VXfQsaY7YeoGfYoCyh5rHTMTeo9dzjpjVp2laKnK8D
	 IHNFjS+8ZT16+WxGU9IZKrRtDrNcYzhbb5E34WludNHJmiPzjR892mi1XY6VtoTpQuNEv
	 P9HT3sw5EH32RaBcfGpV7Iq5fQ+KMNYeA1Jn0Up633P366CFJpincms9ql+Vnd/bMLu6V
	 w2vVjp4j/DaZw9m2TpF+3vagALbHRLNmnjJX99SQSZMjHLBYP+yBn1aa/nsQI9c8Z+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JCmd+Yrx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3A1606A320
	for <linux-can@vger.kernel.org>; Thu, 19 Nov 2026 06:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JCmd+Yrx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9E4A1F000CD;
	Thu, 19 Nov 2026 06:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795071561;
	bh=e4/qEN4i2qxPwHE9ZghQjXcfxzO9APrc050SDuM3VEw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JCmd+YrxDdNCoQO0/1wiXh0TR5kQTWATNCct6JwJBX9lL8IYuNPoiL+uVRBhSGj5C
	 at5k6rbtrwrKRld2ozx+nNG6uEGDAfG7s/+U6Xg5wIFWhFx0W6m4kAcLGdNz5NOCJF
	 I5uPNsBe2XVOL3KrMoEE1kfyPG/nXGdfr8apFG0zRS+6nrl3rUPrA+yS6R7PjBXO43
	 LXuwjCA2TrbjI0inOCMCUja/blHLUrr1Jf/nJlH8r8BcIEwDd7k/t66kFsrhPWKko9
	 rwotw8XdqOVX1Jor744vyDPRWOLHuuLwdNkYmSnbfwqwXFAYThuPVZiX9JNNdHg+VA
	 mm/H10ajwdArg==
Subject:
 Re: [PATCH v6 2/8] can: bcm: do not remove the procfs entry in bcm_notify()
From: netdev-bot+sashiko@kernel.org
To: socketcan@hartkopp.net
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, o.rempel@pengutronix.de,
 mailhol@kernel.org, zhuling0805@qq.com, kuba@kernel.org
Date: Thu, 19 Nov 2026 06:59:20 +0000
Message-ID: <179507156037.3132.17606018249927571458@kernel.org>
In-Reply-To: <20261117-can-bcmlock-memcg-v6-2-6826a6227d36@hartkopp.net>
References: <20261117-can-bcmlock-memcg-v6-2-6826a6227d36@hartkopp.net>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] bcm_proc_show() (net/can/bcm.c:222) reads bo->ifindex into a
  local first.

--

can: bcm: do not remove the procfs entry in bcm_notify()

This patch stops bcm_notify() from removing a CAN_BCM socket's procfs
entry under RTNL on NETDEV_UNREGISTER. The entry now stays until
bcm_release(), bcm_connect() only creates it if it does not exist yet,
and bcm_proc_show() reports unbound sockets as "unbound". The bo->ifindex
accesses are annotated with READ_ONCE()/WRITE_ONCE() for the lockless
readers.

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 3f4c8d8283376..1595b7720c981 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -219,11 +219,16 @@ static int bcm_proc_show(struct seq_file *m, void *v)
>  	struct net *net = m->private;
>  	struct sock *sk = (struct sock *)pde_data(m->file->f_inode);
>  	struct bcm_sock *bo = bcm_sk(sk);
> +	int ifindex = READ_ONCE(bo->ifindex);
>  	struct bcm_op *op;
>  
>  	seq_printf(m, ">>> sock inode %s", bo->procname);
>  	seq_printf(m, " / dropped %lu", bo->dropped_usr_msgs);
> -	seq_printf(m, " / bound %s", bcm_proc_getifname(net, ifname, bo->ifindex));
> +	if (READ_ONCE(bo->bound))
> +		seq_printf(m, " / bound %s",
> +			   bcm_proc_getifname(net, ifname, ifindex));
> +	else
> +		seq_puts(m, " / unbound");
>  	seq_printf(m, " <<<\n");

[Severity: Low]
Can this print "bound any" for a socket that is being connected to a
specific CAN device?

bcm_proc_show() takes its bo->ifindex snapshot first and reads bo->bound
only later. bcm_connect() writes the two fields in the opposite order:

bcm_connect()
    WRITE_ONCE(bo->ifindex, dev->ifindex);
    ...
    WRITE_ONCE(bo->bound, 1);

With this patch the procfs entry stays in place while the socket is
unbound (bound == 0, ifindex == 0). If the socket is connected again
while a reader is running, this interleaving looks possible:

reader                                bcm_connect()
ifindex = READ_ONCE(bo->ifindex);
  /* 0 */
                                      WRITE_ONCE(bo->ifindex, X);
                                      WRITE_ONCE(bo->bound, 1);
READ_ONCE(bo->bound)
  /* 1 */
bcm_proc_getifname(net, ifname, 0)
  /* "any" */

This is a plain interleaving. It does not need CPU reordering, so it can
happen on x86 too.

The commit message says:

    bcm_proc_show() reports an unbound socket as "unbound" instead of
    showing the cleared ifindex as "any".

It also says that "a concurrent bind or unbind may show an intermediate
state in the procfs output". When the socket is connected to device X,
it never actually has bound == 1 with ifindex == 0. So "bound any" here
is a state that never existed, not an intermediate one.

The NETDEV_DOWN check in bcm_notify() has a similar lockless pattern:

    if (READ_ONCE(bo->bound) &&
        READ_ONCE(bo->ifindex) == dev->ifindex) {

It has no acquire ordering. On weakly ordered CPUs, a concurrent
bcm_connect() could let it see bound == 1 together with the old ifindex.
That would drop one ENETDOWN report or add a spurious one.

Would reading bo->bound before bo->ifindex in bcm_proc_show() close the
window on TSO? Pairing smp_store_release(&bo->bound, 1) in bcm_connect()
with smp_load_acquire(&bo->bound) in the lockless readers would also
cover weakly ordered architectures.

The final patch of the series seems to keep the same read order in
bcm_proc_show().

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261117-can-bcmlock-memcg-v6-0-6826a6227d36%40hartkopp.net
