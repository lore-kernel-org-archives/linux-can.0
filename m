From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: flexcan driver: tx_bytes counter never incremented when
 CAN_RAW_LOOPBACK removed?
Date: Mon, 29 Apr 2013 12:40:01 +0200
Message-ID: <517E4E01.3080705@peak-system.com>
References: <CAJW3KNWxa_a727sgi_EO7nMBVbyVrCz0V3wCJBfvhz0ubbqCfA@mail.gmail.com>
 <517A968D.20508@pengutronix.de>
 <CAJW3KNWrdhvXyEA3jmkx+eobH34_g5noykZpyL0YaWjrm1qbLA@mail.gmail.com>
 <20130426205150.GA28450@thinkoso.home> <517E26E4.8010003@pengutronix.de>
Reply-To: Stephane Grosjean <s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:45933 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757155Ab3D2KkJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 29 Apr 2013 06:40:09 -0400
In-Reply-To: <517E26E4.8010003@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

Hi Marc,

Playing with the flexcan driver, I've seen that the tx_bytes counter=20
always equals 0 while tx_packets increases.
I simply removed the CAN_RAW_LOOPBACK option from my CAN socket, so I=20
suppose that:

stats->tx_bytes +=3D can_get_echo_skb(dev, 0);

doesn't do what it should.
Am I wrong?

Best regards,

St=E9phane
--
PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt=20
Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA Darmstadt=20
HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.: DE39305391=20
Tel.+49 (0)6151-817320 / Fax:+49 (0)6151-817329, info@peak-system.com
