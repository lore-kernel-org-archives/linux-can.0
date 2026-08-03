Received: from mail-4397.protonmail.ch (mail-4397.protonmail.ch [185.70.43.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9262401A25
	for <linux-can@vger.kernel.org>; Mon,  3 Aug 2026 11:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785756743; cv=none; b=g3OCSZ966Y/2TBPcJi/XV9v7L8ALBiT4wLBmDmDQXv5Gsuyx6nhUKbUhmKimQSoLGOLzaFe3lm2k1RvPOYcc4SjNNfuQ0NldYc74FL5zn80hAs5KSO/ljOOdNbuzoGX3wmezUbWXjG5J9Ld1DtJLqiDkuuwyxhZi9go8RCpf3T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785756743; c=relaxed/simple;
	bh=GtMdTx2cRLFumvx70g8GT9TjJ8E/i5VnCm00NZBcHHI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bmn6ZWOlh8AgL/GkmOtvBYlogSfpGtRNdWRb+NVBYuhIflrDpddnj9AJECBsJD5b+VJJd+yjtVUVUHS8u6VNyrb87xOBuJY4YujjX0fp+bYl6YPXjLnlR24h68rxZ6c+gA/+jAUSee356hwmDwiucDQGFF4PKF779y4jtUzKXXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=jkUcDiVW; arc=none smtp.client-ip=185.70.43.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="jkUcDiVW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1785756738; x=1786015938;
	bh=ds7ByoMtSeWpWfjRaYWxTBL6LMLmETz14uJT4QVAems=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=jkUcDiVW//79TWgi9xa23u/CjZqaijT8wpO8wHqBqqrwq3c+YUSLJJ/xmLi4Y3xBl
	 PHVC0GcSehywo8Tr2+uHCXrNMdx1NkekHGSTtGhW8wzJlPvK2XAM6YYSfo5jm/CY38
	 aIWOtudJLMIUC1KciIarg1ffBNpa+V31hTQDBUkgOC7m7atb/eo7Thx4rYzKDSdl26
	 QAYYV5q1RmV7dlTG83+h4ITj8rw/s9YLEvtq8ZUGstANqxY5DyvynMeLbrcIWanzh9
	 oQ5a9e8NpPho3Wwt8CG0sIunh74uUhJuqfF7KpbrMmd+mnsIOlfKEGcHxjwzh0JJBY
	 iR66ddcPB+zUw==
Date: Mon, 03 Aug 2026 11:32:15 +0000
To: Marc Kleine-Budde <mkl@pengutronix.de>
From: Sean Nyekjaer <sean@geanix.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>, Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] can: tcan4x5x: put tcan into sleep when removing driver
Message-ID: <qeNtat9LVO8NCBxGCR2a4Lr0ugJ5k1TYM5OqX6V2hjWgKVArdIkxm8wX_DaFd_fQZbF3EyZ-Pv5CsRiy3LgrNiBlX0uw-rn9CawvevVQ6_8=@geanix.com>
In-Reply-To: <anB0TXS1xEtYAMxn@pengutronix.de>
References: <20260803101927.17122-1-sean@geanix.com> <anB0TXS1xEtYAMxn@pengutronix.de>
Feedback-ID: 134068486:user:proton
X-Pm-Message-ID: 2941afb8d7b7f5fafa1302db96114908edad1009
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable





On Monday, 3 August 2026 at 13:27, Marc Kleine-Budde <mkl@pengutronix.de> w=
rote:

> On 03.08.2026 12:19:26, Sean Nyekjaer wrote:
> > Put the tcan4x5x transceiver into sleep mode when the driver is
> > removed, instead of leaving it in its current operating mode.
> > This reduces power consumption(3mA@12V) once the driver is
> > no longer bound to the device.
> >
> > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
>=20
> Seems you patch is not complete:
>=20
> | drivers/net/can/m_can/tcan4x5x-core.c: In function =E2=80=98tcan4x5x_ca=
n_remove=E2=80=99:
> | drivers/net/can/m_can/tcan4x5x-core.c:552:35: error: passing argument 1=
 of =E2=80=98tcan4x5x_power_enable=E2=80=99 from incompatible pointer type =
[-Wincompatible-pointer-types]
> |   552 |         tcan4x5x_power_enable(priv->power, 0);
> |       |                               ~~~~^~~~~~~
> |       |                                   |
> |       |                                   struct regulator *
> | drivers/net/can/m_can/tcan4x5x-core.c:214:56: note: expected =E2=80=
=98struct tcan4x5x_priv *=E2=80=99 but argument is of type =E2=80=98struct =
regulator *=E2=80=99
> |   214 | static int tcan4x5x_power_enable(struct tcan4x5x_priv *priv, in=
t enable)
> |       |                                  ~~~~~~~~~~~~~~~~~~~~~~^~~~

Yes.

>=20
> > ---
> > Changes since v1:
> >  - Moved enter sleep mode into tcan4x5x_power_enable()
> >
> >  drivers/net/can/m_can/tcan4x5x-core.c | 18 ++++++++++++------
> >  1 file changed, 12 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_=
can/tcan4x5x-core.c
> > index 31cc9d0abd45..67902b8b0fab 100644
> > --- a/drivers/net/can/m_can/tcan4x5x-core.c
> > +++ b/drivers/net/can/m_can/tcan4x5x-core.c
> > @@ -211,15 +211,21 @@ static int tcan4x5x_write_fifo(struct m_can_class=
dev *cdev,
> >  =09return regmap_bulk_write(priv->regmap, TCAN4X5X_MRAM_START + addr_o=
ffset, val, val_count);
> >  }
> >
> > -static int tcan4x5x_power_enable(struct regulator *reg, int enable)
> > +static int tcan4x5x_power_enable(struct tcan4x5x_priv *priv, int enabl=
e)
> >  {
>=20
> If you add:
>=20
>         struct regulator *reg =3D priv->power;
>=20
> the diff should be smaller.

Yes.

>=20
> > -=09if (IS_ERR_OR_NULL(reg))
> > +=09if (IS_ERR_OR_NULL(priv->power)) {
>=20
> Can you please add a comment that the reset GPIO is needed to get the
> device out of sleep mode.

Will do! Sorry first day after vacation.

/Sean
