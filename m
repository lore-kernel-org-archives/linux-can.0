From: Sean Nyekjaer <sean@geanix.com>
Subject: Re: [PATCH REPOST 1/2] can: flexcan: fix deadlock when using self
 wakeup
Date: Tue, 10 Sep 2019 09:52:45 +0200
Message-ID: <739eee2e-2919-93b4-24fe-8d0d198ae042@geanix.com>
References: <20190816081749.19300-1-qiangqing.zhang@nxp.com>
 <20190816081749.19300-2-qiangqing.zhang@nxp.com>
 <dd8f5269-8403-702b-b054-e031423ffc73@geanix.com>
 <DB7PR04MB4618A1F984F2281C66959B06E6AB0@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <35190c5b-f8be-8784-5b4f-32a691a6cffe@geanix.com>
 <6a9bc081-334a-df91-3a23-b74a6cdd3633@geanix.com>
 <DB7PR04MB4618E527339B69AEAD46FB06E6A20@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <588ab34d-613d-ac01-7949-921140ca4543@geanix.com>
 <DB7PR04MB461868320DA0B25CC8255213E6BB0@DB7PR04MB4618.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <DB7PR04MB461868320DA0B25CC8255213E6BB0@DB7PR04MB4618.eurprd04.prod.outlook.com>
Content-Language: en-US-large
Sender: netdev-owner@vger.kernel.org
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <martin@geanix.com>
List-Id: linux-can.vger.kernel.org



On 05/09/2019 09.10, Joakim Zhang wrote:
> Hi Sean,
> 
> Could you update lastest flexcan driver using linux-can-next/flexcan and then merge below two patches from linux-can/testing?
> d0b53616716e (HEAD -> testing, origin/testing) can: flexcan: add LPSR mode support for i.MX7D
> 803eb6bad65b can: flexcan: fix deadlock when using self wakeup
> 
> Best Regards,
> Joakim Zhang

Hi

I reverted 2 commits on thw nand driver and got the testing kernel to work.

I can confirm the issue is resolved with this patch :-)

/Sean
