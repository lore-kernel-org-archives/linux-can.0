From: Keith Jones <keith.rjones@yahoo.com>
Subject: Re: flexcan_poll_error_state(struct net_device *dev, u32 reg_esr)
Date: Thu, 7 Jun 2012 09:29:17 -0700 (PDT)
Message-ID: <1339086557.44691.YahooMailNeo@web140804.mail.bf1.yahoo.com>
References: <1338849280.43608.YahooMailNeo@web140802.mail.bf1.yahoo.com> <1338849547.86575.YahooMailNeo@web140805.mail.bf1.yahoo.com> <1338852261.93934.YahooMailNeo@web140802.mail.bf1.yahoo.com> <4FCDB93D.5030007@pengutronix.de>
Reply-To: Keith Jones <keith.rjones@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from nm2-vm0.bullet.mail.bf1.yahoo.com ([98.139.213.127]:24824 "HELO
	nm2-vm0.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751322Ab2FGQ3S convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 7 Jun 2012 12:29:18 -0400
In-Reply-To: <4FCDB93D.5030007@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>





On Tuesday, June 5, 2012 12:46 AM, Marc Kleine-Budde wrote:


> Use v3.4. Your v2.6.35 is probably a freescale kernel, with a freesca=
le
> flexcan driver. The mainline driver should work with mx53.

Dropping "drivers/net/can"=A0 and supporting headers from 3.4 into 2.6.=
35 distro causes rippling compilation inconsistencies. The infrastructu=
re has changed in the 3+ tree.=A0 We would like to continue using 2.6.3=
5 with upgraded flexcan, but the linux source tree dependencies for 3.4=
 support are significant.=A0 On the other hand, building a complete 3.4=
 image for imx_ard would be an effort we wish not to undertake at this =
moment.


How best to get 3.4 flexcan functionality into 2.6.35?

=A0Your thoughts...

--=20
Pengutronix e.K.=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | Marc Kleine-Budde=
=A0 =A0 =A0 =A0 =A0=A0=A0|
Industrial Linux Solutions=A0 =A0 =A0 =A0 | Phone: +49-231-2826-924=A0 =
=A0=A0=A0|
Vertretung West/Dortmund=A0 =A0 =A0 =A0 =A0 | Fax:=A0=A0=A0+49-5121-206=
917-5555 |
Amtsgericht Hildesheim, HRA 2686=A0 | http://www.pengutronix.de=A0=A0=A0=
|
