Received: from mail-4320.protonmail.ch (mail-4320.protonmail.ch [185.70.43.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7F53EEADF;
	Mon, 27 Jul 2026 10:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785148463; cv=none; b=IV6DodU5fOSgf9DPWvG7YVIKHvGA5TKdrANvD6MqCfsKBDap1SVplGhF5r9GiuZ/ewQxhbH2vqF9VAb1NroHyxyeoHCmegIXGmulXM3aeVkbruM/LulUxFIR4zWrVbPeK5vv0LOUxaQRZEWi5LQKVy1oZZAGsRZtUwvF8k43U2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785148463; c=relaxed/simple;
	bh=zCqJBB1z3x/97+7Fk2GLrB59qs5NUkLra150pNmq4RY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xg+vHvxLTSLFYeCu+xCMEYahEEx6zfN2rVay5/P4rN30h58SylhI0yu3hCB9C01/gH7OqWoUUJ3xWr5pSKXQ4jHn8FWWTVjREAnNL+GqD0svxuzTAunzTs+YYOgOqM5dj10tmtSyZXhB0z2mqbjMxi5CbV+0PFtL6eFVGPcsMqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=Y03I15De; arc=none smtp.client-ip=185.70.43.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="Y03I15De"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1785148450; x=1785407650;
	bh=UkJZ6nbIfNmgq6yttFC0NgS/LfJyJyRh8eSqpRX4MNM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Y03I15DejJ9GBHwKaIXUvT4dwi1+SnabvodfGVSH3Z8FjkckyyL0cJbqN/YVuKz+x
	 36r+NAnufxz0hRQdyH6TnwWYQFr/8DJkSyEXQY2SIxubQrKlTUOSdq0XCUsBX+sxiM
	 H9zJEs6iyfk16rQmbtP7jdfwtZpXvld6yfHuxO2b4QLofTXp7zk/aB6Oaicxl5YDmo
	 jpgwZlDSJQBHh03QFza7whoUfsu/JZvA2DX1PG5Q8PFKbiACZl53mlT8kx4G+oXDjF
	 J3aOjvEolXGOWPXhHscaXTZwPOgG2lqBw+SY/gUENFIB4WltfsGPmASsb+HCED2GU6
	 Jmdqk3klfb6QQ==
Date: Mon, 27 Jul 2026 10:34:06 +0000
To: Marc Kleine-Budde <mkl@pengutronix.de>
From: Sean Nyekjaer <sean@geanix.com>
Cc: Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] can: tcan4x5x: put tcan into sleep when removing driver
Message-ID: <79jbRkghpsRXohQwvs2lpvzMHo7eTeLspkjBRCa2Mlc02VkFu1jP8j0xJZP86-teeiqJroLBaM5D2PgvneSZs5iiWJGQPsXu9u7xGm41WTk=@geanix.com>
In-Reply-To: <20260727-merciful-unstoppable-pigeon-4286de-mkl@pengutronix.de>
References: <20260727094900.1214157-1-sean@geanix.com> <20260727-merciful-unstoppable-pigeon-4286de-mkl@pengutronix.de>
Feedback-ID: 134068486:user:proton
X-Pm-Message-ID: 3dc1a304c016a884c3a98a677834e54c4c801fb7
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,


On Monday, 27 July 2026 at 12:22, Marc Kleine-Budde <mkl@pengutronix.de> wr=
ote:

> On 27.07.2026 11:48:59, Sean Nyekjaer wrote:
> > Put the tcan4x5x transceiver into sleep mode when the driver is
>=20
> Ah, the device has an internal transceiver.
>=20
> > removed, instead of leaving it in its current operating mode.
> > This reduces power consumption(3mA@12V) once the driver is
> > no longer bound to the device.
> >
> > Note that the reset pin is needed to bring the device out of sleep
> > and back into standby mode again.
>=20
> Please add a comment, that the reset pin is needed and maybe refer to
> "8.4.3 Sleep Mode" of https://www.ti.com/lit/gpn/tcan4550

Will do.
>=20
> Does it still work, if you move the regmap_update_bits() to
> tcan4x5x_power_enable()?

In our use-case, we don't have control over Vsup. It's directly wired to 12=
V from the car.
But toggling Vsup will get the tcan4x5x into standby mode again.

Maybe:
if (priv->reset_gpio && priv->power =3D=3D NULL) ?

>=20
> > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> > ---
> > I havn't come across any drivers that leaves the devices in the lowest
> > power mode when unbinded. But we need this to enter our lowest power
> > mode in suspend.
> > If it doesn't fit in, I'm happy to carry this out of tree...
>=20
> The mcp251xfd driver puts the device into sleep mode.
>=20
> regards,
> Marc
>=20
> --=20
> Pengutronix e.K.                 | Marc Kleine-Budde          |
> Embedded Linux                   | https://www.pengutronix.de |
> Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |
>=20

/Sean
