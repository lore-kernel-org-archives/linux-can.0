Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794230508;
	b=b0KxFI307XVBuaDaamszIvTB3QBzNmwq+I4hv4JnjYVNDXbDmsyHGFbl9xsE94bnYTuy
	 YcPxRRGjYX0krosdqPSiq7hCMpHVhiTp/Cqu36l27o+kGKghD/cNsQAJZKFMBO8JzRK1t
	 NQSz6HeeHiAayf+RvXd2Wx3NnkDNMHWJJkZUXmxl2BizX9ilPxaDur1mWca6oqzlfcM3Z
	 mvFrIPrmfa7BjdtFPWZwbewswqKAcXp1zCEWem2FVk17MUBHuHX3mzs04t2TJj5Hfrqdp
	 FFEvSUSd/6eInCIypn1SXvcDdNe8r5hdNtNt80VXe5z8wUa4y2QSA/45t1n4Zy7fHEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794230508;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XbOxpnuFk9dAfzLQJOQN1dow2gjcTYMX4QkIICRPqdo=;
	b=AWZFHox1pPvxO4TZHlAazzgs26IL2efwDdtXCqXdB/7BQRq2VeLQzNgFDfEBPb4odb/b
	 BUv3uOZjX+iZ/iLNCEhkVpFGa1JibGyR6BkSfHl0l+TuvU3n2WED0JGlYuiCIdS0jLnDS
	 XP4R60mO7dkmBWlSN8RaKkp3Fgs06JWPkvOg2S9iJVJ5wAW1R98b7osc6UtIBMvLbySvE
	 OaAU0RuPX8gvhgsif6Wi18d82qJNSmvYs62/N+HFnQ+dqTDU/zRzg0i7gPsoKEmAWm3u0
	 Dfs3RVfVbfSimgVXqhaj4PPVQO1bF4rXO1pF/PL+/ZZN86rj64iflEJ/+fjIs7fHJwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h8bvcsb0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E529606A31C
	for <linux-can@vger.kernel.org>; Mon,  9 Nov 2026 13:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h8bvcsb0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8541F008A3;
	Mon,  9 Nov 2026 13:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794230508;
	bh=XbOxpnuFk9dAfzLQJOQN1dow2gjcTYMX4QkIICRPqdo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h8bvcsb0jSyU7PkBnX/nGJHHq8SuoSgqZInBlJeJEn0Y6ghk+aqZBlW84gpQQmOrw
	 tLCjnuhB25xqs75ZdszK305x1sWGvIeXP3wakSdo1zAZ+CGzuag7nG1Za0rN3nrKzp
	 +G4AUSKnWmrqPzKKrJJK8+Znq/GP7gI3mT3PlQUAH6w5HbDKgvuE7OWT3OuYv4+JB0
	 T7Lx/V4rgJ5GRo/eIRJVQEta/29Hvv+hBfLN4KsLhIGj7R8Im7YiHudKAx/8BCI5rO
	 PzGAqfnTv4eJkGGicFxVUiHMuQ+uA6GaaCcPXG62IapjNF4QUOVEIhtLJ9SNcE5P8c
	 COyNBHBPDHHOQ==
Message-ID: <sashiko-outbox-205009@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] can: peak_pci: Fix potential use-after-free during
 removal
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guangshuo Li" <liguangshuo@mail.sdu.edu.cn>
Cc: linux-can@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261109-21df1234b2-can-peak-pci@mail.sdu.edu.cn>
References: <20261109-21df1234b2-can-peak-pci@mail.sdu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 13:21:47 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] can: sja1000: peak_pci: use-after-free in
  peak_pciec_led_work() [1]
--

commit c34b5385557b3189871973b5ef5794cd792b0b5e
Author: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>

can: peak_pci: Fix potential use-after-free during removal

This commit moves unregister_sja1000dev() before peak_pciec_remove() in
peak_pci_remove() so that the ExpressCard context remains valid while the
first channel is unregistered.

> diff --git a/drivers/net/can/sja1000/peak_pci.c b/drivers/net/can/sja1000=
/peak_pci.c
> index 69c61ccf621df..618f8f6a57500 100644
> --- a/drivers/net/can/sja1000/peak_pci.c
> +++ b/drivers/net/can/sja1000/peak_pci.c
> @@ -752,10 +752,10 @@ static void peak_pci_remove(struct pci_dev *pdev)
>  		struct net_device *prev_dev =3D chan->prev_dev;
> =20
>  		dev_info(&pdev->dev, "removing device %s\n", dev->name);
> +		unregister_sja1000dev(dev);
>  		/* do that only for first channel */
>  		if (!prev_dev && chan->pciec_card)
>  			peak_pciec_remove(chan->pciec_card);
> -		unregister_sja1000dev(dev);
>  		free_sja1000dev(dev);

[Severity: Critical]
This problem wasn't introduced by this patch, but can peak_pciec_led_work()
race with channel removal and cause a use-after-free [1] on
multi-channel ExpressCard devices?

peak_pci_remove() (and the failure_remove_channels unwind loop in
peak_pci_probe()) iterates over channels in reverse order, freeing
secondary channels via free_sja1000dev() while leaving their pointers in
card->channel[].  However, card->led_work is only cancelled by
peak_pciec_remove() once the loop reaches the first channel (!prev_dev):

CPU0                              CPU1
peak_pci_remove()
  free_sja1000dev(dev)
                                  peak_pciec_led_work()
                                    netdev =3D card->channel[i].netdev;
                                    if (!(netdev->flags & IFF_UP))
                                      <-- use-after-free
  if (!prev_dev && chan->pciec_card)
    peak_pciec_remove(chan->pciec_card)
      ...
        cancel_delayed_work_sync(&card->led_work)

Cancelling the LED work before freeing any channel netdev would avoid
this race.

[1] https://sashiko.dev/#/bug/linux-d81f042f-87f9-4ee0-9986-e44ae5a9d8a7

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-21df1234b2=
-can-peak-pci@mail.sdu.edu.cn?part=3D1
