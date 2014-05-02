From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: detect auto baud rate on can bus in linux driver.
Date: Fri, 2 May 2014 13:00:07 +0200
Message-ID: <20140502110007.GA1483@vandijck-laurijssen.be>
References: <53590FB6.6090707@tataelxsi.co.in>
 <20140427094418.GB28319@griso.site>
 <20140427180135.GB21176@vandijck-laurijssen.be>
 <1398760380297.91253@tataelxsi.co.in>
 <20140429195841.GB9737@pengutronix.de>
 <5360E8A6.8040204@tataelxsi.co.in>
 <20140430144124.GC28036@vandijck-laurijssen.be>
 <53612640.90106@hartkopp.net>
 <20140501184957.GA25736@vandijck-laurijssen.be>
 <5363243E.7070406@tataelxsi.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay006.isp.belgacom.be ([195.238.6.172]:48973 "EHLO
	mailrelay006.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751678AbaEBLAM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 2 May 2014 07:00:12 -0400
Content-Disposition: inline
In-Reply-To: <5363243E.7070406@tataelxsi.co.in>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ratheendran <ba.rsrajeshwaran@tataelxsi.co.in>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Oliver Hartkopp <socketcan@hartkopp.net>

Hey,

On Fri, May 02, 2014 at 10:21:10AM +0530, Ratheendran wrote:
> Hey=C2=A0 Kurt,
>=20
> I just looked into linux-can/can-j1939-utils which I am plan to use o=
n my final
> target, for this source candump -T < > option is missing.

That is very likely, as the can-j1939-utils forked some time ago,
and the -T option is recent.
You could merge both using git, or, since can-j1939-utils does not
really touch candump, you could just copy the newer candump.c into
your can-j1399-utils directory, overwriting the old candump.c.

Kind regards,
Kurt
