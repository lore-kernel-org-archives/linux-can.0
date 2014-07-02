From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 1/3] can: m_can: add Bosch M_CAN controller support
Date: Wed, 02 Jul 2014 19:54:03 +0200
Message-ID: <53B4473B.2050003@hartkopp.net>
References: <1403863246-18822-1-git-send-email-b29396@freescale.com> <1403863246-18822-2-git-send-email-b29396@freescale.com> <53ADB1E8.1030504@hartkopp.net> <20140630082622.GB25689@shlinux1.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:13973 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751540AbaGBRyL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 2 Jul 2014 13:54:11 -0400
In-Reply-To: <20140630082622.GB25689@shlinux1.ap.freescale.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de
Cc: Dong Aisheng <b29396@freescale.com>, linux-can@vger.kernel.org, wg@grandegger.com, devicetree@vger.kernel.org

Hello Marc,

I'm not really familiar with the naming concept in device trees.

What is your opinion about the remarks below?

Regards,
Oliver

On 30.06.2014 10:26, Dong Aisheng wrote:
> On Fri, Jun 27, 2014 at 08:03:20PM +0200, Oliver Hartkopp wrote:

>>> +  for each elements definition.
>>> +
>>> +Example:
>>> +canfd1: canfd@020e8000 {
>>    ^^^^^^  ^^^^^
>>
>> There's no reason to name this canfd. The fact that the controller supports
>> CAN FD is provided by priv->ctrlmode_supported and the CAN_CTRLMODE_FD bit.
>>
> 
> Just because mx6sx spec calling it CANFD at many places.
> e.g.
> Interrupts:
> 146 CANFD1 CANFD1 interrupt request
> 147 CANFD2 CANFD2 interrupt request
> Memory Map:
> 020F_0000 020F_3FFF CANFD2 16 KB
> 020E_8000 020E_BFFF CANFD1 16 KB
> So i used canfd firstly.
> CCM:
> CANFD
> ips_clk can_clk_root CCGR1[CG15] (canfd_clk_enable)
> m_can_0_cclk can_clk_root CCGR1[CG15] (canfd_clk_enable)
> m_can_0_ips_clk can_clk_root CCGR1[CG15] (canfd_clk_enable)
> 
>> Just write
>>
>> can1: can@020e8000 {
>>
> 
> I'm ok with this style.
> Maybe the following is better:
> m_can1: can@020e8000 {
> 
>>> +	compatible = "bosch,m_can";
>>> +	reg = <0x020e8000 0x4000>, <0x02298000 0x4000>;
>>> +	reg-names = "canfd", "message_ram";
>>                      ^^^^^
>> dito.
>>
> How about m_can?
> Since it's IP driver, not depends on how SoC naming it.
> 
>>> +	interrupts = <0 114 0x04>;
>>> +	clocks = <&clks IMX6SX_CLK_CANFD>;
>>                                    ^^^^^
>> dito.
>>
> 
> Not for this one, because imx6sx spec calling it CANFD in Clock
> chaptor.
> We want to align with our spec since it's arch code.
> 

