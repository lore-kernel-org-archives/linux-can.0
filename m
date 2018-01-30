From: Anssi Hannula <anssi.hannula@bitwise.fi>
Subject: Re: [PATCH] can: xilinx_can: use can_change_state()
Date: Tue, 30 Jan 2018 10:21:14 +0200
Message-ID: <c5e876f1-47e0-c086-53d1-51c3fe1453d1@bitwise.fi>
References: <151722269077.27204.8452699005718607415@maxwell>
 <20180129164953.6596-1-anssi.hannula@bitwise.fi>
 <151724820628.13021.14620062197722880179@maxwell>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.bitwise.fi ([109.204.228.163]:41224 "EHLO mail.bitwise.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751832AbeA3IVS (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 30 Jan 2018 03:21:18 -0500
In-Reply-To: <151724820628.13021.14620062197722880179@maxwell>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <andri.yngvason@marel.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can @ vger . kernel . org" <linux-can@vger.kernel.org>, Michal Simek <michal.simek@xilinx.com>

On 29.1.2018 19:50, Andri Yngvason wrote:
> Hi Anssi
Hi!

> I wasn't sure you knew about can_change_state(). I didn't mean to say that you
> _should_ use it, just that you could.

OK :)

> Quoting Anssi Hannula (2018-01-29 16:49:53)
>> Replace some custom code with a call to can_change_state().
>>
>> This subtly changes the error reporting behavior in some cases.
>>
>> Previously, if both RX and TX error counters indicated the same state,
>> and the status register agreed:
>> - if overall state is PASSIVE, report CAN_ERR_CRTL_RX_PASSIVE
>> - if overall state is WARNING, report CAN_ERR_CRTL_TX_WARNING or
>>   CAN_ERR_CRTL_RX_WARNING depending on which counter is higher.
> If you look at sja1000.c, you'll see that it does this:
> tx_state = txerr >= rxerr ? state : 0
> rx_state = txerr <= rxerr ? state : 0;
> can_change_state(dev, cf, tx_state, rx_state);
>
> Maybe something similar could work for this?

That would work, though with that we don't get the
(CAN_ERR_CRTL_RX_WARNING | CAN_ERR_CRTL_TX_WARNING) error anymore when
both RX and TX are at warning level (and same for passive), but just one
of them. But probably not many users care (just guessing here, though)
so maybe it is worth the large simplification.

The current xilinx_can code does not produce such an error either, after
all, it just similarly picks one of RX/TX based on error counters.

I'll try your suggestion today or tomorrow.

>> Previously, if status registers indicated a different state than the
>> worst state indicated by the RX/TX error counters (I have not observed
>> this to happen, though):
>> - if status register says PASSIVE, report CAN_ERR_CRTL_RX_PASSIVE if
>>   RX error counter indicates PASSIVE as well, otherwise report
>>   CAN_ERR_CRTL_TX_PASSIVE
>> - if status register says WARNING, report CAN_ERR_CRTL_TX_WARNING
>>   or CAN_ERR_CRTL_RX_WARNING depending on which counter is higher.
>>
>> After this commit, in both of the above scenarios:
>> - if overall state is PASSIVE, report
>>   CAN_ERR_CRTL_RX_PASSIVE | CAN_ERR_CRTL_TX_PASSIVE
>> - if overall state is WARNING, report
>>   CAN_ERR_CRTL_RX_WARNING | CAN_ERR_CRTL_TX_WARNING.
>>
>> Tested with the integrated CAN on Zynq-7000 SoC.
>>
> Anyway, the use of this API function is a somewhat superfluous issue, so I think
> we shouldn't worry too much about it.
>

-- 
Anssi Hannula / Bitwise Oy
+358503803997

