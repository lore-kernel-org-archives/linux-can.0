From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Losing CAN messages with socket-CAN
Date: Thu, 04 Apr 2013 23:12:24 +0200
Message-ID: <515DECB8.6090909@grandegger.com>
References: <20130404161608.8B2BF3E5B2D4A@bmail02.one.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:57963 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763239Ab3DDVM3 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 4 Apr 2013 17:12:29 -0400
In-Reply-To: <20130404161608.8B2BF3E5B2D4A@bmail02.one.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "j.p.lammertink" <j.p.lammertink@kubicas.com>
Cc: linux-can@vger.kernel.org

On 04/04/2013 06:16 PM, j.p.lammertink wrote:
> Hi Wolfgang,
>=20
> It looks like you can help us out. That would realy be great!
> I've collected answers to your questions and pasted them below.

=2E..

> <>This CAN controller identifies itself (according to data sheet) as =
follows:
> <>    Vendor Identification Register    8086h
> <>    Device Identification Register    8818h
> <>    Revision Identification Register  00h
> <>    Class Code Register               0C0900h
>=20
> < Ah, the "pch_can" driver does have known issues. End of last year I=
 sent
> < some patches to improve the "pch_can" or, even better, make the "c_=
can"
> < driver work on the EG20T as well. See:
>=20
> <   http://marc.info/?l=3Dlinux-can&m=3D135531975013055&w=3D2
>=20
> < Are you able to build and use a recent mainline kernel? I need to f=
igure
> < out how to help you best.
>=20
> Currently a colleage of mine is attempting to build the kernel (to be=
 able to
> apply patches to solve a display issue). I expect he will succeed one=
 of these
> days.
> Wouldn't it be simplest just to use the latest sources of this driver=
?

These patches are not yet mainline because they do not fix all issues. =
I
do not have a system at hand and therefore somebody else needs to take
care. We actually want to drop the pch_can driver in favor of an update=
d
c_can driver. If you go over the patch series I pointed out you will ge=
t
more information. Anyway, we got positive feedback especially with the
c_can driver for the EG20T.

> Can you tell me which sources I should look for? (Probably I've downl=
oaded them
> already, but I wish to replace only the files that make the differenc=
e)

I think that patch 1/7 of the series may already fix your TX problems:

  http://marc.info/?l=3Dlinux-can&m=3D135526076021515&w=3D2
=B4
If you apply the remaining patches, you can select the "c_can_pci"
driver. If you get trouble with these patches I need to adapt them to a
more recent kernel version.

Wolfgang.
