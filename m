From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: using can-j1939
Date: Thu, 1 Dec 2011 12:52:56 +0100
Message-ID: <20111201115256.GB321@e-circ.dyndns.org>
References: <20111201105434.214940@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:18962 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753198Ab1LALxA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 1 Dec 2011 06:53:00 -0500
Content-Disposition: inline
In-Reply-To: <20111201105434.214940@gmx.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Wagner <wutz@unterderbruecke.de>
Cc: linux-can@vger.kernel.org

On Thu, Dec 01, 2011 at 11:54:34AM +0100, Wolfgang Wagner wrote:
> Hi,
>=20
> thank you very much for your fast response. Glad that you will help m=
e.
>=20
> I want to run the can-j1939 for linux on a Phytec phycore MPC5121e wi=
th kernel release 2.6.33.5-rt2x-ptx-pcm046-3.
I'm not that much used with specific drivers & releases. I included lin=
ux-can
mailing list, maybe they can help to use out-of-tree CAN modules on you=
r system.
>=20
> I managed to download the 3 thing you told me, but now I don't know t=
o move on - I am really desperated because I can't find any proper docu=
mentation.
Did you read Documentation/networking/can/j1939.txt from the can-j1939-=
modules?

The Documentation is a currently a weak point. I've had some busy month=
s,
and j1939 dissappeared from my priorities since our system is working
properly.

Oliver Hartkopp has already proposed to work out some use-cases, but as=
 said,
I've not found time for that yet.
Maybe this is a good opportunity to do so...

Kurt Van Dijck
>=20
> I would be really pleased about your help!
>=20
> Kind regards,
>=20
> Wolfgang Wagner
>=20
>=20
>=20
> -------- Original-Nachricht --------
> Datum: Thu, 1 Dec 2011 10:07:03 +0100
> Von: Gitorious <no-reply@gitorious.org>
> An: wutz@unterderbruecke.de
> Betreff: New message: Re: j1939
>=20
>=20
>=20
> Hello wutzol
>=20
> Kurt Van Dijck has sent you a message on Gitorious:
> ----------------------------------------------------
>=20
> Hi,
>=20
> Thanks for your interest in can-j1939 for linux.
> In order to use our can-j1939 for linux, you will need 3 things:
> * can-j1939 kernel stack on https://gitorious.org/~kurt-vd/linux-can/=
can-j1939-modules
>   I've had a patchset to patch the net-next-2.6 linux branch, but it =
is a bit outdated.
> * can-j1939 utilities on https://gitorious.org/~kurt-vd/linux-can/can=
-j1939-utils
>   This branch of can-utils contains some additional j1939 specific pr=
ograms
> * iproute2-j1939 on https://gitorious.org/~kurt-vd/linux-can/iproute2=
-j1939
>   This replaces iproute2, and adds j1939 specific commands:
>   * turn j1939 on for a specific can device
>   * manage j1939 addressing info for a can device
>=20
> Since linux-can moved to gitorious only recently, I'm not sure all my=
 repositories are already up to date. I will check that.
>=20
> In the kernel modules, a Documentation/networking/j1939.txt (or simil=
ar) is provided.
> I'll be interested in helping you using the j1939 stack. Therefore, y=
ou may
> participate in linux-can@vger.kernel.org (linux-can mailing list) or =
email me directly
> (you'll find my email in the git repositories).
>=20
> Kind regards,
> Kurt Van Dijck
>=20
>=20
> ----------------------------------------------------
> View and reply to this message at https://gitorious.org/messages/1182=
59
>=20
> PLEASE DO NOT reply to this email directly as it will go
> nowhere. Instead, use the above link to reply.
>=20
> --=20
> NEU: FreePhone - 0ct/min Handyspartarif mit Geld-zur=C3=BCck-Garantie=
!	=09
> Jetzt informieren: http://www.gmx.net/de/go/freephone
