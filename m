From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v8] can: grcan: Add device driver for GRCAN and GRHCAN
 cores
Date: Wed, 14 Nov 2012 09:43:13 +0100
Message-ID: <50A359A1.30700@pengutronix.de>
References: <509C47CB.8060701@pengutronix.de> <1352732256-12712-1-git-send-email-andreas@gaisler.com> <50A2B88A.3040609@pengutronix.de> <50A34D49.2070908@gaisler.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6DDD9D2E86A7DB47A77E1113"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46351 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751578Ab2KNIn2 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 14 Nov 2012 03:43:28 -0500
In-Reply-To: <50A34D49.2070908@gaisler.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andreas Larsson <andreas@gaisler.com>
Cc: linux-can@vger.kernel.org, software@gaisler.com, Wolfgang Grandegger <wg@grandegger.com>, devicetree-discuss@lists.ozlabs.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6DDD9D2E86A7DB47A77E1113
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/14/2012 08:50 AM, Andreas Larsson wrote:
> On 11/13/2012 10:15 PM, Marc Kleine-Budde wrote:
>=20
> [...]
>=20
>> On 11/12/2012 03:57 PM, Andreas Larsson wrote:
>>> >+    bpr =3D 0; /* Note bpr and brp are different concepts */
>>> >+    rsj =3D bt->sjw;
>>> >+    ps1 =3D (bt->prop_seg + bt->phase_seg1) - 1; /* tseg1 - 1 */
>>> >+    ps2 =3D bt->phase_seg2;
>>> >+    scaler =3D (bt->brp - 1);
>>> >+    timing |=3D (bpr << GRCAN_CONF_BPR_BIT) & GRCAN_CONF_BPR;
>>> >+    timing |=3D (rsj << GRCAN_CONF_RSJ_BIT) & GRCAN_CONF_RSJ;
>>> >+    timing |=3D (ps1 << GRCAN_CONF_PS1_BIT) & GRCAN_CONF_PS1;
>>> >+    timing |=3D (ps2 << GRCAN_CONF_PS2_BIT) & GRCAN_CONF_PS2;
>>> >+    timing |=3D (scaler << GRCAN_CONF_SCALER_BIT) & GRCAN_CONF_SCAL=
ER;
>>> >+
>>> >+    netdev_info(dev, "setting timing=3D0x%x\n", timing);
>> what about moving the sanity check before putting together the "timing=
"
>> variable and doing the netdev_info()?
>=20
> The idea was for the user to have the full context of the problem when
> getting the error (e.g., when using the bitrate method to set the timin=
g
> parameters, the calculated parameters are not otherwise known to the
> user). But I can do that with a separate netdev_dbg and move the sanity=

> check as suggested.

I'm worried about the first stating "setting timing", but then not
writing it to the register.

>=20
>>> >+    if (!(ps1 > ps2)) {
>>> >+        netdev_err(dev, "PS1 > PS2 must hold: PS1=3D%d, PS2=3D%d\n"=
,
>>> >+               ps1, ps2);
>>> >+        return -EINVAL;
>>> >+    }
>>> >+    if (!(ps2 >=3D rsj)) {
>>> >+        netdev_err(dev, "PS2 >=3D RSJ must hold: PS2=3D%d, RSJ=3D%d=
\n",
>>> >+               ps2, rsj);
>>> >+        return -EINVAL;
>>> >+    }
>>> >+
>>> >+    grcan_write_bits(&regs->conf, timing, GRCAN_CONF_TIMING);
>>> >+    return 0;
>>> >+}
>=20
> [...]
>=20
>>> >+static int grcan_poll(struct napi_struct *napi, int rx_budget)
>>> >+{
>>> >+    struct grcan_priv *priv =3D container_of(napi, struct grcan_pri=
v,
>>> napi);
>>> >+    struct net_device *dev =3D priv->dev;
>>> >+    struct grcan_registers __iomem *regs =3D priv->regs;
>>> >+    int rx_work_done;
>>> >+    unsigned long flags;
>>> >+
>>> >+    /* Receive according to given budget */
>>> >+    rx_work_done =3D grcan_receive(dev, rx_budget);
>>> >+
>>> >+    /* Catch up echo skb according to separate budget to get the
>>> benefits of
>>> >+     * napi for tx as well. The given rx_budget might not be
>>> appropriate for
>>> >+     * the tx side.
>>> >+     */
>>> >+    grcan_transmit_catch_up(dev, GRCAN_TX_BUDGET);
>>> >+
>>> >+    spin_lock_irqsave(&priv->lock, flags);
>>> >+
>>> >+    if (grcan_poll_all_done(dev)) {
>> Just make it:
>>     if (work_done < budget) {
>>         napi_complete();
>>         enable_interrupts();
>>     }
>>
>> If there are CAN frames pending, an interrupt will kick in and
>> reschedule the NAPI.
>=20
> Sure, I can do that for the first check (and add back checking
> tx_work_done as well). That misses to call napi_complete and start

Hmmm...Either move tx-complete handling to the interrupt handler, or
just use a budget big enough for rx and tx-complete.

> interrupts in the case in which handling of frames are complete
> work_done =3D=3D budget though. But on the other hand, then grcan_poll =
will
> be triggered once again and then detect that nothing is to be done if
> that is still the case.
>=20
> However, the problem with skipping the check after turning on interrupt=
s
> is that more frames can have arrived and/or have been sent after
> calculating work_done and before turning on interrupts. For those
> frames, unless I have misunderstood something, interrupts will not be
> raised and they can get stuck until (if ever) later frames once again
> trigger rescheduling of napi.

No, if correctly used, NAPI is race free and no events will be lost:

Handle incoming events (rx or tx-complete) until:
a) number of handled events =3D=3D budget
or
b) no more events pending.

	while (work_done < budget && interrupts_pending()) {
		work_done +=3D handle_rx(budget - work_done);
		work_done +=3D handle_tx(budget - work_done);
	}

Then, if you have handled less events then budget:
1) call napi_complete()
then
2) enable interrupts.

	if (work_done < budget) {
		napi_complete();
		enable_interrupts();
	}

Then, return number of handled events:

	return work_done;

>=20
>>> >+        bool complete =3D true;
>>> >+
>>> >+        if (!priv->closing) {
>>> >+            /* Enable tx and rx interrupts again */
>>> >+            grcan_set_bits(&regs->imr, GRCAN_IRQ_TX | GRCAN_IRQ_RX)=
;
>>> >+
>>> >+            /* If more work arrived between detecting completion an=
d
>>> >+             * turning on interrupts, we need to keep napi running
>>> >+             */
>>> >+            if (!grcan_poll_all_done(dev)) {
>>> >+                complete =3D false;
>>> >+                grcan_clear_bits(&regs->imr,
>>> >+                         GRCAN_IRQ_TX | GRCAN_IRQ_RX);
>>> >+            }
>>> >+        }
>>> >+        if (complete)
>>> >+            napi_complete(napi);
>>> >+    }
>>> >+
>>> >+    spin_unlock_irqrestore(&priv->lock, flags);
>>> >+
>>> >+    return rx_work_done;
>>> >+}

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig6DDD9D2E86A7DB47A77E1113
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlCjWaQACgkQjTAFq1RaXHOaqwCdE0RtGhIuoN1zjau30gOrOQY0
PXEAn1z96svDiqlXrKBtyTl9+I0S+zxj
=CSYH
-----END PGP SIGNATURE-----

--------------enig6DDD9D2E86A7DB47A77E1113--
