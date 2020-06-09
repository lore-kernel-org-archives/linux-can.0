From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCH] can: m_can_platform: fix m_can_runtime_suspend()
Date: Tue, 9 Jun 2020 10:47:52 +0200
Message-ID: <d7f024a4-f2d0-8045-dfd2-d1f89e4789c8@sorico.fr>
References: <20200608094348.12650-1-richard.genoud@gmail.com>
 <b9510aa6-d865-7c4f-6730-dcd207bdb753@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b9510aa6-d865-7c4f-6730-dcd207bdb753@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>, Richard Genoud <richard.genoud@gmail.com>, Sriram Dash <sriram.dash@samsung.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Faiz Abbas <faiz_abbas@ti.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Hi Dan,

Le 08/06/2020 à 16:27, Dan Murphy a écrit :
> Richard
> 
> On 6/8/20 4:43 AM, Richard Genoud wrote:
>> Since commit f524f829b75a ("can: m_can: Create a m_can platform
>> framework"), the can peripheral on STM32MP1 wasn't working anymore.
>>
>> The reason was a bad copy/paste maneuver that added a call to
>> m_can_class_suspend() in m_can_runtime_suspend().
> 
> Are you sure it was a copy paste error?
> 
> Probably don't want to have an unfounded cause unless you know for 
> certain it was this.
I understand.

What makes me think it was a copy-paste error is that the primary goal 
of the patch series "M_CAN Framework" was to introduce the tcan4x5x 
driver into the kernel.
For that, the code has to be split into a re-usable code (m_can.c) and a 
platform code m_can_platform.c
And finally, tcan4x5x.c can be added.
(I'm sure you already know that since you write the patch, it's just to 
be sure that we are on the same page :))

So, when splitting the m_can code into m_can.c and m_can_platform.c, 
there was no reason to change the behavior, even less reason to change 
the behavior in m_can_platform.c, since the main target was tcan4x5x.
(And the behavior changed because the CAN peripheral on the STM32MP1 was 
working before this patch, and not after).

So I went digging into that and I realized that before this patch, 
runtime suspend function was in m_can.c:
static int __maybe_unused m_can_runtime_suspend(struct device *dev)
{
	struct net_device *ndev = dev_get_drvdata(dev);
	struct m_can_priv *priv = netdev_priv(ndev);

	clk_disable_unprepare(priv->cclk);
	clk_disable_unprepare(priv->hclk);

	return 0;
}

And after, in m_can_platform.c:
static int __maybe_unused m_can_runtime_suspend(struct device *dev)
{
	struct net_device *ndev = dev_get_drvdata(dev);
	struct m_can_priv *mcan_class = netdev_priv(ndev);

	m_can_class_suspend(dev);

	clk_disable_unprepare(mcan_class->cclk);
	clk_disable_unprepare(mcan_class->hclk);

	return 0;
}

Same for runtime resume,
Before:
static int __maybe_unused m_can_runtime_resume(struct device *dev)
{
	struct net_device *ndev = dev_get_drvdata(dev);
	struct m_can_priv *priv = netdev_priv(ndev);
	int err;

	err = clk_prepare_enable(priv->hclk);
	if (err)
		return err;

	err = clk_prepare_enable(priv->cclk);
	if (err)
		clk_disable_unprepare(priv->hclk);

	return err;
}

After:
static int __maybe_unused m_can_runtime_resume(struct device *dev)
{
	struct net_device *ndev = dev_get_drvdata(dev);
	struct m_can_priv *mcan_class = netdev_priv(ndev);
	int err;

	err = clk_prepare_enable(mcan_class->hclk);
	if (err)
		return err;

	err = clk_prepare_enable(mcan_class->cclk);
	if (err)
		clk_disable_unprepare(mcan_class->hclk);

	m_can_class_resume(dev);

	return err;
}

Now, the m_class_resume() call has been removed by commit 0704c5743694 
("can: m_can_platform: remove unnecessary m_can_class_resume() call")
cf https://lkml.org/lkml/2019/11/19/965

Then only the m_can_class_suspend() call is left alone. If I remove it, 
the stm32mp1 peripheral works as before the patch. (and the code is 
symmetrical again :))

I read all the iterations I could find about this patch (see note 1), 
and I didn't found any comment on the addition of 
m_can_class_{resume,suspend}() calls.

But I found this in v3 cover letter:
"The m_can platform code will need to be updated as I have not tested 
this code."
and in v3 1/4 comments:
"This patch set is working for the TCAN and at least boots on io-mapped 
devices."

For me, that means that the code in m_can_platform.c was written with 
this sentence in mind :
"I can test everything but this, so let's try not to break things in 
there, keep the changes at a minimum"
And that was really the case for all the file, but the 2 calls to 
m_can_class_{resume,suspend}().

So that's why I have a pretty good confidence in the fact that it was a 
copy-paste error.

And, moreover, if m_can_class_suspend() is called, the CAN device is 
stopped, and all interrupts are disabled (in m_can_stop()), so the 
device can not wake-up by itself (and thus not working anymore).


All this make me think that maybe I should send a v2 of this patch with 
a bigger commit message.
What do you think ?


Thanks !

Richard.


> 
> Dan
> 
> 

Note 1: patches v3 to v12 (missing v11)
https://lwn.net/ml/linux-kernel/20190111173236.14329-1-dmurphy@ti.com/
https://lore.kernel.org/patchwork/patch/1033094/
https://lore.kernel.org/patchwork/cover/1042441/
https://lore.kernel.org/patchwork/patch/1047220/
https://lore.kernel.org/patchwork/patch/1047980/
https://lkml.org/lkml/2019/3/12/362
https://lkml.org/lkml/2019/3/13/512
https://www.spinics.net/lists/netdev/msg557961.html
https://lore.kernel.org/patchwork/patch/1071894/
