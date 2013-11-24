From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Calls to 'pm_runtime_resume()' made from the interrupt context
 without 'pm_runtime_irq_safe' in 'c_can.c' causing occasional kernel crash.
Date: Sun, 24 Nov 2013 23:51:46 +0100
Message-ID: <52928302.3010007@pengutronix.de>
References: <2A43324E02E34840B044C9DC922144800904D233@AMDTCEX10.actuant.pri>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Vh6iOfXLui3LfUmKo0moLeT5S3k4h7dJ7"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50453 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375Ab3KXWv6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 24 Nov 2013 17:51:58 -0500
In-Reply-To: <2A43324E02E34840B044C9DC922144800904D233@AMDTCEX10.actuant.pri>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Glen, Andrew" <AGlen@bepmarine.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Vh6iOfXLui3LfUmKo0moLeT5S3k4h7dJ7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/20/2013 03:07 AM, Glen, Andrew wrote:
> I've been getting occasional crashes running the 3.12 mainline kernel
> with a Debian rootfs on an AM335x (Beaglebone Black).

> The crash would only ever occur the first time the can0 device is
> brought up, i.e.: Reboot, call to 'ip link set can0 type can bitrate
> 250000 triple-sampling on', then 'ip link set can0 up' and about 40%
> of the time I'd get a crash.

> If the 'ip link set can0 up' succeeded I could then bring the can0
> device up/down repeatedly with no issues.

> Strangely, this problem would not occur running the same kernel with
> the Ubuntu rootfs - but I think this is unrelated to the issue.

> As the crash dump suggests, the problem is caused by a call to
> '__pm_runtime_resume' being made from within an interrupt routine -
> occuring when the CAN device is brought up immediately into a bus
> error (assumedly caused by starting up the can receiver midway
> through a transmission by another device).

Can you provide the crash dump?

> Power management should not occur from within an interrupt routine,
> so by making a special interrupt version of the routine
> problematically calling '__pm_runtime_resume' (i.e.
> 'c_can_get_berr_counter'), but with this call removed, I was
> initially able to get around the problem.

> Further researching into the issue, I found the following in
> '/Documentation/power/runtime_pm.txt':

> It is safe to execute the following helper functions from interrupt con=
text:
>=20
> pm_request_idle()
> pm_request_autosuspend()
> pm_schedule_suspend()
> pm_request_resume()
> pm_runtime_get_noresume()
> pm_runtime_get()
> pm_runtime_put_noidle()
> pm_runtime_put()
> pm_runtime_put_autosuspend()
> pm_runtime_enable()
> pm_suspend_ignore_children()
> pm_runtime_set_active()
> pm_runtime_set_suspended()
> pm_runtime_suspended()
> pm_runtime_mark_last_busy()
> pm_runtime_autosuspend_expiration()
>=20
> If pm_runtime_irq_safe() has been called for a device then the
> following helper functions may also be used in interrupt context:
>=20
> pm_runtime_idle()
> pm_runtime_suspend()
> pm_runtime_autosuspend()
> pm_runtime_resume()
> pm_runtime_get_sync()
> pm_runtime_put_sync()
> pm_runtime_put_sync_suspend()
> pm_runtime_put_sync_autosuspend()
>=20
>=20
> In 'c_can.c' as we find it in 3.12 mainline, calls to
> 'pm_runtime_resume()' are being made from the interrupt context (i.e.
> omap3_intc_handle_irq
> ->handle_IRQ->irq_exit->do_softirq->__do_softirq->net_rx_action->c_can_=
poll->c_can_state_change->c_can_get_berr_counter->__pm_runtime_resume)
> without 'pm_runtime_irq_safe' having first been called.

> So it makes sense that these problems were occurring, and that the
> problem goes away after inserting this call.
>=20
> I propose something like the following to fix this problem:
>=20
> diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_ca=
n.c index a668cd4..638fd22 100644
> --- a/drivers/net/can/c_can/c_can.c
> +++ b/drivers/net/can/c_can/c_can.c
> <at>  <at>  -1103,6 +1103,8  <at>  <at>  static int c_can_open(struct n=
et_device *dev)
>         int err;
>         struct c_can_priv *priv =3D netdev_priv(dev);
>=20
> +       pm_runtime_irq_safe(priv->device);
> +
>         c_can_pm_runtime_get_sync(priv);
>         c_can_reset_ram(priv, true);

Thanks for the detailed analysis. The problem with the
c_can_get_berr_counter() function is, that is is called from IRQ handler
and from the userspace via the priv->can.do_get_berr_counter callback.

If the c_can_get_berr_counter() is called from the IRQ handler, there is
no need to call c_can_pm_runtime_get_sync(), as the device is up the
open() function has been called. As the callback can be called if the
device is down, we need the c_can_pm_runtime_get_sync() call.

=46rom my point of view (I'm not familiar with runtime pm)
pm_runtime_irq_safe() has some drawbacks. I think we have a better
option, by introducing __c_can_get_berr_counter() which will not call
into the runtime PM.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Vh6iOfXLui3LfUmKo0moLeT5S3k4h7dJ7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlKSgwIACgkQjTAFq1RaXHMXlQCfYJ5uME2joNccdFf8Vp00SPLn
byYAn16BcC9Jaof2G3iP6A/O0+/dwlPm
=ur+8
-----END PGP SIGNATURE-----

--Vh6iOfXLui3LfUmKo0moLeT5S3k4h7dJ7--
