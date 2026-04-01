Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D553FFADF
	for <linux-can@vger.kernel.org>; Wed,  1 Apr 2026 10:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775041179; cv=none; b=t1E3UEnwB73yAfzmWWhwP8ARirbH6fHdk6dILoW2dF39Jdo33BUx/heMDtEVeldzUgOwFCFHedFuosrhQ6xG77alGr+zb6sgFsnNreLs84FmKpJn2u5u16GbkvZrciMF4l4xhgVNV0YCEgJp+P0tSYWu6IfAgQeG7i4XEeGjRV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775041179; c=relaxed/simple;
	bh=Ope8CY7+795Vdw4uV9G0EQaCrrFUAklBTIr4qOATp1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u77/GNAkMehjz6QhNROMvvC0XccKoI5RWLWnRvB0kVTRqnpxHUVrqp4UsjG+zs+PbLYCLxoRkPEmV0WReQ/E9HCersXzUMT2stPDLQrkvf+Ap1objOhd36CNNdyrrstS96yKkjEO3lx4fSab2X2BT38J3dkCa+vR5ShAFJOQRJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w7tIG-0000Zc-2c; Wed, 01 Apr 2026 12:59:28 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w7tIE-003C6L-2m;
	Wed, 01 Apr 2026 12:59:26 +0200
Received: from pengutronix.de (unknown [IPv6:2a0a:edc0:0:701:a82f:fdef:12b2:33d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6CA0A513631;
	Wed, 01 Apr 2026 10:59:26 +0000 (UTC)
Date: Wed, 1 Apr 2026 12:59:25 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: stable@vger.kernel.org, Vincent Mailhol <mailhol@kernel.org>, 
	Wolfgang Grandegger <wg@grandegger.com>, "David S. Miller" <davem@davemloft.net>, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] can: sja1000: Fix pci_iounmap() buffer
Message-ID: <20260401-effective-piculet-of-will-704d4d-mkl@pengutronix.de>
X-AI: stop_reason: "refusal"
References: <20260330154236.98665-2-fourier.thomas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7zza37utbthxq4gt"
Content-Disposition: inline
In-Reply-To: <20260330154236.98665-2-fourier.thomas@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--7zza37utbthxq4gt
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net] can: sja1000: Fix pci_iounmap() buffer
MIME-Version: 1.0

On 30.03.2026 17:42:31, Thomas Fourier wrote:
> The base_addr is mapped in kvaser_pci_init_one() and the pointer is
> copied to priv->reg_base in kvaser_pci_add_chan() with offset
> channel * KVASER_PCI_PORT_BYTES but unmapped without the offset.
>
> Cancel the offset before calling pci_iounmap().
>
> Fixes: 255a9154319d ("can: sja1000: stop misusing member base_addr of str=
uct net_device")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>

The cleanup functions in this driver are a mess. kvaser_pci_del_chan()
should only delete one channel, but it deletes all. It also unmaps the
iomem, which belongs into kvaser_pci_remove_one().

What about switching the driver to pcim_enable_device(),
pcim_request_region(), pcim_iomap() functions instead?

> ---
>  drivers/net/can/sja1000/kvaser_pci.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/can/sja1000/kvaser_pci.c b/drivers/net/can/sja10=
00/kvaser_pci.c
> index 95fe9ee1ce32..213fd0eb07e7 100644
> --- a/drivers/net/can/sja1000/kvaser_pci.c
> +++ b/drivers/net/can/sja1000/kvaser_pci.c
> @@ -161,6 +161,7 @@ static void kvaser_pci_del_chan(struct net_device *de=
v)
>  {
>  	struct sja1000_priv *priv;
>  	struct kvaser_pci *board;
> +	void __iomem *base_addr;
>  	int i;
>
>  	if (!dev)
> @@ -186,7 +187,8 @@ static void kvaser_pci_del_chan(struct net_device *de=
v)
>  	}
>  	unregister_sja1000dev(dev);
>
> -	pci_iounmap(board->pci_dev, priv->reg_base);
> +	base_addr =3D priv->reg_base - board->channel * KVASER_PCI_PORT_BYTES;
> +	pci_iounmap(board->pci_dev, base_addr);

When called from kvaser_pci_remove_one(), "dev" points to the master
dev, which uses priv->reg_base without an offset, as it's board->channel
is "0", right?

When called from the error path of kvaser_pci_add_chan(), things go
wrong, and in the error path of kvaser_pci_init_one(), the pci mem is
unmapped again.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--7zza37utbthxq4gt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCacz6iwAKCRDMOmT6rpmt
0odmAQD81TVa/VMDwhrecUb6HKnCAO6NHVpV3LM9adc9uYeH9AEAlfAhhjN+3zrG
jHdXYDk5sCdin4NgticimjrM8xlB3Qg=
=/43P
-----END PGP SIGNATURE-----

--7zza37utbthxq4gt--
