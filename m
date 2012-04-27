From: Sven Geggus <lists@fuchsschwanzdomain.de>
Subject: Re: ODB-II Interfaces and Linux CAN?
Date: Fri, 27 Apr 2012 11:50:11 +0000 (UTC)
Message-ID: <jne15j$bbr$1@ultimate100.geggus.net>
References: <jndptc$9c5$1@ultimate100.geggus.net> <4F9A6DEA.5050900@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.gnuher.de ([78.47.12.54]:44182 "EHLO mail.gnuher.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750771Ab2D0LuN (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 27 Apr 2012 07:50:13 -0400
Received: from ultimate100.geggus.net ([2a01:198:297:1::1])
	by mail.gnuher.de (envelope-from
	<news@geggus.net>)
	with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	id 1SNjgi-0002zz-1t
	for linux-can@vger.kernel.org; Fri, 27 Apr 2012 13:50:12 +0200
Received: from news  by ultimate100.geggus.net (envelope-from
	<news@geggus.net>)
	with local (Exim 4.72)
	id 1SNjgh-0003HF-9y
	for linux-can@vger.kernel.org; Fri, 27 Apr 2012 13:50:11 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> The webpage talks about a "327 Chip" when searching for it, I find:
> http://www.blafusel.de/obd/obd2elm327.html
> http://www.elmelectronics.com/DSheets/ELM327DS.pdf

Jepp this includes a description of the serial protocol.

> This chip converts ODB (and CAN seems to be part of ODB) to serial. T=
he
> question is how the 327 in the autodia-e327 is converted to USB. They
> probably use a standard USB-Serial converter chip.=20

They almost certaily do.

> There is support for serial attached CAN adapters in mainline (IIRC),=
 but
> I think it talks a different protocol.

You are talking about slcan.c right?

Probably I should just get me one of these cheap Interfaces.

Sven

--=20
Unix is simple and coherent, but it takes a genius =E2=80=93 or at any =
rate a
programmer =E2=80=93 to understand and appreciate the simplicity
(Dennis M. Ritchie)
/me is giggls@ircnet, http://sven.gegg.us/ on the Web
