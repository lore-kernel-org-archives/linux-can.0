Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F15B3955F9;
	Fri, 16 Oct 2026 14:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792160472; cv=pass; b=WWR9Nl8n9ntD+G2XsxglBdtqDHhRe+avEKNXa/PKJsM+DDRfo7YH+IvCD0SDug2IVF/dbkQCQxfJklfAKdE2XVxm6O+BL8forvuTwweJjayZ0FA0pBG1u0xfb6uToA1F/58hEehpQlTr3HnuEPhCRRVO7jvoyiLFY4NSpnIEJOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792160472; c=relaxed/simple;
	bh=ri1l9nXhKfM1bIfHjH5AIAVXJjef9768xWdpZlXYhw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=adyYza6AV7683jJa5vS5KQnAYVaiWc0NDCfrvidYOYDXCEQTqEBWrqOkFVggsBdLQcV6oq0viFdi/rJs9tsKIKhSkX4HmyZXT0kMRQVlNsOZaiKQ+NIKeR7hm9t10ywRi+T4VSV9GCk0shiaKmonMZ8HUITiTEpcB0XGqtEAhEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=CPEYDfL9; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="CPEYDfL9"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id F16722022C9;
	Fri, 16 Oct 2026 16:21:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792160463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NBDbBDxCYOmi0zU6LSmui73qHGJ2obUNIbsCQeuGJMI=;
	b=CPEYDfL9N3zV794tHJfGNINZWZFSzby0eG6zAJVYEO9uGF1kUbz41BJfwnMJvfsaXEiATP
	YhF1KS4Kv/nmqSxJUBZaQsOEO18BYwUH3wPOW5WUIRRbQRMw+PBAEyEBKUVA08MpeY9E0G
	whHasXMxwN5BevkGJuY5QBJiA2vmoHwWMPexSNMMfbslaBSlUlbJgiRepaOexw8G4JgaMP
	iy6LsOmTqzwdBqxwTMj4EEs7kHjMmUjc+xJyClvgl55kxUEgzcZ4YfdUYqb/QxQPHy45o3
	LTJ+P3C+BaCNNJBLCMKHZgprPzbOqyRLnsk67dzgxJFtV9C8RYyy3C8EUdK4VA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792160463; a=rsa-sha256;
	cv=none;
	b=ejPFQu/0ez+DTGQoPSMPrY9oI7N8uUyZHLcGiVnhJXIWVmVi77OGKnHAUkfXKGZIs7ENKC
	WtgiUnHthX9GxbFf22qQZ2tXLl2JrAgzqnVbpJ/SkfXhzYJdH73dJ1M58g+wcV/S+J1QXl
	3W3KaIwIlFE0M+l/AU+TnKMbDECGSSqFo6L2Xslc8UHYpQfcDHgVd9+CBRQ4E8bBHaT/wM
	ZAViYjSiJnU7vxs8xE+MI/XEymP+gdoZZFCNnR5uk88DDWSM+lcGmE5OyzrM+gY9cIdFsb
	+PAZWQBnprKmck9Bn1ebhBiLoboRzTlO3awASBm9MqKJrIWDrqdFXc4BmcZ/6A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792160463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NBDbBDxCYOmi0zU6LSmui73qHGJ2obUNIbsCQeuGJMI=;
	b=dFED9ZtVWw8UtXZ5wP1ShTIifM4dPXxQSV9zIDdpAYYjAPTKzpyTdS/llXM4PEvnRk642y
	Q/su+z9A3YFpvNyU0cB1JxMQlLTZaIAxdL0aceBv8pKr170CwRJ0+BFRG9UoKg0QwPwkWN
	zRSjWTTUEbwmFp+zQjHh76xHltUU4D/bK5oy1393eB0mmVOODS89ZydKw2W27c6QjnULa8
	W4fzgyUOm5IfivvJ5G0G8ZNqLNZmFLmVyKsdH/WyP8C3YvT9Bq9uQCNYujU5bdU+VTbORD
	b01jT45MrAkXhGrV79hMAjYtJYtOyAp8IZP4398AvhQCG9x02ZyaUo5z0WLuog==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHinv-006CN7-2s;
	Fri, 16 Oct 2026 16:21:03 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 8EC765C62D6;
	Fri, 16 Oct 2026 14:21:03 +0000 (UTC)
Date: Fri, 16 Oct 2026 16:21:03 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Tu Nguyen <tu.nguyen.xg@renesas.com>, linux-can@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>
Subject: Re: [PATCH v4 3/3] can: rcar_canfd: Add support for Renesas RZ/G3L
Message-ID: <20261016-enchanted-poetic-beagle-61cca6-mkl@pengutronix.de>
References: <20261001075742.21961-1-biju.das.jz@bp.renesas.com>
 <20261001075742.21961-4-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7ff2d7fc2rwade7x"
Content-Disposition: inline
In-Reply-To: <20261001075742.21961-4-biju.das.jz@bp.renesas.com>


--7ff2d7fc2rwade7x
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 3/3] can: rcar_canfd: Add support for Renesas RZ/G3L
MIME-Version: 1.0

On 01.10.2026 08:57:39, Biju Das wrote:
> Add support for Renesas RZ/G3L CANFD IP. RZ/G3L has 3 channels and
> 11 interrupts, compared 2 channels and 8 interrupts on RZ/G3S.
> RZ/G3L has 288 buffers compared to 192 buffers on RZ/G3S.
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

netdev sashiko is not happy.

regards,
Marc

--- Patch [22]: [PATCH net-next 22/37] can: rcar_canfd: Add support for Ren=
esas RZ/G3L ---
commit 1811b72e7e6100246f7fbb9e3871869d81790a54
Author: Biju Das <biju.das.jz@bp.renesas.com>

can: rcar_canfd: Add support for Renesas RZ/G3L

This patch adds the renesas,r9a08g046-canfd compatible to
rcar_canfd_of_table and maps it to the existing RZ/G3S hw_info
(r9a08g045_hw_info). The commit message says RZ/G3L has 3 channels,
11 interrupts and 288 buffers.

Link: https://patch.msgid.link/20261001075742.21961-4-biju.das.jz@bp.renesa=
s.com

> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rca=
r_canfd.c
> index 41c395118949..c64387967368 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -2403,6 +2403,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(rcar_canfd_pm_ops, =
rcar_canfd_suspend,
>  static const __maybe_unused struct of_device_id rcar_canfd_of_table[] =
=3D {
>  	{ .compatible =3D "renesas,r8a779a0-canfd", .data =3D &rcar_gen4_hw_inf=
o },
>  	{ .compatible =3D "renesas,r9a08g045-canfd", .data =3D &r9a08g045_hw_in=
fo },
> +	{ .compatible =3D "renesas,r9a08g046-canfd", .data =3D &r9a08g045_hw_in=
fo },

Discovered by: gpt-6-astra, opus-5-5 =C2=B7 Missed by: sashiko-gemini
With this patch, RZ/G3L probes and resets exactly like RZ/G3S. Should
the binding also make resets and reset-names required for RZ/G3L?

In Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml,
r9a08g046 is missing from the allOf block that requires them:

  - if:
      properties:
        compatible:
          contains:
            enum:
              - renesas,r9a08g045-canfd
              - renesas,r9a09g047-canfd
              - renesas,rzg2l-canfd
    then:
      required:
        - resets
        - reset-names

The RZ/G3L block only has "resets: minItems: 2", which applies only when
the property is present. So an RZ/G3L node without resets would pass
dt_binding_check and dtbs_check.

The driver would not catch this either. rcar_canfd_probe() gets both
resets as optional:

    gpriv->rstc1 =3D devm_reset_control_get_optional_exclusive(dev, "rstp_n=
");
    ...
    gpriv->rstc2 =3D devm_reset_control_get_optional_exclusive(dev, "rstc_n=
");

In that case reset_control_reset(NULL) in rcar_canfd_global_init()
does nothing and returns 0. Could the IP then stay in reset with
nothing printed to explain it?

The same RZ/G3L block also sets minItems: 11 for interrupts and
interrupt-names, but has no maxItems: 11. Is that intended?

The schema gap comes from "dt-bindings: can: renesas,rcar-canfd:
Document RZ/G3L SoC" earlier in this series. It is still there at the
end of the series.

Discovered by: gpt-6-astra, opus-5-5 =C2=B7 Missed by: sashiko-gemini =C2=
=B7 Ranked Critical by: gpt-6-astra
This isn't a bug introduced by this patch, but RZ/G3L adds a third
channel, so is the register_candev() failure path in
rcar_canfd_channel_probe() safe?

gpriv->ch[ch] is set before registration. The failure path then frees
ndev, and priv with it, without clearing gpriv->ch[ch]:

rcar_canfd_channel_probe() {
    ...
	gpriv->ch[priv->channel] =3D priv;
	err =3D register_candev(ndev);
	if (err) {
		...
		goto fail_candev;
	}
    ...
fail_candev:
	netif_napi_del(&priv->napi);
fail:
	free_candev(ndev);
	return err;
}

rcar_canfd_probe() then calls remove for every enabled channel:

fail_channel:
	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->max_channels)
		rcar_canfd_channel_remove(gpriv, ch);

The only check in rcar_canfd_channel_remove() is for a NULL priv:

	if (priv) {
		unregister_candev(priv->ndev);
		netif_napi_del(&priv->napi);
		free_candev(priv->ndev);
	}

For the channel that just failed, does this read priv->ndev from freed
memory? It would also call unregister_candev() on a netdev that was
never registered, then free_candev() on the same net_device again.

The early assignment to gpriv->ch[] goes back to at least commit
c5048a7b2c23a.

Discovered by: gpt-6-astra =C2=B7 Missed by: opus-5-5, sashiko-gemini =C2=
=B7 Confirmed by: opus-5-5 =C2=B7 Called a false positive by: gpt-6-astra
This is a pre-existing issue, but when rcar_canfd_global_init() fails,
does rcar_canfd_probe() release the clocks and resets a second time?

rcar_canfd_global_init() already cleans up on its own error paths:

fail_mode:
	rcar_canfd_disable_global_interrupts(gpriv);
fail_reset2:
	reset_control_assert(gpriv->rstc2);
fail_reset1:
	reset_control_assert(gpriv->rstc1);
fail_ram_clk:
	clk_disable_unprepare(gpriv->clk_ram);
fail_clk:
	clk_disable_unprepare(gpriv->clkp);
	return err;

But rcar_canfd_probe() still sends every error to fail_mode:

	err =3D rcar_canfd_global_init(gpriv);
	if (err)
		goto fail_mode;
    ...
fail_mode:
	rcar_canfd_global_deinit(gpriv, false);

rcar_canfd_global_deinit() calls rcar_canfd_disable_global_interrupts(),
which writes GCTR/GERFL while clkp is off and the resets are asserted.
It then asserts the resets again and calls clk_disable_unprepare() on
clk_ram and clkp a second time.

Would this trigger the clock core's "already disabled" and "already
unprepared" warnings? If the clocks are shared, could it also remove
another consumer's enable reference?

Possible triggers are a reset_control_reset() error, or a
readl_poll_timeout() timeout in rcar_canfd_reset_controller() or in
the GOPM mode check. The global_init/global_deinit split came from
commit fa5f4ec8fff8b.

pw-bot: cr

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--7ff2d7fc2rwade7x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCatIyzAAKCRDMOmT6rpmt
0oAnAQDvQTELyr2BZnfOp5yXpwez5ecSnOJC7UJF81msvm1GkAD+NRr2lcKZCQQ2
lasVEmD/+EP1pI8AJARsYgeKmKIOmww=
=M3nd
-----END PGP SIGNATURE-----

--7ff2d7fc2rwade7x--
