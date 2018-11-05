From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH 1/6] phy: Add max_bitrate attribute &
 phy_get_max_bitrate()
Date: Mon, 5 Nov 2018 16:44:12 +0530
Message-ID: <5685cb49-a6bf-3696-f984-020847633e5e@ti.com>
References: <20181102192616.28291-1-faiz_abbas@ti.com>
 <20181102192616.28291-2-faiz_abbas@ti.com>
 <5e1a0b67-510a-5512-d477-0b363e4733fe@pengutronix.de>
 <d75c9e3c-e12b-e0b8-832c-ad117dcbe990@ti.com>
 <0c0885c4-f5ae-a29c-7176-f67fe546cfd8@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0c0885c4-f5ae-a29c-7176-f67fe546cfd8@pengutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, netdev@vger.kernel.org, linux-can@vger.kernel.org
Cc: wg@grandegger.com, robh+dt@kernel.org, mark.rutland@arm.com, kishon@ti.com
List-Id: linux-can.vger.kernel.org

Hi,

On Monday 05 November 2018 03:07 PM, Marc Kleine-Budde wrote:
> On 11/05/2018 07:27 AM, Faiz Abbas wrote:
>> I remove the transceiver child node binding documentation in patch 5/6.
>>
>> The existing implementation is pretty limiting as it just has a child
>> node with no associated device. What if a transceiver requires its own
>> configurations before it can start sending/receiving messages (for
>> example, my usecase requires it to pull the standby line low)?
>>
>> I think that can be solved by implementing the transceiver as a phy and
>> exposing a generic get_max_bitrate API. That way, the transceiver device
>> can do all its startup configuration in the phy probe function.
>>
>> In any case, do suggest if you have a better idea on how to implement
>> pull gpio low requirement.
> 
> As long as we don't have any proper transceiver/phy driver, that does
> more than swtich on/off a GPIO, please add a "xceiver" regulator to your
> driver. Look for:
> 
>> devm_regulator_get(&pdev->dev, "xceiver");
> 

The transceiver is not specific to m_can. The pull down would be
required even if it were connected to some other controller.

Thanks,
Faiz
