From: Sean Nyekjaer <sean@geanix.com>
Subject: Re: [PATCH V2 2/4] can: flexcan: try to exit stop mode during probe
 stage
Date: Sun, 8 Dec 2019 11:47:55 +0100
Message-ID: <cdf11f66-92f5-7431-9e76-6a5c92eb4d91@geanix.com>
References: <20191127055334.1476-1-qiangqing.zhang@nxp.com>
 <20191127055334.1476-3-qiangqing.zhang@nxp.com>
 <ad7e7b15-26f3-daa1-02d2-782ff548756d@pengutronix.de>
 <DB7PR04MB46180C5F1EAC7C4A69A45E0CE65D0@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <d68b2b79-34ec-eb4c-cf4b-047b5157d5e3@pengutronix.de>
 <a1ded645-9e12-d939-7920-8e79983b02a0@geanix.com>
 <DB7PR04MB46184164EAC5719BDCF3822CE65C0@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <e7bef254-9762-0b77-1ace-2040113982ec@geanix.com>
 <DB7PR04MB461820120FF61E08B8B5B0B5E65C0@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <3a4102bc-8a86-3425-e227-590c005df044@geanix.com>
 <2c8f83aa-e7e6-ba15-1e42-2cb834da1c48@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <2c8f83aa-e7e6-ba15-1e42-2cb834da1c48@pengutronix.de>
Content-Language: en-US-large
Sender: netdev-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>, Joakim Zhang <qiangqing.zhang@nxp.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
List-Id: linux-can.vger.kernel.org



On 07/12/2019 21.32, Marc Kleine-Budde wrote:
> On 12/5/19 12:32 PM, Sean Nyekjaer wrote:
>>> If yes, I think we don't need check stop mode in probe stage, since
>>> issue has disappeared automatically.
>>
>> If one have devices deployed where:
>> "can: flexcan: fix deadlock when using self wakeup" isn't applied.
>> They could have devices stuck in stop-mode.
> 
> Ok.
> 
> But both patches:
> 
>      can: flexcan: fix deadlock when using self wakeup
>      can: flexcan: try to exit stop mode during probe stage
> 
> are not yet mainline, so if "can: flexcan: fix deadlock when using self
> wakeup" fixes the problem and goes into stable we don't need "can:
> flexcan: try to exit stop mode during probe stage", right?
> 
>> That's what i meant by this patch doesn't do any harm to have the check
>> included.
> 
> I don't want to have code in the driver that serves no purpose.
> 

Fine with me, I'm continuing to have the patch included in my tree until 
all devices are upgraded with:
	can: flexcan: fix deadlock when using self wakeup

/Sean

> regards,
> Marc
> 
