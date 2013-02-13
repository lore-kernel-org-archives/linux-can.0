From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: isobus with transport protocol
Date: Wed, 13 Feb 2013 09:59:46 +0100
Message-ID: <20130213085946.GA47662@vandijck-laurijssen.be>
References: <CAJsOQGO3bHsCqJ9kr=h0XZHxZ5wPejcPgV7WyCUp2HKYzZx0WQ@mail.gmail.com>
 <5113851F.1060501@pengutronix.de>
 <CAJsOQGMbTkJfc8YYiTdhc9r3aT1mD9MfGmWL3u=DwOmPojNLiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay006.isp.belgacom.be ([195.238.6.172]:7904 "EHLO
	mailrelay006.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758914Ab3BMI7w (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 13 Feb 2013 03:59:52 -0500
Content-Disposition: inline
In-Reply-To: <CAJsOQGMbTkJfc8YYiTdhc9r3aT1mD9MfGmWL3u=DwOmPojNLiw@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Felix Obenhuber <felix@obenhuber.de>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

Felix,

> We're working with ISOBUS systems (ISO11783). During a transport
> protocol session

As you know, I've put a j1939 (and ISOBUS) stack on
https://gitorious.org/linux-can/linux-can-j1939

> There are multiple
> software modules that might send frames at the same time over  a
> single module/socket.

It does allow for multiple software modules to cooperate
both on the same & on different logical ECU's (Source addresses),
and provides a transport protocol without IPC overhead or race conditions.

Can you explain what it is missing for your needs?
I may be able to help you to get things running.

Kind regards,
Kurt

On Thu, Feb 07, 2013 at 05:18:33PM +0100, Felix Obenhuber wrote:
> Hi Marc,
> 
> On Thu, Feb 7, 2013 at 11:42 AM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> > On 02/06/2013 12:59 PM, Felix Obenhuber wrote:
> >> Hi,
> >>
> >> how can I retrive the number of frames currently queued for
> >> transmission on a SocketCAN interface? Is this possible via netlink?
> >
> > Sorry, I don't know. What's you usecase?
> 
> We're working with ISOBUS systems (ISO11783). During a transport
> protocol session (similiar to iso tp) we'd like to know how many
> frames can get queued at once to adjust timings. There are multiple
> software modules that might send frames at the same time over  a
> single module/socket.
> 
> Maybe we have to add a tx fifo within the software...
> 
> cheers,
> 
> Felix
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
