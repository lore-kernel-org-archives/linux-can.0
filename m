From: Gianluca <gmattiroli@midsx.ch>
Subject: Re: socketCAN mcp2515 - rx buffer overflow
Date: Thu, 8 Mar 2012 14:35:26 +0000 (UTC)
Message-ID: <loom.20120308T152308-549@post.gmane.org>
References: <loom.20120308T140608-84@post.gmane.org> <4F58BE03.5030905@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:55877 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753386Ab2CHOfn (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 8 Mar 2012 09:35:43 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1S5eRL-0002g2-K2
	for linux-can@vger.kernel.org; Thu, 08 Mar 2012 15:35:37 +0100
Received: from 62-48-103-138.adsl.ticino.com ([62-48-103-138.adsl.ticino.com])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 08 Mar 2012 15:35:35 +0100
Received: from gmattiroli by 62-48-103-138.adsl.ticino.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 08 Mar 2012 15:35:35 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Marc Kleine-Budde <mkl <at> pengutronix.de> writes:

> Using an SPI attached CAN controller is a really bad choice. Try is
> upgrading to mx53, which has as far as I know one or even two internal
> flexcan cores, an option for you? Another option is to attach a local
> bus capable controller like the SJA1000 to your CPU, or use an USB
> dongle or a PCMCIA card.
> 
> The next thing is the SPI driver on the (mainline) mx51. If I remember
> correctly the mainline kernel doesn't support DMA for the SPI driver
> yet. I don't know if the freescale kernel does. Depending on your kernel
> version there are some knobs to tune the PIO SPI driver, mainly to
> increase the priority of the SPI task.
> 
> Last but not least, there is a not yet mainlined improved version of the
> mcp2515 driver around.
> 
> regards, Marc

Ok, it does not sound to be stable and safe solution. Maybe using the SJA1000 
would be a better choice for our project. Thanks for the help.

Gianluca




