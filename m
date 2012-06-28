From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 2/2] net: flexcan: add transceiver switch gpios support
Date: Thu, 28 Jun 2012 12:32:50 +0200
Message-ID: <4FEC32D2.4060200@pengutronix.de>
References: <1340853701-4488-1-git-send-email-shawn.guo@linaro.org> <1340853701-4488-3-git-send-email-shawn.guo@linaro.org> <4FEBF64F.1010804@gmail.com> <20120628063426.GA22990@S2101-09.ap.freescale.net> <4FEC015A.7050602@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig308454D18A818E2427FA5C42"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39503 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726Ab2F1Kcz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 28 Jun 2012 06:32:55 -0400
In-Reply-To: <4FEC015A.7050602@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Hui Wang <jason77.wang@gmail.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig308454D18A818E2427FA5C42
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 06/28/2012 09:01 AM, Hui Wang wrote:
> Shawn Guo wrote:
>> On Thu, Jun 28, 2012 at 02:14:39PM +0800, Hui Wang wrote:
>> =20
>>>> diff --git
>>>> a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
>>>> b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
>>>> index 8ff324e..e0dbac7 100644
>>>> --- a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
>>>> +++ b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
>>>> @@ -15,6 +15,8 @@ Required properties:
>>>> Optional properties:
>>>> - clock-frequency : The oscillator frequency driving the flexcan dev=
ice
>>>> +- phy-enable-gpios : Specify the gpio used to enable phy
>>>> +- phy-standby-gpios : Specify the gpio used to put phy into STANDBY=

>>>> mode
>>>> Example:
>>>>      =20
>>> Do we need to add new added entries in the example section as well.
>>>
>>> E.g.
>>>
>>> +        phy-enable-gpios =3D <&gpio1 4 0>; /* GPIO1_4, active high*/=

>>> +        phy-standby-gpios =3D <&gpio1 2 1>; /* GPIO1_2, active low *=
/
>>>
>>>    =20
>> I chose not to because after all these two are optional properties.
>>
>>  =20
> OK.
>>>> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
>>>> index 38c0690..1ce3f9e 100644
>>>> --- a/drivers/net/can/flexcan.c
>>>> +++ b/drivers/net/can/flexcan.c
>>>> @@ -26,6 +26,7 @@
>>>> #include <linux/can/platform/flexcan.h>
>>>> #include <linux/clk.h>
>>>> #include <linux/delay.h>
>>>> +#include <linux/gpio.h>
>>>>      =20
>>> It seems <linux/of_gpio.h> already unconditionally includes this head=
er.
>>>    =20
>>
>> Documentation/SubmitChecklist
>>
>> 1: If you use a facility then #include the file that defines/declares
>>    that facility.  Don't depend on other header files pulling in ones
>>    that you use.
>>
>>  =20
> Got it.
>=20
> OK to me.

Is this an Acked-by?

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig308454D18A818E2427FA5C42
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/sMtIACgkQjTAFq1RaXHOy1gCfWrEu/7sBUSGGwybYtbiF7ZdJ
/KIAn1QLY8uWIecnMLho2Px6fe0Xf43L
=xGyQ
-----END PGP SIGNATURE-----

--------------enig308454D18A818E2427FA5C42--
