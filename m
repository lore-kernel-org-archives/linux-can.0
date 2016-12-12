From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: ti hecc rx frames out of order
Date: Mon, 12 Dec 2016 18:01:01 +0100
Message-ID: <83813a5e-b146-2763-1fb3-31d64fcebf4c@hartkopp.net>
References: <1579A5A5423CC14B827884B535F8E951349421F6@SSCOXCHG2.spray.com>
 <08de827f-0d1b-4523-0ed9-f0979345de87@hartkopp.net>
 <1579A5A5423CC14B827884B535F8E95134942564@SSCOXCHG2.spray.com>
 <0b6dc834-db5b-a8e3-1461-f97c7c79ad44@hartkopp.net>
 <1579A5A5423CC14B827884B535F8E95134949AB3@SSCOXCHG2.spray.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:11663 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752188AbcLLRB2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 12 Dec 2016 12:01:28 -0500
In-Reply-To: <1579A5A5423CC14B827884B535F8E95134949AB3@SSCOXCHG2.spray.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Grim, Dennis" <Dennis.Grim@teejet.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 12/12/2016 04:34 PM, Grim, Dennis wrote:

> I will gladly try your idea.  However, it appears to address an issue related to SMP systems.  The TI AM3517 is single core.  Would you expect your idea to have any impact for single core?

No.

> Also, the TI AM3517 HECC device driver uses NAPI.

Ugh!

@Marc: When this is a NAPI driver - what could be the problem then?

Is NAPI probably the root cause of the o-o-o issue here?

Regards,
Oliver
