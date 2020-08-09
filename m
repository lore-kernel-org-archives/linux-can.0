From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] can: m_can: Set pinmux into "default" state on start
Date: Sun, 9 Aug 2020 13:01:36 +0200
Message-ID: <419338dc-870d-51a4-87ac-ceddcba046dc@denx.de>
References: <20200531181324.383930-1-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:35711 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbgHILBk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 9 Aug 2020 07:01:40 -0400
In-Reply-To: <20200531181324.383930-1-marex@denx.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Alexandre Torgue <alexandre.torgue@st.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>

On 5/31/20 8:13 PM, Marek Vasut wrote:
> On systems like stm32mp1 where pins have both "default" and "sleep" pinmux
> states in DT, the pins are in "sleep" state by default. Switch the pins into
> the "default" state when bringing the interface up in m_can_start(), because
> otherwise no CAN communication is possible. This replicates the behavior of
> the resume path, which does the same.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: Wolfgang Grandegger <wg@grandegger.com>
> To: linux-can@vger.kernel.org
> ---
>  drivers/net/can/m_can/m_can.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 02c5795b7393..76fadf2b8ac2 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -1247,6 +1247,8 @@ static void m_can_start(struct net_device *dev)
>  	/* basic m_can configuration */
>  	m_can_chip_config(dev);
>  
> +	pinctrl_pm_select_default_state(cdev->dev);
> +
>  	cdev->can.state = CAN_STATE_ERROR_ACTIVE;
>  
>  	m_can_enable_all_interrupts(cdev);
> 

Any news on this ?
