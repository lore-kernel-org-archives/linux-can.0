From: Sean Nyekjaer <sean@geanix.com>
Subject: Re: [PATCH V2 0/4] can: flexcan: fixes for stop mode
Date: Wed, 27 Nov 2019 09:12:38 +0100
Message-ID: <4a9c2e4a-c62d-6e88-bd9e-01778dab503b@geanix.com>
References: <20191127055334.1476-1-qiangqing.zhang@nxp.com>
 <e936b9b1-d602-ac38-213c-7272df529bef@geanix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <e936b9b1-d602-ac38-213c-7272df529bef@geanix.com>
Content-Language: en-US-large
Sender: netdev-owner@vger.kernel.org
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
List-Id: linux-can.vger.kernel.org



On 27/11/2019 07.12, Sean Nyekjaer wrote:
> 
> 
> On 27/11/2019 06.56, Joakim Zhang wrote:
>>     Could you help check the patch set? With your suggestions, I
>> have cooked a patch to exit stop mode during probe stage.
>>
>>     IMHO, I think this patch is unneed, now in flexcan driver,
>> enter stop mode when suspend, and then exit stop mode when resume.
>> AFAIK, as long as flexcan_suspend has been called, flexcan_resume will
>> be called, unless the system hang during suspend/resume. If so, only
>> code reset can activate OS again. Could you please tell me how does CAN
>> stucked in stop mode at your side?
> 
> Hi Joakim,
> 
> Thanks I'll test this :-)
> Guess I will have do some hacking to get it stuck in stop mode.
> 
> We have a lot of devices in the field that doesn't have:
> "can: flexcan: fix deadlock when using self wakeup"
> 
> And they have traffic on both CAN interfaces, that way it's quite easy 
> to get them stuck in stop mode.
> 
> /Sean

Hi Joakim,

I have been testing this.
I have a hacked version of the driver that calls 
flexcan_enter_stop_mode() as the last step in the probe function.

First insert of flexcan.ko when stop mode is activated:
flexcan 2090000.flexcan: Linked as a consumer to regulator.4

flexcan 2090000.flexcan: registering netdev failed

flexcan 2090000.flexcan: Dropping the link to regulator.4

flexcan: probe of 2090000.flexcan failed with error -110

flexcan 2094000.flexcan: Linked as a consumer to regulator.4

flexcan 2094000.flexcan: registering netdev failed

flexcan 2094000.flexcan: Dropping the link to regulator.4

flexcan: probe of 2094000.flexcan failed with error -110


When I insert a flexcan.ko with the patch
"can: flexcan: try to exit stop mode during probe stage":
flexcan 2090000.flexcan: Linked as a consumer to regulator.4

flexcan 2090000.flexcan: Unbalanced pm_runtime_enable!

flexcan 2094000.flexcan: Linked as a consumer to regulator.4

flexcan 2094000.flexcan: Unbalanced pm_runtime_enable!

I works as I expected but, I think we need to do some pm_runtime cleanup 
when bailing with error -110.
Anyways it works great, thanks for your work on this.

/Sean
