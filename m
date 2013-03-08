From: "Max S." <max@schneidersoft.net>
Subject: Re: write: No buffer space available
Date: Fri, 08 Mar 2013 10:39:34 +0000
Message-ID: <1362739174.3296.2.camel@blackbox>
References: <CACekSAN4Roq50mr7+2P5Fk8zxY6hSOErqgrxu-3sLbyS7SzwJQ@mail.gmail.com>
	 <5138C20B.1070306@hartkopp.net>
	 <CACekSAML-BgcW5CWNfns_V0HgqsEFEHXQ06AdLAMupDKefmnFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.schneidersoft.net ([173.45.248.65]:35217 "EHLO
	mail.schneidersoft.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932759Ab3CHKo4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 8 Mar 2013 05:44:56 -0500
In-Reply-To: <CACekSAML-BgcW5CWNfns_V0HgqsEFEHXQ06AdLAMupDKefmnFQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael =?ISO-8859-1?Q?Th=E9nault?= <michael.thenault@gmail.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

Hello,

On Fri, 2013-03-08 at 11:24 +0100, Michael Th=C3=A9nault wrote:
> Hello,
>=20
> Indeed after connecting the arm board to a termination, I'm able to
> see traffic with the oscilloscope.
> I noticed that after sending only one frame with cansend, I see
> traffic all the time with the oscilloscope. I guess that the reason i=
s
> the lack of ACK frames coming from other nodes, which causes re-sends=
=2E

Yes. If there is no other node to ack the frame, the can controller wil=
l
resend the frame continuously. unless, i think, if you set it up to use
oneshot mode.

M.S.

