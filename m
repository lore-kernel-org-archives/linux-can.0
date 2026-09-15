Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949FC4398F2
	for <linux-can@vger.kernel.org>; Tue, 15 Sep 2026 17:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789494242; cv=none; b=WAuwueYTorNOVy5wJe2xmRfSho3Z+trCUbq6+JAd/XVB2jl9+nMUfL2qDghPNtJI10Luz0TFy/1Sd8FLp/YqEQAD6lFYXQgP5ZqAFxOm9d+d8UAgqwMBiBueqlSe2QZdJUV51cKd534EgOnMadrgRpBQveJ8H+34ro9nxBsYSSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789494242; c=relaxed/simple;
	bh=Sn6M6CwxJRhzmNlzos4uCdtTj9AMzQvheFsXTKgNUv0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h46LGDIQWcJwAC5FUz2P0ZUl6jWo3G7qs+RuzWtkHb6YiE+3EPBTinMBa6FMuqaFG2Dh3wQl8NMjRTwHAkauAZrqvQoUEvrWk9pgNBiEyiUJX2tlB9Cq7qv21uHsGv3NU24rUQVtsJATa8aGYeX8BRMn2A/TL0xANdrjR5FyMIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N16D6m2Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N16D6m2Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03BB21F00893;
	Tue, 15 Sep 2026 17:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789494233;
	bh=VvTldRXcbjvCwRAUBPlKuDju6HGhX8UYNCQ+LCZ28FI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N16D6m2Zv42Ou7F/+6qBCpLOS4Nzl+B4ci4/n/dQl1nGKYJxD1l5aMaJXIt6FPbNP
	 Q0IHLkmiSlUIr1SEMTro/uOS4RdsKJlI+oM3c9hslmz4yZFyTMC7WtevnliuKbkOKK
	 M63iOZCK00E+1dht3chjb2zDXxb8WvUKxfhz2jzHx6tUqwhDvxM9TPWrFQx77jxhxb
	 I+QJrpdvuhFRhKTJLF0hfR0gQJGs56E5hAVvVyNx57hLILE5Srds5JAyA1tHCwh83u
	 n03I2pR2r6/ra9asdO1pN49uHLEyfAuTiTVy28QqfgjmnSIK5CmXm5usHLsWJlaKl9
	 oB1nN0LvwldKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] can: peak_pci: fix PCIeC cleanup on probe failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guangshuo Li" <lgs201920130244@gmail.com>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260915173157.2510375-1-lgs201920130244@gmail.com>
References: <20260915173157.2510375-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 17:43:52 +0000
Message-Id: <20260915174353.03BB21F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] can: peak_pci: UAF of pciec_card during probe failure
- [Low] can: peak_pci: misleading indentation in failure_free_dev
--

commit 97c9f38ab42de88035b4236926e467dfff4e2f5d
Author: Guangshuo Li <lgs201920130244@gmail.com>

can: peak_pci: fix PCIeC cleanup on probe failure

peak_pci_probe() initializes the PCIeC resources before registering the
SJA1000 network device.

Cc: stable@vger.kernel.org

> diff --git a/drivers/net/can/sja1000/peak_pci.c b/drivers/net/can/sja1000=
/peak_pci.c
> index 69c61ccf621df..28b94e6421709 100644
> --- a/drivers/net/can/sja1000/peak_pci.c
> +++ b/drivers/net/can/sja1000/peak_pci.c
> @@ -697,6 +697,8 @@ static int peak_pci_probe(struct pci_dev *pdev, const=
 struct pci_device_id *ent)
>  	return 0;
> =20
>  failure_free_dev:
> +if (!chan->prev_dev && chan->pciec_card)
> +	peak_pciec_remove(chan->pciec_card);
>  	pci_set_drvdata(pdev, chan->prev_dev);
>  	free_sja1000dev(dev);
> =20

[Severity: Low]
Does this misleading indentation violate kernel style guidelines?

The if condition is placed at column 0, while the pci_set_drvdata() and
free_sja1000dev() statements below it are indented with a tab. This visually
suggests they are conditionally executed by the if statement, even though
they run unconditionally.

> @@ -704,20 +706,18 @@ static int peak_pci_probe(struct pci_dev *pdev, con=
st struct pci_device_id *ent)
>  	/* Disable interrupts */
>  	writew(0x0, cfg_base + PITA_ICR + 2);
> =20
> -	chan =3D NULL;
>  	for (dev =3D pci_get_drvdata(pdev); dev; dev =3D prev_dev) {
>  		priv =3D netdev_priv(dev);
>  		chan =3D priv->priv;
>  		prev_dev =3D chan->prev_dev;
> =20
> +		/* do that only for first channel */
> +		if (!prev_dev && chan->pciec_card)
> +			peak_pciec_remove(chan->pciec_card);
>  		unregister_sja1000dev(dev);

[Severity: High]
Does this sequence result in a use-after-free of the card structure if devi=
ce
registration fails for a secondary channel?

During the failure path, the driver iterates over previously registered
channels to unregister them. For the first channel, peak_pciec_remove() is
called, which frees the card structure.

Immediately following this, unregister_sja1000dev() is called, which places
the device into reset mode via priv->write_reg(). This resolves to
peak_pciec_write_reg(), which dereferences the freshly freed card structure:

drivers/net/can/sja1000/peak_pci.c:peak_pciec_write_reg() {
    ...
    int c =3D (priv->reg_base - card->reg_base) / PEAK_PCI_CHAN_SIZE;
    ...
}

Will this cause memory corruption or a crash?

Although the commit message notes this matches the ordering used by
peak_pci_remove(), it appears that function contains the same identical flaw
which is now being reproduced in peak_pci_probe().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915173157.2510=
375-1-lgs201920130244@gmail.com?part=3D1
