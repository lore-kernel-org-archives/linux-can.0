From: Sean Nyekjaer <sean@geanix.com>
Subject: Re: [PATCH REPOST 1/2] can: flexcan: fix deadlock when using self
 wakeup
Date: Wed, 28 Aug 2019 15:24:35 +0200
Message-ID: <6a9bc081-334a-df91-3a23-b74a6cdd3633@geanix.com>
References: <20190816081749.19300-1-qiangqing.zhang@nxp.com>
 <20190816081749.19300-2-qiangqing.zhang@nxp.com>
 <dd8f5269-8403-702b-b054-e031423ffc73@geanix.com>
 <DB7PR04MB4618A1F984F2281C66959B06E6AB0@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <35190c5b-f8be-8784-5b4f-32a691a6cffe@geanix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <35190c5b-f8be-8784-5b4f-32a691a6cffe@geanix.com>
Content-Language: en-US-large
Sender: netdev-owner@vger.kernel.org
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <martin@geanix.com>
List-Id: linux-can.vger.kernel.org



On 20/08/2019 13.55, Sean Nyekjaer wrote:
> 
> I have added some more debug, same test setup:
> https://gist.github.com/sknsean/81208714de23aa3639d3e31dccb2f3e0
> 
> root@iwg26:~# systemctl suspend
> 
> ...
> https://gist.github.com/sknsean/2a786f1543305056d4de03d387872403
> 
> /Sean

Any luck reproducing this?

/Sean
