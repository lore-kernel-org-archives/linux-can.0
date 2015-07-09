From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: can: flexcan: implement workaround for FIFO overruns (based on code by David Jander)
Date: Thu, 09 Jul 2015 09:48:38 +0200
Message-ID: <3634451.aFQ5B85Yzk@ws-stein>
References: <559D35CA.2050402@uweschneider.de> <2576741.YrBIndJIHB@ws-stein> <CAOpc7mEc+kr=Es34772fcTnsQpJsaCaoVOx67AhfRjxucPhAhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:59426 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750816AbbGIHsr (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 9 Jul 2015 03:48:47 -0400
In-Reply-To: <CAOpc7mEc+kr=Es34772fcTnsQpJsaCaoVOx67AhfRjxucPhAhw@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Holger Schurig <holgerschurig@gmail.com>
Cc: Torsten Lang <torsten.lang@uweschneider.de>, linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>

Hello,

On Thursday 09 July 2015 09:27:57, Holger Schurig wrote:
> 2015-07-09 8:58 GMT+02:00 Alexander Stein
> <alexander.stein@systec-electronic.com>:
> > This needs to be handled.
> 
> Do you have any suggestion how to handle this?

Well, up to now I haven't seen any CAN frame loss on several i.MX35 boards while using FIFO mode. So I suggest to extend the compatible to keep the FIFO mode on i.MX3 hardware.

Best regards,
Alexander
-- 
Dipl.-Inf. Alexander Stein

SYS TEC electronic GmbH
Am Windrad 2
08468 Heinsdorfergrund
Tel.: 03765 38600-1156
Fax: 03765 38600-4100
Email: alexander.stein@systec-electronic.com
Website: www.systec-electronic.com
 
Managing Director: Dipl.-Phys. Siegmar Schmidt
Commercial registry: Amtsgericht Chemnitz, HRB 28082

