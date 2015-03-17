From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: RFC: (optional) software filtering in candump
Date: Tue, 17 Mar 2015 11:44:58 +0100
Message-ID: <550805AA.4010306@pengutronix.de>
References: <51A66B55.6080506@sebastianhaas.info> <51A6DC6A.7020609@hartkopp.net> <51A70F0E.1010902@sebastianhaas.info> <51A71298.1070202@volkswagen.de> <51A71696.8030609@sebastianhaas.info> <20130530101719.GB427@vandijck-laurijssen.be> <51A740E7.3020400@volkswagen.de> <20130530123526.GC427@vandijck-laurijssen.be> <51A77250.8070907@sebastianhaas.info> <51AA01F0.8020308@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="WvdBrq5OSFQPu0pdGLULSFiGHi4Shm5PJ"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37847 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753407AbbCQKpO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 17 Mar 2015 06:45:14 -0400
In-Reply-To: <51AA01F0.8020308@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Sebastian Haas <dev@sebastianhaas.info>, Kurt Van Dijck <kurt.van.dijck@eia.be>, Sandro Anders | CarMediaLab <sandro.anders@carmedialab.de>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WvdBrq5OSFQPu0pdGLULSFiGHi4Shm5PJ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/01/2013 04:15 PM, Oliver Hartkopp wrote:
> Hi all,
>=20
> On 30.05.2013 17:37, Sebastian Haas wrote:
>> Am 30.05.2013 14:35, schrieb Kurt Van Dijck:
>>> On Thu, May 30, 2013 at 02:07:03PM +0200, Oliver Hartkopp wrote:
>>>> Am 30.05.2013 12:17, schrieb Kurt Van Dijck:
>>>>> On Thu, May 30, 2013 at 11:06:30AM +0200, Sebastian Haas wrote:
>>>>>> Am 30.05.2013 10:49, schrieb Oliver Hartkopp:
>>>>>>>>> On 29.05.2013 22:55, Sebastian Haas wrote:
>>>>>>>>>> If I start candump this way:
>>>>>>>>>> sh@helios:~/workspace/node-can$ candump vcan0,100~7ff,101~7ff
>>>>>>>>>>   I want to receive any messages except 100h and 101h.
>>>>>>>>>>
>>>>>>>>>> When I send a message which matches the filter, it is received=
 twice:
>>>>>>>>>> sh@helios:~/workspace/node-can$ cansend vcan0 1ff#22
>>>>>>>>>>    vcan0  1FF   [1]  22
>>>>>>>>>>    vcan0  1FF   [1]  22
>>>>>>>>>>
>>>>>>>>>> When I send a message which should not received at all, it is =
received:
>>>>>>>>>> sh@helios:~/workspace/node-can$ cansend vcan0 100#22
>>>>>>>>>>    vcan0  100   [1]  22
>>>>>>>>>>
>>>>>>>>>> Did I misunderstood the filter here?
>>>>>>>>>
>>>>>>>>> The filters are independent and therefore "logical OR".
>>>>>>>> Ok. That explain why received 100h even though I tried to filter=
 it
>>>>>>>> out. But
>>>>>>>> why receive a message twice while it was only sent once?
>>>>>>>
>>>>>>> You have defined two(!) filters that let pass the CAN-ID 0x1FF.
>>>>>>>
>>>>>>> So what else would you expect?
>>>>>> This is actually the way it meant to be? Why? Honestly this is a b=
ug
>>>>>> for me! The filter should stop when it matched and not going furth=
er
>>>>>> generating ghost messages which were never sent?
>>>>>
>>>>> I had initially the same feeling. The problem here IMHO is
>>>>> what the user expects is different from what the kernel does.
>>>>>
>>>>> What the user expects is a 'socket' based filter.
>>>>> The kernel implements an optimised, socket-agnostic filter.
>>>>> This is even more generic, but the kernel expects a CAN_RAW program=

>>>>> to set 'rough' filters and have the fine control in the program.
>>>>>
>>>>> This actually works very good, and is a clever thing to do.
>>>>>
>>>>> However, candump does expose this kernel behaviour to the user. The=
 user,
>>>>> as said, expects something different that what he gets.
>>>>> So the user thinks it is a bug.
>>>>>
>>>>> How to solve this: I think the correct way is to let candump
>>>>> expose the filtering that a user expects, whether in userspace
>>>>> or in kernelspace.
>>>>> Is such approach efficient? no. Does that matter? probably not.
>>>>> candump is, IMO, not an automation tool. It's an administrator/diag=
nostic
>>>>> tool.
>>>>>
>>>>> Although I have no real code in mind yet, I think the expected
>>>>> filtering is much easier to implement within a single program,
>>>>> than it would be in kernelspace.
>>>>>
>>>>> On the other hand, I have found candump's exposure of kernel work
>>>>> a true friend during development.
>>>>> So I'd vote to have an extra control on candump which filtering to =
use.
>>>>>
>>>>> Any thoughts?
>=20
> I used the last days to check different concepts and implementation ide=
as how
> to integrate another filter policy into the 'socket-agnostic' filters i=
n
> af_can.c Kurt wrote this nice pleading about :-)
>=20
> It turned out that linked filters would become a mess in implementation=
 and
> configuration (e.g. extensive locking / performance reduction). Additio=
nally
> it would only make sense for a concatenation of inverted filters, like:=

>=20
> 100~7FF,101~7FF,103~7FF
>=20
> Finally i dropped the idea to fiddle with the really efficient filters =
in
> af_can.c that follow the original idea of the CAN controller HW filters=
=2E
>=20
> The main drawback of the independent filters is that the user does not =
expect
> to get the same message several times due to the match of overlapping f=
ilters.
>=20
> Below you will find an approach that does not push this problem into
> userspace but only omits identical frames that had multiple matches.
>=20
> The idea is to introduce a new socket option CAN_RAW_FILTER_UNIQUE for =
the
> RAW socket, that catches and omits duplicate frames when it's enabled.
> This is a per-socket option and is active for all configured filters ap=
plied
> to this socket.
>=20
> It's a relatively small and clear change and it fixes your "bug".
>=20
> Here's the output of candump with and without the 'unique' option when
> invoking "cansend vcan0 1FF#" in another terminal:
>=20
> $ ./candump vcan0,100~7FF,101~7FF
>   vcan0  1FF   [0]=20
>   vcan0  1FF   [0]=20
>=20
> $ ./candump vcan0,100~7FF,101~7FF,U
>   vcan0  1FF   [0]=20
>=20
> I hope this fit your needs ?! :-)

Sorry for resurrecting this old thread, but a $CUSTOMER stumbled over
the same "issue". So there seems to be realworld need for a solution :)

Are there any new thoughts on the problem?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--WvdBrq5OSFQPu0pdGLULSFiGHi4Shm5PJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJVCAWwAAoJECte4hHFiupUpkQP+gN4oj7+vCtrbwfTe/tptL08
oe9VtRv1nf0+dPZ3KoxadMraqK5xBUBNZ1ABohtB453Gg1SPnTdbxZEOXG7KSy5N
kBC8KhfOgOvSZ3mToFtWLdVzgk33nJ4LdtKZFrGlKHKxx0rBhxmh5evqG1OSMCTd
jqe4KT0MtF6w61VBmgiYVC3RaXeKc50zNEzMfZUgx8GCPvGKkzVw6EgriMO1mlmE
Goe3NIPzACtgtn+SH8C9J3Bnf6BOyc5hmBDrb9vnsR9Aup9Mjks2fsaObjCzKyV3
Z9zYRDRdVACuRw68yVk+j9JFxB0SscuYj6683MLzmrVGOspcZt+SzeCVhEa/pD7X
y+c1l4ajQUlExctQG9O6Xyz7eR3k0CAYnSBdo8ccw1+81ebuoMDSR7sTWct+CwmB
8MKAGhh8O13YYdwoKCszvJZCnXHxwA9SfcYKoID18hVI7N87xwLS44awUAG60Bi3
+LvgZA3HnUKNup10sFlQ13C+t4fqRMBjsdSshD0wWMR0jQuIHKRMFkkxhhghblKQ
ovJnu3r/oeGOp4fgkzbGdo1yA/wWfjof/YjTYRXsI1wqwhjOtIWgGBH7+0XuC5Zz
W7z9Z+SJ1/eqhdholvemU5j2sEhoz/Pw9HHe230JioOsDVdqmpWyjmq+5h/rsUjw
tlySS4wXtU1ITaazXT6J
=Ocaw
-----END PGP SIGNATURE-----

--WvdBrq5OSFQPu0pdGLULSFiGHi4Shm5PJ--
