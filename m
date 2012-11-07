From: Andreas Larsson <andreas@gaisler.com>
Subject: Re: [PATCH v3] can: grcan: Add device driver for GRCAN and GRHCAN
 cores
Date: Wed, 07 Nov 2012 08:32:36 +0100
Message-ID: <509A0E94.1040103@gaisler.com>
References: <5087EDBF.2040108@gaisler.com> <1351588017-14357-1-git-send-email-andreas@gaisler.com> <508FA6D3.9000809@grandegger.com> <508FFF50.8050900@gaisler.com> <50911EB6.1070105@grandegger.com> <509152D5.2050701@gaisler.com> <50918830.9040601@grandegger.com> <50929E7F.1090205@gaisler.com> <509786C0.9070703@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from vsp-authed02.binero.net ([195.74.38.226]:40462 "HELO
	vsp-authed-01-02.binero.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751053Ab2KGHdM (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 7 Nov 2012 02:33:12 -0500
In-Reply-To: <509786C0.9070703@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, devicetree-discuss@lists.ozlabs.org, software@gaisler.com

On 11/05/2012 10:28 AM, Wolfgang Grandegger wrote:
> On 11/01/2012 05:08 PM, Andreas Larsson wrote:
>> On 2012-10-31 21:21, Wolfgang Grandegger wrote:
...
>> Yes, the hardware becomes error active after having monitored 11
>> consecutive recessive bits on the bus 128 times (as allowed by the 2.0
>> CAN spec). There is no way of turning this off, so to conform to the
>> normal linux procedure of not doing this, I shut down the device on bus
>> off interrupt.
>
> This should be handled in the following way:
>
> 1. If priv->can.restart_ms == 0: do *not* allow automatic restart
>     That's what you alredy have implemented.
>
> 2. If priv->can.restart_ms  > 0 : do allow automatic restart.
>     This requires to send CAN_ERR_RESTARTED when the system goes
>     bus-on. See at91_can and mcp251x as example.
>
>> In addition I have thrown out the arbitration lost error frame
>> generation as arbitration errors can not be singled out. The TXLOSS
>> interrupt might be due to arbitration error, but is also triggered in
>> great numbers when there is no one else on the can bus or when there is
>> a problem with the hardware interface or the bus itself.
>>
>> This is how things look currently with no one else on the bus:
>> ~ # cansend can0 123#45
>>    can0  20000004  [8] 00 08 00 00 00 00 60 00   ERRORFRAME
>>          controller-problem{tx-error-warning}
>>          error-counter-tx-rx{{96}{0}}
>>    can0  20000004  [8] 00 20 00 00 00 00 80 00   ERRORFRAME
>>          controller-problem{tx-error-passive}
>>          error-counter-tx-rx{{128}{0}}
>> ~ #
>>
>> And this is how it looks with a short-circuited bus:
>> ~ # cansend can0 123#45
>>    can0  20000004  [8] 00 08 00 00 00 00 90 00   ERRORFRAME
>>          controller-problem{tx-error-warning}
>>          error-counter-tx-rx{{144}{0}}
>>    can0  20000004  [8] 00 20 00 00 00 00 98 00   ERRORFRAME
>>          controller-problem{tx-error-passive}
>>          error-counter-tx-rx{{152}{0}}
>>    can0  20000040  [8] 00 00 00 00 00 00 00 00   ERRORFRAME
>>          bus-off
>> ~ #
>
> This looks good now. Just the automatic restart is missing as described
> above.

When doing the bus_off handling as in at91_can, on a short-circuited bus with 
restart-ms != 0, the result of a cansend is an endless and frequent stream of

   can0  20000004  [8] 00 20 00 00 00 00 88 00   ERRORFRAME
         controller-problem{tx-error-passive}
         error-counter-tx-rx{{136}{0}}
   can0  20000040  [8] 00 00 00 00 00 00 80 00   ERRORFRAME
         bus-off
         error-counter-tx-rx{{128}{0}}
   can0  20000104  [8] 00 00 00 00 00 00 10 00   ERRORFRAME
         controller-problem{}
         restarted-after-bus-off
         error-counter-tx-rx{{16}{0}}
   can0  20000004  [8] 00 10 00 00 00 00 57 80   ERRORFRAME
         controller-problem{rx-error-passive}
         error-counter-tx-rx{{87}{128}}
   can0  20000040  [8] 00 00 00 00 00 00 80 00   ERRORFRAME
         bus-off
         error-counter-tx-rx{{128}{0}}
   can0  20000104  [8] 00 00 00 00 00 00 08 00   ERRORFRAME
         controller-problem{}
         restarted-after-bus-off
         error-counter-tx-rx{{8}{0}}
   can0  20000004  [8] 00 10 00 00 00 00 57 80   ERRORFRAME
         controller-problem{rx-error-passive}
         error-counter-tx-rx{{87}{128}}
   can0  20000040  [8] 00 00 00 00 00 00 80 00   ERRORFRAME
         bus-off
         error-counter-tx-rx{{128}{0}}
   can0  20000104  [8] 00 00 00 00 00 00 08 00   ERRORFRAME
         controller-problem{}
         restarted-after-bus-off
         error-counter-tx-rx{{8}{0}}
   [...]

as the grcan core continues to try to resend the frame when it comes back again. 
To mimic the sja1000 behavior as closely as possible, I guess that the driver 
also would need to make sure that the tx and rx buffers are cleaned out so that 
this resending does not happen, right?

To do this, the hardware needs to be stopped anyway. Therefore, in my opinion it 
is much simpler to handle it as it is in v5: always shut down the hardware on 
bus off and, in the case of a non-zero restart_ms, let restart timer trigger 
can_restart that will call grcan_set_mode which will restart the hardware with 
empty buffers. Do you see any problems with this approach?

The added benefit of this approach is that then the actual millisecond value of 
the non-zero restart_ms is used instead of having the hardware quickly restart 
regardless of the value.

In any case I have some other fixes for v6.

Cheers,
Andreas
