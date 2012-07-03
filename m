From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] can: flexcan: add a regulator for transceiver
Date: Tue, 3 Jul 2012 15:46:47 +0100
Message-ID: <20120703144646.GT29030@opensource.wolfsonmicro.com>
References: <1341319571-27763-1-git-send-email-shawn.guo@linaro.org>
 <20120703130747.GD25995@sirena.org.uk>
 <20120703141829.GG22705@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0M7E0x35R+W+EAky"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:57257 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751551Ab2GCOqs (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 3 Jul 2012 10:46:48 -0400
Content-Disposition: inline
In-Reply-To: <20120703141829.GG22705@S2101-09.ap.freescale.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org


--0M7E0x35R+W+EAky
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 03, 2012 at 10:18:31PM +0800, Shawn Guo wrote:
> On Tue, Jul 03, 2012 at 02:07:47PM +0100, Mark Brown wrote:

> > No, the regulator API will stub itself out if not enabled, and if the
> > supply is fixed then a fixed voltage regulator will do the job.  We
> > shouldn't be open coding this stuff in individual users.

> Ah, yes.  But when you say "a fixed voltage regulator", you actually
> meant dummy regulator, right?

No, I really do mean a fixed voltage regulator.  Dummy regulators should
essentially never be used in production.

>  static void flexcan_transceiver_switch(const struct flexcan_priv *priv, int on)
>  {
> +       if (on)
> +               regulator_enable(priv->reg_xcvr);
> +       else
> +               regulator_disable(priv->reg_xcvr);
> +

So long as the stack guarantees that you won't get unbalanced calls to
this and...

> +       priv->reg_xcvr = devm_regulator_get(&pdev->dev, "xcvr");

...add error checking here the code should be fine, yes.

--0M7E0x35R+W+EAky
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP8wXQAAoJEBus8iNuMP3dY8AP/Az2+p7MS3WTNuTY51VlfeM2
2Qn1+p8VJCk1NdEVqHxmFwVsxj3rGWbhc8L0N+NJ6J5ig85R3x3hdts4TCXe2kFQ
WKz5T0mhRGqpUn87Hn4P3DIdMpeeAyEipIAAt451ecQlIO4olmDmGImVZrISwmUo
LGiqpXrLgwSwrGT7Za43auU9x/etWyqRzf/vJVFpsEpyJnaTH+XyFxo0C0qPVv+2
5R9lK7pzoYiNu9EZJrav2MinfoHpvo3Zbm8IngZUu4QOsWV5gbOWT1jKo1iICvce
W8sh+xt0838BTW0v9v6TbggdfsJhKXN7HSuJqMwpK8iRgLiIKX7la7t4C73onINa
Dq947KPUGtJ6smxtgD+5MhVPsQ+aeF7j0Vs+Dv7sWZMM1zPBQtphi2WLm337Draq
+f63HjORhWDoAgeWCWWUeU/TxUvCzGnowlulA95dcbATKK2PB5h4hr6GT/YYOBrn
GXPdLBWNT3Si1bVQNSnRCtd/d8tPCvcjDVXpYcq6xBzOO1CTi10MMD2UvapgKjtp
NioLGMI/P2YRKz6fPwwDn04BrjYK7lBB57AC7baZLJS59GcobV+ZCqWB1LgVIAOj
AQA+MhH5dr+DPBfTN0MK+BxwFiGT6mbEFP8U2/NkqqB36gKkLMjFcQCVde1XPt4f
JM7/WhE/0pE44Ukp2ZfN
=VFWk
-----END PGP SIGNATURE-----

--0M7E0x35R+W+EAky--
