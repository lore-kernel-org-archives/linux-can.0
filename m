Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795424979;
	b=PFoE2saAkmnURI0SwX9mg1wtXPnrffSQcXsWs9rPc03ztKHK0MxLSMudga6EUAUEtKjG
	 orbkIqcBcyy1b98Pj/dD2Rj+T+30nWPIg2amcizeszIpAyxsUO5qE7uDfe30g1c/7muWX
	 1z7xTV63paUjAqy0YyN0coTPDIUJa7SlAAf4Mk7vRVAsiol6ja+GFI8i+UBnExz1seXF5
	 UaEVE2/AmCVT++vxY4/bsmpcqqAglzycddqfhk/L9czfBB2P2WWqkX0x1MA/xnaIft1rw
	 XzC3Ochpwrc9v/S9hfXWgzwh8qKeYnL+mZwOw+SpF6vB1qTc0RmYMlu5v/8WkU9oVmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795424979;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GaOLrhXUNnXY/Z93ThQ2lTT+5ITbrdGq2pZ351cO970=;
	b=vz8WksjYyveiLctxpmNGBXH3PNCmRxmUp4xXZr9z6rAezhlDiBOH9e/FHpRGT2/88vhh
	 /Tnp/szEjohFZ6qPN0F0GMKwgN+0lYeL+4r29UGsg+t71CfmfXpCdZ7LQ9UBPbwllPjN3
	 MBMBFqwM/R6Fzg5cbRY5hIn/9VQJVFa1Hj5clbHWm4AkJl+zpAnRVX/AYIqL/zRxApAAc
	 IZVWabdToIkX0I6efH9uABSxm9sCZ0/1YDWM/gtwyZL6RmS0GNTOhGxr2A8KKg/tRNxLy
	 PSwhMphFMiVcJlW7WHxgVhRJlsLUddQJ9ntQLhKH7Uo+JRICLGOoCjOA58lm5UFzRlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I3aWf+oT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00341606A31A
	for <linux-can@vger.kernel.org>; Mon, 23 Nov 2026 09:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I3aWf+oT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4FBE1F000C4;
	Mon, 23 Nov 2026 09:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795424978;
	bh=GaOLrhXUNnXY/Z93ThQ2lTT+5ITbrdGq2pZ351cO970=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I3aWf+oTDeullV2pTqGsIhNMHGGQ+dEtFAG/v5snkUCVFKVCJz1UY7UE/jaEMysQA
	 PZvCDs6UMrXLGpBgG5LDKOXn6miPVL52AtLteH77PeNdzHJzVV8/OfDemqCv5horD7
	 itkeuX0LMbvoaWnv1kNcn9HgSZvtZse2U5b9s44ul9wO+TboQr3U/NT4BR34B5a3zI
	 /cUU7bJW0VFNzDissqE91470plvkEFLCHtTUnAoPxhDF6RBIV7QqmioMAqwPCCsgou
	 TLZfQbXIUMkJcDLi4Q9Yj4rEHV8XtRqVe7jR5vyeku9mMe5hae6SyuKpspvVYYlDjq
	 +Cs0zbLVaq1vg==
Message-ID: <sashiko-outbox-228944@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] can: peak_pci: fix UAF and leak of PCIeC resources
Reply-To: sashiko-reviews@lists.linux.dev
To: b.lane130@outlook.com
Cc: linux-can@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <BN8PR06MB6177DC485B9CA4729F930DBDA4452@BN8PR06MB6177.namprd06.prod.outlook.com>
References: <BN8PR06MB6177DC485B9CA4729F930DBDA4452@BN8PR06MB6177.namprd06.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 09:09:37 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] can: peak_pci: UAF of chan->pciec_card in peak_pci_probe()
  rollback
--

commit 966ed02e76bd87e25cf2422b16a91f40918e28bf
Author: Bruce Lane <b.lane130@outlook.com>

can: peak_pci: fix UAF and leak of PCIeC resources

This commit adds peak_pciec_remove() to the failure_free_dev error path
in peak_pci_probe() and moves the peak_pciec_remove() call in
failure_remove_channels inside the channel teardown loop.

> diff --git a/drivers/net/can/sja1000/peak_pci.c b/drivers/net/can/sja1000=
/peak_pci.c
> index 69c61ccf621df..d5f862f05480a 100644
> --- a/drivers/net/can/sja1000/peak_pci.c
> +++ b/drivers/net/can/sja1000/peak_pci.c

[ ... ]

> @@ -709,15 +713,12 @@ static int peak_pci_probe(struct pci_dev *pdev, con=
st struct pci_device_id *ent)
>  		priv =3D netdev_priv(dev);
>  		chan =3D priv->priv;
>  		prev_dev =3D chan->prev_dev;
> -
> +		if (!prev_dev && chan->pciec_card)
> +			peak_pciec_remove(chan->pciec_card);
>  		unregister_sja1000dev(dev);
>  		free_sja1000dev(dev);
>  	}

[Severity: High]
Does calling peak_pciec_remove() before unregister_sja1000dev() cause a
use-after-free of chan->pciec_card when unwinding channel 0?

peak_pciec_remove() frees the struct peak_pciec_card pointed to by
chan->pciec_card, and unregister_sja1000dev() then calls
set_reset_mode() -> priv->write_reg().  On PCAN-ExpressCard devices,
priv->write_reg is peak_pciec_write_reg(), which dereferences
chan->pciec_card:

drivers/net/can/sja1000/peak_pci.c:peak_pciec_write_reg() {
	struct peak_pci_chan *chan =3D priv->priv;
	struct peak_pciec_card *card =3D chan->pciec_card;
	int c =3D (priv->reg_base - card->reg_base) / PEAK_PCI_CHAN_SIZE;
	...
}

Calling unregister_sja1000dev(dev) before peak_pciec_remove() and
free_sja1000dev(dev) afterwards avoids freeing chan->pciec_card while
unregister_sja1000dev() still needs it.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/BN8PR06MB6177DC485B=
9CA4729F930DBDA4452@BN8PR06MB6177.namprd06.prod.outlook.com?part=3D1
