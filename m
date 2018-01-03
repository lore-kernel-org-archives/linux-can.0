From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v6 3/6] can: m_can: Add PM Runtime
Date: Wed, 3 Jan 2018 16:17:09 +0100
Message-ID: <cb306ae5-87c5-f6ef-0c40-3b47e208d256@pengutronix.de>
References: <1513949488-13026-1-git-send-email-faiz_abbas@ti.com>
 <1513949488-13026-4-git-send-email-faiz_abbas@ti.com>
 <aea8638a-c847-b55e-ff2d-37999980ba7b@pengutronix.de>
 <1308ee81-a1e9-ac5a-2d97-334fa825ef8d@ti.com>
 <7d857263-14a7-6001-8f13-42d80f757573@pengutronix.de>
 <a45431f2-d262-39a1-9152-a2ff75560d21@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="9FJOum8Jyl85Fy0rMiJUXXBzYfzgVsd71"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:54103 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751909AbeACPRb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 3 Jan 2018 10:17:31 -0500
In-Reply-To: <a45431f2-d262-39a1-9152-a2ff75560d21@ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Faiz Abbas <faiz_abbas@ti.com>, wg@grandegger.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, fcooper@ti.com, robh@kernel.org, Wenyou.Yang@microchip.com, sergei.shtylyov@cogentembedded.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9FJOum8Jyl85Fy0rMiJUXXBzYfzgVsd71
Content-Type: multipart/mixed; boundary="3iAJdZFUjdHIwpI3NZezNil3cOLlN3ZIZ";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Faiz Abbas <faiz_abbas@ti.com>, wg@grandegger.com, robh+dt@kernel.org,
 mark.rutland@arm.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com,
 fcooper@ti.com, robh@kernel.org, Wenyou.Yang@microchip.com,
 sergei.shtylyov@cogentembedded.com
Message-ID: <cb306ae5-87c5-f6ef-0c40-3b47e208d256@pengutronix.de>
Subject: Re: [PATCH v6 3/6] can: m_can: Add PM Runtime
References: <1513949488-13026-1-git-send-email-faiz_abbas@ti.com>
 <1513949488-13026-4-git-send-email-faiz_abbas@ti.com>
 <aea8638a-c847-b55e-ff2d-37999980ba7b@pengutronix.de>
 <1308ee81-a1e9-ac5a-2d97-334fa825ef8d@ti.com>
 <7d857263-14a7-6001-8f13-42d80f757573@pengutronix.de>
 <a45431f2-d262-39a1-9152-a2ff75560d21@ti.com>
In-Reply-To: <a45431f2-d262-39a1-9152-a2ff75560d21@ti.com>

--3iAJdZFUjdHIwpI3NZezNil3cOLlN3ZIZ
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 01/03/2018 04:06 PM, Faiz Abbas wrote:
> Hi,
>=20
> On Wednesday 03 January 2018 07:55 PM, Marc Kleine-Budde wrote:
>> On 01/03/2018 01:39 PM, Faiz Abbas wrote:
>>> On Tuesday 02 January 2018 09:37 PM, Marc Kleine-Budde wrote:
>>>> On 12/22/2017 02:31 PM, Faiz Abbas wrote:
>>>>> From: Franklin S Cooper Jr <fcooper@ti.com>
>>>>>
>>>>> Add support for PM Runtime which is the new way to handle managing =
clocks.
>>>>> However, to avoid breaking SoCs not using PM_RUNTIME leave the old =
clk
>>>>> management approach in place.
>>>>
>>>> There is no PM_RUNTIME anymore since 464ed18ebdb6 ("PM: Eliminate
>>>> CONFIG_PM_RUNTIME")
>>>
>>> Ok. Will change the commit message.
>>>
>>>>
>>>> Have a look at the discussion: https://patchwork.kernel.org/patch/94=
36507/ :
>>>>
>>>>>> Well, I admit it would be nicer if drivers didn't have to worry ab=
out=20
>>>>>> whether or not CONFIG_PM was enabled.  A slightly cleaner approach=
=20
>>>>>> from the one outlined above would have the probe routine do this:
>>>>>>
>>>>>> 	my_power_up(dev);
>>>>>> 	pm_runtime_set_active(dev);
>>>>>> 	pm_runtime_get_noresume(dev);
>>>>>> 	pm_runtime_enable(dev);
>>>
>>> This discussion seems to be about cases in which CONFIG_PM is not
>>> enabled. CONFIG_PM is always selected in the case of omap devices.
>>
>> Yes, but in the commit message you state that you need to support
>> systems that don't have PM_RUNTIME enabled. The only mainline SoCs I s=
ee
>> is "arch/arm/boot/dts/sama5d2.dtsi" so far. Please check if they selec=
t
>> CONFIG_PM, then we can make the driver much simpler.
>=20
> Actually the old clock management (for hclk which is the interface
> clock) is still required as mentioned in the cover letter. Will change
> the rather misleading description.

Ok. So you can use the code as discussed on
https://patchwork.kernel.org/patch/9436507/ ?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--3iAJdZFUjdHIwpI3NZezNil3cOLlN3ZIZ--

--9FJOum8Jyl85Fy0rMiJUXXBzYfzgVsd71
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlpM8/YACgkQHv7KIOw4
HPZJvQf9F3NXfALMRuFE6FnQB0uB0VvZvdDR8UgGG8gwKN0BZuaEp1lwp+KrLEUB
xdfzMoVzc2QrGtGm1DvdbvDtmOeW4PyN3eSMowBhNUqmfd3RchX9gPSFmEIk6Qxm
RqakGfwsnyRYcO4IkFvohPq51OVVPzKYIIKxjQ+zqJ7/0mP9U6fjIPX3DYMYR4cY
a3vB7YEx7Vr+FUqDWJ5IATAaUe5/y0rK6ea9rslSROZpq5fPT4kwQh+3COfVo55m
/xtweZfEzBOtjXQZzLCkycT1l3XDO3pYMr6fdO+XO1UeByhBsW5QuT2HhURpNn8+
MabHGGAq/i5rNOAp1/ki3g3h6v/PrQ==
=UCiv
-----END PGP SIGNATURE-----

--9FJOum8Jyl85Fy0rMiJUXXBzYfzgVsd71--
