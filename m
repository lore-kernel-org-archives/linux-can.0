From: Andreas Larsson <andreas@gaisler.com>
Subject: Re: [PATCH v3] can: grcan: Add device driver for GRCAN and GRHCAN
 cores
Date: Wed, 07 Nov 2012 13:55:26 +0100
Message-ID: <509A5A3E.4090505@gaisler.com>
References: <5087EDBF.2040108@gaisler.com> <1351588017-14357-1-git-send-email-andreas@gaisler.com> <508FA6D3.9000809@grandegger.com> <508FFF50.8050900@gaisler.com> <50911EB6.1070105@grandegger.com> <509152D5.2050701@gaisler.com> <50918830.9040601@grandegger.com> <50929E7F.1090205@gaisler.com> <509786C0.9070703@grandegger.com> <509A0E94.1040103@gaisler.com> <509A42D8.6030009@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from vsp-authed02.binero.net ([195.74.38.226]:58171 "HELO
	vsp-authed-03-02.binero.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754822Ab2KGMzn (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 7 Nov 2012 07:55:43 -0500
In-Reply-To: <509A42D8.6030009@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, devicetree-discuss@lists.ozlabs.org, software@gaisler.com

On 11/07/2012 12:15 PM, Wolfgang Grandegger wrote:
> On 11/07/2012 08:32 AM, Andreas Larsson wrote:
>> On 11/05/2012 10:28 AM, Wolfgang Grandegger wrote:
> ...
>>> This looks good now. Just the automatic restart is missing as described
>>> above.
>>
>> When doing the bus_off handling as in at91_can, on a short-circuited bus
>> with restart-ms != 0, the result of a cansend is an endless and frequent
>> stream of
>>
>>    can0  20000004  [8] 00 20 00 00 00 00 88 00   ERRORFRAME
>>          controller-problem{tx-error-passive}
>>          error-counter-tx-rx{{136}{0}}
>>    can0  20000040  [8] 00 00 00 00 00 00 80 00   ERRORFRAME
>>          bus-off
>>          error-counter-tx-rx{{128}{0}}
>>    can0  20000104  [8] 00 00 00 00 00 00 10 00   ERRORFRAME
>>          controller-problem{}
>>          restarted-after-bus-off
>>          error-counter-tx-rx{{16}{0}}
>>    can0  20000004  [8] 00 10 00 00 00 00 57 80   ERRORFRAME
>>          controller-problem{rx-error-passive}
>>          error-counter-tx-rx{{87}{128}}
>>    can0  20000040  [8] 00 00 00 00 00 00 80 00   ERRORFRAME
>>          bus-off
>>          error-counter-tx-rx{{128}{0}}
>>    can0  20000104  [8] 00 00 00 00 00 00 08 00   ERRORFRAME
>>          controller-problem{}
>>          restarted-after-bus-off
>>          error-counter-tx-rx{{8}{0}}
>>    can0  20000004  [8] 00 10 00 00 00 00 57 80   ERRORFRAME
>>          controller-problem{rx-error-passive}
>>          error-counter-tx-rx{{87}{128}}
>>    can0  20000040  [8] 00 00 00 00 00 00 80 00   ERRORFRAME
>>          bus-off
>>          error-counter-tx-rx{{128}{0}}
>>    can0  20000104  [8] 00 00 00 00 00 00 08 00   ERRORFRAME
>>          controller-problem{}
>>          restarted-after-bus-off
>>          error-counter-tx-rx{{8}{0}}
>>    [...]
>>
>> as the grcan core continues to try to resend the frame when it comes
>> back again. To mimic the sja1000 behavior as closely as possible, I
>> guess that the driver also would need to make sure that the tx and rx
>> buffers are cleaned out so that this resending does not happen, right?
>
> No, what you see is the normal behavior for automatic restart by the
> hardware. A bus-off recovery is *not* the same than a controller restart.

OK, if these automatic restarts are an OK behavior when restart_ms is non-zero I 
am happy with taking the at91_can approach to things.

Cheers,
Andreas

