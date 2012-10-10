From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [GIT PULL] Disintegrate UAPI for can
Date: Wed, 10 Oct 2012 22:23:48 +0200
Message-ID: <5075D954.8090608@pengutronix.de>
References: <30687.1349789402@warthog.procyon.org.uk> <27643.1349892024@warthog.procyon.org.uk> <5075D2AF.1010409@pengutronix.de> <20121010.160816.1174547411763490557.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigAE09FED92A1A280793F018CA"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121010.160816.1174547411763490557.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: dhowells@redhat.com, socketcan@hartkopp.net, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAE09FED92A1A280793F018CA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 10/10/2012 10:08 PM, David Miller wrote:
> From: Marc Kleine-Budde <mkl@pengutronix.de>
> Date: Wed, 10 Oct 2012 21:55:27 +0200
>=20
>> On 10/10/2012 08:00 PM, David Howells wrote:
>>> Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>>>
>>>> On 10/09/2012 03:30 PM, David Howells wrote:
>>>>> Can you merge the following branch into the can tree please.
>>>>>
>>>>> This is to complete part of the Userspace API (UAPI) disintegration=
 for which
>>>>> the preparatory patches were pulled recently.  After these patches,=
 userspace
>>>>> headers will be segregated into:
>>>>>
>>>>> 	include/uapi/linux/.../foo.h
>>>>>
>>>>> for the userspace interface stuff, and:
>>>>>
>>>>> 	include/linux/.../foo.h
>>>>>
>>>>> for the strictly kernel internal stuff.
>>>>
>>>> Nice work David. The upstream for can-next is David Miller's net-nex=
t
>>>> tree. He doesn't like if I pull unrelated stuff into my tree, so I'm=

>>>> going to cherry pick your patch. This is not yet possible, as net-ne=
xt
>>>> doesn't include the latest patches from the 3.7 merge window, so tha=
t
>>>> compilation breaks. After the merge window closes David Miller merge=
s
>>>> back the latest changes to net-next. I'll postpone your patch until
>>>> then, this means the code will go into v3.8. I'm not familiar with t=
he
>>>> UAPI conversion, should your patch go via linux-can and David's net =
into
>>>> v3.7?
>>>
>>> It's okay for the patch to go into 3.8 if that is easier for you.  As=
 it's
>>> scripted, I can regenerate your branch after -rc1 if that helps too.
>>
>> I don't mind, as long as it compiles (using you tag), and it does, the=

>> patch doesn't break anything. From the linux-can and David Miller's ne=
t
>> point of view, v3.7 is closed for new features just bug fixes are
>> allowed. But I'm open to make an exception, if UAPI hits mainline in
>> v3.7 on most subsystems. Hopefully David sees it the same way.
>=20
> We're putting the UAPI stuff in now, don't delay this please.

That's a clear statement :)

Thanks David,
Marc


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigAE09FED92A1A280793F018CA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlB12VgACgkQjTAFq1RaXHPUMgCbB4CHHqp3xbrKuuNF8QMpaAd7
TXoAmwQya6CTfXFnuLLY8zgRuRHSlqy5
=eIrX
-----END PGP SIGNATURE-----

--------------enigAE09FED92A1A280793F018CA--
