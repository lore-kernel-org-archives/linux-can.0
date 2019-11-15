From: Sean Nyekjaer <sean@geanix.com>
Subject: Re: [PATCH 1/3] can: flexcan: fix deadlock when using self wakeup
Date: Fri, 15 Nov 2019 09:54:00 +0100
Message-ID: <986c06e6-644a-5ad4-b7e0-ce431605b626@geanix.com>
References: <20191115050032.25928-1-qiangqing.zhang@nxp.com>
 <DB7PR04MB4618335E8A90387EDAE17F21E6700@DB7PR04MB4618.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <DB7PR04MB4618335E8A90387EDAE17F21E6700@DB7PR04MB4618.eurprd04.prod.outlook.com>
Content-Language: en-US-large
Sender: netdev-owner@vger.kernel.org
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
List-Id: linux-can.vger.kernel.org



On 15/11/2019 06.09, Joakim Zhang wrote:
> 
> Hi Sean,
> 
> I remember that you are the first one sending out the patch to fix this issue, and I NACK the patch before.
> I am so sorry for that, it can work fine after testing at my side. Could you help double check at your side for
> this patch? Both wakeup from totally suspend and wakeup from suspending?
> 
> With this patch, we can fix two problems:
> 1) fix deadlock when using self wakeup
> 2) frames out-of-order in first IRQ handler run after wakeup
> 
> Thanks a lot!
> 
> Best Regards,
> Joakim Zhang

Hi Joakim,



We are mostly listening for broadcast packages, so we haven't noticed 
frames out-of-order :-)



I have checked this series, it comes out of suspend every time :-)

/Sean
