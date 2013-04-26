From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Usb to can driver
Date: Fri, 26 Apr 2013 10:26:42 +0200
Message-ID: <517A3A42.9000406@pengutronix.de>
References: <1366737302.3325.36.camel@blackbox>   <51770161.2030005@pengutronix.de> <1366818490.5965.35.camel@blackbox>  <51780336.5060800@pengutronix.de> <51781907.3030306@hartkopp.net>  <51784D96.8000309@pengutronix.de> <1366932904.3307.23.camel@blackbox>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2VUWUEBIUWUOFUANUKRVS"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46707 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757744Ab3DZI0u (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 26 Apr 2013 04:26:50 -0400
In-Reply-To: <1366932904.3307.23.camel@blackbox>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Max S." <max@schneidersoft.net>
Cc: linux-can <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2VUWUEBIUWUOFUANUKRVS
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 04/26/2013 01:35 AM, Max S. wrote:
> On Wed, 2013-04-24 at 23:24 +0200, Marc Kleine-Budde wrote:
>> On 04/24/2013 07:40 PM, Oliver Hartkopp wrote:
>>>>> assumptions that are made:
>>>>> * The sizes of the struct can_frame members are id:u32 dlc:u8 data:=
u64 .
>>>>> * It is also assumed that existing defines like CAN_EFF_FLAG in can=
=2Eh
>>>>> and can/error.h don't change, as they are used by the device to
>>>>> construct the can_id field.
>>>>
>>>> You cannot rely in your firmware, that the struct can_frame and
>>>> CAN_*_FLAG doesn't change. Please define your own struct.
>>>>
>>>
>>>
>>> Hm - i really appreciate the memcopy-only approach which can cope wit=
h the
>>> host byte order directly. This is a real improvement on the host side=
=2E
>>>
>>> The struct can_frame and the error message content is official Kernel=
 API and
>>> therefore can be assumed to be fix.
>>
>> Yes but no. The struct can_frame to the _userspace_ is official Kernel=

>> API/ABI, but within the kernel the is no stable API (see
>> stable_api_nonsense.txt). But if we go this way we should make compile=

>> time checks, so that the compilation breaks if the struct can_frame ch=
anges.
>=20
> ok. tell me if i understood correctly.
> A user-space program can safely assume:
> sizeof((struct can_frame *)NULL)->can_id) =3D=3D 4
> and:
> CAN_EFF_FLAG =3D=3D 0x80000000U=20
>=20
> but a kernel-space driver can not?

Yes, in the Kernel we don't have a stable ABI and the API can change,
too. However, if someone changes the API he's not allowed to introduce
any breakage, but that's not so easy if she/he has to recompile your
firmware.

> If I cannot make sufficient assumptions about the struct can_frame and
> CAN_*_FLAGs It will make the code harder to maintain in the long run.

=46rom my point of view it's just the other way round. It's all about
layers/interfaces here. You define how your hardware is accessed, once
the Linux driver and the CAN firmware is stable that interface is carved
in stone. As long as the interface doesn't change everyone can make
changes inside their layers without breaking the whole system (modulo
bugs). If the interface turns out to be outdated, you can create a new on=
e.

Having thought so far, it's a good idea to add a interface version and a
feature bitfield (u32) register. These two registers should be at a
fixed address. In USB terms this probably translates into some initial
USB message with two variables at a fixed offset in that message ;)

> the speed gains derived from a direct memcpy/assignment will later be
> eaten up by the code designed to convert the old struct can_frame
> received from the device to the new struct can_frame found in the
> kernel.

Your device is attached via USB, so I doubt there is any measurable
difference between a memcpy the whole struct can_frame and a member by
member copy.

> The question is in the end, where should i draw the line.
>=20
> One option would be to define a new struct ss_frame to standardize
> communication between device & host, but still use the device_config to=

> allow the changing of byte order.

Sounds like a good idea.

> The driver would then need to do three assignments to rearrange padding=
,
> and adjust any difference in the id flags:
>=20
> * arrange for correct byte order beforehand...

If you tell the USB device your byte order with device_config there's no
need to change the byte order in each frame, am I right?

> can_frame->can_id  =3D CONVERT_ME_FLAGS(ss_frame->can_id);

Assuming you encode the extended frame identifier in can_id, too. But's
that is no problem.

> can_frame->can_dlc =3D ss_frame->can_dlc;
> can_frame->data    =3D ss_frame->data;
>=20
> In this case the 'line' would be explicitly between the struct ss_frame=

> and the struct can_frame not floating somewhere vague between the kerne=
l
> and firmware...

Yes.

> Naturally you will no longer be able to simply:
> *can_frame =3D frame_wrapper->can_frame;
> As i am doing now.

Yes

> What do you think?

We're getting there!

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2VUWUEBIUWUOFUANUKRVS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlF6OkUACgkQjTAFq1RaXHOhygCdF7SkyXihKtAbuRQIIA34wPDJ
hpgAnj/12gz/5EYSHkxrk/KORqwWGwDc
=QmCp
-----END PGP SIGNATURE-----

------enig2VUWUEBIUWUOFUANUKRVS--
