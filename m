From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [PATCH v5] can: flexcan: Re-write receive path to use MB queue instead of FIFO
Date: Wed, 01 Oct 2014 10:29:41 +0200
Message-ID: <4712537.n1vM034J9B@ws-stein>
References: <1411995175-13540-1-git-send-email-david@protonic.nl> <1952804.jDdF5Ah5L9@ws-stein> <542BAA22.7010508@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:58838 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751053AbaJAI2z (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 Oct 2014 04:28:55 -0400
In-Reply-To: <542BAA22.7010508@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: David Jander <david@protonic.nl>, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

On Wednesday 01 October 2014 09:15:46, Marc Kleine-Budde wrote:
> On 10/01/2014 09:11 AM, Alexander Stein wrote:
> > BTW: You posted a patch for at91_can in June (Din't get opportunity
> > to try it yet), where you use a kfifo to accomplish the same, why not
> > here?
> 
> The cyclic buffer approach is okay, from my point of view.

I'M just wondering why 2 different approaches have been chosen.

Regards,
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

