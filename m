From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [RFC PATCH] can: add tx/rx led trigger support
Date: Wed, 11 Apr 2012 21:02:43 +0200
Message-ID: <4F85D553.2010303@hartkopp.net>
References: <1334093965-2692-1-git-send-email-fabio.baltieri@gmail.com> <4F852161.90706@hartkopp.net> <CABkP77eNeTTwSxtKyfUmr7OC4H1nXEN4EeFH7pdR6=BcpKuE6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:44381 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756120Ab2DKTCl (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 11 Apr 2012 15:02:41 -0400
In-Reply-To: <CABkP77eNeTTwSxtKyfUmr7OC4H1nXEN4EeFH7pdR6=BcpKuE6w@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Fabio Baltieri <fabio.baltieri@gmail.com>
Cc: linux-can@vger.kernel.org

Two additional questions:

On 11.04.2012 19:58, Fabio Baltieri wrote:

> On Wed, Apr 11, 2012 at 8:14 AM, Oliver Hartkopp <socketcan@hartkopp.net> wrote:

>> And we should probably add a new CAN netlink command here
>>
>>        http://lxr.linux.no/#linux+v3.3.1/drivers/net/can/dev.c#L577
>>
>> to configure the LED timer per interface: 0 -> LEDs off (==default)
> 
> Nice... I'm taking notes here. :-)


Hm - probably this is a bit heavy weighted suggestion from me.

Do you really think the timer value needs to be configurable or is a simple
on/off switch ok too?

The second question:

Is the LED "blinking" on traffic or is it just "on" for some time when a CAN
frame is processed?

Regards,
Oliver
