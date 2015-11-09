From: Benedikt Spranger <b.spranger@linutronix.de>
Subject: Re: API to support hardware priorities
Date: Mon, 9 Nov 2015 16:27:03 +0100
Message-ID: <20151109162703.3fd6d4fc@mitra>
References: <20151109123618.41ad1bae@mitra>
	<5640A065.2000401@pengutronix.de>
	<5640A4E4.6020005@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:40051 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339AbbKIP1H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 9 Nov 2015 10:27:07 -0500
In-Reply-To: <5640A4E4.6020005@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>, linux-can <linux-can@vger.kernel.org>

On Mon, 9 Nov 2015 14:51:32 +0100
Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> Are we talking about RX or TX here?
TX.

> Do you mean the mailbox feature, where you queue a frame into
> hardware, but sending is delayed until a certain CAN-ID is RX'ed?
No.
The C-CAN/D-CAN and some other Controller can be configured to have
mailboxes for a certain Id. For example you can configure MBX 1 for
Id 23, MBX 2 for Id 42 and 3-7 act as FIFO. So every packet matching Id
23 should queued up to MBX 1, every package matching Id 42 to MBX 2 and
all other Packages to the FIFO.

Having a multiqueue TX part may help but may have some drawbacks. If th=
e
=46IFO (or an other queue) is full the driver calls netif_stop_queue().
Sending bulk data can block out a "high priority" Package. On the other
hand a application writing bulk data in blocking mode should not
receive a EAGAIN and not be punished by a "mixed up" queue i.e.
violating the package send order.

Regards
    Bene

--=20
Linutronix GmbH

Phone: +49 7556 4521 890; Fax.: +49 7556 91 98 86

=46irmensitz: D-88690 Uhldingen, Auf dem Berg 3
Registergericht: Freiburg i. Br., HRB 700 806;=20

Gesch=C3=A4ftsf=C3=BChrer: Heinz Egger, Thomas Gleixner
