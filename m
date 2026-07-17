Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712EF43F0A9
	for <linux-can@vger.kernel.org>; Fri, 17 Jul 2026 16:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784306756; cv=none; b=gunx2Cv13sXMhKQl5pqm8zSxnQ0tHic7rYmyp6D2VZL1m/A9nSJ2fmj8VTrvi+Bq7iHnC4vLbWaf4byyI2pVM68a4KoedLC9acrcjeq9yUT6rLj2kkYXfxsU8qjC2p2o0QCdVmOkRrNBnm1eXhKyo98I5KlcjaiubSFPHpiIhFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784306756; c=relaxed/simple;
	bh=Ba+9xDuRHVy6dgXAI9odRNupIF65lvdPq7Biok8CAfk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Br/dFlUVVLRLB+0OKSXTyFG43bvxAv/IZdhpzKGJrJEVk2ix7CMt58lVIjCwlMJdzN3W+lUBP4bp8KvdejjsFCZ17OAwo27JlVqlS5JAdf5tBrdUFnZUs7DQB876RZzja35t+xrsHcdTLUoZhNCSWodhBqGuV+bBooQUeJLVTDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMfdTGPY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMfdTGPY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A891F000E9;
	Fri, 17 Jul 2026 16:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784306755;
	bh=YSzcsR/Z2LFU6Rt6DkZmuuM9InSpirMV5Oora9OebVA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZMfdTGPYo6cbOSTaNRhYFqdDFa4bkMzcyhSJ/o7nZLOntEkvu9ADMvbP1Z4kt3zo9
	 48NBtgrUbs6bFlZYLOLCapDcVxjuJctAG70X3V7GwY/LBl3Obrexh6cGpbGaM0ny6c
	 zMUNxCPwNQta3jKTALg1qQnx5/g7/5beenK/iDTX0MvKWXqa6J7uyMYcmk9sTOEjES
	 esU9CB+Zm/t0VWlNo3t5cy7iLsdhr/bnhMt1ZAwGRNgY3sVMeplMX4/dpakBWk2zrV
	 FUuxm/Ig3ZtaLPlC1XKJDdUbSEdaplfO+9o/jvi61WIiEZ+aC1Ty3rwQHutmBhxamS
	 kNIHAbseOCyVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 09/19] can: bcm: fix CAN frame rx/tx statistics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260716155528.809908-10-mkl@pengutronix.de>
References: <20260716155528.809908-1-mkl@pengutronix.de>
 <20260716155528.809908-10-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 16:45:54 +0000
Message-Id: <20260717164554.E9A891F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unsynchronized concurrent updates to rx_stamp and rx_ifindex in bc=
m_rx_handler()
- [High] Missing RCU memory barriers for BCM operations lists (rx_ops and t=
x_ops)
--

--- Patch [9]: [PATCH net 09/19] can: bcm: fix CAN frame rx/tx statistics -=
--
commit d8d928a86f45beee426bc4e5b96d4a141f67ddbb
Author: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: can: bcm: fix CAN frame rx/tx statistics

KCSAN detected a data race within the bcm_rx_handler() when two CAN frames
have been simultaneously received and processed in a single rx op by two
different CPUs. This patch uses atomic operations with (signed) long data t=
ypes
to access the statistics in the hot path.

Link: https://patch.msgid.link/20260714-bcm_fixes-v15-4-562f7e3e42da@hartko=
pp.net

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 1e5f8d65d351b..03c98e4cc677d 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
[ ... ]
> @@ -229,10 +229,13 @@ static int bcm_proc_show(struct seq_file *m, void *=
v)
> =20
>  	list_for_each_entry_rcu(op, &bo->rx_ops, list) {
> =20
> -		unsigned long reduction;
> +		long reduction, frames_filtered, frames_abs;
> +
> +		frames_filtered =3D atomic_long_read(&op->frames_filtered);
> +		frames_abs =3D atomic_long_read(&op->frames_abs);

[Severity: High]
This isn't a bug introduced by this patch, but while we're in bcm_proc_show=
(),
does this function safely traverse both operation lists?

Looking further down in bcm_proc_show(), tx_ops is traversed holding only
rcu_read_lock():

	list_for_each_entry(op, &bo->tx_ops, list) {

However, this uses list_for_each_entry() instead of list_for_each_entry_rcu=
(),
which misses the necessary load-acquire operations.

Additionally, in bcm_tx_setup() and bcm_rx_setup(), new BCM operations are
added to these lists without RCU barriers:

net/can/bcm.c:bcm_tx_setup() {
    ...
	/* add this bcm_op to the list of the tx_ops */
	list_add(&op->list, &bo->tx_ops);
    ...
}

and:

net/can/bcm.c:bcm_rx_setup() {
    ...
	/* add this bcm_op to the list of the rx_ops */
	list_add(&op->list, &bo->rx_ops);
    ...
}

Could using list_add() instead of list_add_rcu() miss the store-release mem=
ory
barriers required to safely publish the newly initialized node to concurrent
RCU readers? This could allow the procfs reader to observe uninitialized
or partially initialized list nodes.

[ ... ]
> @@ -756,24 +775,30 @@ static void bcm_rx_handler(struct sk_buff *skb, voi=
d *data)
>  	op->rx_stamp =3D skb->tstamp;
>  	/* save originator for recvfrom() */
>  	op->rx_ifindex =3D skb->dev->ifindex;
> -	/* update statistics */
> -	op->frames_abs++;
> =20
> -	/* snapshot the flag under lock: op->flags/op->frames may be updated
> -	 * concurrently by bcm_rx_setup().
> -	 */
> +	/* op->flags/op->frames may be updated concurrently by bcm_rx_setup() */
>  	spin_lock_bh(&op->bcm_rx_update_lock);

[Severity: High]
This is a pre-existing issue, but while the statistics updates are moved in=
to
the locked section, rx_stamp and rx_ifindex appear to remain unprotected.

For an RX operation subscribed to all interfaces (ifindex =3D=3D 0),
bcm_rx_handler() can execute concurrently on different CPUs for the same
op.

Because op->rx_stamp and op->rx_ifindex are updated before acquiring
bcm_rx_update_lock, if two frames arrive concurrently on different CPUs,
could the first CPU waiting for the lock have its metadata overwritten by
the second CPU?

The first CPU would then process its payload but bundle it with the timesta=
mp
and interface index of the second CPU's frame, returning corrupted metadata
to userspace. On 32-bit systems, could this concurrent unsynchronized write=
 to
the 64-bit ktime_t also cause a torn read?

Should these metadata assignments be moved inside the spin_lock_bh() sectio=
n?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716155528.8099=
08-1-mkl@pengutronix.de?part=3D9
