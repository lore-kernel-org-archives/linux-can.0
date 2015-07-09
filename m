From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: can: flexcan: implement workaround for FIFO overruns (based on code by David Jander)
Date: Thu, 09 Jul 2015 08:58:46 +0200
Message-ID: <2576741.YrBIndJIHB@ws-stein>
References: <559D35CA.2050402@uweschneider.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:50387 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752990AbbGIHFE (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 9 Jul 2015 03:05:04 -0400
In-Reply-To: <559D35CA.2050402@uweschneider.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Torsten Lang <torsten.lang@uweschneider.de>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>

Hello,

On Wednesday 08 July 2015 16:38:02, Torsten Lang wrote:
> This patch is for Kernel 4.1-rc8 (and should AFAIK still be valid also for the current 4.1/4.2 versions). It is based on the rework done by David Jander which disables the only six messages deep hardware FIFO of the FlexCAN core and instead uses all available mailboxes for reception.

Please keep in mind that disabling FIFO mode in FlexCAN disables RTR-reception on i.MX3. Please refer to http://marc.info/?l=linux-can&m=141199785820075&w=2 about the mail I've written to David last year). This needs to be handled.

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

