From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: flexcan: Implement CAN Runtime PM
Date: Tue, 27 Nov 2018 08:52:10 +0100
Message-ID: <7449a067-e9b2-5cdf-7fae-9b9d5acdac87@pengutronix.de>
References: <20181019094326.28185-1-qiangqing.zhang@nxp.com>
 <24a43a20-7302-c449-06b3-5ee8f6c051a0@pengutronix.de>
 <DB7PR04MB461851E4A4C494E8AC91AAEEE6D00@DB7PR04MB4618.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <DB7PR04MB461851E4A4C494E8AC91AAEEE6D00@DB7PR04MB4618.eurprd04.prod.outlook.com>
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "wg@grandegger.com" <wg@grandegger.com>, "davem@davemloft.net" <davem@davemloft.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Aisheng DONG <aisheng.dong@nxp.com>
List-Id: linux-can.vger.kernel.org

On 11/27/18 8:44 AM, Joakim Zhang wrote:
>>> Flexcan will be disabled during suspend if no wakeup function required
>>> and enabled after resume accordingly. During this period, we could
>>> explicitly disable clocks.
>>>
>>> Implement Runtime PM which will:
>>> 1) Keep device in suspend state (clocks disabled) if it's not openned
>>> 2) Make Power Domain framework be able to shutdown the corresponding
>>> power domain of this device.
>>
>> Without CONFIG_PM the device fails to probe:
>>
>>> [  214.420606] flexcan 2090000.flexcan: 2090000.flexcan supply xceiver
>>> not found, using dummy regulator [  214.445952] flexcan
>>> 2090000.flexcan: Linked as a consumer to regulator.0 [  214.453448]
>>> flexcan 2090000.flexcan: registering netdev failed [  214.459666]
>>> flexcan 2090000.flexcan: Dropping the link to regulator.0 [
>>> 214.472066] flexcan: probe of 2090000.flexcan failed with error -110

> I would sent V2 rebased on patch "can: flexcan: add self wakeup
> support", and runtime pm works normally on MX6SX-SDB and MX7D-SDB.
> So, could you tell me which board you tested on that causes the
> device probe failed?

I tested on an imx6dl riotboard
(https://elixir.bootlin.com/linux/latest/source/arch/arm/boot/dts/imx6dl-riotboard.dts
+ patches to enable CAN1) with an external PHY.

> And that CONFIG_PM has set in imx_v6_v7_defconfig which config file I used.

I disabled CONFIG_PM on purpose.

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
