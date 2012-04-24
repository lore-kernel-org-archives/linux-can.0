From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [RFC PATCH v2 1/2] can: add tx/rx LED trigger support
Date: Tue, 24 Apr 2012 08:46:29 +0200
Message-ID: <4F964C45.8010804@grandegger.com>
References: <1335214966-20478-1-git-send-email-fabio.baltieri@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:34409 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413Ab2DXGqc (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 24 Apr 2012 02:46:32 -0400
In-Reply-To: <1335214966-20478-1-git-send-email-fabio.baltieri@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Fabio Baltieri <fabio.baltieri@gmail.com>
Cc: linux-can@vger.kernel.org

Hi Fabio,

On 04/23/2012 11:02 PM, Fabio Baltieri wrote:
> This patch implements the functions to add two LED triggers, named
> <ifname>-tx and <ifname>-rx, to a canbus device driver.
> 
> Triggers are called from specific handlers by each CAN device driver and
> can be disabled altogether with a Kconfig option.
> 
> The implementation keeps the LED on when the interface is UP and blinks
> the LED on network activity at a configurable rate.
> 
> This only supports can-dev based drivers, as it uses some support field
> in the can_priv structure.
> 
> Supported drivers should call can_led_init(), can_led_exit() and
> can_led_event() as needed.
> 
> Supported events are:
> - CAN_LED_EVENT_OPEN: turn on tx/rx LEDs
> - CAN_LED_EVENT_STOP: turn off tx/rx LEDs
> - CAN_LED_EVENT_TX: trigger tx LED blink
> - CAN_LED_EVENT_RX: trigger tx LED blink
> 
> Signed-off-by: Fabio Baltieri <fabio.baltieri@gmail.com>
> ---
> 
> Hello again!
> 
> So, this is the v2 of my can-led patch. I reworked the whole code based on the
> v1 and all the comments from the list (thanks guys!).
> 
> This version takes a different approach and is just an implementation of three
> functions - can_led_{init,exit,event} - to easily add tx/rx led trigger
> support to a netlink-based canbus driver. An implementation on flexcan is on
> the 2/2.
> 
> Working principle:
> 
> - the driver register the triggers on probe, free on exit and add events for
>   open, close, tx, rx where appropriate
> - both LEDs stay off when device is down, on when device is up
> - each LED blinks for led_delay off + led_delay on on tx/rx event using a
>   kernel timer (well, that's actually the opposite to keep critical path
>   cleaner but don't tell anyone, k?).
> - new tx/rx packets don't retrigger the timer until the blink sequence is over,
>   so that on heavy traffic the LED keeps blinking at constate rate.  
> 
> Notes:
> 
> - I considered putting all structures in can_priv to skip a couple of kzallocs
>   as suggested by Oliver, but those pointers are actually useful to check if
>   triggers registered properly, so the code now uses an internal structure with
>   timer, state and name, and add just two pointers into struct can_dev.
> 
> - The blink timer is implemented as:
>   * keep on for delay_time
>   * turn off and retrigger the timer
>   * turn back on after delay
>   so that the hot-path only contains a switch-case, some checks and a mod_timer.
> 
> This is tested on an x86 with a custom usb-can interface and on a flexcan-based
> Freescale ARM board. I'll post some patch to implement support in other drivers
> if anyone is interested into testing this one.
> 
> Any comments?

I still think that the blinking support should go to the timer class to
avoid duplicated code. Any good reason against? Apart from that the
patches look good.

Wolfgang.
