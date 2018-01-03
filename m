From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v6 3/6] can: m_can: Add PM Runtime
Date: Wed, 3 Jan 2018 15:25:22 +0100
Message-ID: <7d857263-14a7-6001-8f13-42d80f757573@pengutronix.de>
References: <1513949488-13026-1-git-send-email-faiz_abbas@ti.com>
 <1513949488-13026-4-git-send-email-faiz_abbas@ti.com>
 <aea8638a-c847-b55e-ff2d-37999980ba7b@pengutronix.de>
 <1308ee81-a1e9-ac5a-2d97-334fa825ef8d@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="hnUQgPkJEXz2nyEvKbaqPC9LPhltPw8YU"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1308ee81-a1e9-ac5a-2d97-334fa825ef8d-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Faiz Abbas <faiz_abbas-l0cyMroinI0@public.gmane.org>, wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
Cc: linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, fcooper-l0cyMroinI0@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Wenyou.Yang-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hnUQgPkJEXz2nyEvKbaqPC9LPhltPw8YU
Content-Type: multipart/mixed; boundary="Bd19tBSfir1eqrgkM8s2a5OB0VGKOlB91";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Faiz Abbas <faiz_abbas-l0cyMroinI0@public.gmane.org>, wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
 mark.rutland-5wv7dgnIgG8@public.gmane.org
Cc: linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org,
 fcooper-l0cyMroinI0@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Wenyou.Yang-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org,
 sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org
Message-ID: <7d857263-14a7-6001-8f13-42d80f757573-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v6 3/6] can: m_can: Add PM Runtime
References: <1513949488-13026-1-git-send-email-faiz_abbas-l0cyMroinI0@public.gmane.org>
 <1513949488-13026-4-git-send-email-faiz_abbas-l0cyMroinI0@public.gmane.org>
 <aea8638a-c847-b55e-ff2d-37999980ba7b-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
 <1308ee81-a1e9-ac5a-2d97-334fa825ef8d-l0cyMroinI0@public.gmane.org>
In-Reply-To: <1308ee81-a1e9-ac5a-2d97-334fa825ef8d-l0cyMroinI0@public.gmane.org>

--Bd19tBSfir1eqrgkM8s2a5OB0VGKOlB91
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 01/03/2018 01:39 PM, Faiz Abbas wrote:
> On Tuesday 02 January 2018 09:37 PM, Marc Kleine-Budde wrote:
>> On 12/22/2017 02:31 PM, Faiz Abbas wrote:
>>> From: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
>>>
>>> Add support for PM Runtime which is the new way to handle managing cl=
ocks.
>>> However, to avoid breaking SoCs not using PM_RUNTIME leave the old cl=
k
>>> management approach in place.
>>
>> There is no PM_RUNTIME anymore since 464ed18ebdb6 ("PM: Eliminate
>> CONFIG_PM_RUNTIME")
>=20
> Ok. Will change the commit message.
>=20
>>
>> Have a look at the discussion: https://patchwork.kernel.org/patch/9436=
507/ :
>>
>>>> Well, I admit it would be nicer if drivers didn't have to worry abou=
t=20
>>>> whether or not CONFIG_PM was enabled.  A slightly cleaner approach=20
>>>> from the one outlined above would have the probe routine do this:
>>>>
>>>> 	my_power_up(dev);
>>>> 	pm_runtime_set_active(dev);
>>>> 	pm_runtime_get_noresume(dev);
>>>> 	pm_runtime_enable(dev);
>=20
> This discussion seems to be about cases in which CONFIG_PM is not
> enabled. CONFIG_PM is always selected in the case of omap devices.

Yes, but in the commit message you state that you need to support
systems that don't have PM_RUNTIME enabled. The only mainline SoCs I see
is "arch/arm/boot/dts/sama5d2.dtsi" so far. Please check if they select
CONFIG_PM, then we can make the driver much simpler.

>>> PM_RUNTIME is required by OMAP based devices to handle clock manageme=
nt.
>>> Therefore, this allows future Texas Instruments SoCs that have the MC=
AN IP
>>> to work with this driver.
>>
>> Who will set the SET_RUNTIME_PM_OPS in this case?
>=20
> It is set with a common SET_RUNTIME_PM_OPS in the case of omap at
> arch/arm/mach-omap2/omap_device.c:632
>=20
> struct dev_pm_domain omap_device_pm_domain =3D {
>         .ops =3D {
>                 SET_RUNTIME_PM_OPS(_od_runtime_suspend, _od_runtime_res=
ume,
>                                    NULL)
>                 USE_PLATFORM_PM_SLEEP_OPS
>                 SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(_od_suspend_noirq,
>                                               _od_resume_noirq)
>         }
> };
>=20
>=20
>>
>>> Signed-off-by: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
>>> [nsekhar-l0cyMroinI0@public.gmane.org: handle pm_runtime_get_sync() failure, fix some bugs]=

>>> Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
>>> Signed-off-by: Faiz Abbas <faiz_abbas-l0cyMroinI0@public.gmane.org>
>>> ---
>>>  drivers/net/can/m_can/m_can.c | 38 +++++++++++++++++++++++++++++++++=
+----
>>>  1 file changed, 34 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_=
can.c
>>> index f72116e..53e764f 100644
>>> --- a/drivers/net/can/m_can/m_can.c
>>> +++ b/drivers/net/can/m_can/m_can.c
>>> @@ -23,6 +23,7 @@
>>>  #include <linux/of.h>
>>>  #include <linux/of_device.h>
>>>  #include <linux/platform_device.h>
>>> +#include <linux/pm_runtime.h>
>>>  #include <linux/iopoll.h>
>>>  #include <linux/can/dev.h>
>>> =20
>>> @@ -625,19 +626,33 @@ static int m_can_clk_start(struct m_can_priv *p=
riv)
>>>  {
>>>  	int err;
>>> =20
>>> +	err =3D pm_runtime_get_sync(priv->device);
>>> +	if (err) {
>>> +		pm_runtime_put_noidle(priv->device);
>>
>> Why do you call this in case of an error?
>=20
> pm_runtime_get_sync() increments the usage count of the device before
> any error is returned. This needs to be decremented using
> pm_runtime_put_noidle().

Oh, I'm curious how many drivers don't get this right.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Bd19tBSfir1eqrgkM8s2a5OB0VGKOlB91--

--hnUQgPkJEXz2nyEvKbaqPC9LPhltPw8YU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlpM59IACgkQHv7KIOw4
HPbwvgf/eZyyyMqAjP+l2WR9sxzjBSvBW6TA1bAOvgP3QYPIKackidBRqOswW06P
rDe6wM44a4QEmQZ9YJQYWHnvDSEmcQSNlT5Gh8lzMmbo/WxU05FruTUP8hOLQL9s
wcgZ+V35u9bX8P3GzyW9wZeaRVsr8123SkqRPwTv7YeznwLSZi4wWmGqFVIs0tXG
r/vTJEZpi+wHYPQ8tFJ3oLYhl2yuFJBXtM+/TA+V5p9SjS3SxKLkOuMJ2UjHMfOK
8MJYL2GKgPOY9MBvxCyOfO+1zgTBtjb/H7ctR1K4l19uhiM/5+6ICLIzKIC2oFmG
b75RD8flQLvqKCRFZWvt5dZcwjOSdg==
=JGF9
-----END PGP SIGNATURE-----

--hnUQgPkJEXz2nyEvKbaqPC9LPhltPw8YU--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
