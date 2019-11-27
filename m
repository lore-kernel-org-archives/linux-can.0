From: Sean Nyekjaer <sean@geanix.com>
Subject: Re: [PATCH V2 0/4] can: flexcan: fixes for stop mode
Date: Wed, 27 Nov 2019 07:12:08 +0100
Message-ID: <e936b9b1-d602-ac38-213c-7272df529bef@geanix.com>
References: <20191127055334.1476-1-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191127055334.1476-1-qiangqing.zhang@nxp.com>
Content-Language: en-US-large
Sender: netdev-owner@vger.kernel.org
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
List-Id: linux-can.vger.kernel.org



On 27/11/2019 06.56, Joakim Zhang wrote:
> 	Could you help check the patch set? With your suggestions, I
> have cooked a patch to exit stop mode during probe stage.
> 
> 	IMHO, I think this patch is unneed, now in flexcan driver,
> enter stop mode when suspend, and then exit stop mode when resume.
> AFAIK, as long as flexcan_suspend has been called, flexcan_resume will
> be called, unless the system hang during suspend/resume. If so, only
> code reset can activate OS again. Could you please tell me how does CAN
> stucked in stop mode at your side?

Hi Joakim,

Thanks I'll test this :-)
Guess I will have do some hacking to get it stuck in stop mode.

We have a lot of devices in the field that doesn't have:
"can: flexcan: fix deadlock when using self wakeup"

And they have traffic on both CAN interfaces, that way it's quite easy 
to get them stuck in stop mode.

/Sean
