From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] can: remove CAN FD compatibility for CAN 2.0 sockets
Date: Sat, 01 Mar 2014 15:31:26 +0100
Message-ID: <5311EF3E.6020800@hartkopp.net>
References: <530F9D39.1010500@hartkopp.net> <5310A9EB.7050102@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:61036 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752676AbaCAObn (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 1 Mar 2014 09:31:43 -0500
In-Reply-To: <5310A9EB.7050102@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Stephane Grosjean <s.grosjean@peak-system.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 28.02.2014 16:23, Stephane Grosjean wrote:
> I agree with this change, so you also have my Acked-by ...
> 

(..)

>>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Acked-by: Stephane Grosjean <s.grosjean@peak-system.com>

Hi Marc,

there's also some documentation to be removed when reverting this
compatibility stuff.

Will send a V2 to have this in one single patch in a minute.

Regards,
Oliver



