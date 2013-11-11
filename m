From: "Max S." <max@schneidersoft.net>
Subject: Re: GS_USB
Date: Mon, 11 Nov 2013 02:10:35 +0000
Message-ID: <1384135835.3749.31.camel@blackbox>
References: <1380889887.22484.2.camel@blackbox>
			 <52507832.8000709@grandegger.com> <1381155720.21207.7.camel@blackbox>
			 <5e3f6029b128db63c69664deed10c5d6@grandegger.com>
		 <1381175546.21207.37.camel@blackbox> <525319E6.4020505@grandegger.com>
	 <1383498724.4208.4.camel@blackbox> <527EC310.5010003@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.schneidersoft.net ([173.45.248.65]:50626 "EHLO
	mail.schneidersoft.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018Ab3KKB5s (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 10 Nov 2013 20:57:48 -0500
In-Reply-To: <527EC310.5010003@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can <linux-can@vger.kernel.org>

Hi Wolfgang,

On Sun, 2013-11-10 at 00:19 +0100, Wolfgang Grandegger wrote:

> You redefine the CAN flags and mask here but in many places you
> silentely assume that they are identical, e.g. via:
> 
>    cf->can_id = hf->can_id;
> 
> Not sure how to handle this transprently. I think these defines will
> never change. Either use the CAN flags and mask directly (like you
> already do for the error frames) or properly remap/copy all flags and
> values. Other opinions?

I have removed the GS_CAN_* flags. They are the same as those in the
Linux can headers. The idea was not to have to repackage everything. But
instead get by with some copies. like cf->can_id = hf->can_id; Byte
order is handled by the device.

> In case of bus-off. What does the hardware do? How does it recover? Is
> recovery triggered by software possible? Is it possible to support
> manual recovery?

Manual recovery is not supported. The node can leave bus off state if
it detects 128 occurrences of 11 consecutive recessive bits on the bus.
Maybe I can trick the controller out of bus off by doing a software
reset. That's probably not going to be a clean solution though.

> 
> > +	} else if (cf->can_id & CAN_ERR_CRTL) {
> > +		dev->can.state = CAN_STATE_ERROR_ACTIVE;
> 
> 
> This means back to error active, right?
Yes, if none of the following conditions apply.
I guess i could use an if else if else instead of conditionally
overwriting the state...
> 
> > +		if ((cf->data[1] & CAN_ERR_CRTL_TX_WARNING) ||
> > +			(cf->data[1] & CAN_ERR_CRTL_RX_WARNING))
> > +			dev->can.state = CAN_STATE_ERROR_WARNING;
> > +
> > +		if ((cf->data[1] & CAN_ERR_CRTL_TX_PASSIVE) ||
> > +			(cf->data[1]&CAN_ERR_CRTL_RX_PASSIVE))
> 
> s/&/ & /
> 
> > +			dev->can.state = CAN_STATE_ERROR_PASSIVE;
> > +	}
> 
> Also please update the stats accordingly:
These are simple counts for how often the conditions occurred? They
count when the respective state is entered? When a node recovers from
bus off does that count as entering error passive?
> 
> 	can_stats.bus_off++;
> 	can_stats.error_warning++
> 	can_stats.error_passive++
> 
> Apart from that, the state handling is rather basic but totaly
> sufficient. Would be nice if you could show the state handling
> and bus-off recovery by reporting the output of "$ candump -td -e
> any,0:0,#FFFFFFFF" while sending messages to the device ...
> 
> 1. without cable connected (entering error passive)
> 2. with short-circuited CAN high and low (entering bus-off)

$ sudo ip link set can0 up type can bitrate 250000
$ cansequence can0 -p
$ candump -td -e can0,0:0,#FFFFFFFF 1>can.log

# CAN node transmitting normally
 (000.000000)  can0  002   [1]  00
...
 (000.000006)  can0  002   [1]  68
# CAN node is disconnected from bus
 (000.040973)  can0  20000004   [8]  00 20 00 00 00 00 80 00
ERRORFRAME
	controller-problem{tx-error-passive}
	error-counter-tx-rx{{128}{0}}
 (007.437011)  can0  002   [1]  69
...
 (000.000991)  can0  002   [1]  B3
# CAN node is reconnected to bus
 (000.000008)  can0  20000004   [8]  00 00 00 00 00 00 00 00
ERRORFRAME
	controller-problem{}
 (000.000004)  can0  002   [1]  B4
...
 (000.000003)  can0  002   [1]  D3
# CAN node is disconnected from bus
 (000.062975)  can0  20000004   [8]  00 20 00 00 00 00 80 00
ERRORFRAME
	controller-problem{tx-error-passive}
	error-counter-tx-rx{{128}{0}}
# short added between CAN-High to CAN-Low
 (005.593023)  can0  20000040   [8]  00 00 00 00 00 00 00 0E
ERRORFRAME
	bus-off
	error-counter-tx-rx{{0}{14}}
 (000.260982)  can0  20000100   [8]  00 00 00 00 00 00 E8 00
ERRORFRAME
	restarted-after-bus-off
	error-counter-tx-rx{{232}{0}}
 (000.526024)  can0  20000040   [8]  00 00 00 00 00 00 00 7D
ERRORFRAME
	bus-off
	error-counter-tx-rx{{0}{125}}
 (001.834994)  can0  20000100   [8]  00 00 00 00 00 00 F0 00
ERRORFRAME
	restarted-after-bus-off
	error-counter-tx-rx{{240}{0}}
 (000.523992)  can0  20000040   [8]  00 00 00 00 00 00 00 80
ERRORFRAME
	bus-off
	error-counter-tx-rx{{0}{128}}
 (001.835013)  can0  20000100   [8]  00 00 00 00 00 00 F8 00
ERRORFRAME
	restarted-after-bus-off
	error-counter-tx-rx{{248}{0}}
 (000.524981)  can0  20000004   [8]  00 00 00 00 00 00 28 00
ERRORFRAME
	controller-problem{}
	error-counter-tx-rx{{40}{0}}
 (000.086006)  can0  20000040   [8]  00 00 00 00 00 00 00 7C
ERRORFRAME
	bus-off
	error-counter-tx-rx{{0}{124}}
# The short between CAN-High and CAN-Low is removed
 (000.525000)  can0  20000100   [8]  00 00 00 00 00 00 80 00
ERRORFRAME
	restarted-after-bus-off
	error-counter-tx-rx{{128}{0}}
 (002.702998)  can0  002   [1]  D4
...
 (000.000003)  can0  002   [1]  ED
# CAN node is reconnected to bus
 (000.000007)  can0  20000004   [8]  00 08 00 00 00 00 6E 00
ERRORFRAME
	controller-problem{tx-error-warning}
	error-counter-tx-rx{{110}{0}}
 (000.000003)  can0  002   [1]  EE
...
 (000.000990)  can0  002   [1]  60
 (000.000008)  can0  20000004   [8]  00 00 00 00 00 00 00 00
ERRORFRAME
	controller-problem{}
 (000.000004)  can0  002   [1]  61
 (000.000004)  can0  002   [1]  62
...

Thank you for your time,
Max Schneider.


