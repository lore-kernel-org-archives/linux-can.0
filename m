From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: WARNING in can_rcv
Date: Wed, 17 Jan 2018 10:43:02 +0100
Message-ID: <359313e4-6280-8c97-a424-4f962b11c907@pengutronix.de>
References: <001a11c16b40d795350562e878cc@google.com>
 <a48197ff-9270-8af7-a814-56af53093b3c@pengutronix.de>
 <CACT4Y+b0oUPVr7f973ZgBm9rUog=-mRWDFpcr-EzKaGYRnn8mQ@mail.gmail.com>
 <48c5623e-de78-5cfa-b537-2acf9a44ae51@hartkopp.net>
 <20180117071204.GG15527@zzz.localdomain>
 <dd50dd71-d552-1955-ebab-de1982ec9298@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="L6fMULkn17zkfO4ygePtnbtRw0BiWDNpz"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34381 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752330AbeAQJnh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 17 Jan 2018 04:43:37 -0500
In-Reply-To: <dd50dd71-d552-1955-ebab-de1982ec9298@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Eric Biggers <ebiggers3@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>, syzbot <syzbot+4386709c0c1284dca827@syzkaller.appspotmail.com>, David Miller <davem@davemloft.net>, linux-can@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>, syzkaller-bugs@googlegroups.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--L6fMULkn17zkfO4ygePtnbtRw0BiWDNpz
Content-Type: multipart/mixed; boundary="O4iHdkUPOAUVo1RBB9TIUnOWPYMLDzXx2";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>,
 Eric Biggers <ebiggers3@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>,
 syzbot <syzbot+4386709c0c1284dca827@syzkaller.appspotmail.com>,
 David Miller <davem@davemloft.net>, linux-can@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
 syzkaller-bugs@googlegroups.com
Message-ID: <359313e4-6280-8c97-a424-4f962b11c907@pengutronix.de>
Subject: Re: WARNING in can_rcv
References: <001a11c16b40d795350562e878cc@google.com>
 <a48197ff-9270-8af7-a814-56af53093b3c@pengutronix.de>
 <CACT4Y+b0oUPVr7f973ZgBm9rUog=-mRWDFpcr-EzKaGYRnn8mQ@mail.gmail.com>
 <48c5623e-de78-5cfa-b537-2acf9a44ae51@hartkopp.net>
 <20180117071204.GG15527@zzz.localdomain>
 <dd50dd71-d552-1955-ebab-de1982ec9298@hartkopp.net>
In-Reply-To: <dd50dd71-d552-1955-ebab-de1982ec9298@hartkopp.net>

--O4iHdkUPOAUVo1RBB9TIUnOWPYMLDzXx2
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 01/17/2018 09:07 AM, Oliver Hartkopp wrote:
>=20
>=20
> On 01/17/2018 08:12 AM, Eric Biggers wrote:
>> On Wed, Jan 17, 2018 at 07:39:24AM +0100, Oliver Hartkopp wrote:
>>>
>>>
>>> On 01/16/2018 07:11 PM, Dmitry Vyukov wrote:
>>>> On Tue, Jan 16, 2018 at 7:07 PM, Marc Kleine-Budde <mkl@pengutronix.=
de> wrote:
>>>>> On 01/16/2018 06:58 PM, syzbot wrote:
>>>>>> Hello,
>>>>>>
>>>>>> syzkaller hit the following crash on
>>>>>> a8750ddca918032d6349adbf9a4b6555e7db20da
>>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/m=
aster
>>>>>> compiler: gcc (GCC) 7.1.1 20170620
>>>>>> .config is attached
>>>>>> Raw console output is attached.
>>>>>> C reproducer is attached
>>>>>> syzkaller reproducer is attached. See https://goo.gl/kgGztJ
>>>>>> for information about syzkaller reproducers
>>>>>>
>>>>>>
>>>>>> IMPORTANT: if you fix the bug, please add the following tag to the=
 commit:
>>>>>> Reported-by: syzbot+4386709c0c1284dca827@syzkaller.appspotmail.com=

>>>>>> It will help syzbot understand when the bug is fixed. See footer f=
or
>>>>>> details.
>>>>>> If you forward the report, please keep this part and the footer.
>>>>>>
>>>>>> device eql entered promiscuous mode
>>>>>> ------------[ cut here ]------------
>>>>>> PF_CAN: dropped non conform CAN skbuf: dev type 65534, len 42, dat=
alen 0
>>>>>> WARNING: CPU: 0 PID: 3650 at net/can/af_can.c:729 can_rcv+0x1c5/0x=
200
>>>>>> net/can/af_can.c:724
>>>>>> Kernel panic - not syncing: panic_on_warn set ...
>>>>>
>>>>> Invalid packages generate a warning (WARN_ONCE()), and you have
>>>>> panic_on_warn active. Should we better silently drop these CAN pack=
ages?
>>>>
>>>> Hi,
>>>>
>>>> pr_warn_once() will be more appropriate. It prints a single line.
>>>>
>>>
>>> The idea behind this WARN() is to detect really bad things that might=
 have
>>> happen on network driver level:
>>>
>>> The CAN subsystem registers with dev_add_pack() for ETH_P_CAN and
>>> ETH_P_CANFD only. These ETH_P_ types are only allowed to be created b=
y CAN
>>> network devices (like vcan, vxcan, and real CAN drivers).
>>>
>>> I don't have any strong opinion on using WARN() or pr_warn_once().
>>> Is this detected violation worth using WARN(), as something already m=
ust
>>> have gone really wrong to trigger this issue?
>>>
>>
>> WARN() indicates a kernel bug.  If it's instead "userspace did somethi=
ng
>> stupid", or "someone sent some unexpected network packet", it needs to=
 be
>> pr_warn_once(), pr_warn_ratelimited(), or removed entirely.
>=20
> Ok. Thanks for the explanation!
> It is "some bogus network driver sent something unexpected" - but that =

> does not harm the entire system.
>=20
> pr_warn_once() seems the right way to go then.

Is this an Acked-by for both patches?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--O4iHdkUPOAUVo1RBB9TIUnOWPYMLDzXx2--

--L6fMULkn17zkfO4ygePtnbtRw0BiWDNpz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlpfGqYACgkQHv7KIOw4
HPYUwgf9GWOV9b5/xsoxpCFAypA3DsqHZJWJdCsPf/wvIYA92RgvbtMPt8Jy5qAl
8TDvEUqOTNR7I0HJBNMkmFXHvZWVdaiaNaSHkZGZHqR0+0hXNsLtIhfbHndxAojw
X4GPDrMAQxR0sXcckX/4S1Fk03wPOukjrJP/v58iS8wlCgmmIFyTUlorGepLiqKq
N2yxRW/YErF5H7IJvN0swble5EyecjrYsVxfJLzT3xl7mkzJ79TslXV9XMMlqwhW
Gp05AvWLNYRO9C4XlN9wMLeGf44WYhmD7qZ3095G1RDwELgOJx3IJDo9c5jU1c68
jlqBlUVALUfrydkkW8KdU5BgcYph+g==
=VVPk
-----END PGP SIGNATURE-----

--L6fMULkn17zkfO4ygePtnbtRw0BiWDNpz--
