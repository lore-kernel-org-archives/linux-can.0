From: Sean Nyekjaer <sean@geanix.com>
Subject: Re: [PATCH V2 2/4] can: flexcan: try to exit stop mode during probe
 stage
Date: Thu, 5 Dec 2019 12:11:33 +0100
Message-ID: <e7bef254-9762-0b77-1ace-2040113982ec@geanix.com>
References: <20191127055334.1476-1-qiangqing.zhang@nxp.com>
 <20191127055334.1476-3-qiangqing.zhang@nxp.com>
 <ad7e7b15-26f3-daa1-02d2-782ff548756d@pengutronix.de>
 <DB7PR04MB46180C5F1EAC7C4A69A45E0CE65D0@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <d68b2b79-34ec-eb4c-cf4b-047b5157d5e3@pengutronix.de>
 <a1ded645-9e12-d939-7920-8e79983b02a0@geanix.com>
 <DB7PR04MB46184164EAC5719BDCF3822CE65C0@DB7PR04MB4618.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <DB7PR04MB46184164EAC5719BDCF3822CE65C0@DB7PR04MB4618.eurprd04.prod.outlook.com>
Content-Language: en-US-large
Sender: netdev-owner@vger.kernel.org
To: Joakim Zhang <qiangqing.zhang@nxp.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
List-Id: linux-can.vger.kernel.org



On 05/12/2019 12.04, Joakim Zhang wrote:
> Hi Sean,
> 
> At my side, both Power-On-Reset and reboot from console can get CAN-IP out of stop mode, HW is i.MX7D-SDB/i.MX8QXP-mek.
> I think HW design could make difference.
> 
> We more care about how does CAN-IP stuck in stop mode, could you please explain in details? We want figure out the root cause.

When running only with the first stop mode commit:
de3578c198c6 ("can: flexcan: add self wakeup support")
And there is incoming traffic on both CAN lines.
I happens when going into suspend.
Then the CAN-IP is stuck in stop mode..

I'm on this custom i.MX6ull board.
I have another custom board also with the i.MX6ull where the watchdog 
pins are wired to the PMIC.
Will try to test on that next week

/Sean
