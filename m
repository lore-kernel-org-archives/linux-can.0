From: Sean Nyekjaer <sean@geanix.com>
Subject: Re: [PATCH V2 1/2] can: flexcan: disable runtime PM if register
 flexcandev failed
Date: Wed, 18 Dec 2019 15:03:54 +0100
Message-ID: <935f466b-a9c9-de73-be12-6ebb7b77e058@geanix.com>
References: <20191210085721.9853-1-qiangqing.zhang@nxp.com>
 <DB7PR04MB46181D2F1538A53B4F1892E2E6500@DB7PR04MB4618.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <DB7PR04MB46181D2F1538A53B4F1892E2E6500@DB7PR04MB4618.eurprd04.prod.outlook.com>
Content-Language: en-US-large
Sender: netdev-owner@vger.kernel.org
To: Joakim Zhang <qiangqing.zhang@nxp.com>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
List-Id: linux-can.vger.kernel.org



On 17/12/2019 07.36, Joakim Zhang wrote:
> 
> Hi Sean,
> 
> Have you found time to test this patch set? Thanks :-)
> 
> Best Regards,
> Joakim Zhang
> 

Hi Joakim

Sorry for the delay :)

I have tested this patchset and found no issues...

Just a heads up when adding "ChangeLog:" do it under the "---" and above 
the diff. That way the ChangeLog doesn't end up in the commit msg...

/Sean
