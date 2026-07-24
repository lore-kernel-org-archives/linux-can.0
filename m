Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E6E3F8248
	for <linux-can@vger.kernel.org>; Fri, 24 Jul 2026 09:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784887188; cv=none; b=Cc/hoGQ8Lv7Nams3tS1HdyDbX953bJmEdHltN/kiCjiS86Eph8HU8CibzNxBV2uwsR8YePZjmFAcUciztp73T8l0+TTiKN9uDmLKl9MDgCE/XcdIv9T186GkR+j4Grdn0VWDm0PNga4SSF4O9cjAsIGjUzXqlZO9Z3RiMFZCsd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784887188; c=relaxed/simple;
	bh=AL9oNrOVBwBZ3ppgj7sB3QYq7dA1Hj02+I4F9OzqtrA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y0j1LdF9/Pm3kv98WDriZPRTE87BdJw9RG3WNzlVXweDiN1mQghmmHztY8EU5UzwwwsqxHf236MFl5aVQTVCCkBbOd1ucU+dCzqalVpeXhuyX3pWfu5yTXTaq0lVlFIFIweTxfDHXebhWDrtvLncLjfQ57vBWwdeyK56SY79YxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATGqajlk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATGqajlk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 196D81F000E9;
	Fri, 24 Jul 2026 09:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784887186;
	bh=uW2vYXgMOqAWGPts4gzbqtF9NTrSvzj+7Nj1IEtBW/0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ATGqajlkIoyC0bJcj2Kf3+LcmfyocDOzsURSVwjUND2nm+MWw69TMNVPML/g6a64f
	 w3ei1DkLP4aYGq3pegTGsKyIuvNne3bPyrBSt4C9mDf0J7WGJiv++OEvk3NwMIUlkM
	 SLKSeyPXQwACQeo/099v/TeICxtIoBUUW98AxlfMeNCcuezJbNTxuyCwVxmSeiX+Fx
	 YZoCIDUpB0fof/Pk2xK4InDgtAK5eqc8ufhe0ArtXXpg3oxgdUjj/e0Y1AUGsbHj8S
	 qQznMgr6m28CF8KbtfMcdT0racm5r8ry2BGn9FvZ/yJNP1PBW/PCJ+huBVyT2NdjtV
	 n3780KeTURvRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] can: ctucanfd: unmap BAR0 using base address
Reply-To: sashiko-reviews@lists.linux.dev
To: "Avi Weiss" <thnkslprpt@gmail.com>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260723095934.181042-1-thnkslprpt@gmail.com>
References: <20260723095934.181042-1-thnkslprpt@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 09:59:45 +0000
Message-Id: <20260724095946.196D81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] NAPI poll livelock on SKB allocation failure.
- [High] Missing bounds checks on PCI BAR lengths before MMIO accesses.
--

--- Patch [1]: [PATCH net] can: ctucanfd: unmap BAR0 using base address ---
commit 6b71833578fcc5fa2bdb08928e4e80211ffbd177
Author: Avi Weiss <thnkslprpt@gmail.com>

can: ctucanfd: unmap BAR0 using base address

BAR0 is mapped into bar0_base, while cra_addr points to an offset within
that mapping and is used for other purposes. This patch passes bar0_base
to pci_iounmap(), instead of cra_addr, on the probe error path so the
address returned by pci_iomap() is used for unmapping.

> diff --git a/drivers/net/can/ctucanfd/ctucanfd_pci.c b/drivers/net/can/ct=
ucanfd/ctucanfd_pci.c
> index 625788fa89766..f845951c5d513 100644
> --- a/drivers/net/can/ctucanfd/ctucanfd_pci.c
> +++ b/drivers/net/can/ctucanfd/ctucanfd_pci.c
> @@ -194,7 +194,7 @@ static int ctucan_pci_probe(struct pci_dev *pdev,
>  	pci_set_drvdata(pdev, NULL);
>  	kfree(bdata);
>  err_pci_iounmap_bar0:
> -	pci_iounmap(pdev, cra_addr);
> +	pci_iounmap(pdev, bar0_base);
>  err_pci_iounmap_bar1:
>  	pci_iounmap(pdev, addr);
>  err_release_regions:

While reviewing this patch, I noticed a couple of pre-existing issues in
the driver.

> @@ ... @@ static int ctucan_pci_probe(struct pci_dev *pdev,
>  	if (driver_data =3D=3D CTUCAN_WITHOUT_CTUCAN_ID) {
>  		cra_addr =3D bar0_base;
>  		num_cores =3D 2;
>  	} else {
>  		cra_addr =3D bar0_base + CTUCAN_BAR0_CRA_BASE;
>  		ctucan_id =3D ioread32(bar0_base + CTUCAN_BAR0_CTUCAN_ID);
>  		dev_info(dev, "ctucan_id 0x%08lx\n", (unsigned long)ctucan_id);
>  		num_cores =3D ctucan_id & 0xf;
>  	}
[ ... ]
>  	while (core_i < num_cores) {
>  		addr +=3D 0x4000;
>  		ret =3D ctucan_probe_common(dev, addr, irq, ntxbufs, 100000000,
>  					  0, ctucan_pci_set_drvdata);

[Severity: High]
This isn't a bug introduced by this patch, but does this code lack bounds
checking on the PCI BAR lengths?

The driver extracts num_cores from a hardware register, which could allow
up to 15 cores.  Then it advances the MMIO pointer 'addr' out-of-bounds by
0x4000 for each core and probes the device based on this untrusted value.

Can a malicious or malfunctioning PCIe device (or virtual device via
passthrough) advertise a small BAR size but a large num_cores, triggering
an out-of-bounds MMIO access and kernel panic?


> diff --git a/drivers/net/can/ctucanfd/ctucanfd_base.c b/drivers/net/can/c=
tucanfd/ctucanfd_base.c
> --- a/drivers/net/can/ctucanfd/ctucanfd_base.c
> +++ b/drivers/net/can/ctucanfd/ctucanfd_base.c
> @@ ... @@ static int ctucan_rx(struct net_device *ndev)
>  	if (unlikely(!skb)) {
>  		priv->rxfrm_first_word =3D ffw;
>  		set_bit(CTUCANFD_FLAG_RX_FFW_BUFFERED, &priv->drv_flags);
>  		return 0;
>  	}
[ ... ]
> @@ ... @@ static int ctucan_rx_poll(struct napi_struct *napi, int quota)
>  	if (!framecnt && res !=3D 0) {
>  		if (napi_complete_done(napi, work_done)) {
>  			/* Clear and enable RBNEI. It is level-triggered, so
>  			 * there is no race condition.
>  			 */

[Severity: High]
This is a pre-existing issue, but could this cause a NAPI poll livelock
on SKB allocation failure?

If alloc_can_skb() or alloc_canfd_skb() fails due to OOM in ctucan_rx(),
it returns 0.

The NAPI poll routine ctucan_rx_poll() then skips napi_complete_done()
because res =3D=3D 0, causing the !framecnt && res !=3D 0 check to evaluate=
 to
false.

Because it returns less than quota without calling napi_complete_done(),
doesn't this violate NAPI semantics?  The core will immediately reschedule
the poll, creating an infinite loop trying to allocate memory and leading
to 100% CPU usage and a potential system lockup.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723095934.1810=
42-1-thnkslprpt@gmail.com?part=3D1
