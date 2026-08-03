Received: from mail-10625.protonmail.ch (mail-10625.protonmail.ch [79.135.106.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CB53FDBF5
	for <linux-can@vger.kernel.org>; Mon,  3 Aug 2026 11:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785755796; cv=none; b=DBu/kO4pyiSdikh/LesDiXKXthPcqBUk+n/ZgPFQ/U18tQvia4L200T+9j8i2UrwfyjzKqrjvzpdC73ed7/lW+Na4tp2WRoqfBG0wM1G7O4mz/brsewLMpBIjv4JaYNnwqQzy90byEp/xUExWDQbGX9oDNGcvSdOS9PyqZYC0og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785755796; c=relaxed/simple;
	bh=QiW7xw0ZNCqCoK7T3aJJ+nsXpdSQt+rdYJfPwEdAdGs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZdBqCq3G7qtZwjRgqFr9f03PMdeXXqbywAcf0eFwtMwlnI9n2eToZEfa0MyzV3MyP0glBXW63ml4zmUKRCh2clMojQoq5WJPMqxeOdinqOSvNCZdkxw/goJxWqGrjE4D101vfvrAhkaMsl3alNQ1k5YPWjxFSNaK9YcnEi3oeEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=btlEh2Vl; arc=none smtp.client-ip=79.135.106.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="btlEh2Vl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1785755783; x=1786014983;
	bh=X285j/+ggX13KHE+9Cxwu0Q0Md7Zif1JbObUrF6J38U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=btlEh2Vltx6SaOrRmnVf+mLp6zj19iKYKAsr80fMusGMMfjpb5gltfvFbQlNYkFvc
	 lQqsGBK3WDz/zZOkVPQQ2FHLDpIDoWiGyxfXXnOqhIipGbYVE20i4llZlF0FaHFCn2
	 iAi0Nj1GPLheGYBCTb/05SjojgQ7MdHKhbabSObiRU5znMvxwjQcUqGiRfb8okoFu4
	 /1LI/usRVdaaEG51Ot91pYus3ftJE8hf1Ynu6zKLNYaPgQzGQ8c1PVstBpDQhVO0rv
	 mtWap8qGIxhvXfNkQ+g3vg+qdMm7EHl03I3XoYaoOTrKlSq8+FulSNMt7LoT6rDrkp
	 Wkf0k81KaF0AA==
Date: Mon, 03 Aug 2026 11:16:20 +0000
To: sashiko-reviews@lists.linux.dev
From: Sean Nyekjaer <sean@geanix.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Vincent Mailhol <mailhol@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2] can: tcan4x5x: put tcan into sleep when removing driver
Message-ID: <q3LwALtEs55OqWLslOGbypHDnnUEkEDZlOYrjnxD7LQhiWSkFOOr9zw5_VahYRMVSjShxnODVlL8k34_HGh3vunnQHHPkT28LApT39NeOvo=@geanix.com>
In-Reply-To: <20260803103319.E155A1F000E9@smtp.kernel.org>
References: <20260803101927.17122-1-sean@geanix.com> <20260803103319.E155A1F000E9@smtp.kernel.org>
Feedback-ID: 134068486:user:proton
X-Pm-Message-ID: 839e74617ac4414366cd53aa8c50e0cffbd333c6
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable





On Monday, 3 August 2026 at 13:05, sashiko-bot@kernel.org <sashiko-bot@kern=
el.org> wrote:

> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
>=20
> New issues:
> - [High] The function signature of `tcan4x5x_power_enable()` was changed =
to accept a `struct tcan4x5x_priv *` instead of `struct regulator *`, but t=
he call site in `tcan4x5x_can_remove()` was not updated. This causes a seve=
re type mismatch leading to a wild pointer dereference.

Will fix for v3 :)

> - [Medium] The transceiver is not explicitly put into sleep mode via SPI =
during driver removal if it is powered by a regulator, undermining the patc=
h's intended power savings.

Intended, as the regulator will power it off.

>=20
> Pre-existing issues:
> - [High] The polling hrtimer is not synchronously cancelled during device=
 teardown, allowing its callback to execute concurrently on freed memory.
> --
>=20
> --- Patch [1]: [PATCH v2] can: tcan4x5x: put tcan into sleep when removin=
g driver ---
> commit b49d2b844c12ed05e9ff4437bc458dbace9b23e8
> Author: Sean Nyekjaer <sean@geanix.com>
>=20
> can: tcan4x5x: put tcan into sleep when removing driver
>=20
> Put the tcan4x5x transceiver into sleep mode when the driver is
> removed, instead of leaving it in its current operating mode.
> This reduces power consumption(3mA@12V) once the driver is
> no longer bound to the device.
>=20
> > diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_=
can/tcan4x5x-core.c
> > index 31cc9d0abd453..67902b8b0fab4 100644
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
> [Severity: High]
> Did this signature change miss updating the call site in
> tcan4x5x_can_remove()?
>=20
> When the driver is unloaded, tcan4x5x_can_remove() still passes priv->pow=
er
> which is a struct regulator pointer:
>=20
> drivers/net/can/m_can/tcan4x5x-core.c:tcan4x5x_can_remove() {
> =09...
> =09tcan4x5x_power_enable(priv->power, 0);
> =09...
> }
>=20
> Could this cause a panic when tcan4x5x_power_enable() tries to dereferenc=
e
> the regulator pointer as a struct tcan4x5x_priv?
>=20
> > -=09if (IS_ERR_OR_NULL(reg))
> > +=09if (IS_ERR_OR_NULL(priv->power)) {
> > +=09=09if (priv->reset_gpio && !enable)
> > +=09=09=09return regmap_update_bits(priv->regmap, TCAN4X5X_CONFIG,
> > +=09=09=09=09=09=09  TCAN4X5X_MODE_SEL_MASK,
> > +=09=09=09=09=09=09  TCAN4X5X_MODE_SLEEP);
> > +
> >  =09=09return 0;
> > +=09}
>=20
> [Severity: Medium]
> If the device tree specifies a regulator for the transceiver, will this
> skip putting the device into sleep mode?
>=20
> Since the sleep configuration is gated inside the check for
> IS_ERR_OR_NULL(priv->power), if a regulator is present, the function skip=
s
> this block and just disables the regulator.
>=20
> If this regulator is shared with other components on the board, does it l=
eave
> the transceiver powered and in its previous state instead of entering sle=
ep
> mode?
>=20
> [ ... ]
>=20
> [Severity: High]
> This isn't a bug introduced by this patch, but is there a race condition
> with the polling hrtimer during device teardown?
>=20
> During device teardown, m_can_disable_all_interrupts() uses a non-blockin=
g
> cancel:
>=20
> drivers/net/can/m_can/m_can.c:m_can_disable_all_interrupts() {
> =09...
> =09if (!cdev->net->irq) {
> =09=09netdev_dbg(cdev->net, "Stop hrtimer\n");
> =09=09hrtimer_try_to_cancel(&cdev->hrtimer);
> =09}
> }
>=20
> If the timer callback m_can_polling_timer() is concurrently running on an=
other
> CPU, hrtimer_try_to_cancel() will fail.
>=20
> If the callback reads the state before it is updated to CAN_STATE_STOPPED=
,
> will it reschedule itself and eventually execute on freed memory?
>=20
> drivers/net/can/m_can/m_can.c:m_can_polling_timer() {
> =09...
> =09hrtimer_forward_now(timer, ms_to_ktime(HRTIMER_POLL_INTERVAL_MS));
>=20
> =09return HRTIMER_RESTART;
> }
>=20
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803101927.17=
122-1-sean@geanix.com?part=3D1
>=20
> 
