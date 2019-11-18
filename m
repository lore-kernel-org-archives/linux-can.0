From: Sean Nyekjaer <sean@geanix.com>
Subject: Re: [PATCH 1/3] can: flexcan: fix deadlock when using self wakeup
Date: Mon, 18 Nov 2019 08:52:57 +0100
Message-ID: <16a0aa7b-875e-8dd9-085c-3341d3f1ac51@geanix.com>
References: <20191115050032.25928-1-qiangqing.zhang@nxp.com>
 <9870ec21-b664-522e-e0df-290ab56fbb32@geanix.com>
 <DB7PR04MB4618220095E1F844A44DB480E64D0@DB7PR04MB4618.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <DB7PR04MB4618220095E1F844A44DB480E64D0@DB7PR04MB4618.eurprd04.prod.outlook.com>
Content-Language: en-US-large
Sender: netdev-owner@vger.kernel.org
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "mkl@pengutronix.de" <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
List-Id: linux-can.vger.kernel.org



On 18/11/2019 08.05, Joakim Zhang wrote:
> 
>> -----Original Message-----
>> From: linux-can-owner@vger.kernel.org <linux-can-owner@vger.kernel.org>
>> On Behalf Of Sean Nyekjaer
>> Sent: 2019年11月15日 17:08
>> To: Joakim Zhang <qiangqing.zhang@nxp.com>; mkl@pengutronix.de
>> Cc: linux-can@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>;
>> netdev@vger.kernel.org
>> Subject: Re: [PATCH 1/3] can: flexcan: fix deadlock when using self wakeup
>>
>>
>>
>> On 15/11/2019 06.03, Joakim Zhang wrote:
>>> From: Sean Nyekjaer <sean@geanix.com>
>>>
>>> When suspending, when there is still can traffic on the interfaces the
>>> flexcan immediately wakes the platform again. As it should :-). But it
>>> throws this error msg:
>>> [ 3169.378661] PM: noirq suspend of devices failed
>>>
>>> On the way down to suspend the interface that throws the error message
>>> does call flexcan_suspend but fails to call flexcan_noirq_suspend.
>>> That means the flexcan_enter_stop_mode is called, but on the way out
>>> of suspend the driver only calls flexcan_resume and skips
>>> flexcan_noirq_resume, thus it doesn't call flexcan_exit_stop_mode.
>>> This leaves the flexcan in stop mode, and with the current driver it
>>> can't recover from this even with a soft reboot, it requires a hard reboot.
>>>
>>> This patch can fix deadlock when using self wakeup, it happenes to be
>>> able to fix another issue that frames out-of-order in first IRQ
>>> handler run after wakeup.
>>>
>>> In wakeup case, after system resume, frames received out-of-order,the
>>> problem is wakeup latency from frame reception to IRQ handler is much
>>> bigger than the counter overflow. This means it's impossible to sort
>>> the CAN frames by timestamp. The reason is that controller exits stop
>>> mode during noirq resume, then it can receive the frame immediately.
>>> If noirq reusme stage consumes much time, it will extend interrupt
>>> response time.
>>>
>>> Fixes: de3578c198c6 ("can: flexcan: add self wakeup support")
>>> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
>>> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
>>
>> Hi Joakim and Marc
>>
>> We have quite a few devices in the field where flexcan is stuck in Stop-Mode.
>> We do not have the possibility to cold reboot them, and hot reboot will not get
>> flexcan out of stop-mode.
>> So flexcan comes up with:
>> [  279.444077] flexcan: probe of 2090000.flexcan failed with error -110
>> [  279.501405] flexcan: probe of 2094000.flexcan failed with error -110
>>
>> They are on, de3578c198c6 ("can: flexcan: add self wakeup support")
>>
>> Would it be a solution to add a check in the probe function to pull it out of
>> stop-mode?
> 
> Hi Sean,
> 
> Soft reset cannot be applied when clocks are shut down in a low power mode. The module should be first removed from low power mode, and then soft reset can be applied.
> And exit from stop mode happens when the Stop mode request is removed, or when activity is detected on the CAN bus and the Self Wake Up mechanism is enabled.
> 
> So from my point of view, we can add a check in the probe function to pull it out of stop mode, since controller actually could be stuck in stop mode if suspend/resume failed and users just
> want a warm reset for the system.

Exactly what I thought could be done :)

> 
> Could you please tell me how can I generate a warm reset? AFAIK, both "reboot" command put into prompt and RST KEY in our EVK board all play a role of cold reset.

Warm reset is just `reboot` :-) Cold is poweroff...

/Sean

> 
> Best Regards,
> Joakim Zhang
>> /Sean
