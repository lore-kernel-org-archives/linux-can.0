From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v12 1/5] can: m_can: Create a m_can platform framework
Date: Thu, 25 Jul 2019 09:09:49 +0200
Message-ID: <98b95fbe-adcc-c95f-7f3d-6c57122f4586@pengutronix.de>
References: <20190509161109.10499-1-dmurphy@ti.com>
 <dbb7bdef-820d-5dcc-d7b5-a82bc1b076fb@ti.com>
 <a8e3f2d3-18c3-3bdb-1318-8964afc7e032@ti.com>
 <93530d94-ec65-de82-448e-f2460dd39fb9@ti.com>
 <0f6c41c8-0071-ed3a-9e65-caf02a0fbefe@ti.com>
 <6fa79302-ad32-7f43-f9d5-af70aa789284@ti.com>
 <f236a88a-485c-9002-1e4a-9a5ad0e1c81f@ti.com>
 <437b6371-8488-a0ff-fa68-d1fb5a81bb8b@ti.com>
 <20190724064754.GC22447@kroah.com>
 <443fe5e5-5e5c-f669-1f4b-565d9f3dd6c8@ti.com>
 <20190725062834.GC5647@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="SyeBRhgR6Wi7a7a7T18A7SOMgbULzN3PG"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190725062834.GC5647@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>, Dan Murphy <dmurphy@ti.com>
Cc: wg@grandegger.com, davem@davemloft.net, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SyeBRhgR6Wi7a7a7T18A7SOMgbULzN3PG
Content-Type: multipart/mixed; boundary="QN5jWKS6cqhMz0iPtcqSdVweoxpAUyMl7";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Greg KH <gregkh@linuxfoundation.org>, Dan Murphy <dmurphy@ti.com>
Cc: wg@grandegger.com, davem@davemloft.net, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <98b95fbe-adcc-c95f-7f3d-6c57122f4586@pengutronix.de>
Subject: Re: [PATCH v12 1/5] can: m_can: Create a m_can platform framework
References: <20190509161109.10499-1-dmurphy@ti.com>
 <dbb7bdef-820d-5dcc-d7b5-a82bc1b076fb@ti.com>
 <a8e3f2d3-18c3-3bdb-1318-8964afc7e032@ti.com>
 <93530d94-ec65-de82-448e-f2460dd39fb9@ti.com>
 <0f6c41c8-0071-ed3a-9e65-caf02a0fbefe@ti.com>
 <6fa79302-ad32-7f43-f9d5-af70aa789284@ti.com>
 <f236a88a-485c-9002-1e4a-9a5ad0e1c81f@ti.com>
 <437b6371-8488-a0ff-fa68-d1fb5a81bb8b@ti.com>
 <20190724064754.GC22447@kroah.com>
 <443fe5e5-5e5c-f669-1f4b-565d9f3dd6c8@ti.com>
 <20190725062834.GC5647@kroah.com>
In-Reply-To: <20190725062834.GC5647@kroah.com>

--QN5jWKS6cqhMz0iPtcqSdVweoxpAUyMl7
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 7/25/19 8:28 AM, Greg KH wrote:
> On Wed, Jul 24, 2019 at 10:36:02AM -0500, Dan Murphy wrote:
>> Hello
>>
>> On 7/24/19 1:47 AM, Greg KH wrote:
>>> On Tue, Jul 23, 2019 at 10:14:14AM -0500, Dan Murphy wrote:
>>>> Hello
>>>>
>>>> On 7/10/19 7:08 AM, Dan Murphy wrote:
>>>>> Hello
>>>>>
>>>>> On 6/17/19 10:09 AM, Dan Murphy wrote:
>>>>>> Marc
>>>>>>
>>>>>> On 6/10/19 11:35 AM, Dan Murphy wrote:
>>>>>>> Bump
>>>>>>>
>>>>>>> On 6/6/19 8:16 AM, Dan Murphy wrote:
>>>>>>>> Marc
>>>>>>>>
>>>>>>>> Bump
>>>>>>>>
>>>>>>>> On 5/31/19 6:51 AM, Dan Murphy wrote:
>>>>>>>>> Marc
>>>>>>>>>
>>>>>>>>> On 5/15/19 3:54 PM, Dan Murphy wrote:
>>>>>>>>>> Marc
>>>>>>>>>>
>>>>>>>>>> On 5/9/19 11:11 AM, Dan Murphy wrote:
>>>>>>>>>>> Create a m_can platform framework that peripheral
>>>>>>>>>>> devices can register to and use common code and register sets=
=2E
>>>>>>>>>>> The peripheral devices may provide read/write and configurati=
on
>>>>>>>>>>> support of the IP.
>>>>>>>>>>>
>>>>>>>>>>> Acked-by: Wolfgang Grandegger <wg@grandegger.com>
>>>>>>>>>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>>>>>>>>>>> ---
>>>>>>>>>>>
>>>>>>>>>>> v12 - Update the m_can_read/write functions to
>>>>>>>>>>> create a backtrace if the callback
>>>>>>>>>>> pointer is NULL. - https://lore.kernel.org/patchwork/patch/10=
52302/
>>>>>>>>>>>
>>>>>>>>>> Is this able to be merged now?
>>>>>>>>> ping
>>>>>> Wondering if there is anything else we need to do?
>>>>>>
>>>>>> The part has officially shipped and we had hoped to have driver
>>>>>> support in Linux as part of the announcement.
>>>>>>
>>>>> Is this being sent in a PR for 5.3?
>>>>>
>>>>> Dan
>>>>>
>>>> Adding Greg to this thread as I have no idea what is going on with t=
his.
>>> Why me?  What am I supposed to do here?  I see no patches at all to d=
o
>>> anything with :(
>>
>> I am not sure who to email. The maintainer seems to be on hiatus or su=
per
>> busy with other work.
>=20
> Who is the maintainer?

That's me.

>> So I added you to see if you know how to handle this.=C2=A0 Wolfgang A=
cked it but
>> he said Marc needs to pull
>=20
> Then work with them, again, what can I do if I can't even see the
> patches here?

The patches are included in a pull request to David Miller
(net-next/master, the CAN upstream), which has already have been merged.

>> it in.=C2=A0 We have quite a few users of this patchset. I have been h=
osting the
>> patchset in a different tree.
>>
>> These users keep pinging us for upstream status and all we can do is p=
oint
>> them to the
>>
>> LKML to show we are continuing to pursue inclusion.
>>
>> https://lore.kernel.org/patchwork/project/lkml/list/?series=3D393454
>=20
> Looks sane, work with the proper developers, good luck!

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--QN5jWKS6cqhMz0iPtcqSdVweoxpAUyMl7--

--SyeBRhgR6Wi7a7a7T18A7SOMgbULzN3PG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl05Vb0ACgkQWsYho5Hk
nSDmHQgAqjfWPPj6SIVuU5r1vwRl+igXIiKKf5wbNNThPsVrtWr/rUGl/RIDYCNr
UsAjTR2XxEte/MegGEJHF+ds+N5ObG8sQbLED6VqlKCcnip40VamkBVnRQD7xfsi
4mseg99aTg3ITp0VQoD241wbuh3mA/wrHYzBdHFF5lH2rRU4P6G+CxsgW/uyCU2T
SmrTsvka70aovp+8ixOOxWlUfZQ5rF/oBboCZ2DUTwJGIRtcdy1BP2WyP+lATRJ3
h8NP29gzo/V0ri1nDxX81N0qva+yMryRIkONE+mL956SCKhleXVtB+Qs4YFcbRfS
sDV5Jj+RP7+58G/SmcwupdZTdd0EQA==
=RQ+I
-----END PGP SIGNATURE-----

--SyeBRhgR6Wi7a7a7T18A7SOMgbULzN3PG--
