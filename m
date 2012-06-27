From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 4/4] can: flexcan: add transceiver switch support when
 use device tree
Date: Wed, 27 Jun 2012 12:02:18 +0200
Message-ID: <4FEADA2A.6070304@pengutronix.de>
References: <1340785161-3598-1-git-send-email-jason77.wang@gmail.com> <1340785161-3598-2-git-send-email-jason77.wang@gmail.com> <1340785161-3598-3-git-send-email-jason77.wang@gmail.com> <1340785161-3598-4-git-send-email-jason77.wang@gmail.com> <1340785161-3598-5-git-send-email-jason77.wang@gmail.com> <4FEAC3AA.500@pengutronix.de> <4FEAD897.5070408@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigADBB73CA3DFC3F6C69F3E900"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55894 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753814Ab2F0KCZ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 27 Jun 2012 06:02:25 -0400
In-Reply-To: <4FEAD897.5070408@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Hui Wang <jason77.wang@gmail.com>
Cc: davem@davemloft.net, shawn.guo@linaro.org, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigADBB73CA3DFC3F6C69F3E900
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 06/27/2012 11:55 AM, Hui Wang wrote:
> Marc Kleine-Budde wrote:
>> On 06/27/2012 10:19 AM, Hui Wang wrote:
>> =20
>>> Some platforms (like i.MX6) has an external PHY, the PHY is operated
>>> by some gpios. If the system registers a platform_data, we can
>>> set a callback function pointer to pdata->transceiver_switch to
>>> implement PHY switch. If we use device tree, we couldn't pass
>>> platform_data to the driver, so i move the switch function to the
>>> driver and add device tree entries to let user set which gpios
>>> are used to operate PHY.
>>>
>>> This design doesn't break existing platforms, if a platform doesn't
>>> need PHY switch, it doesn't need to set dt entries just as before,
>>> if a platform has platform_data, the pdata->transceiver_switch has
>>> higher priority.
>>>
>>> Cc: linux-can@vger.kernel.org
>>> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
>>> Cc: David S. Miller <davem@davemloft.net>
>>> Cc: Shawn Guo <shawn.guo@linaro.org>
>>> Signed-off-by: Hui Wang <jason77.wang@gmail.com>
>>>    =20
>>
>> please coordinate whith Shawn Guo, he has posted a similar patch some
>> days ago. http://www.spinics.net/lists/netdev/msg202442.html
>>
>> Marc
>>
>>  =20
> After read and compared with his patch:
> 1. Shawn use gpio_is_valid(gpio) instead of (gpio >=3D 0), it is good.

yes

> 2. Shawn add a flag to record active level, it is good.

yes - have a look at the device tree if there is a common symbol name
for this.

> 3. Shawn only add 1 gpio, this is not enough for imx6 sabre lite board.=


improve your patch to work with 1 or 2 gpios.

> 4. Shawn forget to call gpio_release()

good catch.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigADBB73CA3DFC3F6C69F3E900
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/q2ioACgkQjTAFq1RaXHPhbwCfRwSWXSAwDSqzEze6ef5eAVsV
aNcAoIccq5PWu7zp2vISezjQwX8UN1U2
=zF89
-----END PGP SIGNATURE-----

--------------enigADBB73CA3DFC3F6C69F3E900--
