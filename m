From: Andreas Larsson <andreas@gaisler.com>
Subject: Re: [PATCH v8] can: grcan: Add device driver for GRCAN and GRHCAN
 cores
Date: Wed, 14 Nov 2012 16:07:25 +0100
Message-ID: <50A3B3AD.5080507@gaisler.com>
References: <509C47CB.8060701@pengutronix.de> <1352732256-12712-1-git-send-email-andreas@gaisler.com> <50A2B88A.3040609@pengutronix.de> <50A34D49.2070908@gaisler.com> <50A359A1.30700@pengutronix.de> <50A37A5B.8060808@gaisler.com> <50A37F0A.7050204@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from vsp-authed02.binero.net ([195.74.38.226]:30921 "HELO
	vsp-authed-03-02.binero.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1161007Ab2KNPHc (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 14 Nov 2012 10:07:32 -0500
In-Reply-To: <50A37F0A.7050204@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, software@gaisler.com, Wolfgang Grandegger <wg@grandegger.com>, devicetree-discuss@lists.ozlabs.org

On 2012-11-14 12:22, Marc Kleine-Budde wrote:
> On 11/14/2012 12:02 PM, Andreas Larsson wrote:
>> On 2012-11-14 09:43, Marc Kleine-Budde wrote:
>>> Handle incoming events (rx or tx-complete) until:
>>> a) number of handled events == budget
>>> or
>>> b) no more events pending.
>>>
>>>      while (work_done < budget && interrupts_pending()) {
>>>          work_done += handle_rx(budget - work_done);
>>>          work_done += handle_tx(budget - work_done);
>>>      }
>>
>> That could starve handle_tx completely though under high rx pressure,
>> but I can prevent that by making sure that half of the budget is held
>> back in the first call to handle_rx.
>
> What about making the budget big enough to handle both rx and tx in one
> napi call. Have a look at the marvell driver [1] for inspiration.

Even if I set the budget to something large, unless I limit the rx side in some 
way it could go on multiple rounds around the circular buffer until it have used 
all the budget. So in some way or another, grcan_receive must be hindered from 
using all the budget.

Sorry, but I am not sure what aspect of the marvell driver poll handling you 
want me to mimic. Without having analyzed exactly how the queueing works yet, it 
seems to make sure that every function that is called from the poll function 
gets ample opportunity to do work by not letting one function hogging all the 
budget. If you want me to mimic it in the aspect of doing work in series of 16 
or something like that, sure, no problem. If it is something else you want to 
point to, please let me know what.


The simplest way to make sure that both tx and rx gets to run is to take 
inspiration from the ethoc driver [1] and just let the tx side get just as much 
budget as the rx side and be done with it. With the echo frames for can, the 
budget should be halved for each I guess to make sure no more frames are 
delivered than the budget, but apart from that I don't see the problem with such 
a simple approach.

static int ethoc_poll(struct napi_struct *napi, int budget)
{
	struct ethoc *priv = container_of(napi, struct ethoc, napi);
	int rx_work_done = 0;
	int tx_work_done = 0;

	rx_work_done = ethoc_rx(priv->netdev, budget);
	tx_work_done = ethoc_tx(priv->netdev, budget);

	if (rx_work_done < budget && tx_work_done < budget) {
		napi_complete(napi);
		ethoc_enable_irq(priv, INT_MASK_TX | INT_MASK_RX);
	}

	return rx_work_done;
}

[1]
http://lxr.free-electrons.com/source/drivers/net/ethernet/ethoc.c#L598

Cheers,
Andreas

