From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 02/12] can: rx-offload: Add support for timestamp based
 irq offloading
Date: Tue, 5 Jul 2016 14:40:23 +0200
Message-ID: <d86b55f5-56eb-1d16-b630-27afc0fda005@pengutronix.de>
References: <1467657137-18891-1-git-send-email-mkl@pengutronix.de>
 <1467657137-18891-3-git-send-email-mkl@pengutronix.de>
 <146765818281.26740.6668128129784946822@maxwell>
 <1d462f0c-3dc2-ba44-b3bf-53469062ff22@pengutronix.de>
 <4456cc74-7d85-c05e-fc86-af916ce0edb0@pengutronix.de>
 <20160705115851.GA13601@maxwell>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="xUREF7VumKCGVoCCXsnL05k8SWBhFna1v"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:40208 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754519AbcGEMkf (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 5 Jul 2016 08:40:35 -0400
In-Reply-To: <20160705115851.GA13601@maxwell>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <andri.yngvason@marel.com>
Cc: linux-can@vger.kernel.org, david@protonic.nl

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xUREF7VumKCGVoCCXsnL05k8SWBhFna1v
Content-Type: multipart/mixed; boundary="5vNo8XPWKUxqBwUvQN9JI6pC3W1cDUx19"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Andri Yngvason <andri.yngvason@marel.com>
Cc: linux-can@vger.kernel.org, david@protonic.nl
Message-ID: <d86b55f5-56eb-1d16-b630-27afc0fda005@pengutronix.de>
Subject: Re: [PATCH v2 02/12] can: rx-offload: Add support for timestamp based
 irq offloading
References: <1467657137-18891-1-git-send-email-mkl@pengutronix.de>
 <1467657137-18891-3-git-send-email-mkl@pengutronix.de>
 <146765818281.26740.6668128129784946822@maxwell>
 <1d462f0c-3dc2-ba44-b3bf-53469062ff22@pengutronix.de>
 <4456cc74-7d85-c05e-fc86-af916ce0edb0@pengutronix.de>
 <20160705115851.GA13601@maxwell>
In-Reply-To: <20160705115851.GA13601@maxwell>

--5vNo8XPWKUxqBwUvQN9JI6pC3W1cDUx19
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/05/2016 01:58 PM, Andri Yngvason wrote:
> On Tue, Jul 05, 2016 at 12:30:32AM +0200, Marc Kleine-Budde wrote:
>> On 07/04/2016 10:59 PM, Marc Kleine-Budde wrote:
>>> Actually I want to have the difference between two timestamps in orde=
r
>>> to sort . The timestamps are monotonically increasing and will
>>> eventually roll over. As the flexcan core only has a 16 bit timer, I
>>> shift the timestamp by 16 bit (cb =3D reg_ts << 16), to fill the whol=
e 32
>>> bit. This way I don't have to take care about the overflow, right?
>>>
> Hmmm, yes, that is quite clever. If I understand correctly, this means =
that if
> you have three timestamps on the roll-over boundary: 0xfffe0000, 0xffff=
0000 and
> 0x0001000, the sorting algorithm will sort them in this particular orde=
r because
> 	(int)(0xfffe0000 - 0xffff0000) < 0
> and
> 	(int)(0xffff0000 - 0x00010000) < 0

ACK. The queue_add_sort will walk the skb_queue reverse (from oldest to
newest) optimizing for the case that frames are read in-order. So if I
read the frames in order (even over a roll-over) there will be a maximum
of one compare for each frame. Only the frames that are read in one
can_rx_offload_irq_offload_timestamp() call will be sorted.

> Perhaps there should be a comment explaining this?

ACK

>>>> main: a=3D0xfffffff0 b=3D0xfffffffc diff=3D 12
>>>> main: a=3D0xfffffff0 b=3D0xfffffffd diff=3D 13
>>>> main: a=3D0xfffffff0 b=3D0xfffffffe diff=3D 14
>>>> main: a=3D0xfffffff0 b=3D0xffffffff diff=3D 15
>>>> main: a=3D0xfffffff0 b=3D0x00000000 diff=3D 16
>>>> main: a=3D0xfffffff0 b=3D0x00000001 diff=3D 17
>>>> main: a=3D0xfffffff0 b=3D0x00000002 diff=3D 18
>>>> main: a=3D0xfffffff0 b=3D0x00000003 diff=3D 19
>>>> main: a=3D0xfffffff0 b=3D0x00000004 diff=3D 20
>>
>> It's also working when the difference is negative:
>>
>>> main: a=3D0xfffffffc b=3D0xfffffff0 diff=3D-12
>>> main: a=3D0xfffffffd b=3D0xfffffff0 diff=3D-13
>>> main: a=3D0xfffffffe b=3D0xfffffff0 diff=3D-14
>>> main: a=3D0xffffffff b=3D0xfffffff0 diff=3D-15
>>> main: a=3D0x00000000 b=3D0xfffffff0 diff=3D-16
>>> main: a=3D0x00000001 b=3D0xfffffff0 diff=3D-17
>>> main: a=3D0x00000002 b=3D0xfffffff0 diff=3D-18
>>> main: a=3D0x00000003 b=3D0xfffffff0 diff=3D-19
>>
>> It will get "problematic" if the difference between the two u32 is
>> around 2^31. But then it's hard to tell which of the mailboxes holds t=
he
>> older timestamp.
>>
> Yes, it's also safe to assume that if you ever get this much of a diffe=
rence
> between timestamps in the mailbox, something else must be wrong before =
that
> happens.

ACK

> I've run into bugs involving this kind of a comparison function where t=
he
> difference actually can be large enough to cause problems, so this was =
a red
> flag for me, but it turns out to be OK.

That

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--5vNo8XPWKUxqBwUvQN9JI6pC3W1cDUx19--

--xUREF7VumKCGVoCCXsnL05k8SWBhFna1v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJXe6q3AAoJED07qiWsqSVqFvYH/iU/inyLnJzMW0MILVt4BZnz
QJmKtoj6w8ERkU2PdPpAOAvFq2ukMIdDAilnIK8Tn8+b9U3eHyECkE1UXezGdRoY
Hv2aLid7vrGHlpiiPswLWTR6KS6Ahcg7LO0j6l96GpqI9I3s85MYzM610qKpOH/+
70/oAv9t86ZBNVmOa+e/bDlh9VM8WkQMuMP4r7fC6C2TvUgF9v+UN2FsUq4Yd1v2
mesMCmsG5NV8FS6zCtTbZPVuHmSSk0gJ+nzv1U3ZLQaksHOQcf5yG9fujpgt0yVk
dsbX5PJnJ3T7Xqf1A/G+UKPcpQU67OhICNk3YDzeFoN9e1Y5kMUwuvvgDiqGRD4=
=GUky
-----END PGP SIGNATURE-----

--xUREF7VumKCGVoCCXsnL05k8SWBhFna1v--
