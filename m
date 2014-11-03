From: David Jander <david@protonic.nl>
Subject: Re: [PATCH 11/15] can: rx-fifo: Add support for can state tracking
 and error polling
Date: Mon, 3 Nov 2014 14:09:21 +0100
Message-ID: <20141103140921.4ffd55e7@archvile>
References: <1412956020-21489-1-git-send-email-david@protonic.nl>
	<1412956020-21489-12-git-send-email-david@protonic.nl>
	<545765D8.7090906@pengutronix.de>
	<20141103135135.10fd4c6f@archvile>
	<54577C03.7010609@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:4542 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752427AbaKCNIs (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 3 Nov 2014 08:08:48 -0500
In-Reply-To: <54577C03.7010609@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>

On Mon, 03 Nov 2014 13:58:43 +0100
Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> On 11/03/2014 01:51 PM, David Jander wrote:
> >> On 10/10/2014 05:46 PM, David Jander wrote:
> >>> The interrupt handler should store the error flags if needed and call
> >>> can_rx_fifo_irq_error() if there was an error flag set. This will trigger
> >>> a napi-poll that will call poll_can_state() and poll_bus_error()
> >>> callbacks. Those should handle can state machine and send error frames
> >>> as needed.
> >>>
> >>> Signed-off-by: David Jander <david@protonic.nl>
> >>> ---
> >>>  drivers/net/can/dev.c   | 23 ++++++++++++++++++++---
> >>>  include/linux/can/dev.h |  9 +++++++++
> >>>  2 files changed, 29 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
> >>> index fc35d28..dac7579 100644
> >>> --- a/drivers/net/can/dev.c
> >>> +++ b/drivers/net/can/dev.c
> >>> @@ -352,6 +352,9 @@ static int can_rx_fifo_napi_poll(struct napi_struct
> >>> *napi, int quota) unsigned int tail;
> >>>  
> >>>  restart_poll:
> >>> +	if (work_done < quota)
> >>> +		work_done += fifo->poll_can_state(fifo);
> >>> +
> >>
> >> Do we need two callbacks in the poll-loop? I think one should be enough.
> >> The driver can call as many non-rx related functions as needed then.
> >> E.g. state change, bus error handling, tx-completion handling, etc...
> > 
> > Ok. I split it into two handlers, because I saw most drivers doing first
> > state-handling then message reception and last error handling... in this
> > particular order. If that order is not important, we can use one poll()
> > function for both state- and error-handling.
> > In that case... should the poll() handler be called _before_ or _after_
> > handling the mailboxes?
> 
> Following the general rule zero-one-infinity ("Allow none of foo, one of
> foo, or any number of foo" [1]) one callback should be fine. As we are
> optimizing for not loosing RX CAN frames I tend to say it should come
> after rx.

Hahaha, ok, I got it :)
Any idea on how to call this function? Just "poll" seems a little bit
under-documented...

> Marc
> 
> [1] http://c2.com/cgi/wiki?ZeroOneInfinityRule

Best regards,

-- 
David Jander
Protonic Holland.
