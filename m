From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: RFC: improve and consolidate state change and bus-off handling
Date: Fri, 02 Dec 2011 11:04:23 +0100
Message-ID: <4ED8A2A7.4060902@grandegger.com>
References: <4ED8948E.5090806@grandegger.com> <4ED89D50.9040401@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:36541 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753927Ab1LBKEd (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 2 Dec 2011 05:04:33 -0500
In-Reply-To: <4ED89D50.9040401@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: SocketCAN Core Mailing List <socketcan-core@lists.berlios.de>, Linux-can Mailing List <linux-can@vger.kernel.org>

On 12/02/2011 10:41 AM, Marc Kleine-Budde wrote:
> On 12/02/2011 10:04 AM, Wolfgang Grandegger wrote:
>> Hello,
>>
>> as you might know, our handling of CAN state changes and bus-off is
>> not consistent, weak or even incorrect. Therefore I'm making an effort
>> to improve, consolidate and *unify* it. Most things are straight-
>> forward, but others need more attention and especially for the bus-off
>> recovery I would appreciate some CAN expert advice (more below). I have
>> already some patches implementing:
>>
>> - Add missing do_get_berr_counter() callbacks (for ti_hecc, etc.).
> 
> +1
> 
>> - Add error counters to the data fields 6..7 of *any* CAN error message
>>   automatically in alloc_can_err_skb():
>>
>>        if (priv->do_get_berr_counter) {
>>                struct can_berr_counter bec;
>>
>>                priv->do_get_berr_counter(dev, &bec);
>>                (*cf)->data[6] = bec.txerr;
>>                (*cf)->data[7] = bec.rxerr;
>>        }
> 
> What about some not directly connected devices like the mcp251x. At
> least the mcp2515 driver (which is not mainline, though) needs a spi
> transfer for that.
> 
> Do we need a flag in the driver to indicate not to read the berr_counter?

We could introduce a return code for the do_get_berr_counter callback
and handle it.

>> - Allow state changes going down including "back to error active":
>>
>>   Therefore I added:
>>
>>     $ cat include/linux/can/error.h
>>     ...
>>     #define CAN_ERR_STATE_CHANGE 0x00000200U /* CAN error state change / data[1] */
>>     ...
>>     #define CAN_ERR_CRTL_ACTIVE      0x40 /* recovered to error active state */
>>  
>>   For any state change the CAN_ERR_STATE_CHANGE will be set in the
>>   can_id. If the state gets worse, CAN_ERR_CRTL is set as usual
>>   also for backward compatibility. The state change management will
>>   be done by a common "can_change_state()" function doing all the bit
> 
> yeah! common function! +1
> 
>>   settings and counter increments. For the SJA1000 "candump -e" will
>>   then report for recovery from the error passive state (no cable):
>>
>>     can0  20000204  [8] 00 08 00 00 00 00 60 00   ERRORFRAME
>> 	controller-problem{tx-error-warning}
>> 	state-change{tx-error-warning}
>> 	error-counter-tx-rx{{96}{0}}
>>     can0  20000204  [8] 00 30 00 00 00 00 80 00   ERRORFRAME
>> 	controller-problem{tx-error-passive}
>> 	state-change{tx-error-passive}
>> 	error-counter-tx-rx{{128}{0}}
>>     can0  124  [3] 12 34 56
>>     ...
>>     can0  124  [3] 12 34 56
>>     can0  20000200  [8] 00 08 00 00 00 00 7F 00   ERRORFRAME
>> 	state-change{tx-error-warning}
>> 	error-counter-tx-rx{{127}{0}}
>>     can0  124  [3] 12 34 56
>>     ...
>>     can0  124  [3] 12 34 56
>>     can0  20000200  [8] 00 40 00 00 00 00 5F 00   ERRORFRAME
>> 	state-change{back-to-error-active}
>> 	error-counter-tx-rx{{95}{0}}
>>  
>>    Updating all drivers correctly is a challenge, especially because I
>>    do not have all hardware. Help and comments are appreciated.
> 
> I can test the at91_can, flexcan and if we're lucky we've a mcp251x in
> the office.

Good, I can test here MSCAN/MPC5200 and maybe MPC51xx , CC770/I82527 on
my old MPC8xx board and SJA1000. And maybe also Flexcan on a i.MX28.

>> - Bus-off recovery:
>>
>>   Currently, I think, we do not handle bus-off recovery correctly for
>>   most controllers. We brute-force stop and restart the controller.
>>   The controller will do the recovery cycle anyway and we may send
>>   messages to early. Instead the software should handle the bus-off
>>   recovery cycle as shown below:
>>
>>   * bus-off happens
>>     - call netif_stop_queue() and maybe disable interrupts
>>
>>   * automatic or manual restart is done
>>     - trigger bus-off recovery sequence by resetting the init bit
>>       (on SJA1000) and maybe re-enable the interrupts
>>     - await the controller going back to error-active state
>>       (signaled via interrupt).
> 
> I'm not sure if all controllers signal correctly that they are back in
> error active. My observation is that bus off handling is a bit like
> climbing the mount Everest, the air is quite thin and things can lock up
> quite fast.

I know, unfortunately. But SJA1000, CC770/i82527 and MSCAN behave like
expected and for the controller doing the recovery automatically in
hardware, like the at91?, we need to await back to error active anyway.
Anyway, we simple do not touch controllers with magic bus-off handling.

> 
>>     - call netif_wake_queue()
>>
>>   Here is a "candump -e" output for the SJA1000 (with delta times)
>>
>>     (009.832477)  can0  20000204  [8] 00 30 00 00 00 00 88 00   ERRORFRAME
>> 	controller-problem{tx-error-passive}
>> 	state-change{tx-error-passive}
>> 	error-counter-tx-rx{{136}{0}}
>>     (000.000804)  can0  20000240  [8] 00 00 00 00 00 00 7F 00   ERRORFRAME
>> 	bus-off
>> 	state-change{}
>> 	error-counter-tx-rx{{127}{0}}
>>     (000.099795)  can0  20000100  [8] 00 00 00 00 00 00 7F 00   ERRORFRAME
>> 	restarted-after-bus-off
>> 	error-counter-tx-rx{{127}{0}}
>>     (000.003061)  can0  20000200  [8] 00 40 00 00 00 00 00 00   ERRORFRAME
>> 	state-change{back-to-error-active}
>>
>>    Before doing all the necessary code changes, which are not always
>>    trivial I ask: Would that be the correct bus-off handling???
> 
> However if hardware permits the described steps sound reasonable (from
> my non CAN expert point of view).

On the SJA1000 and i82527 I realized that the hardware does the bus-off
recovery cycle anyway, even if you stop and restart the controller.

Patches coming soon...

Wolfgang.
