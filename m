From: Sean Nyekjaer <sean@geanix.com>
Subject: Re: [PATCH V2 0/4] can: flexcan: fixes for stop mode
Date: Wed, 27 Nov 2019 10:52:06 +0100
Message-ID: <1c71c2ef-39a4-6f38-98c0-4ee43767a725@geanix.com>
References: <20191127055334.1476-1-qiangqing.zhang@nxp.com>
 <e936b9b1-d602-ac38-213c-7272df529bef@geanix.com>
 <4a9c2e4a-c62d-6e88-bd9e-01778dab503b@geanix.com>
 <DB7PR04MB46186472F0437A825548CE11E6440@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <DB7PR04MB4618C541894AD851BED5B0B7E6440@DB7PR04MB4618.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <DB7PR04MB4618C541894AD851BED5B0B7E6440@DB7PR04MB4618.eurprd04.prod.outlook.com>
Content-Language: en-US-large
Sender: netdev-owner@vger.kernel.org
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
List-Id: linux-can.vger.kernel.org



On 27/11/2019 10.48, Joakim Zhang wrote:
> One more should confirm with you, you inserted a flexcan.ko after stop mode activated without fix patch firstly, and then inserted a flexcan.ko
> with fix patch. If yes, this could cause unbalanced pm_runtime_enabled. The reason is that firstly inserted the flexcan.ko would enable device runtime pm,
> and then you inserted flexcan.ko enable device runtime pm again.
> 
> Could you please insert flexcan.ko with fix patch directly after stop mode activated?
>   
Hi,

If I insert flexcan.ko with fix patch directly after stop mode 
activated, the unbalanced msg is not shown...
I guess we are good then :)

/Sean
