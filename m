Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49541364949
	for <linux-can@vger.kernel.org>; Tue, 14 Jul 2026 10:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784025182; cv=none; b=iAS2G72poNZgBzq2dDiSfMAf0U9Lfsr8n7+xCJudBO63ENh83pZJqBR0kj3X2x28IQ/xr7frYacHqRl/Tka0JfZ4kAY0nhnMwRCH0oUzerhopVzE+UT5Fy7QiY9CkX73YUEx42vjlBZoEjAB8GHxpRppuSXt3YvF/ksn6sfbJqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784025182; c=relaxed/simple;
	bh=Ra55QEotI1BfKgt76WAAF3Te2pMsRzKJlgkwOdliKuY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qHDdB8aaeQdzR4Kw7gYHTigBSuB5RtFn+7WWVaedyt/a27wtWgu7OIeiFooYXdvWGYGvcttfkMWVRQV9M9h1fgg8+feO8X4AnpQHzSN9D9HlVjF/JcUufPop0qgcNzPFZzSlHV6UmL5/nMeD6h+q7OqhVs3c+6JXsiXDRvffsb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RlecEvgL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RlecEvgL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B6391F000E9;
	Tue, 14 Jul 2026 10:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784025180;
	bh=8m3B4GkzoSo2kWmb6czFj+zxJDgq7Gj5nydQPz2Qiew=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RlecEvgLs6qasaI+xa/FcFsRO4Vu7DlVyE2LEewHrbGF3aCPHmPHZsUCLVLXRrDFq
	 emghlQKeFw+IqcfBjABRTqYqWg2DDzErgEcIdmYr32hKyykvcM7E/WwLHiWCTeLczZ
	 Q4hytR6Qfq5xAz1xy9sAMYF3tGtuUSrBiXh2ylfXROWCydi6frQRdB2IX2R4iODbNf
	 aH6Z9uJoHyPYJ8xcuAmvP+QerC+e16stj7b0BHS15xEorU+JMgq+oK4pmtv+iRkKfI
	 528zK06qeGaRepZJ1oGBqgm1fEQGHWKtTau0+mCtZwDU/kBEqmxTud6UeOyak62Atb
	 iF+nQ0ffTdnBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 04/11] can: bcm: fix CAN frame rx/tx statistics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260714-bcm_fixes-v13-4-fd667c61099a@hartkopp.net>
References: <20260714-bcm_fixes-v13-0-fd667c61099a@hartkopp.net>
 <20260714-bcm_fixes-v13-4-fd667c61099a@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 10:33:00 +0000
Message-Id: <20260714103300.8B6391F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing RCU list primitives lead to potential NULL pointer derefer=
ence or memory corruption during lockless /proc/net/can-bcm/... traversal.
--

--- Patch [4]: [PATCH v13 04/11] can: bcm: fix CAN frame rx/tx statistics -=
--
commit acb95cd7e83f916c374a2a2f75ed2b971c9fa9d5
Author: Oliver Hartkopp <socketcan@hartkopp.net>

    can: bcm: fix CAN frame rx/tx statistics

This commit fixes a data race detected by KCSAN when two CAN frames are
simultaneously received and processed by different CPUs. It transitions
the statistics counters to use atomic operations to prevent races.
Additionally, it simplifies overflow checks and consolidates rx statistics
updates into a single critical section.

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index af4bb4182bc29..38c3f690c1cd0 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -229,10 +229,13 @@ static int bcm_proc_show(struct seq_file *m, void *=
v)
> =20
>  	list_for_each_entry_rcu(op, &bo->rx_ops, list) {
> =20
> -		unsigned long reduction;
> +		long reduction, frames_filtered, frames_abs;
> +

[ ... ]

> @@ -280,7 +283,8 @@ static int bcm_proc_show(struct seq_file *m, void *v)
>  			seq_printf(m, "t2=3D%lld ",
>  				   (long long)ktime_to_us(op->kt_ival2));
> =20
> -		seq_printf(m, "# sent %ld\n", op->frames_abs);
> +		seq_printf(m, "# sent %ld\n",
> +			   atomic_long_read(&op->frames_abs));
>  	}

[Severity: High]
This is a pre-existing issue, but while reviewing this code we noticed a
potential missing RCU primitive issue.

In bcm_proc_show(), the code traverses the bo->tx_ops list (which contains
the loop printing the tx stats above) using list_for_each_entry() instead
of list_for_each_entry_rcu(). This omits the READ_ONCE() dependency ordering
required for safe lockless traversal under rcu_read_lock().

Additionally, when adding to these lists in bcm_tx_setup() and
bcm_rx_setup(), the code uses the non-RCU list_add() primitive instead of
list_add_rcu(), which omits the required smp_store_release() semantics.

Since a user can repeatedly read the procfs file for a CAN_BCM socket while
another thread concurrently adds filters on the same socket, could this
expose lockless readers to uninitialized memory and lead to memory corrupti=
on
or wild pointer dereferences?

>  	seq_putc(m, '\n');

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-bcm_fixes-=
v13-0-fd667c61099a@hartkopp.net?part=3D4
