From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: c_can: wrong frame order reception
Date: Wed, 02 Apr 2014 07:57:16 +0200
Message-ID: <2275726.4ik4KABhfi@ws-stein>
References: <2323199.vffRdFDsB5@ws-stein> <7234338.9RqiOdiLOY@ws-stein> <533B067A.3030609@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:32842 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756616AbaDBF6b (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 2 Apr 2014 01:58:31 -0400
In-Reply-To: <533B067A.3030609@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>

Hello Oliver,

On Tuesday 01 April 2014 20:33:30, Oliver Hartkopp wrote:
> don't know if you monitored the patch set which was posted by Thomas 
Gleixner:
> 
> There was one patch "c_can: Make it SMP safe"
> 
> 	http://marc.info/?l=linux-can&m=139516364829052&w=2
> 
> which addressed some issues, you obviously fixed with your below patch too.
> 
> Your patch below additionally implements the PCH_CAN support for C_CAN.
> 
> Can you please check, if the patchset from Thomas which is available here
> 
> 	tag 'linux-can-fixes-for-3.15-20140401'
> 	in https://gitorious.org/linux-can/linux-can
> 
> fixes the frame order reception in your setup too - and if so, sent a 
rebased
> patch for the PCH_CAN support?

Yep, I've seen that. I've already picked those patches and rebased eg20t 
support on v3.14. Testing of those is already enqueued, but it got delayed due 
to some other problems.

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

