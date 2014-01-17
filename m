From: Michal Sojka <sojkam1@fel.cvut.cz>
Subject: Re: [PATCH RFC 1/2] can: Limit default size of CAN_RAW socket send queue
Date: Fri, 17 Jan 2014 16:31:47 +0100
Message-ID: <87bnzalj4s.fsf@steelpick.2x.cz>
References: <1389902301-24505-1-git-send-email-sojkam1@fel.cvut.cz> <52D8F44A.7000007@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from max.feld.cvut.cz ([147.32.192.36]:57714 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752464AbaAQPbx (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 17 Jan 2014 10:31:53 -0500
In-Reply-To: <52D8F44A.7000007@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: yegorslists@googlemail.com

On Fri, Jan 17 2014, Marc Kleine-Budde wrote:
> On 01/16/2014 08:58 PM, Michal Sojka wrote:

[...]

>> Open issues:
>> - Will this work with CANFD?
>
> Can you calculate the size in bytes depending if we have a CAN or a
> CANFD network card at this socket?

One option would be to change the sk_sndbuf in raw_setsockopt when
optname == CAN_RAW_FD_FRAMES and sk_sndbuf is at the default value.

The other option would be ignore CANFD completely, which would mean that
the default socket queue would allow only 1 or 2 CANFD frames before
blocking (I don't have exact numbers at hand).

What do you think?

-Michal
