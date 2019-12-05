From: Sean Nyekjaer <sean@geanix.com>
Subject: Re: [PATCH V2 2/4] can: flexcan: try to exit stop mode during probe
 stage
Date: Thu, 5 Dec 2019 10:21:34 +0100
Message-ID: <a1ded645-9e12-d939-7920-8e79983b02a0@geanix.com>
References: <20191127055334.1476-1-qiangqing.zhang@nxp.com>
 <20191127055334.1476-3-qiangqing.zhang@nxp.com>
 <ad7e7b15-26f3-daa1-02d2-782ff548756d@pengutronix.de>
 <DB7PR04MB46180C5F1EAC7C4A69A45E0CE65D0@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <d68b2b79-34ec-eb4c-cf4b-047b5157d5e3@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <d68b2b79-34ec-eb4c-cf4b-047b5157d5e3@pengutronix.de>
Content-Language: en-US-large
Sender: netdev-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>, Joakim Zhang <qiangqing.zhang@nxp.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
List-Id: linux-can.vger.kernel.org



On 04/12/2019 09.45, Marc Kleine-Budde wrote:
> On 12/4/19 3:22 AM, Joakim Zhang wrote:
>>
>>> -----Original Message-----
>>> From: Marc Kleine-Budde <mkl@pengutronix.de>
>>> Sent: 2019年12月4日 2:15
>>> To: Joakim Zhang <qiangqing.zhang@nxp.com>; sean@geanix.com;
>>> linux-can@vger.kernel.org
>>> Cc: dl-linux-imx <linux-imx@nxp.com>; netdev@vger.kernel.org
>>> Subject: Re: [PATCH V2 2/4] can: flexcan: try to exit stop mode during probe
>>> stage
>>>
>>> On 11/27/19 6:56 AM, Joakim Zhang wrote:
>>>> CAN controller could be stucked in stop mode once it enters stop mode
>>>                            ^^^^^^^ stuck
>>>> when suspend, and then it fails to exit stop mode when resume.
>>>
>>> How can this happen?
>>
>> I am also confused how can this happen, as I asked Sean, only CAN
>> enter stop mode when suspend, then system hang,
> How do you recover the system when suspended?
> 
>> it could let CAN
>> stuck in stop mode. However, Sean said this indeed happen at his
>> side, @sean@geanix.com, could you explain how this happen in
>> details?
> That would be good.
> 
>>>> Only code reset can get CAN out of stop mode,
>>>
>>> What is "code reset"?
>>
>> As I know, "code reset" is to press the POWER KEY from the board. At
>> my side, reboot command from OS also can get CAN out of stop mode.
> Do you mean "cold reset", also known as Power-On-Reset, POR or power cycle?
> 
> What does pressing the POWER KEY do? A power cycle of the system or
> toggling the reset line of the imx?
> 
> We need to describe in detail, as not everyone has the same board as
> you, and these boards might not even have a power key :)
> 
>> Below is experiment I did:
>> 	Firstly, do a hacking to let CAN stuck into stop mode, then:
> 
> You mean you put the CAN into stop mode without keeping track in the CAN
> driver that the CAN-IP is in stop mode, e.g. by hacking the driver.
> 
> Then you try several methods to recover:
> 
>> 	(1) press power on/off key, get CAN out of stop mode;
>> 	(2) reboot command from console, get CAN out of stop mode;
>> 	(3) unbind/bind driver, cannot get CAN out of stop mode;
>> 	(4) remod/insmod module, cannot get CAN out of stop mode;
> 
> (2) resets the complete imx, including the CAN-IP core, (1) probably, too.
No, if the CAN-IP core is in stop-mode it will stay that way even after 
a reboot from the console.
At least it's what we are seeing in the field.

This could be because we are missing a wire from the watchdog out to the 
RESETBMCU/PWRON on the PMIC.
But i guess a check for if the CAN-Ip is in stop-mode doesn't hurt 
anything :)

/Sean
