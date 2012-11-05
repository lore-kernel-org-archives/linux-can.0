From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v3] can: grcan: Add device driver for GRCAN and GRHCAN
 cores
Date: Mon, 05 Nov 2012 10:28:32 +0100
Message-ID: <509786C0.9070703@grandegger.com>
References: <5087EDBF.2040108@gaisler.com> <1351588017-14357-1-git-send-email-andreas@gaisler.com> <508FA6D3.9000809@grandegger.com> <508FFF50.8050900@gaisler.com> <50911EB6.1070105@grandegger.com> <509152D5.2050701@gaisler.com> <50918830.9040601@grandegger.com> <50929E7F.1090205@gaisler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:46518 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876Ab2KEJ2l (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 5 Nov 2012 04:28:41 -0500
In-Reply-To: <50929E7F.1090205@gaisler.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andreas Larsson <andreas@gaisler.com>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, devicetree-discuss@lists.ozlabs.org, software@gaisler.com

On 11/01/2012 05:08 PM, Andreas Larsson wrote:
> On 2012-10-31 21:21, Wolfgang Grandegger wrote:
...
>>>> This is most probably an ack slot bus error similar to. You seem not to
>>>> handle bus errors and it's not a controller problem as the state did
>>>> not
>>>> change.
>>>
>>> No, the hardware has no support for can-bus error reporting.
>>
>> OK, but why is CAN_ERR_CRTL set?
> 
> Maybe I am just confused with the terminology. What I mean is that the
> only error reporting that is supported by the hardware (apart from AMBA
> bus errors, but that is unrelated to the discussion) is the error
> counter related errors.

We have to distinguish between state changes, bus error and other
errors. To make that clear, I have added an (old) annotated output from
the SJA1000, which is the defacto reference. Bus error reporting is
enabled and no cable is connected. Watch the TX error count increasing
and how the state changes:

  $ ./candump -e 0xffff any
  can0  20000088  [8] 00 00 80 19 00 08 00 00   ERRORFRAME
               \             \  \-- ACK slot.
                \             \-- error occured on transmission
                 \-- Bus-error | Protocol violations (data[2], data[3]).

  can0  20000088  [8] 00 00 80 19 00 10 00 00   ERRORFRAME
  can0  20000088  [8] 00 00 80 19 00 18 00 00   ERRORFRAME
  can0  20000088  [8] 00 00 80 19 00 20 00 00   ERRORFRAME
  can0  20000088  [8] 00 00 80 19 00 28 00 00   ERRORFRAME
  can0  20000088  [8] 00 00 80 19 00 30 00 00   ERRORFRAME
  can0  20000088  [8] 00 00 80 19 00 38 00 00   ERRORFRAME
  can0  20000088  [8] 00 00 80 19 00 40 00 00   ERRORFRAME
  can0  20000088  [8] 00 00 80 19 00 48 00 00   ERRORFRAME
  can0  20000088  [8] 00 00 80 19 00 50 00 00   ERRORFRAME
  can0  20000088  [8] 00 00 80 19 00 58 00 00   ERRORFRAME
  can0  2000008C  [8] 00 08 80 19 00 60 00 00   ERRORFRAME
               \          \--  reached warning level for TX errors
                \-- | Controller problems (see data[1]).

  can0  20000088  [8] 00 00 80 19 00 68 00 00   ERRORFRAME
  can0  20000088  [8] 00 00 80 19 00 70 00 00   ERRORFRAME
  can0  20000088  [8] 00 00 80 19 00 78 00 00   ERRORFRAME
  can0  2000008C  [8] 00 20 80 19 00 80 00 00   ERRORFRAME
               \          \--   reached passive level for TX errors
                \-- | Controller problems (see data[1]).

  can0  20000088  [8] 00 00 80 19 00 80 00 00   ERRORFRAME
                                      \  \-- RXerror count
                                       \-- TXerror count

  can0  20000088  [8] 00 00 80 19 00 80 00 00   ERRORFRAME
  ...
  can0  20000088  [8] 00 00 80 19 00 80 00 00   ERRORFRAME


> From what I can see CAN_ERR_BUSERROR is not reported in the error
> counter related cases by the other drivers I looked in. The grcan
> hardware does not support reporting errors like form and stuff errors
> and which bits the errors occured in and the like.

CAN controller normally report state changes and some, like the SJA1000,
also individual bus errors including more information about the cause of
the problem. That information is not available for your controller and
therefore it does not make sense to report empty bus errors to the app.

> Have I understood it correctly that reporting about protocol errors like
> that is what it is to support CAN_CTRLMODE_BERR_REPORTING? This seems to
> be the case but the janz-ican3 driver connects
> CAN_CTRLMODE_BERR_REPORTING to all error frame reporting, so I am not
> entirely sure.

The "berr-reporting" has been introduced some time ago, because the
bus-error rate can be quite high and may hang the system, especially
low-end systems. On the SJA1000 or Flexcan this can be simply achieved
by enabling bus-error interrupts. Signaling of state changes should
always work, though.

>>>> http://lxr.linux.no/#linux+v3.6.4/drivers/net/can/flexcan.c#L353
>>>>
>>>>>     can0  20000004  [8] 00 20 00 00 00 00 88 00   ERRORFRAME
>>>>>           controller-problem{tx-error-passive}
>>>>>           error-counter-tx-rx{{136}{0}}
>>>>
>>>> OK, a state change to error passive. The device seems not to report
>>>> changes to error warning.
>>>
>>> No, there is no interrupts or anything that alert about the error
>>> states. That is why I set the sate based on the error counters in the
>>> error handler.
>>
>> Who does trigger the message above?
> 
> Sorry for confusing the matter. There is no interrupt for error warning,
> but there are interrupts for increases of the error counters and the
> other state changes. So to be able to report on error warning I check
> the error counters and do it manually.

OK.

>> Obviously the device restarts automatically after bus-off. Can this be
>> switched off. The normal procedure is to call "ip ... type can restart"
>> or to set "restart-ms" for automatic restart after the specified delay.
> 
> Yes, the hardware becomes error active after having monitored 11
> consecutive recessive bits on the bus 128 times (as allowed by the 2.0
> CAN spec). There is no way of turning this off, so to conform to the
> normal linux procedure of not doing this, I shut down the device on bus
> off interrupt.

This should be handled in the following way:

1. If priv->can.restart_ms == 0: do *not* allow automatic restart
   That's what you alredy have implemented.

2. If priv->can.restart_ms  > 0 : do allow automatic restart.
   This requires to send CAN_ERR_RESTARTED when the system goes
   bus-on. See at91_can and mcp251x as example.

> In addition I have thrown out the arbitration lost error frame
> generation as arbitration errors can not be singled out. The TXLOSS
> interrupt might be due to arbitration error, but is also triggered in
> great numbers when there is no one else on the can bus or when there is
> a problem with the hardware interface or the bus itself.
> 
> This is how things look currently with no one else on the bus:
> ~ # cansend can0 123#45
>   can0  20000004  [8] 00 08 00 00 00 00 60 00   ERRORFRAME
>         controller-problem{tx-error-warning}
>         error-counter-tx-rx{{96}{0}}
>   can0  20000004  [8] 00 20 00 00 00 00 80 00   ERRORFRAME
>         controller-problem{tx-error-passive}
>         error-counter-tx-rx{{128}{0}}
> ~ #
> 
> And this is how it looks with a short-circuited bus:
> ~ # cansend can0 123#45
>   can0  20000004  [8] 00 08 00 00 00 00 90 00   ERRORFRAME
>         controller-problem{tx-error-warning}
>         error-counter-tx-rx{{144}{0}}
>   can0  20000004  [8] 00 20 00 00 00 00 98 00   ERRORFRAME
>         controller-problem{tx-error-passive}
>         error-counter-tx-rx{{152}{0}}
>   can0  20000040  [8] 00 00 00 00 00 00 00 00   ERRORFRAME
>         bus-off
> ~ #

This looks good now. Just the automatic restart is missing as described
above.

Wolfgang.
