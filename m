From: Andreas Larsson <andreas@gaisler.com>
Subject: Re: [PATCH v5] can: sja1000: Add support for listen-only mode and
 one-shot mode
Date: Fri, 21 Sep 2012 10:12:49 +0200
Message-ID: <505C2181.5020906@gaisler.com>
References: <5059F783.5030200@hartkopp.net> <1348127441-2165-1-git-send-email-andreas@gaisler.com> <505C2096.3020808@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from vsp-authed02.binero.net ([195.74.38.226]:63768 "HELO
	vsp-authed-02-02.binero.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753366Ab2IUINY (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 21 Sep 2012 04:13:24 -0400
In-Reply-To: <505C2096.3020808@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, software@gaisler.com

On 09/21/2012 10:08 AM, Marc Kleine-Budde wrote:
> On 09/20/2012 09:50 AM, Andreas Larsson wrote:
>> One-shot mode uses the TCS bit of the status register to discern
>> whether a transmission was successful or not. On a failed
>> transmission, the frame is not echoed back.
>>
>> Signed-off-by: Andreas Larsson <andreas@gaisler.com>
>> Acked-by: Wolfgang Grandegger <wg@grandegger.com>
>> Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
>
> Applied to can-next.

Excellent! Thanks everyone for the feedback!

Cheers,
Andreas

