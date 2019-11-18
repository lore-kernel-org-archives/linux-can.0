From: Sean Nyekjaer <sean@geanix.com>
Subject: Re: [PATCH 1/3] can: flexcan: fix deadlock when using self wakeup
Date: Mon, 18 Nov 2019 09:21:45 +0100
Message-ID: <12e03487-d468-c009-72c7-88804e87e256@geanix.com>
References: <20191115050032.25928-1-qiangqing.zhang@nxp.com>
 <9870ec21-b664-522e-e0df-290ab56fbb32@geanix.com>
 <DB7PR04MB4618220095E1F844A44DB480E64D0@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <16a0aa7b-875e-8dd9-085c-3341d3f1ac51@geanix.com>
 <DB7PR04MB461895F57FD4F360A723D2FAE64D0@DB7PR04MB4618.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <DB7PR04MB461895F57FD4F360A723D2FAE64D0@DB7PR04MB4618.eurprd04.prod.outlook.com>
Content-Language: en-US-large
Sender: netdev-owner@vger.kernel.org
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "mkl@pengutronix.de" <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
List-Id: linux-can.vger.kernel.org



On 18/11/2019 09.04, Joakim Zhang wrote:
>>>> Hi Joakim and Marc
>>>>
>>>> We have quite a few devices in the field where flexcan is stuck in Stop-Mode.
>>>> We do not have the possibility to cold reboot them, and hot reboot
>>>> will not get flexcan out of stop-mode.
>>>> So flexcan comes up with:
>>>> [  279.444077] flexcan: probe of 2090000.flexcan failed with error
>>>> -110 [  279.501405] flexcan: probe of 2094000.flexcan failed with
>>>> error -110
>>>>
>>>> They are on, de3578c198c6 ("can: flexcan: add self wakeup support")
>>>>
>>>> Would it be a solution to add a check in the probe function to pull
>>>> it out of stop-mode?
>>>
>>> Hi Sean,
>>>
>>> Soft reset cannot be applied when clocks are shut down in a low power mode.
>> The module should be first removed from low power mode, and then soft reset
>> can be applied.
>>> And exit from stop mode happens when the Stop mode request is removed,
>> or when activity is detected on the CAN bus and the Self Wake Up mechanism is
>> enabled.
>>>
>>> So from my point of view, we can add a check in the probe function to
>>> pull it out of stop mode, since controller actually could be stuck in stop mode
>> if suspend/resume failed and users just want a warm reset for the system.
>>
>> Exactly what I thought could be done :)
>>
>>>
>>> Could you please tell me how can I generate a warm reset? AFAIK, both
>> "reboot" command put into prompt and RST KEY in our EVK board all play a role
>> of cold reset.
>>
>> Warm reset is just `reboot` :-) Cold is poweroff...
> 
> I add the code flexcan_enter_stop_mode(priv) at the end of the probe function, 'reboot' the system directly after system active.
> However, I do not meet the probe error, it can probe successfully. Do you know the reason?

You will have to get it in the deadlock situation first :)

This can be achieved by using de3578c198c6 and sending can messages to 
both can interfaces while calling suspend.

/Sean
