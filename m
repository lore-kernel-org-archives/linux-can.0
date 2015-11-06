From: =?utf-8?Q?Michael_Luxen?= <mluxen@gmx.net>
Subject: AW: can-isotp-modules
Date: Fri, 6 Nov 2015 06:59:08 +0100
Message-ID: <zarafa.563c41ac.05a0.6a1e301242cec580@euve35974.vserver.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from euve35974.vserver.de ([62.75.213.146]:48161 "EHLO
	euve35974.vserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750924AbbKFF7L convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 6 Nov 2015 00:59:11 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?utf-8?Q?Oliver_Hartkopp?= <socketcan@hartkopp.net>
Cc: =?utf-8?Q?linux-can=40vger=2Ekernel=2Eorg?= <linux-can@vger.kernel.org>, =?utf-8?Q?linux-can-owner=40vger=2Ekernel=2Eorg?= <linux-can-owner@vger.kernel.org>

Hello Oliver,

one additional remark.
Not all preconditions are mentioned in your updated installation proces=
s.
On a fresh BBB Debian console image I've to install...

sudo apt-get install linux-headers-$(uname -r)

=2E..before.

Regards
Michael

-----Urspr=C3=BCngliche Nachricht-----
Von:	Oliver Hartkopp <socketcan@hartkopp.net>
Gesendet:	Mi 04.11.2015 19:33
Betreff:	Re: AW: can-isotp-modules
An:	Michael Luxen <mluxen@gmx.net>; Oliver Pajonk <oliver@pjnk.de>;=20
CC:	linux-can-owner@vger.kernel.org; linux-can@vger.kernel.org;=20
> On 04.11.2015 13:02, Michael Luxen wrote:
>=20
> > @Oliver H.:
> > One proposal from myside, can you please add a can-isotp-module ins=
tallation=20
> process (like it is below) on the GITHUB webside.
> > It would be easier for some people (like me) to get the source code=
 running=20
> without asking. :-)
>=20
> Done.
>=20
> Don't know why I did not had that idea before m)
>=20
> Thanks,
> Oliver
>
